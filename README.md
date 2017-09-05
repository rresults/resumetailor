# resumer: Resume tailor

In case you have diverse work experience you would like to highlight specific job records and to hide others. `resumer` is a set of R scripts and markdown template. You keep your work experience records in YAML file. Each record is labelled with tags and values. For example, you could mark a record with tag `research` and value one. When you build a tailored resume you specify what tags are relevant to new position. The position is linked with research, so you limit your resume with experience relevant to research. All records labelled with `research` tag will be added to the resume. The value of a tag how job achievements will be sorted.

## Experience records file

Each record consists of position title, name of organization, period of work, description of job and one or more results. Each result has to be labelled at least by one tag. Value of each tag is relative: the bigger the tag value, the higher in final resume it will be posted.


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

## The resume tailoring algorithm

A user keeps all job records in a yaml file. Also he/she has `head.md` and `tail.md` files to be added to the resume. When the user wants to generate a new resume he/she specifies tags of interest. Then script does the following:

1. Filters all positions where at least one of tags of interest presented.
2. For each position keeps only results records with tags of interest.
3. For each result calculates total value of tags and sort them accordingly. 
4. For each position calculates total value of tags and sort them (with respect to passed years also).
5. From selected positions and results generates Markdown file `jobs.md`.
6. Converts these three Markdown files to a single PDF with help of Pandoc and LaTeX.

## Resume building workflow

1. Put your job records in `source/alex_jobs.yaml` file.
2. Edit 'head.md` and `tail.md` in `source` directory.
3. Source `generate_jobs.R` file.
3. Run `generate_pdf()` function. It expects to find pandoc binary in `/usr/bin/pandoc`.
4. Get your resume in `cv.pdf`.


