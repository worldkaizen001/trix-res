const baseURL = "https://charissa.trixdesk.com/api";

class Endpoints {
  static const register = "user/register";
  static const cart = "user/cart";
  static const forgotInit = "user/forgot/init";
  static const forgotVerify = "user/forgot/verify";
  static const forgotReset = "user/forgot/reset";

  static const login = "user/login";
  static const orders = "user/orders";
  static const profile = "user/profile";
  static const logout = "user/logout";
  static const deactivate = "user/close-account";
  // api/service/stores?show=1,2

  static const stores = "service/stores";
  static const products = "service/products";
  static const categories = "service/categories";
  static const notifications = "service/notifications";
}

String route(String url) => "$baseURL/$url";
