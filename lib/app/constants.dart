List<String> currencies = ['\$ USD', '€ EUR', '£ GBP', '₽ RUB', '¥ JPY'];
List<String> statisticPeriods = ['Today', 'Yesterday', 'Week', 'Month', 'All time'];

String exchangeApiUrl = 'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_6CAjjvpi9LT7hvLtjq3wDolpQOYp4GCfwmFrJBYu';

Map<String, dynamic> months = {'lines': ['JAN', 'DEC'], 'count': 12};
Map<String, dynamic> days = {'lines': ['1', '31'], 'count': 31};
Map<String, dynamic> weeks = {'lines': ['MO', 'SU'], 'count': 7};
Map<String, dynamic> hours = {'lines': ['', ''], 'count': 1};