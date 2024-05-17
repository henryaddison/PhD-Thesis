\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uob-phd-thesis}[2024/05/16 University of Bristol thesis template]

\RequirePackage[l2tabu]{nag} % Warns for incorrect (obsolete) LaTeX usage

\RequirePackage{xkeyval}

%% variable holding whether entire document should be one- or two-sided
\newtoks\@uobtwoside
\@uobtwoside={semi}

\PassOptionsToClass{
  a4paper,
  twoside={\the\@uobtwoside},
  fontsize=11pt,
  listof=totoc,
  listof=chapterentry,
  titlepage=firstiscover,
}{scrbook}

\DeclareOptionX{twoside}{\@uobtwoside={true}}

%% Forward other options to KOMA
\DeclareOptionX*{%
  \PassOptionsToClass{\CurrentOption}{scrbook}
}
\ProcessOptionsX*\relax
%% LOAD KOMA CLASS

\LoadClass{scrbook}
\RequirePackage{scrlayer-scrpage}

%% Font options

\usepackage[T1]{fontenc}
\usepackage{microtype}

\setkomafont{disposition}{\bfseries}
\addtokomafont{title}{\Huge}
\linespread{1.5} % some extra spacing

%% Set page style and recalculate type area

\KOMAoptions{headinclude=true, DIV=10}

\renewcommand*{\partpagestyle}{empty}
\pagestyle{scrheadings}
\cfoot*{\pagemark}
\ofoot[]{}
\ifoot[]{}

\recalctypearea

%% Load useful packages

\RequirePackage[british]{datetime2}
\DTMlangsetup[en-GB]{ord=omit}

% \RequirePackage{bristol-colours}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{wasysym}
\RequirePackage{stmaryrd}
\RequirePackage{fontawesome}
\RequirePackage{mleftright}
\RequirePackage{ifthen}
\RequirePackage{scalerel}
\RequirePackage{epigraph}
\RequirePackage{datetime}
\RequirePackage{enumitem}
\RequirePackage{array}
\RequirePackage{mathtools}
\RequirePackage{etoolbox}
\RequirePackage{thmtools}
\RequirePackage{import}

\RequirePackage[autostyle=false, style=english]{csquotes}
\RequirePackage[british]{babel}
\RequirePackage[
  backend=biber,
  style=authoryear, doi=true,
  backref=true,
  sortcites=true,
  style=authoryear,
  maxnames=1000,
  mincrossrefs=99,
  sorting=nyt,
  sortcites,
  url=false
]{biblatex}

%% Hyperref

\usepackage[pdfusetitle,hyperfootnotes=false]{hyperref}
\usepackage{hyperref}
\usepackage[capitalize,nameinlink]{cleveref}
\hypersetup{breaklinks=true,colorlinks=true,pdfinfo={
  Title={PhD Thesis},
  Author={Henry Addison}
}}%,linkcolor=UniversityRed,urlcolor=UniversityRed, citecolor=UniversityRed}

%% TITLE PAGE

\NewDocumentCommand{\printdatewithoutmonth}{m}{
  \DTMdefboolkey{en-GB}{showdayofmonth}[false]{}
  \DTMusedate{#1}
  \DTMdefboolkey{en-GB}{showdayofmonth}[true]{}
}


\newtoks\@school
\NewDocumentCommand{\school}{m}{\@school={#1}}

\newtoks\@faculty
\NewDocumentCommand{\faculty}{m}{\@faculty={#1}}

\newtoks\@date
\RenewDocumentCommand{\date}{m}{\@date={#1}}

\newtoks\@wordcount
\NewDocumentCommand{\wordcount}{m}{\@wordcount={#1}}

\defpairofpagestyles[plain.scrheadings]{titlepage}{
  \cfoot[]{}
  \ofoot*{\normalfont Word count: \the\@wordcount}
}
% \renewcommand*{\titlepagestyle}{titlepage}
\titlehead{\thispagestyle{titlepage} \recalctypearea}

\publishers{
  \bigskip\bigskip\bigskip
  \includegraphics[width=0.5\textwidth]{logos/UoB_RGB_24.png} \\[2em]
  A dissertation submitted to the University of Bristol in accordance with the requirements for award of the degree of Doctor of Philosophy in the {\the\@faculty}. \\[2em]
  \the\@school \\
  \the\@date \\
}

\NewDocumentEnvironment{abstract}{+b}{
  \recalctypearea
  \thispagestyle{empty}
  \begin{center}
    {\Large\bfseries Abstract}\\
  \end{center}
  \bigskip
  {#1}
  \cleardoubleoddemptypage
}{}

\NewDocumentEnvironment{dedicationandacknowledgements}{+b}{
  \thispagestyle{empty}
  \begin{center}
    \Large\bfseries Dedication and acknowledgements
  \end{center}
  \bigskip
  {#1}
  \cleardoubleoddemptypage
}{}

\NewDocumentEnvironment{covid}{+b}{
  \thispagestyle{empty}
  \begin{center}
    \Large\bfseries Covid-19 statement
  \end{center}
  \bigskip
  \quotation
  {#1}
  \endquotation
  \cleardoubleoddpage
}{}

\NewDocumentEnvironment{declaration}{+b}{
  \thispagestyle{empty}
  \thispagestyle{empty}
  \begin{center}
    \Large\bfseries Author's Declaration
  \end{center}
  \bigskip
  \quotation
  {#1}
  \endquotation
  \@author \\
  \DTMusedate{thesisdate}
  \cleardoubleoddpage
}{}
