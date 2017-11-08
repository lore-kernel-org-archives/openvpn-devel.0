From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 8 Nov 2017 11:01:52 +0100
Message-ID: <1510135312-16578-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <20171108094835.GK958@...1296...>
References: <20171108094835.GK958@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] doxygen: add make target and use
 relative paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Add a make target, such that 'make doxygen' works (both for in-tree and
out-of-tree builds).

While doing so, instead of genering docs with full path names (e.g.
/home/steffan/dev/openvpn/src/openvpn/crypto.h), use a relative path wrt
the project root (e.g. src/openvpn/crypto.h) in the generated
documentation.  This makes the generated doxygen easier to read.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2:
 - merge patches 1/2 and 2/2 from the v1 set
 - use abs_top_srcdir (instead of top_srcdir)

 Makefile.am                     |   5 +-
 configure.ac                    |   1 +
 doc/Makefile.am                 |   2 +
 doc/doxygen/openvpn.doxyfile    | 279 ----------------------------------------
 doc/doxygen/openvpn.doxyfile.in | 279 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 286 insertions(+), 280 deletions(-)
 delete mode 100644 doc/doxygen/openvpn.doxyfile
 create mode 100644 doc/doxygen/openvpn.doxyfile.in

diff --git a/Makefile.am b/Makefile.am
index 87af724..34632c4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -46,7 +46,7 @@ EXTRA_DIST = \
 	contrib \
 	debug
 
-.PHONY: config-version.h
+.PHONY: config-version.h doxygen
 
 if GIT_CHECKOUT
 BUILT_SOURCES = \
@@ -96,3 +96,6 @@ config-version.h:
 	else \
 		rm -f config-version.h.tmp; \
 	fi
+
+doxygen: doc/doxygen/openvpn.doxyfile
+	doxygen doc/doxygen/openvpn.doxyfile
diff --git a/configure.ac b/configure.ac
index 45aa501..eca83e6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1420,6 +1420,7 @@ AC_CONFIG_FILES([
 	distro/rpm/Makefile
 	distro/rpm/openvpn.spec
 	distro/systemd/Makefile
+	doc/doxygen/openvpn.doxyfile
 	include/Makefile
 	src/Makefile
 	src/compat/Makefile
diff --git a/doc/Makefile.am b/doc/Makefile.am
index dedd1fa..f9e7f4a 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -14,6 +14,8 @@ MAINTAINERCLEANFILES = \
 
 CLEANFILES = openvpn.8.html
 
+SUBDIRS = doxygen
+
 dist_doc_DATA = \
 	management-notes.txt
 
diff --git a/doc/doxygen/openvpn.doxyfile b/doc/doxygen/openvpn.doxyfile
deleted file mode 100644
index a7d9728..0000000
--- a/doc/doxygen/openvpn.doxyfile
+++ /dev/null
@@ -1,279 +0,0 @@
-# Doxyfile 1.5.5
-
-#---------------------------------------------------------------------------
-# Project related configuration options
-#---------------------------------------------------------------------------
-DOXYFILE_ENCODING      = UTF-8
-PROJECT_NAME           = "OpenVPN"
-PROJECT_NUMBER         =
-OUTPUT_DIRECTORY       = doxygen
-CREATE_SUBDIRS         = NO
-OUTPUT_LANGUAGE        = English
-BRIEF_MEMBER_DESC      = YES
-REPEAT_BRIEF           = YES
-ABBREVIATE_BRIEF       = "The $name class" \
-                         "The $name widget" \
-                         "The $name file" \
-                         is \
-                         provides \
-                         specifies \
-                         contains \
-                         represents \
-                         a \
-                         an \
-                         the
-ALWAYS_DETAILED_SEC    = NO
-INLINE_INHERITED_MEMB  = NO
-FULL_PATH_NAMES        = YES
-STRIP_FROM_PATH        = ""
-STRIP_FROM_INC_PATH    =
-SHORT_NAMES            = NO
-JAVADOC_AUTOBRIEF      = YES # NO
-QT_AUTOBRIEF           = NO
-MULTILINE_CPP_IS_BRIEF = NO
-DETAILS_AT_TOP         = NO
-INHERIT_DOCS           = YES
-SEPARATE_MEMBER_PAGES  = NO
-TAB_SIZE               = 8
-ALIASES                =
-OPTIMIZE_OUTPUT_FOR_C  = YES
-OPTIMIZE_OUTPUT_JAVA   = NO
-OPTIMIZE_FOR_FORTRAN   = NO
-OPTIMIZE_OUTPUT_VHDL   = NO
-BUILTIN_STL_SUPPORT    = NO
-CPP_CLI_SUPPORT        = NO
-SIP_SUPPORT            = NO
-DISTRIBUTE_GROUP_DOC   = NO
-SUBGROUPING            = YES
-TYPEDEF_HIDES_STRUCT   = NO
-#---------------------------------------------------------------------------
-# Build related configuration options
-#---------------------------------------------------------------------------
-EXTRACT_ALL            = YES
-EXTRACT_PRIVATE        = YES
-EXTRACT_STATIC         = YES
-EXTRACT_LOCAL_CLASSES  = YES
-EXTRACT_LOCAL_METHODS  = YES
-EXTRACT_ANON_NSPACES   = YES
-HIDE_UNDOC_MEMBERS     = NO
-HIDE_UNDOC_CLASSES     = NO
-HIDE_FRIEND_COMPOUNDS  = NO
-HIDE_IN_BODY_DOCS      = NO
-INTERNAL_DOCS          = NO
-CASE_SENSE_NAMES       = NO
-HIDE_SCOPE_NAMES       = NO
-SHOW_INCLUDE_FILES     = YES
-INLINE_INFO            = YES
-SORT_MEMBER_DOCS       = YES
-SORT_BRIEF_DOCS        = NO
-SORT_GROUP_NAMES       = NO
-SORT_BY_SCOPE_NAME     = NO
-GENERATE_TODOLIST      = YES
-GENERATE_TESTLIST      = YES
-GENERATE_BUGLIST       = YES
-GENERATE_DEPRECATEDLIST= YES
-ENABLED_SECTIONS       =
-MAX_INITIALIZER_LINES  = 30
-SHOW_USED_FILES        = YES
-SHOW_DIRECTORIES       = NO
-FILE_VERSION_FILTER    =
-#---------------------------------------------------------------------------
-# configuration options related to warning and progress messages
-#---------------------------------------------------------------------------
-QUIET                  = NO
-WARNINGS               = YES
-WARN_IF_UNDOCUMENTED   = YES
-WARN_IF_DOC_ERROR      = YES
-WARN_NO_PARAMDOC       = NO
-WARN_FORMAT            = "$file:$line: $text"
-WARN_LOGFILE           =
-#---------------------------------------------------------------------------
-# configuration options related to the input files
-#---------------------------------------------------------------------------
-INPUT                  = .
-INPUT_ENCODING         = UTF-8
-FILE_PATTERNS          = *.c \
-                         *.cc \
-                         *.cxx \
-                         *.cpp \
-                         *.c++ \
-                         *.d \
-                         *.java \
-                         *.ii \
-                         *.ixx \
-                         *.ipp \
-                         *.i++ \
-                         *.inl \
-                         *.h \
-                         *.hh \
-                         *.hxx \
-                         *.hpp \
-                         *.h++ \
-                         *.idl \
-                         *.odl \
-                         *.cs \
-                         *.php \
-                         *.php3 \
-                         *.inc \
-                         *.m \
-                         *.mm \
-                         *.dox \
-                         *.py \
-                         *.f90 \
-                         *.f \
-                         *.vhd \
-                         *.vhdl
-RECURSIVE              = YES
-EXCLUDE                =
-EXCLUDE_SYMLINKS       = NO
-EXCLUDE_PATTERNS       =
-EXCLUDE_SYMBOLS        =
-EXAMPLE_PATH           =
-EXAMPLE_PATTERNS       = *
-EXAMPLE_RECURSIVE      = NO
-IMAGE_PATH             =
-INPUT_FILTER           =
-FILTER_PATTERNS        =
-FILTER_SOURCE_FILES    = NO
-#---------------------------------------------------------------------------
-# configuration options related to source browsing
-#---------------------------------------------------------------------------
-SOURCE_BROWSER         = YES
-INLINE_SOURCES         = NO
-STRIP_CODE_COMMENTS    = YES
-REFERENCED_BY_RELATION = YES
-REFERENCES_RELATION    = YES
-REFERENCES_LINK_SOURCE = YES
-USE_HTAGS              = NO
-VERBATIM_HEADERS       = YES
-#---------------------------------------------------------------------------
-# configuration options related to the alphabetical class index
-#---------------------------------------------------------------------------
-ALPHABETICAL_INDEX     = NO
-COLS_IN_ALPHA_INDEX    = 5
-IGNORE_PREFIX          =
-#---------------------------------------------------------------------------
-# configuration options related to the HTML output
-#---------------------------------------------------------------------------
-GENERATE_HTML          = YES
-HTML_OUTPUT            = html
-HTML_FILE_EXTENSION    = .html
-HTML_HEADER            =
-HTML_FOOTER            =
-HTML_STYLESHEET        =
-HTML_ALIGN_MEMBERS     = YES
-GENERATE_HTMLHELP      = NO
-GENERATE_DOCSET        = NO
-DOCSET_FEEDNAME        = "Doxygen generated docs"
-DOCSET_BUNDLE_ID       = org.doxygen.Project
-HTML_DYNAMIC_SECTIONS  = NO
-CHM_FILE               =
-HHC_LOCATION           =
-GENERATE_CHI           = NO
-BINARY_TOC             = NO
-TOC_EXPAND             = NO
-DISABLE_INDEX          = NO
-ENUM_VALUES_PER_LINE   = 4
-GENERATE_TREEVIEW      = NO
-TREEVIEW_WIDTH         = 250
-#---------------------------------------------------------------------------
-# configuration options related to the LaTeX output
-#---------------------------------------------------------------------------
-GENERATE_LATEX         = YES
-LATEX_OUTPUT           = latex
-LATEX_CMD_NAME         = latex
-MAKEINDEX_CMD_NAME     = makeindex
-COMPACT_LATEX          = YES # NO
-PAPER_TYPE             = a4wide
-EXTRA_PACKAGES         =
-LATEX_HEADER           =
-PDF_HYPERLINKS         = YES
-USE_PDFLATEX           = YES
-LATEX_BATCHMODE        = NO
-LATEX_HIDE_INDICES     = NO
-#---------------------------------------------------------------------------
-# configuration options related to the RTF output
-#---------------------------------------------------------------------------
-GENERATE_RTF           = NO
-RTF_OUTPUT             = rtf
-COMPACT_RTF            = NO
-RTF_HYPERLINKS         = NO
-RTF_STYLESHEET_FILE    =
-RTF_EXTENSIONS_FILE    =
-#---------------------------------------------------------------------------
-# configuration options related to the man page output
-#---------------------------------------------------------------------------
-GENERATE_MAN           = NO
-MAN_OUTPUT             = man
-MAN_EXTENSION          = .3
-MAN_LINKS              = NO
-#---------------------------------------------------------------------------
-# configuration options related to the XML output
-#---------------------------------------------------------------------------
-GENERATE_XML           = NO
-XML_OUTPUT             = xml
-XML_SCHEMA             =
-XML_DTD                =
-XML_PROGRAMLISTING     = YES
-#---------------------------------------------------------------------------
-# configuration options for the AutoGen Definitions output
-#---------------------------------------------------------------------------
-GENERATE_AUTOGEN_DEF   = NO
-#---------------------------------------------------------------------------
-# configuration options related to the Perl module output
-#---------------------------------------------------------------------------
-GENERATE_PERLMOD       = NO
-PERLMOD_LATEX          = NO
-PERLMOD_PRETTY         = YES
-PERLMOD_MAKEVAR_PREFIX =
-#---------------------------------------------------------------------------
-# Configuration options related to the preprocessor
-#---------------------------------------------------------------------------
-ENABLE_PREPROCESSING   = YES
-MACRO_EXPANSION        = NO
-EXPAND_ONLY_PREDEF     = NO
-SEARCH_INCLUDES        = YES
-INCLUDE_PATH           =
-INCLUDE_FILE_PATTERNS  =
-PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
-EXPAND_AS_DEFINED      =
-SKIP_FUNCTION_MACROS   = YES
-#---------------------------------------------------------------------------
-# Configuration::additions related to external references
-#---------------------------------------------------------------------------
-TAGFILES               =
-GENERATE_TAGFILE       =
-ALLEXTERNALS           = NO
-EXTERNAL_GROUPS        = YES
-PERL_PATH              = /usr/bin/perl
-#---------------------------------------------------------------------------
-# Configuration options related to the dot tool
-#---------------------------------------------------------------------------
-CLASS_DIAGRAMS         = NO
-MSCGEN_PATH            =
-HIDE_UNDOC_RELATIONS   = YES
-HAVE_DOT               = YES
-CLASS_GRAPH            = YES
-COLLABORATION_GRAPH    = YES
-GROUP_GRAPHS           = YES
-UML_LOOK               = NO
-TEMPLATE_RELATIONS     = NO
-INCLUDE_GRAPH          = YES
-INCLUDED_BY_GRAPH      = YES
-CALL_GRAPH             = NO # YES
-CALLER_GRAPH           = NO # YES
-GRAPHICAL_HIERARCHY    = YES
-DIRECTORY_GRAPH        = YES
-DOT_IMAGE_FORMAT       = png
-DOT_PATH               = "/usr/bin/dot"
-DOTFILE_DIRS           =
-DOT_GRAPH_MAX_NODES    = 50
-MAX_DOT_GRAPH_DEPTH    = 1000
-DOT_TRANSPARENT        = YES
-DOT_MULTI_TARGETS      = NO
-GENERATE_LEGEND        = YES
-DOT_CLEANUP            = YES
-#---------------------------------------------------------------------------
-# Configuration::additions related to the search engine
-#---------------------------------------------------------------------------
-SEARCHENGINE           = NO
diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile.in
new file mode 100644
index 0000000..e1cdc3b
--- /dev/null
+++ b/doc/doxygen/openvpn.doxyfile.in
@@ -0,0 +1,279 @@
+# Doxyfile 1.5.5
+
+#---------------------------------------------------------------------------
+# Project related configuration options
+#---------------------------------------------------------------------------
+DOXYFILE_ENCODING      = UTF-8
+PROJECT_NAME           = "OpenVPN"
+PROJECT_NUMBER         =
+OUTPUT_DIRECTORY       = doxygen
+CREATE_SUBDIRS         = NO
+OUTPUT_LANGUAGE        = English
+BRIEF_MEMBER_DESC      = YES
+REPEAT_BRIEF           = YES
+ABBREVIATE_BRIEF       = "The $name class" \
+                         "The $name widget" \
+                         "The $name file" \
+                         is \
+                         provides \
+                         specifies \
+                         contains \
+                         represents \
+                         a \
+                         an \
+                         the
+ALWAYS_DETAILED_SEC    = NO
+INLINE_INHERITED_MEMB  = NO
+FULL_PATH_NAMES        = YES
+STRIP_FROM_PATH        = @abs_top_srcdir@
+STRIP_FROM_INC_PATH    =
+SHORT_NAMES            = NO
+JAVADOC_AUTOBRIEF      = YES # NO
+QT_AUTOBRIEF           = NO
+MULTILINE_CPP_IS_BRIEF = NO
+DETAILS_AT_TOP         = NO
+INHERIT_DOCS           = YES
+SEPARATE_MEMBER_PAGES  = NO
+TAB_SIZE               = 8
+ALIASES                =
+OPTIMIZE_OUTPUT_FOR_C  = YES
+OPTIMIZE_OUTPUT_JAVA   = NO
+OPTIMIZE_FOR_FORTRAN   = NO
+OPTIMIZE_OUTPUT_VHDL   = NO
+BUILTIN_STL_SUPPORT    = NO
+CPP_CLI_SUPPORT        = NO
+SIP_SUPPORT            = NO
+DISTRIBUTE_GROUP_DOC   = NO
+SUBGROUPING            = YES
+TYPEDEF_HIDES_STRUCT   = NO
+#---------------------------------------------------------------------------
+# Build related configuration options
+#---------------------------------------------------------------------------
+EXTRACT_ALL            = YES
+EXTRACT_PRIVATE        = YES
+EXTRACT_STATIC         = YES
+EXTRACT_LOCAL_CLASSES  = YES
+EXTRACT_LOCAL_METHODS  = YES
+EXTRACT_ANON_NSPACES   = YES
+HIDE_UNDOC_MEMBERS     = NO
+HIDE_UNDOC_CLASSES     = NO
+HIDE_FRIEND_COMPOUNDS  = NO
+HIDE_IN_BODY_DOCS      = NO
+INTERNAL_DOCS          = NO
+CASE_SENSE_NAMES       = NO
+HIDE_SCOPE_NAMES       = NO
+SHOW_INCLUDE_FILES     = YES
+INLINE_INFO            = YES
+SORT_MEMBER_DOCS       = YES
+SORT_BRIEF_DOCS        = NO
+SORT_GROUP_NAMES       = NO
+SORT_BY_SCOPE_NAME     = NO
+GENERATE_TODOLIST      = YES
+GENERATE_TESTLIST      = YES
+GENERATE_BUGLIST       = YES
+GENERATE_DEPRECATEDLIST= YES
+ENABLED_SECTIONS       =
+MAX_INITIALIZER_LINES  = 30
+SHOW_USED_FILES        = YES
+SHOW_DIRECTORIES       = NO
+FILE_VERSION_FILTER    =
+#---------------------------------------------------------------------------
+# configuration options related to warning and progress messages
+#---------------------------------------------------------------------------
+QUIET                  = NO
+WARNINGS               = YES
+WARN_IF_UNDOCUMENTED   = YES
+WARN_IF_DOC_ERROR      = YES
+WARN_NO_PARAMDOC       = NO
+WARN_FORMAT            = "$file:$line: $text"
+WARN_LOGFILE           =
+#---------------------------------------------------------------------------
+# configuration options related to the input files
+#---------------------------------------------------------------------------
+INPUT                  = @abs_top_srcdir@
+INPUT_ENCODING         = UTF-8
+FILE_PATTERNS          = *.c \
+                         *.cc \
+                         *.cxx \
+                         *.cpp \
+                         *.c++ \
+                         *.d \
+                         *.java \
+                         *.ii \
+                         *.ixx \
+                         *.ipp \
+                         *.i++ \
+                         *.inl \
+                         *.h \
+                         *.hh \
+                         *.hxx \
+                         *.hpp \
+                         *.h++ \
+                         *.idl \
+                         *.odl \
+                         *.cs \
+                         *.php \
+                         *.php3 \
+                         *.inc \
+                         *.m \
+                         *.mm \
+                         *.dox \
+                         *.py \
+                         *.f90 \
+                         *.f \
+                         *.vhd \
+                         *.vhdl
+RECURSIVE              = YES
+EXCLUDE                =
+EXCLUDE_SYMLINKS       = NO
+EXCLUDE_PATTERNS       =
+EXCLUDE_SYMBOLS        =
+EXAMPLE_PATH           =
+EXAMPLE_PATTERNS       = *
+EXAMPLE_RECURSIVE      = NO
+IMAGE_PATH             =
+INPUT_FILTER           =
+FILTER_PATTERNS        =
+FILTER_SOURCE_FILES    = NO
+#---------------------------------------------------------------------------
+# configuration options related to source browsing
+#---------------------------------------------------------------------------
+SOURCE_BROWSER         = YES
+INLINE_SOURCES         = NO
+STRIP_CODE_COMMENTS    = YES
+REFERENCED_BY_RELATION = YES
+REFERENCES_RELATION    = YES
+REFERENCES_LINK_SOURCE = YES
+USE_HTAGS              = NO
+VERBATIM_HEADERS       = YES
+#---------------------------------------------------------------------------
+# configuration options related to the alphabetical class index
+#---------------------------------------------------------------------------
+ALPHABETICAL_INDEX     = NO
+COLS_IN_ALPHA_INDEX    = 5
+IGNORE_PREFIX          =
+#---------------------------------------------------------------------------
+# configuration options related to the HTML output
+#---------------------------------------------------------------------------
+GENERATE_HTML          = YES
+HTML_OUTPUT            = html
+HTML_FILE_EXTENSION    = .html
+HTML_HEADER            =
+HTML_FOOTER            =
+HTML_STYLESHEET        =
+HTML_ALIGN_MEMBERS     = YES
+GENERATE_HTMLHELP      = NO
+GENERATE_DOCSET        = NO
+DOCSET_FEEDNAME        = "Doxygen generated docs"
+DOCSET_BUNDLE_ID       = org.doxygen.Project
+HTML_DYNAMIC_SECTIONS  = NO
+CHM_FILE               =
+HHC_LOCATION           =
+GENERATE_CHI           = NO
+BINARY_TOC             = NO
+TOC_EXPAND             = NO
+DISABLE_INDEX          = NO
+ENUM_VALUES_PER_LINE   = 4
+GENERATE_TREEVIEW      = NO
+TREEVIEW_WIDTH         = 250
+#---------------------------------------------------------------------------
+# configuration options related to the LaTeX output
+#---------------------------------------------------------------------------
+GENERATE_LATEX         = YES
+LATEX_OUTPUT           = latex
+LATEX_CMD_NAME         = latex
+MAKEINDEX_CMD_NAME     = makeindex
+COMPACT_LATEX          = YES # NO
+PAPER_TYPE             = a4wide
+EXTRA_PACKAGES         =
+LATEX_HEADER           =
+PDF_HYPERLINKS         = YES
+USE_PDFLATEX           = YES
+LATEX_BATCHMODE        = NO
+LATEX_HIDE_INDICES     = NO
+#---------------------------------------------------------------------------
+# configuration options related to the RTF output
+#---------------------------------------------------------------------------
+GENERATE_RTF           = NO
+RTF_OUTPUT             = rtf
+COMPACT_RTF            = NO
+RTF_HYPERLINKS         = NO
+RTF_STYLESHEET_FILE    =
+RTF_EXTENSIONS_FILE    =
+#---------------------------------------------------------------------------
+# configuration options related to the man page output
+#---------------------------------------------------------------------------
+GENERATE_MAN           = NO
+MAN_OUTPUT             = man
+MAN_EXTENSION          = .3
+MAN_LINKS              = NO
+#---------------------------------------------------------------------------
+# configuration options related to the XML output
+#---------------------------------------------------------------------------
+GENERATE_XML           = NO
+XML_OUTPUT             = xml
+XML_SCHEMA             =
+XML_DTD                =
+XML_PROGRAMLISTING     = YES
+#---------------------------------------------------------------------------
+# configuration options for the AutoGen Definitions output
+#---------------------------------------------------------------------------
+GENERATE_AUTOGEN_DEF   = NO
+#---------------------------------------------------------------------------
+# configuration options related to the Perl module output
+#---------------------------------------------------------------------------
+GENERATE_PERLMOD       = NO
+PERLMOD_LATEX          = NO
+PERLMOD_PRETTY         = YES
+PERLMOD_MAKEVAR_PREFIX =
+#---------------------------------------------------------------------------
+# Configuration options related to the preprocessor
+#---------------------------------------------------------------------------
+ENABLE_PREPROCESSING   = YES
+MACRO_EXPANSION        = NO
+EXPAND_ONLY_PREDEF     = NO
+SEARCH_INCLUDES        = YES
+INCLUDE_PATH           =
+INCLUDE_FILE_PATTERNS  =
+PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
+EXPAND_AS_DEFINED      =
+SKIP_FUNCTION_MACROS   = YES
+#---------------------------------------------------------------------------
+# Configuration::additions related to external references
+#---------------------------------------------------------------------------
+TAGFILES               =
+GENERATE_TAGFILE       =
+ALLEXTERNALS           = NO
+EXTERNAL_GROUPS        = YES
+PERL_PATH              = /usr/bin/perl
+#---------------------------------------------------------------------------
+# Configuration options related to the dot tool
+#---------------------------------------------------------------------------
+CLASS_DIAGRAMS         = NO
+MSCGEN_PATH            =
+HIDE_UNDOC_RELATIONS   = YES
+HAVE_DOT               = YES
+CLASS_GRAPH            = YES
+COLLABORATION_GRAPH    = YES
+GROUP_GRAPHS           = YES
+UML_LOOK               = NO
+TEMPLATE_RELATIONS     = NO
+INCLUDE_GRAPH          = YES
+INCLUDED_BY_GRAPH      = YES
+CALL_GRAPH             = NO # YES
+CALLER_GRAPH           = NO # YES
+GRAPHICAL_HIERARCHY    = YES
+DIRECTORY_GRAPH        = YES
+DOT_IMAGE_FORMAT       = png
+DOT_PATH               = "/usr/bin/dot"
+DOTFILE_DIRS           =
+DOT_GRAPH_MAX_NODES    = 50
+MAX_DOT_GRAPH_DEPTH    = 1000
+DOT_TRANSPARENT        = YES
+DOT_MULTI_TARGETS      = NO
+GENERATE_LEGEND        = YES
+DOT_CLEANUP            = YES
+#---------------------------------------------------------------------------
+# Configuration::additions related to the search engine
+#---------------------------------------------------------------------------
+SEARCHENGINE           = NO
-- 
2.7.4


