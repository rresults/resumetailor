# resumer: Resume tailor

In case you have diverse work experience you would like to highlight specific job records and to hide others. `resumer` is a set of R scripts and markdown template. You keep your work experience records in YAML file. Each record is labelled with tags and values. For example, you could mark a record with tag `research` and value one. When you build a tailored resume you specify what tags are relevant to new position. The position is linked with research, so you limit your resume with experience relevant to research. All records labelled with `research` tag will be added to the resume. The value of a tag how job achievements will be sorted.

## Experience records file


```yaml
Research consultant:
  org: The Danish-Russian Economic Development Support Programme
  period: [2008-03-01, 2010-12-01]
  desc: Providing training and support to educational institutions in conducting market research 
  results:
    - Developing and conducting research project based on requirements of Danish International Development Agency:
       eu: 1
       research: 1
    - Training and consultations of educational facilities staff in field of sociological and marketing research:
       train: 1
       research: 1
    - Developing of software system for questionnaire design, opinion poll data input and computing of descriptive statistics (based on LimeSurvey and queXML):
       research: 1
       it: 1
       floss: 1
    - Composing a manual for staff of educational facilities on methods of sociological research and using of developed system:
       train: 2
```


## Steps to convert yaml records to markdown 

1. All related positions are sorted in accumulated tags value and reverse chronological order.
    
    1. For every position all results are filtered by tags 
    2. For all filtered results total tags value is calculated.
    
2. In each position all related results are presented and sorted in accumulated tags value.
