class FoodLig {
  // Base URL for the API
  static const String baseUrl = 'restaurant-rating-api.azurewebsites.net';

  // API Version
  static const String apiVersion = 'v1';

  // Authentication endpoints
  static const String authenticatePlaceAdmin =
      '/api/Account/authenticate-placeadmin'; // Authenticate place admin
  static const String registerPlaceAdmin =
      '/api/Account/register-placeadmin'; // Register place admin

  // Location endpoints
  static const String getAllCities =
      '/api/$apiVersion/Location/GetAllCities'; // Get all cities
  static const String getDistrictByCityId =
      '/api/$apiVersion/Location/GetDistrictByCityId'; // Get district by city ID
  static const String getCityById =
      '/api/$apiVersion/Location/GetCityById'; // Get city by ID
  static const String getTime = '/api/$apiVersion/Location/GetTime'; // Get time

  // MenuType endpoints
  static const String getAllMenuTypes =
      '/api/$apiVersion/MenuType/GetAllMenuTypes'; // Get all menu types

  // Place endpoints
  static const String getPlaceByCityId =
      '/api/$apiVersion/Place/GetPlaceByCityId'; // Get place by city ID
  static const String getPlaceById =
      '/api/$apiVersion/Place/GetPlaceById'; // Get place by ID
  static const String getAllPlaceTypes =
      '/api/$apiVersion/PlaceType/GetAllPlaceTypes'; // Get all place types
  static const String updatePlace =
      '/api/$apiVersion/Place/UpdatePlace'; // Update place

  // Menu endpoints
  static const String getMenuByPlaceId =
      '/api/$apiVersion/Menu/GetMenuByPlaceId'; // Get menu by place ID
  static const String createMenu =
      '/api/$apiVersion/Menu/CreateMenu'; // Create menu
  static const String deleteMenu =
      '/api/$apiVersion/Menu/DeleteMenuById'; // Delete menu
  static const String updateMenu =
      '/api/$apiVersion/Menu/UpdateMenu'; // Update menu

  // Food endpoints
  static const String createFood =
      '/api/$apiVersion/Food/CreateFood'; // Create food
  static const String getFoodByParameter =
      '/api/$apiVersion/Food/GetFoodByParameter'; // Get food by parameter
  static const String getFoodById =
      '/api/$apiVersion/Food/GetFoodById'; // Get food by ID
  static const String getAllFoodTypes =
      '/api/$apiVersion/FoodType/GetAllFoodTypes'; // Get all food types
  static const String deleteFood =
      '/api/$apiVersion/Food/DeleteFoodById'; // Delete food
  static const String updateFood =
      '/api/$apiVersion/Food/UpdateFood'; // Update food

  // Account endpoints
  static const String confirmEmail =
      '/api/Account/confirm-email'; // Confirm email
  static const String resetPasswordForget =
      '/api/Account/reset-password'; // Reset password (forget)
  static const String deleteUser = '/api/Account/delete-account'; // Delete user
  static const String forgotPassword =
      '/api/Account/forgot-password'; // Forgot password
  static const String resetPassword =
      '/api/Account/change-password'; // Reset password
}
