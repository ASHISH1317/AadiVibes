import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:aadivibes/app/data/config/encryption.dart';
import 'package:aadivibes/app/data/config/logger.dart';
import 'package:aadivibes/app/data/local/user_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:path/path.dart' as path;

/// DIO interceptor to add the authentication token
InterceptorsWrapper addAuthToken({String authTokenHeader = 'authToken'}) =>
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers.addAll(<String, dynamic>{
          authTokenHeader: 'Bearer ${UserProvider.authToken}',
        });
        handler.next(options); //continue
      },
    );

/// Dio interceptor to encrypt the request body
InterceptorsWrapper encryptBody() => InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        final String method = options.method.toUpperCase();

        if (options.headers['encrypt'] as bool) {
          switch (method) {
            case 'POST':
            case 'PUT':
            case 'PATCH':
              logW('encrypting $method method');
              if (options.data.runtimeType.toString() ==
                  '_InternalLinkedHashMap<String, dynamic>') {
                logI('Data will be encrypted before sending request');
                options.data = <String, dynamic>{
                  'data': AppEncryption.encrypt(
                      plainText: jsonEncode(options.data)),
                };
              } else {
                logI(
                    'Skipping encryption for ${options.data.runtimeType} type');
              }

              break;
            default:
              logWTF('Skipping encryption for $method method');
              break;
          }
        }
        handler.next(options); //continue
      },
    );

/// API service of the application. To use Get, POST, PUT and PATCH rest methods
class APIService {
  static final Dio _dio = Dio();

  static late String _prodBaseApiUrl;
  static late String _devBaseApiUrl;

  static String get _baseUrl => kReleaseMode ? _prodBaseApiUrl : _devBaseApiUrl;

  /// Initialize the API service
  static void initializeAPIService({
    required String devBaseUrl,
    required String prodBaseUrl,
    bool encryptData = false,
    String authHeader = 'authToken',
    String xAPIKeyHeader = 'x-api-key',
    String xAPIKeyValue = 'x-api-key',
  }) {
    _devBaseApiUrl = devBaseUrl;
    _prodBaseApiUrl = prodBaseUrl;

    _dio.options.headers.addAll(<String, dynamic>{
      xAPIKeyHeader: xAPIKeyValue,
    });
    /*if (UserProvider.isLoggedIn) {
      _dio.options.headers.addAll(<String, dynamic>{
        authHeader: UserProvider.authToken,
      });
    }*/
    _dio.interceptors.add(addAuthToken(authTokenHeader: authHeader));
    //Add interceptor for encryption layer
    if (encryptData) {
      logI('Data will be encrypted for POST / PUT / PATCH');
      _dio.interceptors.add(encryptBody());
    }
    if (kDebugMode) {
      //Add interceptor for console logs
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ));
    }

    // _restClient.getTasks();
  }

  /// GET rest API call
  /// Used to get data from backend
  ///
  /// Use [forcedBaseUrl] when want to use specific baseurl other
  /// than configured
  ///
  /// The updated data to be passed in [data]
  ///
  /// [params] are query parameters
  ///
  /// [path] is the part of the path after the base URL
  ///
  /// set [encrypt] to true if the body needs to be encrypted. Make sure the
  /// encryption keys in the backend matches with the one in frontend
  static Future<Response<Map<String, dynamic>?>?> get({
    required String path,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async =>
      _dio.get<Map<String, dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        queryParameters: params,
        options: Options(headers: <String, dynamic>{
          'encrypt': encrypt,
        }),
      );

  /// POST rest API call
  /// Used to send any data to server and get a response
  ///
  /// Use [forcedBaseUrl] when want to use specific baseurl other
  /// than configured
  ///
  /// The updated data to be passed in [data]
  ///
  /// [params] are query parameters
  ///
  /// [path] is the part of the path after the base URL
  ///
  /// set [encrypt] to true if the body needs to be encrypted. Make sure the
  /// encryption keys in the backend matches with the one in frontend
  static Future<Response<Map<String, dynamic>?>?> post({
    required String path,
    FormData? data,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async =>
      _dio.post<Map<String, dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        data: data,
        queryParameters: params,
        options: Options(headers: <String, dynamic>{
          'encrypt': encrypt,
        }),
      );

  /// PUT rest API call
  /// Usually used to create new record
  ///
  /// Use [forcedBaseUrl] when want to use specific baseurl other
  /// than configured
  ///
  /// The updated data to be passed in [data]
  ///
  /// [params] are query parameters
  ///
  /// [path] is the part of the path after the base URL
  ///
  /// set [encrypt] to true if the body needs to be encrypted. Make sure the
  /// encryption keys in the backend matches with the one in frontend
  static Future<Response<Map<String, dynamic>?>?> put({
    required String path,
    FormData? data,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async =>
      _dio.put<Map<String, dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        data: data,
        queryParameters: params,
        options: Options(headers: <String, dynamic>{
          'encrypt': encrypt,
        }),
      );

  /// PATCH rest API call
  /// Usually used to update any record
  ///
  /// Use [forcedBaseUrl] when want to use specific baseurl other
  /// than configured
  ///
  /// The updated data to be passed in [data]
  ///
  /// [params] are query parameters
  ///
  /// [path] is the part of the path after the base URL
  ///
  /// set [encrypt] to true if the body needs to be encrypted. Make sure the
  /// encryption keys in the backend matches with the one in frontend
  static Future<Response<Map<String, dynamic>?>?> patch({
    required String path,
    FormData? data,
    Map<String, dynamic>? params,
    bool encrypt = true,
    String? forcedBaseUrl,
  }) async =>
      _dio.patch<Map<String, dynamic>?>(
        (forcedBaseUrl ?? _baseUrl) + path,
        data: data,
        queryParameters: params,
        options: Options(headers: <String, dynamic>{
          'encrypt': encrypt,
        }),
      );

  /// Upload file to the server. You will get the URL in the response if the
  /// [file] was uploaded successfully. Else you will get null in response.
  static Future<String?> uploadFile({
    required File file,
    required String folder,
  }) async {
    final Response<Map<String, dynamic>?>? response = await APIService.post(
      path: '/user/upload/$folder/images',
      data: FormData.fromMap(<String, dynamic>{
        'images': MultipartFile.fromBytes(
          List<int>.from(await file.readAsBytes()),
          contentType:
              http_parser.MediaType('image', path.extension(file.path)),
          filename: file.path,
        ),
      }),
      encrypt: false,
    );
    if (response?.data!['code'] == 'FILE_UPLOADED') {
      logE(response?.data!['file']);
      return response?.data!['file'] as String;
    } else {
      return null;
    }
  }
}
