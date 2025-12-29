John Cena Career Match Dataset – Data Dictionary Version 1.0



This dataset contains three CSV files describing professional wrestling matches from the career of John Cena, created from HTML web files, from cagematch.net. Each file represents a different analytical perspective: match outcomes, championship context, and geographic location. All files share a common key: Match\_ID.



MatchesTable.csv



Purpose

Contains core match-level information including competitors, outcomes, event details, and match structure.

Grain: 1 row = 1 match

Primary Key: Match\_ID



| Column Name | Data Type | Description | Example |

|------------|----------|------------|--------|

|Match\_ID | Integer | Unique identifier for each match | 2326|

|Match\_Date | Date | Date the match took place | 2025-12-13|

|Match | Text | Match description | Gunther vs John Cena|

|Winner | Text | Winner of the match | Gunther|

|Loser | Text | Loser of the match | John Cena|

|WinLoss | Text | Result from John Cena’s perspective | Win, Loss|

|Championship\_Match | Text | Championship involved or Exhibition if none | WWE Championship, WWE United States Championship|

|Promotion | Text | Wrestling promotion | WWE|

|Match\_Type | Text | Match format | Singles|

|Stipulation | Text | Special rules if applicable | No Stipulation, Street Fight|

|Event |	Text | Event series | WWE Saturday Night’s Main Event|

|Event\_Name | Text | Specific event name	| WWE Saturday Night’s Main Event|

|Event\_Type | Text | Event category | PPV/PLE, Televised|



Notes: WinLoss reflects John Cena’s result, not the generic match outcome. Exhibition matches have no title implications.





ChampionshipTable.csv



Purpose: Describes championship context for each match, including whether a title was defended, won, or lost.

Grain: 1 row = 1 match

Primary Key: Match\_ID



| Column Name | Data Type | Description | Example |

|------------|----------|------------|--------|

|Match\_ID | Integer | Unique match identifier | 2326|

|Match\_Date | Date | Match date | 2025-12-13|

|Championship\_Match | Text | Championship contested or Exhibition | WWE Intercontinental Championship|

|WinLoss | Text | Match result from Cena’s perspective | Loss|

|WinChampionship | Yes/No | Indicates if a championship was won | Yes, No|

|LoseChampionship | Yes/No | Indicates if John Cena lost a championship in the match | Yes, No|

|SinglesChampionshipHeld | Text | Singles title involved or No Championship | WWE Intercontinental Championship|

|TagChampionshipHeld | Text | Tag title involved or No Championship | No Championship|

|IsTitleMatch | Yes/No | Indicates whether the match was a title match |	Yes, No|



Notes: Fields are designed to support career-long title analysis. Non-title matches are explicitly marked





LocationTable.csv



Purpose: Provides geographic context for each match, including venue and location details.

Grain: 1 row = 1 match

Primary Key: Match\_ID



| Column Name | Data Type | Description | Example |

|------------|----------|------------|--------|

|Match\_ID | Integer | Unique match identifier | 2326|

|Match\_Date | Date | Match date | 2025-12-13|

|Venue | Text | Venue where the match occurred | Capital One Arena|

|CityTown | Text | City | Washington|

|StateProvince | Text | State or province | District of Columbia|

|Country | Text | Country | USA|



Notes: Designed for geographic and map-based analysis. City, state, and country are stored separately to avoid geocoding ambiguity.





All three CSV files can be joined using: Match\_ID

