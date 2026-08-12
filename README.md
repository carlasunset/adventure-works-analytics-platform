# Adventure Works Analytics Platform

A modern analytics platform built to transform Adventure Works transactional sales data into reliable, documented, and analytics-ready data products.

The project uses **dbt and Databricks** to implement a dimensional data warehouse designed around business questions related to sales performance, customers, products, geography, payment methods, and sales reasons.

The platform emphasizes **data quality, dimensional modeling, metric consistency, lineage, governance, and safe consumption by BI tools**.

---

## Business Context

Adventure Works needs a reliable analytical foundation to support sales decision-making.

The platform was designed to answer questions such as:

* How many orders were placed and how many units were sold?
* How much gross and net revenue was generated?
* Which products generate the highest average ticket?
* Who are the highest-value customers?
* Which cities generate the most revenue?
* How do sales evolve over time?
* Which products sell the most when the sales reason is `Promotion`?

The analytical model also needs to support filtering and segmentation by:

* product;
* customer;
* sales date;
* credit card type;
* sales reason;
* order status;
* city;
* state;
* country.

---

## Architecture

The analytics workflow follows a layered dbt architecture:

```text
Adventure Works Source
        │
        ▼
     Sources
        │
        ▼
     Staging
        │
        ▼
   Intermediate
        │
        ▼
 Dimensional Marts
        │
        ▼
     Power BI
```

### Sources

Defines the raw Adventure Works tables used by the project and applies source-level documentation and data quality tests.

### Staging

Standardizes the source data while preserving its original grain.

Responsibilities include:

* column selection and renaming;
* data type normalization;
* string standardization;
* controlled value corrections;
* preparation of clean analytical inputs.

### Intermediate

Centralizes joins and reusable business transformations before publication.

This layer is also used to safely resolve relationships that could otherwise introduce **fanout or duplicated metrics**.

### Marts

Provides the dimensional models consumed by analytics and BI.

Published marts include:

* fact tables;
* dimensions;
* relationship models required for analytical filtering.

The marts are protected with **dbt contracts and data tests**.

---

## Dimensional Model

The core sales model is centered around:

### `fct_sales`

**Grain:** one row per sales order item.

The fact contains the keys required to analyze each sold item across the main business dimensions.

Core measures include:

* order quantity;
* unit price;
* gross sales amount;
* discount amount;
* net sales amount.

### Dimensions

Current analytical dimensions include:

* `dim_product`
* `dim_customer`
* `dim_date`
* `dim_credit_card`
* `dim_address`
* `dim_sales_reason`

Additional relationship models are used where the source relationship cannot safely be represented as a simple one-to-many join.

---

## Handling Many-to-Many Sales Reasons

An order can be associated with multiple sales reasons.

Joining sales reasons directly to the sales fact would therefore increase the number of rows and duplicate financial measures.

The project handles this relationship separately, preserving the original sales fact grain and preventing accidental fanout.

For analytical consumption, sales reason is treated as an **association/filtering dimension rather than an additive financial grain**.

This distinction is documented because financial values filtered by multiple reasons must not be summed across sales reasons as if the categories were mutually exclusive.

---

## Core Metrics

The analytical layer uses consistent metric definitions.

| Metric             | Definition                           |
| ------------------ | ------------------------------------ |
| Number of Orders   | Distinct count of sales orders       |
| Purchased Quantity | Sum of order quantity                |
| Gross Sales        | `Order Quantity × Unit Price`        |
| Discount Amount    | `Gross Sales × Unit Price Discount`  |
| Net Sales          | `Gross Sales - Discount Amount`      |
| Average Ticket     | Net sales divided by distinct orders |

Metric definitions are centralized so that transformations and BI calculations do not introduce conflicting business logic.

---

## Data Quality

Data quality is treated as part of the analytical architecture rather than as a final validation step.

The project currently includes:

* source tests;
* primary key tests;
* relationship tests;
* uniqueness and not-null validations;
* singular business-rule tests;
* fanout validation;
* reconciliation tests;
* dbt model contracts.

A model is not considered ready for consumption simply because it executes successfully.

Its grain, keys, relationships, metrics, tests, and downstream behavior must also be validated.

---

## Financial Reconciliation

One of the key financial controls validates Adventure Works gross sales for **2011**.

Expected gross sales:

```text
$12,646,112.16
```

A dedicated dbt reconciliation test verifies that the analytical transformation reproduces this value from the underlying sales transactions.

This control helps ensure that transformations do not introduce:

* missing transactions;
* duplicated transactions;
* incorrect joins;
* incorrect metric calculations;
* unexpected changes in financial totals.

---

## Technology Stack

| Component       | Technology   |
| --------------- | ------------ |
| Data Warehouse  | Databricks   |
| Transformation  | dbt          |
| Development     | dbt Cloud    |
| Language        | SQL / Jinja  |
| Version Control | Git / GitHub |
| BI              | Power BI     |
| Documentation   | dbt Docs     |

---

## Repository Structure

```text
.
├── models/
│   ├── staging/
│   │   ├── sales/
│   │   ├── production/
│   │   └── person/
│   │
│   ├── intermediate/
│   │
│   └── marts/
│       ├── dimensions/
│       └── facts/
│
├── seeds/
├── tests/
├── macros/
├── docs/
├── dbt_project.yml
└── README.md
```

The repository structure follows the transformation lifecycle rather than mirroring the transactional database directly.

---

## Development Workflow

Changes are developed using a controlled Git workflow:

```text
Feature Branch
      ↓
Implementation
      ↓
dbt Build
      ↓
Validation
      ↓
Commit
      ↓
Pull Request
      ↓
Merge
```

Branches are organized around cohesive development cycles or features rather than individual models whenever possible.

---

## Validation

The project has been validated through:

* source profiling;
* grain analysis;
* cardinality analysis;
* join fanout checks;
* row-count reconciliation;
* financial reconciliation;
* dbt tests;
* dbt contracts;
* full `dbt build` execution;
* generated dbt documentation;
* lineage inspection.

The current sales fact preserves the expected sales-order-item grain across **121,317 sales items**.

---

## Analytics Consumption

The dimensional layer is designed to support an interactive **Power BI dashboard**.

The dashboard provides analysis across:

* sales performance;
* products;
* customers;
* geography;
* time;
* payment methods;
* sales reasons.

Business logic is intentionally kept in the analytics layer whenever possible rather than being duplicated inside BI.

---

## Engineering Principles

The project follows a few core principles:

> Business process before fact table.

> Grain before joins.

> Cardinality before aggregation.

> Data quality before publication.

> One definition for each metric.

> No join is considered safe without fanout analysis.

These principles guide both modeling decisions and implementation choices throughout the platform.

---

## Project Status

The core analytical warehouse is operational.

Completed components include:

* source modeling;
* staging models;
* intermediate transformations;
* dimensional sales model;
* fact and dimensions;
* sales reason relationship modeling;
* data quality tests;
* financial reconciliation;
* dbt contracts;
* dbt documentation and lineage.

Current work is focused on:

* analytical consumption in Power BI;
* validating the complete set of business questions;
* final technical documentation;
* conceptual dimensional model;
* delivery documentation.

---

## Author

**Carla Lira Rodrigues**

Analytics Engineering • dbt • Databricks • SQL • Power BI
