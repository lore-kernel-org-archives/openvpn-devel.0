From: Antonio Quartulli <a@...2181...>
Date: Thu, 24 Aug 2017 21:38:45 +0800
Message-Id: <20170824133845.3984-1-a@...2181...>
In-Reply-To: <20170824133305.25604-1-a@...2181...>
References: <20170824133305.25604-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2] bash: substitute legacy `` with modern
 $()
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
Cc: Antonio Quartulli <a@...2181...>

The backquotes for command substitution in bash are
considered old-style in favour of the more modern $() [1].
Substitute them.

[1]https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html#Command-Substitution

Signed-off-by: Antonio Quartulli <a@...2181...>
---

v2: added overlooked occurrence

note: I did not really know how to test this patch.

 dev-tools/gen-release-tarballs.sh | 12 ++++++------
 tests/t_cltsrv.sh                 |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index f9c620e3..b4f5edc0 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -22,7 +22,7 @@ set -u
 if [ $# -ne 4 ]; then
     echo "Usage: $0 <remote-name> <tag-name> <sign-key> <dest-dir>"
     echo ""
-    echo "   remote-name  -- valid remotes: `git remote | tr \\\n ' '`"
+    echo "   remote-name  -- valid remotes: $(git remote | tr \\\n ' ')"
     echo "   tag-name     -- An existing release tag"
     echo "   sign-key     -- PGP key used to sign all files"
     echo "   dest-dir     -- Where to put the complete set of release tarballs"
@@ -49,7 +49,7 @@ if [ $? -ne 0 ]; then
 fi
 
 # Extract the git URL
-giturl="`git remote get-url $arg_remote_name 2>/dev/null`"
+giturl="$(git remote get-url $arg_remote_name 2>/dev/null)"
 if [ $? -ne 0 ]; then
     echo "** ERROR ** Invalid git remote name: $arg_remote_name"
     exit 2
@@ -71,7 +71,7 @@ get_filename()
 {
     local wildcard="$1"
 
-    res="`find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | cut -d/ -f2-`"
+    res="$(find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | cut -d/ -f2-)"
     if [ $? -ne 0 ]; then
         echo "-- 'find' failed."
         exit 5
@@ -88,7 +88,7 @@ copy_files()
     local fileext="$1"
     local dest="$2"
 
-    file="`get_filename openvpn-*.*.*.$fileext`"
+    file="$(get_filename openvpn-*.*.*.$fileext)"
     if [ -z "$file" ]; then
         echo "** ERROR Failed to find source file"
         exit 5
@@ -106,7 +106,7 @@ sign_file()
     local signkey="$1"
     local srchfile="$2"
     local signtype="$3"
-    local file="`get_filename $srchfile`"
+    local file="$(get_filename $srchfile)"
 
     echo "-- Signing $file ..."
     case "$signtype" in
@@ -169,7 +169,7 @@ fi
 #
 
 # Clone the remote repository
-workdir="`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
+workdir="$(mktemp -d -p /var/tmp openvpn-build-release-XXXXXX)"
 cd $workdir
 echo "-- Working directory: $workdir"
 echo "-- git clone $giturl"
diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh
index 752251e4..1ab3db3e 100755
--- a/tests/t_cltsrv.sh
+++ b/tests/t_cltsrv.sh
@@ -25,14 +25,14 @@ top_builddir="${top_builddir:-..}"
 trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
 addopts=
-case `uname -s` in
+case $(uname -s) in
     FreeBSD)
     # FreeBSD jails map the outgoing IP to the jail IP - we need to
     # allow the real IP unless we want the test to run forever.
-    if test "`sysctl 2>/dev/null -n security.jail.jailed`" = 1 \
+    if test "$(sysctl 2>/dev/null -n security.jail.jailed)" = 1 \
     || ps -ostate= -p $$ | grep -q J; then
 	addopts="--float"
-	if test "x`ifconfig | grep inet`" = x ; then
+	if test "x$(ifconfig | grep inet)" = x ; then
 	    echo "###"
 	    echo "### To run the test in a FreeBSD jail, you MUST add an IP alias for the jail's IP."
 	    echo "###"
-- 
2.14.1


