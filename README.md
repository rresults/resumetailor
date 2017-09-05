# resumer: Resume tailor

In case you have diverse work experience you would like to highlight specific job records and to hide others. `resumer` is a set of R scripts and markdown template. You keep your work experience records in YAML file. Each record is labelled with tags and values. For example, you could mark a record with tag `research` and value one. When you build a tailored resume you specify what tags are relevant to new position. The position is linked with research, so you limit your resume with experience relevant to research. All records labelled with `research` tag will be added to the resume. The value of a tag how job achievements will be sorted.

## Steps to convert yaml records to markdown 

1. All related positions are sorted in accumulated tags value and reverse chronological order.
    
    1. For every position all results are filtered by tags 
    2. For all filtered results total tags value is calculated.
    
2. In each position all related results are presented and sorted in accumulated tags value.
