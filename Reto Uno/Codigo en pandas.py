import pandas as pd
from sodapy import Socrata

# Unauthenticated client only works with public data sets. Note 'None'
# in place of application token, and no username or password:
client = Socrata("www.datos.gov.co", None)

# Example authenticated client (needed for non-public datasets):
# client = Socrata(www.datos.gov.co,
#                  MyAppToken,
#                  userame="user@example.com",
#                  password="AFakePassword")

# First 200 results, returned as JSON from API / converted to Python list of
# dictionaries by sodapy.
results = client.get("gt2j-8ykr", limit=200)

# Convert to pandas DataFrame
results_df = pd.DataFrame.from_records(results)

# determining the name of the file
file_name = 'CasosCovid.xlsx'

# saving the excel
results_df.to_excel(file_name)
print('DataFrame is written to Excel File successfully.')
