class CommonResponse {
  static const errorCode = 500;
  static const successCode = 200;

  CommonResponse(this.code, this.data);

  int code;
  Object data;
}
