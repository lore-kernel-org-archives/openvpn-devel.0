From: David Sommerseth <davids@...1347...>
Date: Fri,  8 Apr 2011 13:40:04 +0200
Message-Id: <1302262805-23686-2-git-send-email-davids@...1347...>
In-Reply-To: <1302262805-23686-1-git-send-email-davids@...1347...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<1302262805-23686-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH 1/2] Make use of $TMPDIR on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...1347...>

According to the Single Unix Specification (SuS) [1] the $TMPDIR environment
variable may define another temporary directory than the standard /tmp
directory.  As it is considered safe to assume /tmp will always exist, remove
the possibility to change this at compile time.

With this path the temporary directory can be defined by either setting
$TMPDIR or using the --tmp-dir option.  Otherwise, /tmp will be the
default

[1] http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#tag_08_03

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac |   11 -----------
 options.c    |    7 +++++--
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index a9f022e..e0847bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -279,11 +279,6 @@ AC_ARG_WITH(netstat-path,
 )
 AC_DEFINE_UNQUOTED(NETSTAT_PATH, "$NETSTAT", [Path to netstat tool])
 
-AC_ARG_WITH(tmp-dir-path,
-   [  --with-tmp-dir-path=PATH  Default tmp-dir to use when not configured (unset defaults to /tmp)],
-   [TMPDIRPATH="$withval"]
-)
-
 AC_ARG_WITH(mem-check,
    [  --with-mem-check=TYPE  Build with debug memory checking, TYPE = dmalloc or valgrind],
    [MEMCHECK="$withval"]
@@ -571,12 +566,6 @@ LDFLAGS="$LDFLAGS -Wl,--fatal-warnings"
 AC_CHECK_FUNC(epoll_create, AC_DEFINE(HAVE_EPOLL_CREATE, 1, [epoll_create function is defined]))
 LDFLAGS="$OLDLDFLAGS"
 
-dnl set the default temporary directory
-if test -z "$TMPDIRPATH"; then
-   TMPDIRPATH="/tmp"
-fi
-AC_DEFINE_UNQUOTED(DEFAULT_TMPDIR, "$TMPDIRPATH", [Default --tmp-dir])
-
 dnl
 dnl check for valgrind tool
 dnl
diff --git a/options.c b/options.c
index 0b91657..7303cb4 100644
--- a/options.c
+++ b/options.c
@@ -777,8 +777,11 @@ init_options (struct options *o, const bool init_gc)
   /* On Windows, find temp dir via enviroment variables */
   o->tmp_dir = win_get_tempdir();
 #else
-  /* Non-windows platforms have this value defined via ./configure */
-  o->tmp_dir = DEFAULT_TMPDIR;
+  /* Non-windows platforms use $TMPDIR, and if not set, default to '/tmp' */
+  o->tmp_dir = getenv("TMPDIR");
+  if( !o->tmp_dir ) {
+          o->tmp_dir = "/tmp";
+  }
 #endif /* WIN32 */
 }
 
-- 
1.7.4.2


