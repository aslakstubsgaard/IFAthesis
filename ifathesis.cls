%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% IFAthesis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This LaTex class file is developed for theses, written at IFA, Aarhus University.
% Made by Aslak Stubsgaard - 2016
%    Copyright (c)  2016  Aslak Stubsgaard.
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
% This class file is based on the MIT thesis class file see:
% http://web.mit.edu/thesis/tex/ for the mitthesis.cls
% The above copyright only apply to the extend that it does not infringe on the 
% copyright of the source material, seen below.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ORIGINAL COPYRIGHT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Documentclass options (vi and upcase) and changes to copyright notice
%	Copyright (c) 1990, by Krishna Sethuraman.
%
% Pagestyle and header generation
%	Copyright (c) 1987, 1988 by Peter Nuth
%
% Original version
%	 Copyright (c) 1987 by Stephen Gildea
% Permission to copy all or part of this work is granted, provided
% that the copies are not made or distributed for resale, and that
% the copyright notice and this notice are retained.
%
% THIS WORK IS PROVIDED ON AN "AS IS" BASIS.  THE AUTHOR PROVIDES NO
% WARRANTY WHATSOEVER, EITHER EXPRESS OR IMPLIED, REGARDING THE WORK,
% INCLUDING WARRANTIES WITH RESPECT TO ITS MERCHANTABILITY OR FITNESS
% FOR ANY PARTICULAR PURPOSE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LOG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changes are mainly pertaining to the copyrightnotice and copyrightnoticetext,
% removal of 'vi' option, crest inclusion, department and university name, and
% the layout of this class file.
% Aslak Stubsgaard - April 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BASICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ifathesis}[2016/04/07]

% Need to lead crests in abstractpage
\RequirePackage{graphicx}

\def\mystretch{1.5}		% Double spacing hack
\DeclareOption{doublespace}{}	% This is default
				% So we do not read this style twice
\DeclareOption{singlespace}{		% If he explicitly wants single spacing
    \typeout{Single spaced}
    \def\mystretch{1}}

\DeclareOption{upcase}{\typeout{Uppercase cover page.}
	\gdef\choosecase#1{\uppercase\expandafter{#1}}}
\def\choosecase#1{#1}

%% leftblank option by Kevin Fu
\newif\if@leftblank \@leftblankfalse

\DeclareOption{leftblank}{\typeout{Intentionally Leaving Pages Blank}
\@leftblanktrue}

%  Thesis looks much like report
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}

% If the user wants single spacing, set baselinestretch=1.

\usepackage{setspace}

% Note - doublespace.sty has some float-related troubles in
% combination with graphics or color, and is not officially compliant
% with 2e.  setspace is a replacement which is 2e-compliant.

% Read the doublespace style that we got from Rochester:
%\input setdoublespace.sty

\def\baselinestretch{\mystretch}	% Double spacing hack
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%  Set up margins and formatting params %%%%%%%%%%%%%%%%%%%%
% Margins.
%  Note we want 1in top margin assuming no header line, so push header
%	into 1in margin.
%  Draft mode brings the header back down.

\setlength{\oddsidemargin}{0.25in}	% 1.25in left margin
\setlength{\evensidemargin}{0.25in}	% 1.25in left margin (even pages)
\setlength{\topmargin}{0.0in}		% 1in top margin
\setlength{\textwidth}{6.0in}		% 6.0in text - 1.25in rt margin
\setlength{\textheight}{9in}		% Body ht for 1in margins
\addtolength{\topmargin}{-\headheight}	% No header, so compensate
\addtolength{\topmargin}{-\headsep}	% for header height and separation

% The next two macros compensate page style for headers and footers
% We only need them in page styles that USE headers and footers.
    % If we have a header, it must be 1in from top of page.
\def\pulldownheader{			% Shift header down 1in from top
    \addtolength{\topmargin}{\headheight}
    \addtolength{\topmargin}{\headsep}
    \addtolength{\textheight}{-\headheight}
    \addtolength{\textheight}{-\headsep}
}
    % If we have a footer, put it 1in up from bottom
\def\pullupfooter{				% Shift footer up
    \addtolength{\textheight}{-\footskip}
%    \addtolength{\textheight}{-\footheight}  %footheight doesn't
%    						exist in 2e
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%  Fix various header and footer problems %%%%%%%%%%%%%%%%%%%
% Draft mark on the right side of left pages (outside)
% this mark is also the only one visible on single sided.
\newcommand{\draftrmark}{**DRAFT**}
% Draft mark on the left side of right pages (outside)
\newcommand{\draftlmark}{**DRAFT**} %

% Macros to make changing the Draft easier
\newcommand{\drmark}[1]{\renewcommand{\draftrmark}{#1}}
\newcommand{\dlmark}[1]{\renewcommand{\draftlmark}{#1}}
\newcommand{\dmark}[1]{\drmark{#1}\dlmark{#1}}

% Format for draft of thesis.  Define our own PageStyle -
% Just like headings, but has foot lines with the date and warning

\if@twoside         % If two-sided printing.
\def\ps@drafthead{
    \let\@mkboth\markboth
    \def\@oddfoot{\rm \today \hfil \sc \draftrmark}
    \def\@evenfoot{\sc \draftlmark \hfil \rm \today }
    \def\@evenhead{\rm \thepage\hfil \sl \leftmark}
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
    \def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}{}}
    \def\sectionmark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\z@
	\thesection. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
    \pullupfooter				% Bring footer up
}
\else               % If one-sided printing.
\def\ps@drafthead{
    \let\@mkboth\markboth
    \def\@oddfoot{\rm \today \hfil \sc \draftrmark}
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
    \def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
    \pullupfooter				% Bring footer up
}
\fi

% I redefine these formats that were defined in report.sty
% Definition of 'headings' page style
%  Note the use of ##1 for parameter of \def\chaptermark inside the
%  \def\ps@headings.
%

\if@twoside					% If two-sided printing.
\def\ps@headings{\let\@mkboth\markboth
    \def\@oddfoot{}
    \def\@evenfoot{}		% No feet.
    \def\@evenhead{\rm \thepage\hfil \sl \leftmark}	% Left heading.
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}	% Right heading.
    \def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}{}}
    \def\sectionmark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\z@
	\thesection. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
}
\else						% If one-sided printing.
\def\ps@headings{\let\@mkboth\markboth
    \def\@oddfoot{}
    \def\@evenfoot{}		%     No feet.
    \def\@oddhead{\hbox {}\sl \rightmark \hfil \rm\thepage}	% Heading.
    \def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
}
\fi

% Redefinition of 'myheadings' page style.
%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
    \def\@oddfoot{}
    \def\@evenfoot{}
    \def\sectionmark##1{}
    \def\subsectionmark##1{}
    \def\@evenhead{\rm \thepage\hfil\sl\leftmark\hbox {}}	%
    \def\@oddhead{\hbox{}\sl\rightmark \hfil \rm\thepage}	%
    \pulldownheader				% Bring header down from edge
}

% Redefine '/chapter' to always start on an odd page.
% Should make no difference in singleside mode.
%
\if@leftblank
% Prints "THIS PAGE INTENTIONALLY LEFT BLANK" on blank pages.
\def\chapter{\clearpage\ifodd\c@page\else
   \hbox{}\par\vfill\centerline%
   {THIS PAGE INTENTIONALLY LEFT BLANK}%
   \vfill\newpage\fi
   \thispagestyle{plain}	% Page style of chapter page is 'plain'
   \global\@topnum\z@		% Prevents figures from going at top of page.
   \@afterindentfalse		% Suppresses indent in first paragraph.  Change
   \secdef\@chapter\@schapter}	% to \@afterindenttrue to have indent.
\else
\def\chapter{\cleardoublepage	% Starts new page.
   \thispagestyle{plain}	% Page style of chapter page is 'plain'
   \global\@topnum\z@		% Prevents figures from going at top of page.
   \@afterindentfalse		% Suppresses indent in first paragraph.  Change
   \secdef\@chapter\@schapter}	% to \@afterindenttrue to have indent.
\fi
% If using the report style, use - instead of . in the figure number.
\@ifundefined{thechapter}{}{\def\thefigure{\thechapter-\arabic{figure}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COPYRIGHT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here's Gildea's Boilerplate Stuff.
% Copyright (c) 1987 by Stephen Gildea
% Permission to copy all or part of this work is granted, provided
% that the copies are not made or distributed for resale, and that
% the copyright notice and this notice are retained.

% The copyright notice stuff is a tremendous mess.
%
% \@copyrightnotice is used by \maketitle to actually put text on the
% page; it default is the GNU FDL.
% \copyrightnoticetext takes an argument and defined \@copyrightnotice
% to that argument.  \copyrightnotice takes an argument, and calls
% \copyrightnoticetext with that argument, preceeded by a copyright
% symbol and followed by the GNU FDL or the permission text.

% If there is no \copyrightnotice command, it is asssumed a GNU FDL copyright.
\def\@copyrightnotice{
\bigskip
\begin{quote}
    Copyright \copyright{}  {\@degreeyear}  {\@author}. \par
    Permission is granted to copy, distribute and/or modify this document
    under the terms of the GNU Free Documentation License, Version 1.3
    or any later version published by the Free Software Foundation;
    with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
    A copy of the license is included in the section entitled ``GNU
    Free Documentation License''.
\end{quote}
\bigskip
}

% If \copyrightnotice is specified the author takes ownership
\def\copyrightnotice{\copyrightnoticetext{
\copyright\ \@author\.  All rights reserved.\par\permission}
}

% if \copyrightnoticetext is specifed the author can choose the copyright terms
\long\def\copyrightnoticetext#1{\gdef\@copyrightnotice{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NAMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\thesisdate#1{\gdef\@thesisdate{#1}}

% typically just a month and year
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% Usage: \supervisor{name}{title}
%        \chairman{name}{title}

% since there can be more than one supervisor,
% we build the appropriate boxes for the titlepage and
% the abstractpage as the user makes multiple calls
% to \supervisor
\newbox\@titlesupervisor 	\newbox\@abstractsupervisor

\def\supervisor#1#2{\setbox\@titlesupervisor\vbox
  {\unvbox\@titlesupervisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Certified by}{#1 \\ #2 \\ Thesis Supervisor}}
  \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize
  \par\noindent Thesis Supervisor: #1 \\ Title: #2}}

% department chairman, not thesis committee chairman
\def\chairman#1#2{\gdef\@chairmanname{#1}\gdef\@chairmantitle{#2}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TITLEPAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% `upcase' documentclass option: \choosecase is defined either as a dummy or
%% a macro to change the (expanded) argument to uppercase.
\def\maketitle{\begin{titlepage}
\large
{\def\baselinestretch{1.2}\Large\bf \choosecase{\@title} \par}
by\par
{\Large  \choosecase{\@author}}
\par
\@prevdegrees
\par
\choosecase{Submitted to the} \choosecase{\@department} \\
\choosecase{in partial fulfillment of the requirements for the}
\choosecase{\@degreeword}
\choosecase{of}
\par
\choosecase{\@degree}
\par
at
\par\AU\par
\@degreemonth\ \@degreeyear
\vskip 3\baselineskip
\signature{Author}{\@department \\ \@thesisdate}
\par
\vfill
\unvbox\@titlesupervisor
\par
\vfill
\signature{Accepted by}{\@chairmanname \\ \@chairmantitle}
\vfill
\par
\@copyrightnotice
\par
\cleardoublepage
\end{titlepage}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ABSTRACTPAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this environment should probably be called abstract,
% but we want people to also be able to get at the more
% basic abstract environment
\def\abstractpage{%\cleardoublepage
\begin{center}{\large{\bf \@title} \\
by \\
\@author \\[\baselineskip]}
\par
\def\baselinestretch{1}\@normalsize
Submitted to the \@department \\
on \@thesisdate, in partial fulfillment of the \\
requirements for the \@degreeword\ of \\
\@degree
\par
at
\par\AU\par
\begin{center}
  \includegraphics[width=0.3\textwidth]{au.png}
  \hspace{1in}
  \includegraphics[width=0.3\textwidth]{ifa.png}
\end{center}\end{center}
\par
\begin{abstract}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COPYRGIHTPAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this environment should probably be called abstract,
% but we want people to also be able to get at the more
% basic abstract environment
\def\copyrightpage{%\cleardoublepage
\par\vspace*{\fill} % push copyrightnotice to the bottom of the page
\@copyrightnotice
\clearpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OTHER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define all the pieces that go on the title page and the abstract.

% \title and \author already exist

\def\prevdegrees#1{\gdef\@prevdegrees{#1}}
\def\@prevdegrees{}

\def\department#1{\gdef\@department{#1}}

% If you are getting two degrees, use \and between the names.
\def\degree#1{\setbox0\hbox{#1}	 %for side effect of setting \@degreeword
  \gdef\@degree{#1}}

% \and is used inside the \degree argument to separate two degrees
\def\and{\gdef\@degreeword{degrees} \par and \par}
\def\@degreeword{degree}

%% Changed from \unvbox to \unvcopy for use with multiple copies of abstract
%% page.
%% Krishna Sethuraman (1990)
\def\endabstractpage{\end{abstract}\noindent
 \unvcopy\@abstractsupervisor \newpage}

%% This counter is used to save the page number for the second copy of
%% the abstract.
\newcounter{savepage}

% You can use the titlepage environment to do it all yourself if you
% don't want to use \maketitle.  If the titlepage environment, the
% paragraph skip is infinitely stretchable, so if you leave a blank line
% between lines that you want space between, the space will stretch so
% that the title page fills up the entire page.
\def\titlepage{\cleardoublepage\centering
  \thispagestyle{empty}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}
% The \kern0pt pushes any depth into the height.  Thanks to Richard Stone.
\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}

\def\AU{Aarhus University}

\def\permission{\par\noindent{\centering
   The author hereby grants to \AU\ permission to reproduce and to
   distribute publicly paper and electronic copies of this thesis
   document in whole or in part in any medium now known or hereafter
   created.}\par}

\def\signature#1#2{\par\noindent#1\dotfill\null\\*
  {\raggedleft #2\par}}

\def\abstract{\subsection*{Abstract}\small\def\baselinestretch{1}\@normalsize}
\def\endabstract{\par}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
