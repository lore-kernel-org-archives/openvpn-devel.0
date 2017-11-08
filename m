MIME-Version: 1.0
In-Reply-To: <1510135312-16578-1-git-send-email-steffan.karger@...1435...>
References: <20171108094835.GK958@...1296...>
 <1510135312-16578-1-git-send-email-steffan.karger@...1435...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 8 Nov 2017 15:21:34 +0500
Message-ID: <CAFHpkQETyNExfOK2pY-acMBjv-t=UsVj5AkARJqdonowk0LRtA@...278...>
Content-Type: multipart/alternative; boundary="001a1140b7ca5e4ea6055d760d38"
Subject: Re: [Openvpn-devel] [PATCH v2] doxygen: add make target and use
 relative paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1140b7ca5e4ea6055d760d38
Content-Type: text/plain; charset="UTF-8"

2017-11-08 15:01 GMT+05:00 Steffan Karger <steffan.karger@...1435...>:

> Add a make target, such that 'make doxygen' works (both for in-tree and
> out-of-tree builds).
>


should we add both variants of 'make doxygen' to travis-ci matrix ?


>
> While doing so, instead of genering docs with full path names (e.g.
> /home/steffan/dev/openvpn/src/openvpn/crypto.h), use a relative path wrt
> the project root (e.g. src/openvpn/crypto.h) in the generated
> documentation.  This makes the generated doxygen easier to read.
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2:
>  - merge patches 1/2 and 2/2 from the v1 set
>  - use abs_top_srcdir (instead of top_srcdir)
>
>  Makefile.am                     |   5 +-
>  configure.ac                    |   1 +
>  doc/Makefile.am                 |   2 +
>  doc/doxygen/openvpn.doxyfile    | 279 ------------------------------
> ----------
>  doc/doxygen/openvpn.doxyfile.in | 279 ++++++++++++++++++++++++++++++
> ++++++++++
>  5 files changed, 286 insertions(+), 280 deletions(-)
>  delete mode 100644 doc/doxygen/openvpn.doxyfile
>  create mode 100644 doc/doxygen/openvpn.doxyfile.in
>
> diff --git a/Makefile.am b/Makefile.am
> index 87af724..34632c4 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -46,7 +46,7 @@ EXTRA_DIST = \
>         contrib \
>         debug
>
> -.PHONY: config-version.h
> +.PHONY: config-version.h doxygen
>
>  if GIT_CHECKOUT
>  BUILT_SOURCES = \
> @@ -96,3 +96,6 @@ config-version.h:
>         else \
>                 rm -f config-version.h.tmp; \
>         fi
> +
> +doxygen: doc/doxygen/openvpn.doxyfile
> +       doxygen doc/doxygen/openvpn.doxyfile
> diff --git a/configure.ac b/configure.ac
> index 45aa501..eca83e6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1420,6 +1420,7 @@ AC_CONFIG_FILES([
>         distro/rpm/Makefile
>         distro/rpm/openvpn.spec
>         distro/systemd/Makefile
> +       doc/doxygen/openvpn.doxyfile
>         include/Makefile
>         src/Makefile
>         src/compat/Makefile
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index dedd1fa..f9e7f4a 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -14,6 +14,8 @@ MAINTAINERCLEANFILES = \
>
>  CLEANFILES = openvpn.8.html
>
> +SUBDIRS = doxygen
> +
>  dist_doc_DATA = \
>         management-notes.txt
>
> diff --git a/doc/doxygen/openvpn.doxyfile b/doc/doxygen/openvpn.doxyfile
> deleted file mode 100644
> index a7d9728..0000000
> --- a/doc/doxygen/openvpn.doxyfile
> +++ /dev/null
> @@ -1,279 +0,0 @@
> -# Doxyfile 1.5.5
> -
> -#----------------------------------------------------------
> -----------------
> -# Project related configuration options
> -#----------------------------------------------------------
> -----------------
> -DOXYFILE_ENCODING      = UTF-8
> -PROJECT_NAME           = "OpenVPN"
> -PROJECT_NUMBER         =
> -OUTPUT_DIRECTORY       = doxygen
> -CREATE_SUBDIRS         = NO
> -OUTPUT_LANGUAGE        = English
> -BRIEF_MEMBER_DESC      = YES
> -REPEAT_BRIEF           = YES
> -ABBREVIATE_BRIEF       = "The $name class" \
> -                         "The $name widget" \
> -                         "The $name file" \
> -                         is \
> -                         provides \
> -                         specifies \
> -                         contains \
> -                         represents \
> -                         a \
> -                         an \
> -                         the
> -ALWAYS_DETAILED_SEC    = NO
> -INLINE_INHERITED_MEMB  = NO
> -FULL_PATH_NAMES        = YES
> -STRIP_FROM_PATH        = ""
> -STRIP_FROM_INC_PATH    =
> -SHORT_NAMES            = NO
> -JAVADOC_AUTOBRIEF      = YES # NO
> -QT_AUTOBRIEF           = NO
> -MULTILINE_CPP_IS_BRIEF = NO
> -DETAILS_AT_TOP         = NO
> -INHERIT_DOCS           = YES
> -SEPARATE_MEMBER_PAGES  = NO
> -TAB_SIZE               = 8
> -ALIASES                =
> -OPTIMIZE_OUTPUT_FOR_C  = YES
> -OPTIMIZE_OUTPUT_JAVA   = NO
> -OPTIMIZE_FOR_FORTRAN   = NO
> -OPTIMIZE_OUTPUT_VHDL   = NO
> -BUILTIN_STL_SUPPORT    = NO
> -CPP_CLI_SUPPORT        = NO
> -SIP_SUPPORT            = NO
> -DISTRIBUTE_GROUP_DOC   = NO
> -SUBGROUPING            = YES
> -TYPEDEF_HIDES_STRUCT   = NO
> -#----------------------------------------------------------
> -----------------
> -# Build related configuration options
> -#----------------------------------------------------------
> -----------------
> -EXTRACT_ALL            = YES
> -EXTRACT_PRIVATE        = YES
> -EXTRACT_STATIC         = YES
> -EXTRACT_LOCAL_CLASSES  = YES
> -EXTRACT_LOCAL_METHODS  = YES
> -EXTRACT_ANON_NSPACES   = YES
> -HIDE_UNDOC_MEMBERS     = NO
> -HIDE_UNDOC_CLASSES     = NO
> -HIDE_FRIEND_COMPOUNDS  = NO
> -HIDE_IN_BODY_DOCS      = NO
> -INTERNAL_DOCS          = NO
> -CASE_SENSE_NAMES       = NO
> -HIDE_SCOPE_NAMES       = NO
> -SHOW_INCLUDE_FILES     = YES
> -INLINE_INFO            = YES
> -SORT_MEMBER_DOCS       = YES
> -SORT_BRIEF_DOCS        = NO
> -SORT_GROUP_NAMES       = NO
> -SORT_BY_SCOPE_NAME     = NO
> -GENERATE_TODOLIST      = YES
> -GENERATE_TESTLIST      = YES
> -GENERATE_BUGLIST       = YES
> -GENERATE_DEPRECATEDLIST= YES
> -ENABLED_SECTIONS       =
> -MAX_INITIALIZER_LINES  = 30
> -SHOW_USED_FILES        = YES
> -SHOW_DIRECTORIES       = NO
> -FILE_VERSION_FILTER    =
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to warning and progress messages
> -#----------------------------------------------------------
> -----------------
> -QUIET                  = NO
> -WARNINGS               = YES
> -WARN_IF_UNDOCUMENTED   = YES
> -WARN_IF_DOC_ERROR      = YES
> -WARN_NO_PARAMDOC       = NO
> -WARN_FORMAT            = "$file:$line: $text"
> -WARN_LOGFILE           =
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to the input files
> -#----------------------------------------------------------
> -----------------
> -INPUT                  = .
> -INPUT_ENCODING         = UTF-8
> -FILE_PATTERNS          = *.c \
> -                         *.cc \
> -                         *.cxx \
> -                         *.cpp \
> -                         *.c++ \
> -                         *.d \
> -                         *.java \
> -                         *.ii \
> -                         *.ixx \
> -                         *.ipp \
> -                         *.i++ \
> -                         *.inl \
> -                         *.h \
> -                         *.hh \
> -                         *.hxx \
> -                         *.hpp \
> -                         *.h++ \
> -                         *.idl \
> -                         *.odl \
> -                         *.cs \
> -                         *.php \
> -                         *.php3 \
> -                         *.inc \
> -                         *.m \
> -                         *.mm \
> -                         *.dox \
> -                         *.py \
> -                         *.f90 \
> -                         *.f \
> -                         *.vhd \
> -                         *.vhdl
> -RECURSIVE              = YES
> -EXCLUDE                =
> -EXCLUDE_SYMLINKS       = NO
> -EXCLUDE_PATTERNS       =
> -EXCLUDE_SYMBOLS        =
> -EXAMPLE_PATH           =
> -EXAMPLE_PATTERNS       = *
> -EXAMPLE_RECURSIVE      = NO
> -IMAGE_PATH             =
> -INPUT_FILTER           =
> -FILTER_PATTERNS        =
> -FILTER_SOURCE_FILES    = NO
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to source browsing
> -#----------------------------------------------------------
> -----------------
> -SOURCE_BROWSER         = YES
> -INLINE_SOURCES         = NO
> -STRIP_CODE_COMMENTS    = YES
> -REFERENCED_BY_RELATION = YES
> -REFERENCES_RELATION    = YES
> -REFERENCES_LINK_SOURCE = YES
> -USE_HTAGS              = NO
> -VERBATIM_HEADERS       = YES
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to the alphabetical class index
> -#----------------------------------------------------------
> -----------------
> -ALPHABETICAL_INDEX     = NO
> -COLS_IN_ALPHA_INDEX    = 5
> -IGNORE_PREFIX          =
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to the HTML output
> -#----------------------------------------------------------
> -----------------
> -GENERATE_HTML          = YES
> -HTML_OUTPUT            = html
> -HTML_FILE_EXTENSION    = .html
> -HTML_HEADER            =
> -HTML_FOOTER            =
> -HTML_STYLESHEET        =
> -HTML_ALIGN_MEMBERS     = YES
> -GENERATE_HTMLHELP      = NO
> -GENERATE_DOCSET        = NO
> -DOCSET_FEEDNAME        = "Doxygen generated docs"
> -DOCSET_BUNDLE_ID       = org.doxygen.Project
> -HTML_DYNAMIC_SECTIONS  = NO
> -CHM_FILE               =
> -HHC_LOCATION           =
> -GENERATE_CHI           = NO
> -BINARY_TOC             = NO
> -TOC_EXPAND             = NO
> -DISABLE_INDEX          = NO
> -ENUM_VALUES_PER_LINE   = 4
> -GENERATE_TREEVIEW      = NO
> -TREEVIEW_WIDTH         = 250
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to the LaTeX output
> -#----------------------------------------------------------
> -----------------
> -GENERATE_LATEX         = YES
> -LATEX_OUTPUT           = latex
> -LATEX_CMD_NAME         = latex
> -MAKEINDEX_CMD_NAME     = makeindex
> -COMPACT_LATEX          = YES # NO
> -PAPER_TYPE             = a4wide
> -EXTRA_PACKAGES         =
> -LATEX_HEADER           =
> -PDF_HYPERLINKS         = YES
> -USE_PDFLATEX           = YES
> -LATEX_BATCHMODE        = NO
> -LATEX_HIDE_INDICES     = NO
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to the RTF output
> -#----------------------------------------------------------
> -----------------
> -GENERATE_RTF           = NO
> -RTF_OUTPUT             = rtf
> -COMPACT_RTF            = NO
> -RTF_HYPERLINKS         = NO
> -RTF_STYLESHEET_FILE    =
> -RTF_EXTENSIONS_FILE    =
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to the man page output
> -#----------------------------------------------------------
> -----------------
> -GENERATE_MAN           = NO
> -MAN_OUTPUT             = man
> -MAN_EXTENSION          = .3
> -MAN_LINKS              = NO
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to the XML output
> -#----------------------------------------------------------
> -----------------
> -GENERATE_XML           = NO
> -XML_OUTPUT             = xml
> -XML_SCHEMA             =
> -XML_DTD                =
> -XML_PROGRAMLISTING     = YES
> -#----------------------------------------------------------
> -----------------
> -# configuration options for the AutoGen Definitions output
> -#----------------------------------------------------------
> -----------------
> -GENERATE_AUTOGEN_DEF   = NO
> -#----------------------------------------------------------
> -----------------
> -# configuration options related to the Perl module output
> -#----------------------------------------------------------
> -----------------
> -GENERATE_PERLMOD       = NO
> -PERLMOD_LATEX          = NO
> -PERLMOD_PRETTY         = YES
> -PERLMOD_MAKEVAR_PREFIX =
> -#----------------------------------------------------------
> -----------------
> -# Configuration options related to the preprocessor
> -#----------------------------------------------------------
> -----------------
> -ENABLE_PREPROCESSING   = YES
> -MACRO_EXPANSION        = NO
> -EXPAND_ONLY_PREDEF     = NO
> -SEARCH_INCLUDES        = YES
> -INCLUDE_PATH           =
> -INCLUDE_FILE_PATTERNS  =
> -PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP
> P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN
> ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
> -EXPAND_AS_DEFINED      =
> -SKIP_FUNCTION_MACROS   = YES
> -#----------------------------------------------------------
> -----------------
> -# Configuration::additions related to external references
> -#----------------------------------------------------------
> -----------------
> -TAGFILES               =
> -GENERATE_TAGFILE       =
> -ALLEXTERNALS           = NO
> -EXTERNAL_GROUPS        = YES
> -PERL_PATH              = /usr/bin/perl
> -#----------------------------------------------------------
> -----------------
> -# Configuration options related to the dot tool
> -#----------------------------------------------------------
> -----------------
> -CLASS_DIAGRAMS         = NO
> -MSCGEN_PATH            =
> -HIDE_UNDOC_RELATIONS   = YES
> -HAVE_DOT               = YES
> -CLASS_GRAPH            = YES
> -COLLABORATION_GRAPH    = YES
> -GROUP_GRAPHS           = YES
> -UML_LOOK               = NO
> -TEMPLATE_RELATIONS     = NO
> -INCLUDE_GRAPH          = YES
> -INCLUDED_BY_GRAPH      = YES
> -CALL_GRAPH             = NO # YES
> -CALLER_GRAPH           = NO # YES
> -GRAPHICAL_HIERARCHY    = YES
> -DIRECTORY_GRAPH        = YES
> -DOT_IMAGE_FORMAT       = png
> -DOT_PATH               = "/usr/bin/dot"
> -DOTFILE_DIRS           =
> -DOT_GRAPH_MAX_NODES    = 50
> -MAX_DOT_GRAPH_DEPTH    = 1000
> -DOT_TRANSPARENT        = YES
> -DOT_MULTI_TARGETS      = NO
> -GENERATE_LEGEND        = YES
> -DOT_CLEANUP            = YES
> -#----------------------------------------------------------
> -----------------
> -# Configuration::additions related to the search engine
> -#----------------------------------------------------------
> -----------------
> -SEARCHENGINE           = NO
> diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.
> doxyfile.in
> new file mode 100644
> index 0000000..e1cdc3b
> --- /dev/null
> +++ b/doc/doxygen/openvpn.doxyfile.in
> @@ -0,0 +1,279 @@
> +# Doxyfile 1.5.5
> +
> +#----------------------------------------------------------
> -----------------
> +# Project related configuration options
> +#----------------------------------------------------------
> -----------------
> +DOXYFILE_ENCODING      = UTF-8
> +PROJECT_NAME           = "OpenVPN"
> +PROJECT_NUMBER         =
> +OUTPUT_DIRECTORY       = doxygen
> +CREATE_SUBDIRS         = NO
> +OUTPUT_LANGUAGE        = English
> +BRIEF_MEMBER_DESC      = YES
> +REPEAT_BRIEF           = YES
> +ABBREVIATE_BRIEF       = "The $name class" \
> +                         "The $name widget" \
> +                         "The $name file" \
> +                         is \
> +                         provides \
> +                         specifies \
> +                         contains \
> +                         represents \
> +                         a \
> +                         an \
> +                         the
> +ALWAYS_DETAILED_SEC    = NO
> +INLINE_INHERITED_MEMB  = NO
> +FULL_PATH_NAMES        = YES
> +STRIP_FROM_PATH        = @abs_top_srcdir@
> +STRIP_FROM_INC_PATH    =
> +SHORT_NAMES            = NO
> +JAVADOC_AUTOBRIEF      = YES # NO
> +QT_AUTOBRIEF           = NO
> +MULTILINE_CPP_IS_BRIEF = NO
> +DETAILS_AT_TOP         = NO
> +INHERIT_DOCS           = YES
> +SEPARATE_MEMBER_PAGES  = NO
> +TAB_SIZE               = 8
> +ALIASES                =
> +OPTIMIZE_OUTPUT_FOR_C  = YES
> +OPTIMIZE_OUTPUT_JAVA   = NO
> +OPTIMIZE_FOR_FORTRAN   = NO
> +OPTIMIZE_OUTPUT_VHDL   = NO
> +BUILTIN_STL_SUPPORT    = NO
> +CPP_CLI_SUPPORT        = NO
> +SIP_SUPPORT            = NO
> +DISTRIBUTE_GROUP_DOC   = NO
> +SUBGROUPING            = YES
> +TYPEDEF_HIDES_STRUCT   = NO
> +#----------------------------------------------------------
> -----------------
> +# Build related configuration options
> +#----------------------------------------------------------
> -----------------
> +EXTRACT_ALL            = YES
> +EXTRACT_PRIVATE        = YES
> +EXTRACT_STATIC         = YES
> +EXTRACT_LOCAL_CLASSES  = YES
> +EXTRACT_LOCAL_METHODS  = YES
> +EXTRACT_ANON_NSPACES   = YES
> +HIDE_UNDOC_MEMBERS     = NO
> +HIDE_UNDOC_CLASSES     = NO
> +HIDE_FRIEND_COMPOUNDS  = NO
> +HIDE_IN_BODY_DOCS      = NO
> +INTERNAL_DOCS          = NO
> +CASE_SENSE_NAMES       = NO
> +HIDE_SCOPE_NAMES       = NO
> +SHOW_INCLUDE_FILES     = YES
> +INLINE_INFO            = YES
> +SORT_MEMBER_DOCS       = YES
> +SORT_BRIEF_DOCS        = NO
> +SORT_GROUP_NAMES       = NO
> +SORT_BY_SCOPE_NAME     = NO
> +GENERATE_TODOLIST      = YES
> +GENERATE_TESTLIST      = YES
> +GENERATE_BUGLIST       = YES
> +GENERATE_DEPRECATEDLIST= YES
> +ENABLED_SECTIONS       =
> +MAX_INITIALIZER_LINES  = 30
> +SHOW_USED_FILES        = YES
> +SHOW_DIRECTORIES       = NO
> +FILE_VERSION_FILTER    =
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to warning and progress messages
> +#----------------------------------------------------------
> -----------------
> +QUIET                  = NO
> +WARNINGS               = YES
> +WARN_IF_UNDOCUMENTED   = YES
> +WARN_IF_DOC_ERROR      = YES
> +WARN_NO_PARAMDOC       = NO
> +WARN_FORMAT            = "$file:$line: $text"
> +WARN_LOGFILE           =
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to the input files
> +#----------------------------------------------------------
> -----------------
> +INPUT                  = @abs_top_srcdir@
> +INPUT_ENCODING         = UTF-8
> +FILE_PATTERNS          = *.c \
> +                         *.cc \
> +                         *.cxx \
> +                         *.cpp \
> +                         *.c++ \
> +                         *.d \
> +                         *.java \
> +                         *.ii \
> +                         *.ixx \
> +                         *.ipp \
> +                         *.i++ \
> +                         *.inl \
> +                         *.h \
> +                         *.hh \
> +                         *.hxx \
> +                         *.hpp \
> +                         *.h++ \
> +                         *.idl \
> +                         *.odl \
> +                         *.cs \
> +                         *.php \
> +                         *.php3 \
> +                         *.inc \
> +                         *.m \
> +                         *.mm \
> +                         *.dox \
> +                         *.py \
> +                         *.f90 \
> +                         *.f \
> +                         *.vhd \
> +                         *.vhdl
> +RECURSIVE              = YES
> +EXCLUDE                =
> +EXCLUDE_SYMLINKS       = NO
> +EXCLUDE_PATTERNS       =
> +EXCLUDE_SYMBOLS        =
> +EXAMPLE_PATH           =
> +EXAMPLE_PATTERNS       = *
> +EXAMPLE_RECURSIVE      = NO
> +IMAGE_PATH             =
> +INPUT_FILTER           =
> +FILTER_PATTERNS        =
> +FILTER_SOURCE_FILES    = NO
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to source browsing
> +#----------------------------------------------------------
> -----------------
> +SOURCE_BROWSER         = YES
> +INLINE_SOURCES         = NO
> +STRIP_CODE_COMMENTS    = YES
> +REFERENCED_BY_RELATION = YES
> +REFERENCES_RELATION    = YES
> +REFERENCES_LINK_SOURCE = YES
> +USE_HTAGS              = NO
> +VERBATIM_HEADERS       = YES
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to the alphabetical class index
> +#----------------------------------------------------------
> -----------------
> +ALPHABETICAL_INDEX     = NO
> +COLS_IN_ALPHA_INDEX    = 5
> +IGNORE_PREFIX          =
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to the HTML output
> +#----------------------------------------------------------
> -----------------
> +GENERATE_HTML          = YES
> +HTML_OUTPUT            = html
> +HTML_FILE_EXTENSION    = .html
> +HTML_HEADER            =
> +HTML_FOOTER            =
> +HTML_STYLESHEET        =
> +HTML_ALIGN_MEMBERS     = YES
> +GENERATE_HTMLHELP      = NO
> +GENERATE_DOCSET        = NO
> +DOCSET_FEEDNAME        = "Doxygen generated docs"
> +DOCSET_BUNDLE_ID       = org.doxygen.Project
> +HTML_DYNAMIC_SECTIONS  = NO
> +CHM_FILE               =
> +HHC_LOCATION           =
> +GENERATE_CHI           = NO
> +BINARY_TOC             = NO
> +TOC_EXPAND             = NO
> +DISABLE_INDEX          = NO
> +ENUM_VALUES_PER_LINE   = 4
> +GENERATE_TREEVIEW      = NO
> +TREEVIEW_WIDTH         = 250
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to the LaTeX output
> +#----------------------------------------------------------
> -----------------
> +GENERATE_LATEX         = YES
> +LATEX_OUTPUT           = latex
> +LATEX_CMD_NAME         = latex
> +MAKEINDEX_CMD_NAME     = makeindex
> +COMPACT_LATEX          = YES # NO
> +PAPER_TYPE             = a4wide
> +EXTRA_PACKAGES         =
> +LATEX_HEADER           =
> +PDF_HYPERLINKS         = YES
> +USE_PDFLATEX           = YES
> +LATEX_BATCHMODE        = NO
> +LATEX_HIDE_INDICES     = NO
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to the RTF output
> +#----------------------------------------------------------
> -----------------
> +GENERATE_RTF           = NO
> +RTF_OUTPUT             = rtf
> +COMPACT_RTF            = NO
> +RTF_HYPERLINKS         = NO
> +RTF_STYLESHEET_FILE    =
> +RTF_EXTENSIONS_FILE    =
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to the man page output
> +#----------------------------------------------------------
> -----------------
> +GENERATE_MAN           = NO
> +MAN_OUTPUT             = man
> +MAN_EXTENSION          = .3
> +MAN_LINKS              = NO
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to the XML output
> +#----------------------------------------------------------
> -----------------
> +GENERATE_XML           = NO
> +XML_OUTPUT             = xml
> +XML_SCHEMA             =
> +XML_DTD                =
> +XML_PROGRAMLISTING     = YES
> +#----------------------------------------------------------
> -----------------
> +# configuration options for the AutoGen Definitions output
> +#----------------------------------------------------------
> -----------------
> +GENERATE_AUTOGEN_DEF   = NO
> +#----------------------------------------------------------
> -----------------
> +# configuration options related to the Perl module output
> +#----------------------------------------------------------
> -----------------
> +GENERATE_PERLMOD       = NO
> +PERLMOD_LATEX          = NO
> +PERLMOD_PRETTY         = YES
> +PERLMOD_MAKEVAR_PREFIX =
> +#----------------------------------------------------------
> -----------------
> +# Configuration options related to the preprocessor
> +#----------------------------------------------------------
> -----------------
> +ENABLE_PREPROCESSING   = YES
> +MACRO_EXPANSION        = NO
> +EXPAND_ONLY_PREDEF     = NO
> +SEARCH_INCLUDES        = YES
> +INCLUDE_PATH           =
> +INCLUDE_FILE_PATTERNS  =
> +PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP
> P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN
> ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
> +EXPAND_AS_DEFINED      =
> +SKIP_FUNCTION_MACROS   = YES
> +#----------------------------------------------------------
> -----------------
> +# Configuration::additions related to external references
> +#----------------------------------------------------------
> -----------------
> +TAGFILES               =
> +GENERATE_TAGFILE       =
> +ALLEXTERNALS           = NO
> +EXTERNAL_GROUPS        = YES
> +PERL_PATH              = /usr/bin/perl
> +#----------------------------------------------------------
> -----------------
> +# Configuration options related to the dot tool
> +#----------------------------------------------------------
> -----------------
> +CLASS_DIAGRAMS         = NO
> +MSCGEN_PATH            =
> +HIDE_UNDOC_RELATIONS   = YES
> +HAVE_DOT               = YES
> +CLASS_GRAPH            = YES
> +COLLABORATION_GRAPH    = YES
> +GROUP_GRAPHS           = YES
> +UML_LOOK               = NO
> +TEMPLATE_RELATIONS     = NO
> +INCLUDE_GRAPH          = YES
> +INCLUDED_BY_GRAPH      = YES
> +CALL_GRAPH             = NO # YES
> +CALLER_GRAPH           = NO # YES
> +GRAPHICAL_HIERARCHY    = YES
> +DIRECTORY_GRAPH        = YES
> +DOT_IMAGE_FORMAT       = png
> +DOT_PATH               = "/usr/bin/dot"
> +DOTFILE_DIRS           =
> +DOT_GRAPH_MAX_NODES    = 50
> +MAX_DOT_GRAPH_DEPTH    = 1000
> +DOT_TRANSPARENT        = YES
> +DOT_MULTI_TARGETS      = NO
> +GENERATE_LEGEND        = YES
> +DOT_CLEANUP            = YES
> +#----------------------------------------------------------
> -----------------
> +# Configuration::additions related to the search engine
> +#----------------------------------------------------------
> -----------------
> +SEARCHENGINE           = NO
> --
> 2.7.4
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a1140b7ca5e4ea6055d760d38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-11-08 15:01 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan.karger@...1435..." target=3D"_blank">steffan.karger@...1386...=
435...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Add a make target, such that &#39;make doxygen&#39; works (both for in-tre=
e and<br>
out-of-tree builds).<br></blockquote><div><br><br></div><div>should we add =
both variants of &#39;make doxygen&#39; to travis-ci matrix ?<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
While doing so, instead of genering docs with full path names (e.g.<br>
/home/steffan/dev/openvpn/src/<wbr>openvpn/crypto.h), use a relative path w=
rt<br>
the project root (e.g. src/openvpn/crypto.h) in the generated<br>
documentation.=C2=A0 This makes the generated doxygen easier to read.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
..">steffan.karger@...1435...</a>&gt;<br>
---<br>
v2:<br>
=C2=A0- merge patches 1/2 and 2/2 from the v1 set<br>
=C2=A0- use abs_top_srcdir (instead of top_srcdir)<br>
<br>
=C2=A0Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0doc/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0doc/doxygen/openvpn.doxyfile=C2=A0 =C2=A0 | 279 ---------------------=
---------<wbr>----------<br>
=C2=A0doc/doxygen/<a href=3D"http://openvpn.doxyfile.in" rel=3D"noreferrer"=
 target=3D"_blank">openvpn.doxyfile.<wbr>in</a> | 279 +++++++++++++++++++++=
+++++++++<wbr>++++++++++<br>
=C2=A05 files changed, 286 insertions(+), 280 deletions(-)<br>
=C2=A0delete mode 100644 doc/doxygen/openvpn.doxyfile<br>
=C2=A0create mode 100644 doc/doxygen/<a href=3D"http://openvpn.doxyfile.in"=
 rel=3D"noreferrer" target=3D"_blank">openvpn.doxyfile.<wbr>in</a><br>
<br>
diff --git a/Makefile.am b/Makefile.am<br>
index 87af724..34632c4 100644<br>
--- a/Makefile.am<br>
+++ b/Makefile.am<br>
@@ -46,7 +46,7 @@ EXTRA_DIST =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 contrib \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 debug<br>
<br>
-.PHONY: config-version.h<br>
+.PHONY: config-version.h doxygen<br>
<br>
=C2=A0if GIT_CHECKOUT<br>
=C2=A0BUILT_SOURCES =3D \<br>
@@ -96,3 +96,6 @@ config-version.h:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f config-versio=
n.h.tmp; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
+<br>
+doxygen: doc/doxygen/openvpn.doxyfile<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0doxygen doc/doxygen/openvpn.doxyfile<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 45aa501..eca83e6 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -1420,6 +1420,7 @@ AC_CONFIG_FILES([<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 distro/rpm/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 distro/rpm/openvpn.spec<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 distro/systemd/Makefile<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0doc/doxygen/openvpn.doxyfile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 include/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 src/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 src/compat/Makefile<br>
diff --git a/doc/Makefile.am b/doc/Makefile.am<br>
index dedd1fa..f9e7f4a 100644<br>
--- a/doc/Makefile.am<br>
+++ b/doc/Makefile.am<br>
@@ -14,6 +14,8 @@ MAINTAINERCLEANFILES =3D \<br>
<br>
=C2=A0CLEANFILES =3D openvpn.8.html<br>
<br>
+SUBDIRS =3D doxygen<br>
+<br>
=C2=A0dist_doc_DATA =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 management-notes.txt<br>
<br>
diff --git a/doc/doxygen/openvpn.doxyfile b/doc/doxygen/openvpn.doxyfile<br>
deleted file mode 100644<br>
index a7d9728..0000000<br>
--- a/doc/doxygen/openvpn.doxyfile<br>
+++ /dev/null<br>
@@ -1,279 +0,0 @@<br>
-# Doxyfile 1.5.5<br>
-<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# Project related configuration options<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-DOXYFILE_ENCODING=C2=A0 =C2=A0 =C2=A0 =3D UTF-8<br>
-PROJECT_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;OpenVPN&quo=
t;<br>
-PROJECT_NUMBER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-OUTPUT_DIRECTORY=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D doxygen<br>
-CREATE_SUBDIRS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-OUTPUT_LANGUAGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D English<br>
-BRIEF_MEMBER_DESC=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-REPEAT_BRIEF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-ABBREVIATE_BRIEF=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;The $name class&quot;=
 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;The $name widget&quot; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;The $name file&quot; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0is \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0provides \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0specifies \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0contains \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0represents \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0a \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0an \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0the<br>
-ALWAYS_DETAILED_SEC=C2=A0 =C2=A0 =3D NO<br>
-INLINE_INHERITED_MEMB=C2=A0 =3D NO<br>
-FULL_PATH_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-STRIP_FROM_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;&quot;<br>
-STRIP_FROM_INC_PATH=C2=A0 =C2=A0 =3D<br>
-SHORT_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-JAVADOC_AUTOBRIEF=C2=A0 =C2=A0 =C2=A0 =3D YES # NO<br>
-QT_AUTOBRIEF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-MULTILINE_CPP_IS_BRIEF =3D NO<br>
-DETAILS_AT_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-INHERIT_DOCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-SEPARATE_MEMBER_PAGES=C2=A0 =3D NO<br>
-TAB_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 8<br>
-ALIASES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-OPTIMIZE_OUTPUT_FOR_C=C2=A0 =3D YES<br>
-OPTIMIZE_OUTPUT_JAVA=C2=A0 =C2=A0=3D NO<br>
-OPTIMIZE_FOR_FORTRAN=C2=A0 =C2=A0=3D NO<br>
-OPTIMIZE_OUTPUT_VHDL=C2=A0 =C2=A0=3D NO<br>
-BUILTIN_STL_SUPPORT=C2=A0 =C2=A0 =3D NO<br>
-CPP_CLI_SUPPORT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-SIP_SUPPORT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-DISTRIBUTE_GROUP_DOC=C2=A0 =C2=A0=3D NO<br>
-SUBGROUPING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-TYPEDEF_HIDES_STRUCT=C2=A0 =C2=A0=3D NO<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# Build related configuration options<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-EXTRACT_ALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-EXTRACT_PRIVATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-EXTRACT_STATIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-EXTRACT_LOCAL_CLASSES=C2=A0 =3D YES<br>
-EXTRACT_LOCAL_METHODS=C2=A0 =3D YES<br>
-EXTRACT_ANON_NSPACES=C2=A0 =C2=A0=3D YES<br>
-HIDE_UNDOC_MEMBERS=C2=A0 =C2=A0 =C2=A0=3D NO<br>
-HIDE_UNDOC_CLASSES=C2=A0 =C2=A0 =C2=A0=3D NO<br>
-HIDE_FRIEND_COMPOUNDS=C2=A0 =3D NO<br>
-HIDE_IN_BODY_DOCS=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-INTERNAL_DOCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-CASE_SENSE_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-HIDE_SCOPE_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-SHOW_INCLUDE_FILES=C2=A0 =C2=A0 =C2=A0=3D YES<br>
-INLINE_INFO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-SORT_MEMBER_DOCS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-SORT_BRIEF_DOCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-SORT_GROUP_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-SORT_BY_SCOPE_NAME=C2=A0 =C2=A0 =C2=A0=3D NO<br>
-GENERATE_TODOLIST=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-GENERATE_TESTLIST=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-GENERATE_BUGLIST=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-GENERATE_DEPRECATEDLIST=3D YES<br>
-ENABLED_SECTIONS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-MAX_INITIALIZER_LINES=C2=A0 =3D 30<br>
-SHOW_USED_FILES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-SHOW_DIRECTORIES=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-FILE_VERSION_FILTER=C2=A0 =C2=A0 =3D<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to warning and progress messages<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-QUIET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO=
<br>
-WARNINGS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-WARN_IF_UNDOCUMENTED=C2=A0 =C2=A0=3D YES<br>
-WARN_IF_DOC_ERROR=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-WARN_NO_PARAMDOC=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-WARN_FORMAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;$file:$line=
: $text&quot;<br>
-WARN_LOGFILE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to the input files<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-INPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D .<=
br>
-INPUT_ENCODING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D UTF-8<br>
-FILE_PATTERNS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D *.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.cc \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.cxx \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.cpp \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.c++ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.d \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.java \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.ii \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.ixx \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.ipp \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.i++ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.inl \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.h \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.hh \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.hxx \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.hpp \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.h++ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.idl \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.odl \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.cs \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.php \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.php3 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.inc \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.m \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.mm \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.dox \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.py \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.f90 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.f \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.vhd \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.vhdl<br>
-RECURSIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-EXCLUDE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-EXCLUDE_SYMLINKS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-EXCLUDE_PATTERNS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-EXCLUDE_SYMBOLS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-EXAMPLE_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-EXAMPLE_PATTERNS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D *<br>
-EXAMPLE_RECURSIVE=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-IMAGE_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-INPUT_FILTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-FILTER_PATTERNS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-FILTER_SOURCE_FILES=C2=A0 =C2=A0 =3D NO<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to source browsing<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-SOURCE_BROWSER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-INLINE_SOURCES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-STRIP_CODE_COMMENTS=C2=A0 =C2=A0 =3D YES<br>
-REFERENCED_BY_RELATION =3D YES<br>
-REFERENCES_RELATION=C2=A0 =C2=A0 =3D YES<br>
-REFERENCES_LINK_SOURCE =3D YES<br>
-USE_HTAGS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-VERBATIM_HEADERS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to the alphabetical class index<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-ALPHABETICAL_INDEX=C2=A0 =C2=A0 =C2=A0=3D NO<br>
-COLS_IN_ALPHA_INDEX=C2=A0 =C2=A0 =3D 5<br>
-IGNORE_PREFIX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to the HTML output<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-GENERATE_HTML=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-HTML_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D html<br>
-HTML_FILE_EXTENSION=C2=A0 =C2=A0 =3D .html<br>
-HTML_HEADER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-HTML_FOOTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-HTML_STYLESHEET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-HTML_ALIGN_MEMBERS=C2=A0 =C2=A0 =C2=A0=3D YES<br>
-GENERATE_HTMLHELP=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-GENERATE_DOCSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-DOCSET_FEEDNAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;Doxygen generated doc=
s&quot;<br>
-DOCSET_BUNDLE_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D org.doxygen.Project<br>
-HTML_DYNAMIC_SECTIONS=C2=A0 =3D NO<br>
-CHM_FILE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-HHC_LOCATION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-GENERATE_CHI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-BINARY_TOC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-TOC_EXPAND=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-DISABLE_INDEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-ENUM_VALUES_PER_LINE=C2=A0 =C2=A0=3D 4<br>
-GENERATE_TREEVIEW=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-TREEVIEW_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 250<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to the LaTeX output<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-GENERATE_LATEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-LATEX_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D latex<br>
-LATEX_CMD_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D latex<br>
-MAKEINDEX_CMD_NAME=C2=A0 =C2=A0 =C2=A0=3D makeindex<br>
-COMPACT_LATEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES # NO<br>
-PAPER_TYPE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D a4wide<br>
-EXTRA_PACKAGES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-LATEX_HEADER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-PDF_HYPERLINKS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-USE_PDFLATEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-LATEX_BATCHMODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-LATEX_HIDE_INDICES=C2=A0 =C2=A0 =C2=A0=3D NO<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to the RTF output<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-GENERATE_RTF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-RTF_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D rtf<br>
-COMPACT_RTF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-RTF_HYPERLINKS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-RTF_STYLESHEET_FILE=C2=A0 =C2=A0 =3D<br>
-RTF_EXTENSIONS_FILE=C2=A0 =C2=A0 =3D<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to the man page output<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-GENERATE_MAN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-MAN_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D man<br>
-MAN_EXTENSION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D .3<br>
-MAN_LINKS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to the XML output<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-GENERATE_XML=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-XML_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D xml<br>
-XML_SCHEMA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-XML_DTD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-XML_PROGRAMLISTING=C2=A0 =C2=A0 =C2=A0=3D YES<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options for the AutoGen Definitions output<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-GENERATE_AUTOGEN_DEF=C2=A0 =C2=A0=3D NO<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# configuration options related to the Perl module output<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-GENERATE_PERLMOD=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-PERLMOD_LATEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-PERLMOD_PRETTY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-PERLMOD_MAKEVAR_PREFIX =3D<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# Configuration options related to the preprocessor<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-ENABLE_PREPROCESSING=C2=A0 =C2=A0=3D YES<br>
-MACRO_EXPANSION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-EXPAND_ONLY_PREDEF=C2=A0 =C2=A0 =C2=A0=3D NO<br>
-SEARCH_INCLUDES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-INCLUDE_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-INCLUDE_FILE_PATTERNS=C2=A0 =3D<br>
-PREDEFINED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D _WIN32 NTLM =
USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSS=
L ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY<br>
-EXPAND_AS_DEFINED=C2=A0 =C2=A0 =C2=A0 =3D<br>
-SKIP_FUNCTION_MACROS=C2=A0 =C2=A0=3D YES<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# Configuration::additions related to external references<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-TAGFILES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-GENERATE_TAGFILE=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-ALLEXTERNALS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-EXTERNAL_GROUPS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-PERL_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D /usr/bin/per=
l<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# Configuration options related to the dot tool<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-CLASS_DIAGRAMS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-MSCGEN_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
-HIDE_UNDOC_RELATIONS=C2=A0 =C2=A0=3D YES<br>
-HAVE_DOT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-CLASS_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-COLLABORATION_GRAPH=C2=A0 =C2=A0 =3D YES<br>
-GROUP_GRAPHS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
-UML_LOOK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
-TEMPLATE_RELATIONS=C2=A0 =C2=A0 =C2=A0=3D NO<br>
-INCLUDE_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-INCLUDED_BY_GRAPH=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-CALL_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO # YES<br>
-CALLER_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO # YES<br>
-GRAPHICAL_HIERARCHY=C2=A0 =C2=A0 =3D YES<br>
-DIRECTORY_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-DOT_IMAGE_FORMAT=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D png<br>
-DOT_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;/=
usr/bin/dot&quot;<br>
-DOTFILE_DIRS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
-DOT_GRAPH_MAX_NODES=C2=A0 =C2=A0 =3D 50<br>
-MAX_DOT_GRAPH_DEPTH=C2=A0 =C2=A0 =3D 1000<br>
-DOT_TRANSPARENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-DOT_MULTI_TARGETS=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
-GENERATE_LEGEND=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-DOT_CLEANUP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-# Configuration::additions related to the search engine<br>
-#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
-SEARCHENGINE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
diff --git a/doc/doxygen/<a href=3D"http://openvpn.doxyfile.in" rel=3D"nore=
ferrer" target=3D"_blank">openvpn.<wbr>doxyfile.in</a> b/doc/doxygen/<a hre=
f=3D"http://openvpn.doxyfile.in" rel=3D"noreferrer" target=3D"_blank">openv=
pn.<wbr>doxyfile.in</a><br>
new file mode 100644<br>
index 0000000..e1cdc3b<br>
--- /dev/null<br>
+++ b/doc/doxygen/<a href=3D"http://openvpn.doxyfile.in" rel=3D"noreferrer"=
 target=3D"_blank">openvpn.<wbr>doxyfile.in</a><br>
@@ -0,0 +1,279 @@<br>
+# Doxyfile 1.5.5<br>
+<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# Project related configuration options<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+DOXYFILE_ENCODING=C2=A0 =C2=A0 =C2=A0 =3D UTF-8<br>
+PROJECT_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;OpenVPN&quo=
t;<br>
+PROJECT_NUMBER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+OUTPUT_DIRECTORY=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D doxygen<br>
+CREATE_SUBDIRS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+OUTPUT_LANGUAGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D English<br>
+BRIEF_MEMBER_DESC=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+REPEAT_BRIEF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+ABBREVIATE_BRIEF=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;The $name class&quot;=
 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;The $name widget&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;The $name file&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0is \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0provides \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0specifies \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0contains \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0represents \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0a \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0an \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0the<br>
+ALWAYS_DETAILED_SEC=C2=A0 =C2=A0 =3D NO<br>
+INLINE_INHERITED_MEMB=C2=A0 =3D NO<br>
+FULL_PATH_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+STRIP_FROM_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D @abs_top_srcdir@<br>
+STRIP_FROM_INC_PATH=C2=A0 =C2=A0 =3D<br>
+SHORT_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+JAVADOC_AUTOBRIEF=C2=A0 =C2=A0 =C2=A0 =3D YES # NO<br>
+QT_AUTOBRIEF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+MULTILINE_CPP_IS_BRIEF =3D NO<br>
+DETAILS_AT_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+INHERIT_DOCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+SEPARATE_MEMBER_PAGES=C2=A0 =3D NO<br>
+TAB_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 8<br>
+ALIASES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+OPTIMIZE_OUTPUT_FOR_C=C2=A0 =3D YES<br>
+OPTIMIZE_OUTPUT_JAVA=C2=A0 =C2=A0=3D NO<br>
+OPTIMIZE_FOR_FORTRAN=C2=A0 =C2=A0=3D NO<br>
+OPTIMIZE_OUTPUT_VHDL=C2=A0 =C2=A0=3D NO<br>
+BUILTIN_STL_SUPPORT=C2=A0 =C2=A0 =3D NO<br>
+CPP_CLI_SUPPORT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+SIP_SUPPORT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+DISTRIBUTE_GROUP_DOC=C2=A0 =C2=A0=3D NO<br>
+SUBGROUPING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+TYPEDEF_HIDES_STRUCT=C2=A0 =C2=A0=3D NO<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# Build related configuration options<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+EXTRACT_ALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+EXTRACT_PRIVATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+EXTRACT_STATIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+EXTRACT_LOCAL_CLASSES=C2=A0 =3D YES<br>
+EXTRACT_LOCAL_METHODS=C2=A0 =3D YES<br>
+EXTRACT_ANON_NSPACES=C2=A0 =C2=A0=3D YES<br>
+HIDE_UNDOC_MEMBERS=C2=A0 =C2=A0 =C2=A0=3D NO<br>
+HIDE_UNDOC_CLASSES=C2=A0 =C2=A0 =C2=A0=3D NO<br>
+HIDE_FRIEND_COMPOUNDS=C2=A0 =3D NO<br>
+HIDE_IN_BODY_DOCS=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+INTERNAL_DOCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+CASE_SENSE_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+HIDE_SCOPE_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+SHOW_INCLUDE_FILES=C2=A0 =C2=A0 =C2=A0=3D YES<br>
+INLINE_INFO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+SORT_MEMBER_DOCS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+SORT_BRIEF_DOCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+SORT_GROUP_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+SORT_BY_SCOPE_NAME=C2=A0 =C2=A0 =C2=A0=3D NO<br>
+GENERATE_TODOLIST=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+GENERATE_TESTLIST=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+GENERATE_BUGLIST=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+GENERATE_DEPRECATEDLIST=3D YES<br>
+ENABLED_SECTIONS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+MAX_INITIALIZER_LINES=C2=A0 =3D 30<br>
+SHOW_USED_FILES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+SHOW_DIRECTORIES=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+FILE_VERSION_FILTER=C2=A0 =C2=A0 =3D<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to warning and progress messages<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+QUIET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO=
<br>
+WARNINGS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+WARN_IF_UNDOCUMENTED=C2=A0 =C2=A0=3D YES<br>
+WARN_IF_DOC_ERROR=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+WARN_NO_PARAMDOC=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+WARN_FORMAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;$file:$line=
: $text&quot;<br>
+WARN_LOGFILE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to the input files<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+INPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D @a=
bs_top_srcdir@<br>
+INPUT_ENCODING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D UTF-8<br>
+FILE_PATTERNS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D *.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.cc \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.cxx \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.cpp \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.c++ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.d \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.java \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.ii \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.ixx \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.ipp \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.i++ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.inl \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.h \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.hh \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.hxx \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.hpp \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.h++ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.idl \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.odl \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.cs \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.php \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.php3 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.inc \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.m \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.mm \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.dox \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.py \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.f90 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.f \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.vhd \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*.vhdl<br>
+RECURSIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+EXCLUDE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+EXCLUDE_SYMLINKS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+EXCLUDE_PATTERNS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+EXCLUDE_SYMBOLS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+EXAMPLE_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+EXAMPLE_PATTERNS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D *<br>
+EXAMPLE_RECURSIVE=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+IMAGE_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+INPUT_FILTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+FILTER_PATTERNS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+FILTER_SOURCE_FILES=C2=A0 =C2=A0 =3D NO<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to source browsing<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+SOURCE_BROWSER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+INLINE_SOURCES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+STRIP_CODE_COMMENTS=C2=A0 =C2=A0 =3D YES<br>
+REFERENCED_BY_RELATION =3D YES<br>
+REFERENCES_RELATION=C2=A0 =C2=A0 =3D YES<br>
+REFERENCES_LINK_SOURCE =3D YES<br>
+USE_HTAGS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+VERBATIM_HEADERS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to the alphabetical class index<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+ALPHABETICAL_INDEX=C2=A0 =C2=A0 =C2=A0=3D NO<br>
+COLS_IN_ALPHA_INDEX=C2=A0 =C2=A0 =3D 5<br>
+IGNORE_PREFIX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to the HTML output<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+GENERATE_HTML=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+HTML_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D html<br>
+HTML_FILE_EXTENSION=C2=A0 =C2=A0 =3D .html<br>
+HTML_HEADER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+HTML_FOOTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+HTML_STYLESHEET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+HTML_ALIGN_MEMBERS=C2=A0 =C2=A0 =C2=A0=3D YES<br>
+GENERATE_HTMLHELP=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+GENERATE_DOCSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+DOCSET_FEEDNAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;Doxygen generated doc=
s&quot;<br>
+DOCSET_BUNDLE_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D org.doxygen.Project<br>
+HTML_DYNAMIC_SECTIONS=C2=A0 =3D NO<br>
+CHM_FILE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+HHC_LOCATION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+GENERATE_CHI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+BINARY_TOC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+TOC_EXPAND=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+DISABLE_INDEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+ENUM_VALUES_PER_LINE=C2=A0 =C2=A0=3D 4<br>
+GENERATE_TREEVIEW=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+TREEVIEW_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 250<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to the LaTeX output<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+GENERATE_LATEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+LATEX_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D latex<br>
+LATEX_CMD_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D latex<br>
+MAKEINDEX_CMD_NAME=C2=A0 =C2=A0 =C2=A0=3D makeindex<br>
+COMPACT_LATEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES # NO<br>
+PAPER_TYPE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D a4wide<br>
+EXTRA_PACKAGES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+LATEX_HEADER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+PDF_HYPERLINKS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+USE_PDFLATEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+LATEX_BATCHMODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+LATEX_HIDE_INDICES=C2=A0 =C2=A0 =C2=A0=3D NO<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to the RTF output<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+GENERATE_RTF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+RTF_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D rtf<br>
+COMPACT_RTF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+RTF_HYPERLINKS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+RTF_STYLESHEET_FILE=C2=A0 =C2=A0 =3D<br>
+RTF_EXTENSIONS_FILE=C2=A0 =C2=A0 =3D<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to the man page output<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+GENERATE_MAN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+MAN_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D man<br>
+MAN_EXTENSION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D .3<br>
+MAN_LINKS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to the XML output<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+GENERATE_XML=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+XML_OUTPUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D xml<br>
+XML_SCHEMA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+XML_DTD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+XML_PROGRAMLISTING=C2=A0 =C2=A0 =C2=A0=3D YES<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options for the AutoGen Definitions output<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+GENERATE_AUTOGEN_DEF=C2=A0 =C2=A0=3D NO<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# configuration options related to the Perl module output<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+GENERATE_PERLMOD=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+PERLMOD_LATEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+PERLMOD_PRETTY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+PERLMOD_MAKEVAR_PREFIX =3D<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# Configuration options related to the preprocessor<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+ENABLE_PREPROCESSING=C2=A0 =C2=A0=3D YES<br>
+MACRO_EXPANSION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+EXPAND_ONLY_PREDEF=C2=A0 =C2=A0 =C2=A0=3D NO<br>
+SEARCH_INCLUDES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+INCLUDE_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+INCLUDE_FILE_PATTERNS=C2=A0 =3D<br>
+PREDEFINED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D _WIN32 NTLM =
USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSS=
L ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY<br>
+EXPAND_AS_DEFINED=C2=A0 =C2=A0 =C2=A0 =3D<br>
+SKIP_FUNCTION_MACROS=C2=A0 =C2=A0=3D YES<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# Configuration::additions related to external references<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+TAGFILES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+GENERATE_TAGFILE=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+ALLEXTERNALS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+EXTERNAL_GROUPS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+PERL_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D /usr/bin/per=
l<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# Configuration options related to the dot tool<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+CLASS_DIAGRAMS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+MSCGEN_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D<br>
+HIDE_UNDOC_RELATIONS=C2=A0 =C2=A0=3D YES<br>
+HAVE_DOT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+CLASS_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+COLLABORATION_GRAPH=C2=A0 =C2=A0 =3D YES<br>
+GROUP_GRAPHS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D YES<br>
+UML_LOOK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
+TEMPLATE_RELATIONS=C2=A0 =C2=A0 =C2=A0=3D NO<br>
+INCLUDE_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+INCLUDED_BY_GRAPH=C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+CALL_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO # YES<br>
+CALLER_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO # YES<br>
+GRAPHICAL_HIERARCHY=C2=A0 =C2=A0 =3D YES<br>
+DIRECTORY_GRAPH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+DOT_IMAGE_FORMAT=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D png<br>
+DOT_PATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;/=
usr/bin/dot&quot;<br>
+DOTFILE_DIRS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D<br>
+DOT_GRAPH_MAX_NODES=C2=A0 =C2=A0 =3D 50<br>
+MAX_DOT_GRAPH_DEPTH=C2=A0 =C2=A0 =3D 1000<br>
+DOT_TRANSPARENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+DOT_MULTI_TARGETS=C2=A0 =C2=A0 =C2=A0 =3D NO<br>
+GENERATE_LEGEND=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+DOT_CLEANUP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D YES<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+# Configuration::additions related to the search engine<br>
+#----------------------------<wbr>------------------------------<wbr>-----=
------------<br>
+SEARCHENGINE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NO<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888">--<br>
2.7.4<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div><br></div></div>

--001a1140b7ca5e4ea6055d760d38--

