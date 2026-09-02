## Beejan Technology – Conceptual Customer Complaint Data Pipeline

# Problem Statement

Beejan Technology receives thousands of customer complaints through different channels, including social media, call centres, SMS, website forms and network logs. The data is stored in different formats and locations, while reporting is manually compiled using spreadsheets. This results in delayed reports, duplicated work and data silos.

The goal of this conceptual pipeline is to bring the different data sources together, preserve the raw data, clean and enrich it, and make trusted data available for reporting and analysis.

## Conceptual Flow

<img width="765" height="60" alt="image" src="https://github.com/user-attachments/assets/83ff8b9a-ffb0-4b44-95fd-6375748cc380" />

Note: The design is conceptual at this stage, so no specific tools have been selected.

## The Conceptual Pipeline Architecture diagram:
<img width="988" height="255" alt="image" src="https://github.com/user-attachments/assets/f1164cb0-2cbe-427c-8e3a-df1be2584565" />

#   Design Choices
## Source Identification & Ingestion

The main complaint sources are social media, call centres, SMS, website forms and network logs. Billing and customer information are also assumed to be available for enrichment.

These sources provide data in different formats and at different frequencies. For example, social media and SMS complaints may arrive continuously, while call-centre or reporting data may be provided as files periodically.

Because of these differences, I would use both streaming and batch ingestion methods. 

I would not make every source real-time because this may add unnecessary complexity. The ingestion method should depend on how quickly the business needs the data.

## Storage

I propose having a raw storage layer and a clean data layer. (i.e a Data lake and a Datawarehouse)

The raw layer preserves the original data received from each source. This provides historical records and allows the data to be reprocessed if transformation rules change.

The clean layer contains cleaned, standardized and enriched data that is ready for analysis and reporting.

## Processing & Transformation

The processing stage will:

  - Validate incoming data.
  - Handle missing or invalid values.
  - Standardize dates, fields and categories.
  - Identify and remove duplicate records.
  - Enrich complaints with customer, billing, network or location information.
  - Classify complaints into categories such as Network, Billing, Customer Service, SIM etc

For example, a complaint such as *"My internet has been very slow since yesterday"* could be classified as a Network or Internet Issue.

## Serving

The cleaned data will be made available for business users through reports, dashboards and analytical datasets.

Management could monitor complaint volume, complaint categories, locations, trends and resolution times. Customer service and network teams could investigate recurring complaints and identify areas requiring attention.

## Orchestration, Monitoring & Data Quality

The pipeline should run according to the needs of each data source. Some sources may require near-real-time processing, while others may run hourly or daily.

The pipeline should also be monitored so that failures can be detected quickly. For example, the system should identify if a file was not received, an ingestion process failed, or an unusual amount of data was received.

Data-quality checks should also be included. These checks can identify missing values, duplicate records, invalid dates and unexpected data formats.

When a major failure occurs, an alert should be sent to the responsible team so that the issue can be investigated and the pipeline restarted or corrected.

## Assumptions
Because Beejan Technology is an imaginary company, the following assumptions have been made:

  - The company has access to the stated complaint sources.
  - Some sources provide APIs while others provide files or records periodically.
  - Customer, billing and network information are available for enrichment.
  - Some complaints need near-real-time processing, while others can be processed in batches.
  - The company needs historical complaint data for trend analysis.

## Challenges & Unknowns
The major Challenge is that the same customer may contact the company through multiple channels about the same issue. 
The pipeline therefore needs to distinguish between genuine duplicate records and multiple interactions from the same customer.

Some important details are still unknown and would need to be confirmed before implementation. 
These include, the actual data volumes, exact formats, ingestion frequencies, and how customers will be identified across different channels.


The expected result, will help Beejan Technology understand customer problems more quickly, identify recurring issues and make better decisions based on consistent data.
