--Create Database--
CREATE DATABASE JohnCenaDW;
--Upload CSV files: MatchesTable.csv, ChampionshipTable.csv, LocationTable.csv--
--Switch to JohnCenaDW--
--Sanity Check--
Select * From dbo.MatchesTable;
Select * From dbo.ChampionshipTable;
Select * From dbo.LocationTable;

--Create Dim_Location--
CREATE TABLE Dim_Location (
    Match_ID INT NOT NULL,
    Venue VARCHAR(255) NULL,
    CityTown VARCHAR(100) NULL,
    StateProvince VARCHAR(100) NULL,
    Country VARCHAR(100) NULL,
    CONSTRAINT PK_Dim_Location PRIMARY KEY (Match_ID)
);
GO
--Insert Data--
INSERT INTO dbo.Dim_Location (
    Match_ID,
    Venue,
    CityTown,
    StateProvince,
    Country
)
SELECT
    Match_ID,
    Venue,
    CityTown,
    StateProvince,
    Country
FROM dbo.LocationTable;
GO
--Check table creation--
Select * From dbo.Dim_Location;

--Create Dim_Date--
CREATE TABLE dbo.Dim_Date (
    Match_Date DATE NOT NULL,
    [Year] INT NULL,
    [Quarter] TINYINT NULL,
    [Month] TINYINT NULL,
    [Day] TINYINT NULL,
    DayName VARCHAR(20) NULL,
    CONSTRAINT PK_Dim_Date PRIMARY KEY (Match_Date)
);
--Populate Table--
INSERT INTO dbo.Dim_Date (
    Match_Date,
    [Year],
    [Quarter],
    [Month],
    [Day],
    DayName
)
SELECT DISTINCT
    d.Match_Date,
    YEAR(d.Match_Date) AS [Year],
    DATEPART(QUARTER, d.Match_Date) AS [Quarter],
    MONTH(d.Match_Date) AS [Month],
    DAY(d.Match_Date) AS [Day],
    DATENAME(WEEKDAY, d.Match_Date) AS DayName
FROM (
    SELECT Match_Date FROM dbo.MatchesTable
    UNION
    SELECT Match_Date FROM dbo.LocationTable
    UNION
    SELECT Match_Date FROM dbo.ChampionshipTable
) d;
--Check table creation--
Select * From dbo.Dim_Date;

--Create Dim_Event--
CREATE TABLE dbo.Dim_Event (
    Match_ID INT NOT NULL,
    Event VARCHAR(MAX) NULL,
    Event_Name VARCHAR(MAX) NULL,
    Event_Type VARCHAR(MAX) NULL,
    Promotion VARCHAR(MAX) NULL,
    CONSTRAINT PK_Dim_Event PRIMARY KEY (Match_ID)
);
--Populate table--
INSERT INTO dbo.Dim_Event (
    Match_ID,
    Event,
    Event_Name,
    Event_Type,
    Promotion
)
SELECT
    Match_ID,
    Event,
    Event_Name,
    Event_Type,
    Promotion
FROM dbo.MatchesTable;
--Check table creation--
Select * From Dim_Event;

--Create Dim_Championship--
CREATE TABLE dbo.Dim_Championship (
    Match_ID INT NOT NULL,
    Championship_Match VARCHAR(MAX) NULL,
    WinLoss VARCHAR(MAX) NULL,
    WinChampionship VARCHAR(MAX) NULL,
    LoseChampionship VARCHAR(MAX) NULL,
    SinglesChampionshipHeld VARCHAR(MAX) NULL,
    TagChampionshipHeld VARCHAR(MAX) NULL,
    IsTitleMatch VARCHAR(MAX) NULL,
    CONSTRAINT PK_Dim_Championship PRIMARY KEY (Match_ID)
);
--Populate table--
INSERT INTO dbo.Dim_Championship (
    Match_ID,
    Championship_Match,
    WinLoss,
    WinChampionship,
    LoseChampionship,
    SinglesChampionshipHeld,
    TagChampionshipHeld,
    IsTitleMatch
)
SELECT
    Match_ID,
    Championship_Match,
    WinLoss,
    WinChampionship,
    LoseChampionship,
    SinglesChampionshipHeld,
    TagChampionshipHeld,
    IsTitleMatch
FROM dbo.ChampionshipTable;
--Check table creation--
Select * From dbo.Dim_Championship;

--Create Dim_MatchType--
CREATE TABLE dbo.Dim_MatchType (
    Match_ID INT NOT NULL,
    Match_Type VARCHAR(MAX) NULL,
    Stipulation VARCHAR(MAX) NULL,
    Match VARCHAR(MAX) NULL,
    Championship_Match VARCHAR(MAX) NULL,
    CONSTRAINT PK_Dim_MatchType PRIMARY KEY (Match_ID)
);
--Populate table--
INSERT INTO dbo.Dim_MatchType (
    Match_ID,
    Match_Type,
    Stipulation,
    Match,
    Championship_Match
)
SELECT
    Match_ID,
    Match_Type,
    Stipulation,
    Match,
    Championship_Match
FROM dbo.MatchesTable;
--Check table creation--
Select * From dbo.Dim_MatchType

--Create Dim_Result--
CREATE TABLE dbo.Dim_Result (
    Match_ID INT NOT NULL,
    Match VARCHAR(MAX) NULL,
    Winner VARCHAR(MAX) NULL,
    Loser VARCHAR(MAX) NULL,
    WinLoss VARCHAR(MAX) NULL,
    Match_Type VARCHAR(MAX) NULL,
    CONSTRAINT PK_Dim_Result PRIMARY KEY (Match_ID)
);
--Populate table--
INSERT INTO dbo.Dim_Result (
    Match_ID,
    Match,
    Winner,
    Loser,
    WinLoss,
    Match_Type
)
SELECT
    Match_ID,
    Match,
    Winner,
    Loser,
    WinLoss,
    Match_Type
FROM dbo.MatchesTable;
--Check table creation--
Select * From dbo.Dim_Result;

--Create Fact_Match--
CREATE TABLE dbo.Fact_Match (
    Match_ID INT NOT NULL,
    Match_Date DATE NULL,
    Match VARCHAR(MAX) NULL,
    Winner VARCHAR(MAX) NULL,
    Loser VARCHAR(MAX) NULL,
    Championship_Match VARCHAR(MAX) NULL,
    Match_Type VARCHAR(MAX) NULL,
    Event VARCHAR(MAX) NULL
);
--Populate table--
INSERT INTO dbo.Fact_Match (
    Match_ID,
    Match_Date,
    Match,
    Winner,
    Loser,
    Championship_Match,
    Match_Type,
    Event
)
SELECT
    Match_ID,
    Match_Date,
    Match,
    Winner,
    Loser,
    Championship_Match,
    Match_Type,
    Event
FROM dbo.MatchesTable;
--Check table creation--
Select * From dbo.Fact_Match;
--Add Primary Key to Fact_Match--
ALTER TABLE dbo.Fact_Match
ADD CONSTRAINT PK_Fact_Match PRIMARY KEY (Match_ID);
--Add Foreign Keys--
--Dim_Location--
ALTER TABLE dbo.Fact_Match
ADD CONSTRAINT FK_FactMatch_DimLocation
FOREIGN KEY (Match_ID) REFERENCES dbo.Dim_Location (Match_ID);
--Dim_Event--
ALTER TABLE dbo.Fact_Match
ADD CONSTRAINT FK_FactMatch_DimEvent
FOREIGN KEY (Match_ID) REFERENCES dbo.Dim_Event (Match_ID);
--Dim_Championship--
ALTER TABLE dbo.Fact_Match
ADD CONSTRAINT FK_FactMatch_DimChampionship
FOREIGN KEY (Match_ID) REFERENCES dbo.Dim_Championship (Match_ID);
--Dim_MatchType--
ALTER TABLE dbo.Fact_Match
ADD CONSTRAINT FK_FactMatch_DimMatchType
FOREIGN KEY (Match_ID) REFERENCES dbo.Dim_MatchType (Match_ID);
--Dim_Result--
ALTER TABLE dbo.Fact_Match
ADD CONSTRAINT FK_FactMatch_DimResult
FOREIGN KEY (Match_ID) REFERENCES dbo.Dim_Result (Match_ID);
--Dim_Date--
ALTER TABLE dbo.Fact_Match
ADD CONSTRAINT FK_FactMatch_DimDate
FOREIGN KEY (Match_Date) REFERENCES dbo.Dim_Date (Match_Date);

