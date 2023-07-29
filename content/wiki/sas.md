---
date:        "2023-07-28"
author: 'Wllyssys Alves'
title: SAS
publishdate: "2023-07-28"
lastmod:     "2023-07-28"
type: blog
---

# SAS


### Índice

1. LIBNAME
2. Aritmética
3. Data Step
4. Data e Posições
5. Consulta de Passagem
6. MACRO
7. Paralelismo
8. Outros




---

### LIBNAME


#### 1A Criando LIBNAMES

```sas

/* Com authdomain */
LIBNAME DADOS DB2 DATABASE=bancodedados SCHEMA=schema AUTHDOMAIN=usuario;

/* Com usuário e senha */
LIBNAME PG postgres SERVER='192.168.0.1' DATABASE='DATABASE' PORT='5432' USER='postgres' PASS='SENHA' schema='SCHEMA';

/* Para uma pasta */
LIBNAME DADOS '/CAMINHO/PARA/PASTA';

/* Para várias pastas com uma mesma LIBNAME */
LIBNAME DADOS ('/CAMINHO/PARA/PASTA1', '/CAMINHO/PARA/PASTA2');

/* Limpar todas as LIBNAMEs */
LIBNAME _ALL_ CLEAR;

```





### 2 Aritmética 

#### 2A Data step 

```SAS
data _null_;
	ano = year(today());
	anomes = (ano * 100) + month(today());
	call symputx("anomes", anomes);
run;

/* O valor de anomes pode ser acessado no código como uma macro. */
data dados_saida_&anomes;
	set dados_entrada;
run;
```


### 3 Data Step

SINTAXE
```SAS
DATA New-Dataset-Name (OPTIONS);
    SET Existing-Dataset-Name (OPTIONS);
    .
    .
    .
RUN;
```


```SAS
DATA sample_new_vars (DROP = height weight);
    SET sample;
    bmi = (weight / (height*height) ) * 703;
    height2 = height * 0.0254;
RUN;
```


```SAS
DATA sample_stringonly;
   SET sample(KEEP=ids _CHAR_);
RUN;

DATA sample_numericonly;
   SET sample(KEEP=ids _NUMERIC_);
RUN;
```

```SAS
 RENAME = (oldvariable1=newvariable1 oldvariable2=newvariable2 ...)
```

```SAS
DATA sample2 (RENAME=(Gender=Sex DOB=Date_of_Birth));
    SET sample;
RUN;
```


Usando switch/select
```sas
data Heart / view=Heart;
	set sashelp.heart;
	select (Smoking_Status);
	   when ('Non-smoker')        Smoking_Cat=1;
	   when ('Light (1-5)')       Smoking_Cat=2;
	   when ('Moderate (6-15)')   Smoking_Cat=3;
	   when ('Heavy (16-25)')     Smoking_Cat=4;
	   when ('Very Heavy (> 25)') Smoking_Cat=5;
	   otherwise                  Smoking_Cat=.;
	end;
run;
```




### 4 Datas e Posições

4a Buscar mês e ano atual com macro
```SAS
%LET ANO = %sysfunc(year("&sysdate"d));
%LET MES = %sysfunc(month("&sysdate"d));
```

4b Criando ANOMES - aritmética
```SAS
%LET MES_INI    = 1;
%LET MES_FIM    = %sysfunc(month("&sysdate"d));
%LET MES        = %sysfunc(month("&sysdate"d));
%LET ANOMES_INI = %eval(100*&ANO + &MES_INI);
%LET ANOMES     = %eval(100*&ANO + &MES_FIM);
```

Convertendo yyyymmdd de caractere para data !revisar
```SAS
data want_where_num;
  set have_with_num_date;
  date_new = input(put(date,8.), yymmdd8.);
  format date_new weekdate9. ;
run;
```

Formata datas do SAS para DB2
```sas
call symputx('mesano0',cat("'",put(intnx('month',intnx('year',today(),-0),-1),ddmmyyp10.),"'"));
```

Criando datetime
```sas
PROC SQL;
	CREATE TABLE BIC2_COUNT AS
	SELECT 
		MEMNAME
		,NOBS
		,dhms('23nov21'd, 23, 6, 11) format datetime20.  as posicao
	from dictionary.tables
    where 
		libname = "LIBNAME" AND 
		MEMNAME = "MEMNAME"
;QUIT;
```






Salvando dados de uma tabela em variáveis:

```SAS
proc sql;
	select posicao, mes, ano
	into :posicao , :mes , :ano
	from datas;
quit;
```

### Consulta de passagem (pass-through)


Consulta de passagem com authdomain
```SAS
proc sql;
	connect to db2 (DATABASE=DB01 AUTHDOMAIN=USUARIO);
	create table dados as 
	select * from connection to db2 (
		SELECT 
		*
		FROM schema.tabela 
		WHERE data_ref = current_date;
	) a;
	disconnect from db2;
quit;
```

Consulta de passagem com usuário e senha
```SAS
proc sql;
	connect to postgres (server='192.168.0.1' port=5432 user=usuario password=senha db=banco);
	create table dados as 
	select * from connection to postgres (
		select * from schema.tabela;
	) a;
	disconnect from postgres;
quit;
```



Executar SQL num banco de dados através do SAS.
```sas
PROC SQL;
	connect to db2 (authdomain=meuusuario database=meubancodedados);
	execute by db2 (delete from meuschema.minhatabela where coluna = 1338);
	disconnect from db2;
QUIT;
```


### MACRO

Sintaxe
```sas
%MACRO <macro name>(Param1, Param2,….Paramn);

Macro Statements;

%MEND;

/* Calling a Macro program */
%MacroName (Value1, Value2,…..Valuen);



/* OUTRO EXEMPLO */
%MACRO show_result(make_ , type_);
	proc print data = sashelp.cars;
	where make = "&make_" and type = "&type_" ;
	   TITLE "Sales as of &SYSDAY &SYSDATE";
	run;
%MEND;

%show_result(BMW,SUV);
```

Macro sintaxe IF ELSE
```sas
%IF condition %THEN action;  
	%ELSE %IF condition %THEN action;  
%ELSE action;  

%IF condition %THEN %DO;  
	action;  
%END
```



### Paralelismo

Executando duas consultas em paralelo
```sas
options autosignon sascmd = "!sascmd";  

SIGNON TASK1;
rsubmit TASK1 wait=no;
	/* BUSCANDO OS DADOS 1 */
	data _null_;
		mes = month(today());
		put mes;
	run;
endrsubmit;

signon task2;
rsubmit task2 wait=no;
	/* BUSCANDO OS DADOS 2*/
	data _null_;
		mes = year(today());
		put mes;
	run;
endrsubmit; 

waitfor _all_;
signoff _all_;
```

Fonte:
https://www.lexjansen.com/sesug/2016/PA-265_Final_PDF.pdf
https://www.lexjansen.com/nesug/nesug05/io/io2.pdf
https://stackoverflow.com/questions/36284342/sas-program-with-local-library-in-set-statement


Salvando os dados em paralelo numa LIBNAME.
```sas
options autosignon sascmd = "!sascmd"; 

SIGNON TASK1 SIGNONWAIT=NO;
rsubmit TASK1 wait=no;

%PUT NOTE-: iniciando_1;
 
libname mylib 'caminho';

proc sql;
	CONNECT TO db2 (DATABASE=bancodedados AUTHDOMAIN=usuario);
	create table mylib.tabela_1 as 
	select * from connection to db2 (
		SELECT * from schema.tabela ;
	) a ;
quit;
 
%PUT NOTE-: finalizando_1;
endrsubmit;
 

signon task2 SIGNONWAIT=NO;
rsubmit task2 wait=no;

%PUT NOTE-: iniciando_2;

/* mesmo caminho da lib anterior, muda apenas o nome */
libname mylib2 'caminho';

PROC SQL;
CONNECT TO db2 (DATABASE=bancodedados AUTHDOMAIN=usuario);
    CREATE TABLE mylib2.tabela_2 AS
    SELECT * FROM CONNECTION TO DB2
    (
        SELECT * from schema.outra_tabela
     ) a;
	DISCONNECT FROM DB2;
QUIT;
 
%PUT NOTE-: finalizando_2;
endrsubmit; 

*waitfor _all_;
signoff _all_;
```



Substituir tabela caso não dê erro.

```sas

%macro tratamentoDeErros2;

	%if &sysErr < 6 %then %do;
		data interno.tabela_1;
			set tabela_1;
		run;
	%end;

%mend;


%tratamentoDeErros2;
```

### Outros

Buscar nome da tabela mais recente por sufixo ANOMES.

```sas
proc sql noprint;
    select max(memname) as membername
    into :inadAtual separated by '","'
    from sashelp.vmember
    where libname = "DADOS"
      AND memname like "TABELA_2022%"
;
QUIT;




/* outra versao. precisa ser atualizada */
proc sql noprint;
	select 
		input(
			substr(
				max( scan(memname,5,'_') )
			,5,2)
		, 6.)
		,max( scan(memname,5,'_') )
	into :mes_max, :anomes_max
	from dictionary.tables
	where 
		libname = upcase("rlzmci")
		and memname like 'IND_000000977_RLZ_ANL_%';
quit;

%put &mes_max;
```



Criando um array separado por vírgula

Pode ser usado para quando quer se encarteirar MCIs por vários meses diferentes.

```SAS
DATA AUXILIAR;
    DO I=&MES_INI. TO &MES_FIM.;
        OUTPUT;
    END;
RUN;

PROC SQL NOPRINT;
    SELECT I INTO :meses_str Separated By ' '
        FROM AUXILIAR;
    DROP TABLE AUXILIAR;
RUN;

%PUT &meses_str;

```


Selecionar linhas de forma aleatória numa tabela.
```sas
PROC SURVEYSELECT 
	DATA=TABELA_ENTRADA
	OUT=TABELA_SAIDA
	METHOD=SRS
	SAMPSIZE=100000 SEED=1234567;
RUN;
```


Juntar várias tabelas com mesmo radical e adicionar a tabela de origem.

```sas
PROC SQL NOPRINT;
	SELECT 'DADOS.'||TRIM(MEMNAME) AS MEMNAME
	INTO :TABELAS SEPARATED BY ' '
	FROM SASHELP.VMEMBER
	WHERE LIBNAME = "DADOS"
	AND MEMNAME LIKE "TABELA_2023%"
;QUIT;

DATA TODAS_TABELAS;
	SET &TABELAS INDSNAME=DSNAME;

	/* NESSE CASO PEGO APENAS PARTE DO NOME DA TABELA DE ENTRADA */
	ANOMES_ARQ = INPUT(SCAN(DSNAME, -1, '_'), 6.);
RUN;
```


Limpar acentos - preciso ajustar. adiciona underscore.
```sas
%MACRO LIMPAR_ACENTO(STRING);

	&STRING = UPCASE(&STRING);
	&STRING = TRANWRD(&STRING, 'Á', 'A');
	&STRING = TRANWRD(&STRING, 'É', 'E');
	&STRING = TRANWRD(&STRING, 'Í', 'I');
	&STRING = TRANWRD(&STRING, 'Ó', 'O');
	&STRING = TRANWRD(&STRING, 'Ú', 'U');

	&STRING = TRANWRD(&STRING, 'Ã', 'A');
	&STRING = TRANWRD(&STRING, 'Ê', 'E');
	&STRING = TRANWRD(&STRING, 'Ô', 'O');
	&STRING = TRANWRD(&STRING, 'Ç', 'C');
	&STRING = TRIM(&STRING);
	

%MEND LIMPAR_ACENTO;
```


Concatenar agregar array aggregate 
Juntar valores de linhas por coluna numa linha.

|cod1|cod2|
|---|---|
|A|1|
|A|2|
|A|3|
|B|5|
|B|6|

Após rodar ficará assim

|cod1|cod2s|
|---|---|
|A| 1,2,3|
|B|5,6|


```sas
data TEST3(DROP=CD_MDLD RENAME=CAT=MODALIDADES) ;

    length cat $1000;

    retain cat ;

set PRDS ;

    by CD_PRD notsorted ;

        if first.CD_PRD then cat = cats(CD_MDLD) ;

            else cat = catx(' , ',cat,CD_MDLD) ;

        if last.CD_PRD then output ;

run ;
```


