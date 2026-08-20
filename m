Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C0FC5DF82
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cagfa2LiljVZ1rCjcL/aIwS1XLC6Khxb1XfMA1AElzA=; b=YYeLHxIJSaw6SPYGtPNMIrJVJK
	NrBLBlOVG/Xr+NLY2uiIeHuPbCkRPrIRJahNZ32rKJRyWqPOaJEfD7LRMGvtZscdMaVGfRfTCm0yw
	+qWShibTOopTTPKE2bfpmjro7zKtvOULAg0t6ULNpGUD0ZoHPT9bE0DBlEGBtr2Lv+TM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwysI-0002uR-MQ;
	Thu, 20 Aug 2026 09:15:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwysH-0002uA-TJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 09:15:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7fNXdrScGp0v2zeEeb8BZrXr0L9OHZ3wUcUk/YEZMf8=; b=FwubH6w2LJne4IK7995T42nd/v
 02IALp78ZGqe7Q9Xb/qlkSc0t5nxYImV6h8XYOcSVjqSLlnLpwMrP1ZDJUDMEsKcU+Hv9E6Z0OIph
 Q8QR08WMpqhRTzPpgznvT3y4lCp+l1ortZJfg4yJvdBvTPIyfdkDwjOlRhYAFncHaYkk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7fNXdrScGp0v2zeEeb8BZrXr0L9OHZ3wUcUk/YEZMf8=; b=TyH+cxSb7bfbYCniconTG5/B4N
 56eqp+L4qy8H/03wAq3bQ47dvzba76oYsOiS+TcDz7pyYBZYPjO611xJS6wnJdNYbc6vejMfDiJBC
 u64YVcTd6AXCHVZezs07yJsVdYOTT51xNVBx/OK7GVkTbj/7lhrvYZm76mxOtW4/XeCc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwysE-00084U-FS for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 09:15:49 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67K9FdSB004613
 for <openvpn-devel@lists.sourceforge.net>; Thu, 20 Aug 2026 11:15:39 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67K9FdWI004612
 for openvpn-devel@lists.sourceforge.net; Thu, 20 Aug 2026 11:15:39 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 20 Aug 2026 11:15:29 +0200
Message-ID: <20260820091539.4592-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwysE-00084U-FS
Subject: [Openvpn-devel] [PATCH v4] Reformat all shell-scripts with shfmt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

According to ./dev-tools/reformat-shell.sh.

Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1793
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1793
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/git-pre-commit-format.sh b/dev-tools/git-pre-commit-format.sh
index 9b2ecaf..3507289 100755
--- a/dev-tools/git-pre-commit-format.sh
+++ b/dev-tools/git-pre-commit-format.sh
@@ -26,7 +26,6 @@
 # OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
-
 # git pre-commit hook that runs a stylecheck.
 # Features:
 #  - abort commit when commit does not comply with the style guidelines
@@ -43,12 +42,11 @@
 # exit on error
 set -e
 
-
 # If called so, install this script as pre-commit hook
-if [ "$1" = "install" ] ; then
+if [ "$1" = "install" ]; then
     TARGET="$(git rev-parse --git-path hooks)/pre-commit"
 
-    if [ -e "$TARGET" ] ; then
+    if [ -e "$TARGET" ]; then
         printf "$TARGET file exists. Won't overwrite.\n"
         printf "Aborting installation.\n"
         exit 1
@@ -62,18 +60,19 @@
 fi
 
 # check whether the given file matches any of the set extensions
-matches_extension() {
+matches_extension()
+{
     local filename="$(basename -- "$1")"
     local extension=".${filename##*.}"
     local ext
 
-    for ext in .c .h ; do [ "$ext" = "$extension" ] && return 0; done
+    for ext in .c .h; do [ "$ext" = "$extension" ] && return 0; done
 
     return 1
 }
 
 # necessary check for initial commit
-if git rev-parse --verify HEAD >/dev/null 2>&1 ; then
+if git rev-parse --verify HEAD >/dev/null 2>&1; then
     against=HEAD
 else
     # Initial commit: diff against an empty tree object
@@ -88,8 +87,8 @@
 
     # Allow to use in parallel with pre-commit
     if [ $(basename "$0") = "pre-commit.legacy" ]; then
-       echo "Skipping clang-format check in favor of pre-commit"
-       exit 0
+        echo "Skipping clang-format check in favor of pre-commit"
+        exit 0
     fi
 else
     TOOL=uncrustify
@@ -98,7 +97,7 @@
     TOOL_CMD="$TOOL_BIN -q -l C -c $UNCRUST_CONFIG"
 
     # make sure the config file is correctly set
-    if [ ! -f "$UNCRUST_CONFIG" ] ; then
+    if [ ! -f "$UNCRUST_CONFIG" ]; then
         printf "Error: uncrustify config file not found.\n"
         printf "Expected to find it at $UNCRUST_CONFIG.\n"
         printf "Aborting commit.\n"
@@ -106,7 +105,7 @@
     fi
 fi
 
-if [ -z "$TOOL_BIN" ] ; then
+if [ -z "$TOOL_BIN" ]; then
     printf "Error: $TOOL executable not found.\n"
     printf "Is it installed and in your \$PATH?\n"
     printf "Aborting commit.\n"
@@ -120,44 +119,43 @@
 # create one patch containing all changes to the files
 # sed to remove quotes around the filename, if inserted by the system
 # (done sometimes, if the filename contains special characters, like the quote itself)
-git diff-index --cached --diff-filter=ACMR --name-only $against -- | \
-sed -e 's/^"\(.*\)"$/\1/' | \
-while read file
-do
-    # ignore file if we do check for file extensions and the file
-    # does not match the extensions .c or .h
-    if ! matches_extension "$file"; then
-        continue;
-    fi
+git diff-index --cached --diff-filter=ACMR --name-only $against -- |
+    sed -e 's/^"\(.*\)"$/\1/' |
+    while read file; do
+        # ignore file if we do check for file extensions and the file
+        # does not match the extensions .c or .h
+        if ! matches_extension "$file"; then
+            continue
+        fi
 
-    # escape special characters in the target filename:
-    # phase 1 (characters escaped in the output diff):
-    #     - '\': backslash needs to be escaped in the output diff
-    #     - '"': quote needs to be escaped in the output diff if present inside
-    #            of the filename, as it used to bracket the entire filename part
-    # phase 2 (characters escaped in the match replacement):
-    #     - '\': backslash needs to be escaped again for sed itself
-    #            (i.e. double escaping after phase 1)
-    #     - '&': would expand to matched string
-    #     - '|': used as sed split char instead of '/'
-    # printf %s particularly important if the filename contains the % character
-    file_escaped_target=$(printf "%s" "$file" | sed -e 's/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
+        # escape special characters in the target filename:
+        # phase 1 (characters escaped in the output diff):
+        #     - '\': backslash needs to be escaped in the output diff
+        #     - '"': quote needs to be escaped in the output diff if present inside
+        #            of the filename, as it used to bracket the entire filename part
+        # phase 2 (characters escaped in the match replacement):
+        #     - '\': backslash needs to be escaped again for sed itself
+        #            (i.e. double escaping after phase 1)
+        #     - '&': would expand to matched string
+        #     - '|': used as sed split char instead of '/'
+        # printf %s particularly important if the filename contains the % character
+        file_escaped_target=$(printf "%s" "$file" | sed -e 's/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
 
-    # uncrustify our sourcefile, create a patch with diff and append it to our $patch
-    # The sed call is necessary to transform the patch from
-    #    --- - timestamp
-    #    +++ $tmpout timestamp
-    # to both lines working on the same file and having a a/ and b/ prefix.
-    # Else it can not be applied with 'git apply'.
-    git show ":$file" | $TOOL_CMD > "$tmpout"
-    git show ":$file" | diff -u -- - "$tmpout" | \
-        sed -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/$file_escaped_target\"|" >> "$patch"
-done
+        # uncrustify our sourcefile, create a patch with diff and append it to our $patch
+        # The sed call is necessary to transform the patch from
+        #    --- - timestamp
+        #    +++ $tmpout timestamp
+        # to both lines working on the same file and having a a/ and b/ prefix.
+        # Else it can not be applied with 'git apply'.
+        git show ":$file" | $TOOL_CMD >"$tmpout"
+        git show ":$file" | diff -u -- - "$tmpout" |
+            sed -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/$file_escaped_target\"|" >>"$patch"
+    done
 
 rm -f "$tmpout"
 
 # if no patch has been generated all is ok, clean up the file stub and exit
-if [ ! -s "$patch" ] ; then
+if [ ! -s "$patch" ]; then
     rm -f "$patch"
     exit 0
 fi
@@ -165,7 +163,7 @@
 # a patch has been created, notify the user and exit
 printf "Formatting of some code does not follow the project guidelines.\n"
 
-if [ $(wc -l < $patch) -gt 80 ] ; then
+if [ $(wc -l <$patch) -gt 80 ]; then
     printf "The file $patch contains the necessary fixes.\n"
 else
     printf "Here's the patch that fixes the formatting:\n\n"
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 40db33e..a7aa3c4 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -20,24 +20,23 @@
  --check-level=exhaustive --max-configs=10 \
  --error-exitcode=1"
 
-
 set -x
 
 mkdir -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
 cppcheck $COMMON_ARGS $INCLUDE_FLAGS \
-         --platform=unix64 \
-         --library=posix.cfg --library=bsd.cfg --library=gnu.cfg \
-         -U_WIN32 \
-         src/openvpn/ src/compat/ src/plugins/ sample/ \
-         tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \
-         tests/unit_tests/plugins/
+    --platform=unix64 \
+    --library=posix.cfg --library=bsd.cfg --library=gnu.cfg \
+    -U_WIN32 \
+    src/openvpn/ src/compat/ src/plugins/ sample/ \
+    tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \
+    tests/unit_tests/plugins/
 cppcheck $COMMON_ARGS \
-         --platform=win64 \
-         --library=windows.cfg \
-         -D_WIN32 \
-         -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
-         -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
-         -UTARGET_AIX \
-         src/openvpn* src/compat/ \
-         tests/unit_tests/example_test/ tests/unit_tests/openvpn*
+    --platform=win64 \
+    --library=windows.cfg \
+    -D_WIN32 \
+    -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
+    -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
+    -UTARGET_AIX \
+    src/openvpn* src/compat/ \
+    tests/unit_tests/example_test/ tests/unit_tests/openvpn*
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index 96546dd..7ca6002 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -34,8 +34,7 @@
 COPY_YEAR="$1"
 
 cd "$(git rev-parse --show-toplevel)"
-for file in $(git ls-files | grep -v vendor/);
-do
+for file in $(git ls-files | grep -v vendor/); do
     echo -n "Updating $file ..."
     # The first sed operation covers 20xx-20yy copyright lines,
     # The second sed operation changes 20xx -> 20xx-20yy
diff --git a/tests/lwip_client_up.sh b/tests/lwip_client_up.sh
index a6b4d24..b1941a4 100755
--- a/tests/lwip_client_up.sh
+++ b/tests/lwip_client_up.sh
@@ -2,16 +2,17 @@
 #
 # Determine the OpenVPN PID from its pid file. This works reliably even when
 # the OpenVPN process is backgrounded for parallel tests.
-MY_PPID=`cat $pid`
+MY_PPID=$(cat $pid)
 
 # Add this client's VPN IP and PID to a file. This enables
 # t_server_null_client.sh to kill this OpenVPN client after fping tests have
 # finished.
-echo "$ifconfig_local,$MY_PPID" >> ./$test_name.lwip
+echo "$ifconfig_local,$MY_PPID" >>./$test_name.lwip
 
 # Wait long enough to allow fping tests to finish. Also ensure that this
 # OpenVPN client is killed even if t_server_null_client.sh failed to do it.
-(sleep 15
-echo "ERROR: t_server_null_client.sh failed to kill OpenVPN client with PID $MY_PPID in test $test_name. Killing it in lwip_client_up.sh."
-kill -15 $MY_PPID
+(
+    sleep 15
+    echo "ERROR: t_server_null_client.sh failed to kill OpenVPN client with PID $MY_PPID in test $test_name. Killing it in lwip_client_up.sh."
+    kill -15 $MY_PPID
 ) &
diff --git a/tests/null_client_up.sh b/tests/null_client_up.sh
index d4df0c6..be339ee 100755
--- a/tests/null_client_up.sh
+++ b/tests/null_client_up.sh
@@ -4,8 +4,11 @@
 
 # Determine the OpenVPN PID from its pid file. This works reliably even when
 # the OpenVPN process is backgrounded for parallel tests.
-MY_PPID=`cat $pid`
+MY_PPID=$(cat $pid)
 
 # Allow OpenVPN to finish initializing while waiting in the background and then
 # killing the process gracefully.
-(sleep 5 ; kill -15 $MY_PPID) &
+(
+    sleep 5
+    kill -15 $MY_PPID
+) &
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 2f37845..305441be 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -19,9 +19,9 @@
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
 openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
-if [ -r "${top_builddir}"/t_client.rc ] ; then
+if [ -r "${top_builddir}"/t_client.rc ]; then
     . "${top_builddir}"/t_client.rc
-elif [ -r "${srcdir}"/t_client.rc ] ; then
+elif [ -r "${srcdir}"/t_client.rc ]; then
     . "${srcdir}"/t_client.rc
 else
     echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
@@ -32,37 +32,35 @@
 # Check for external dependencies
 FPING="fping"
 FPING6="fping6"
-which fping > /dev/null
+which fping >/dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fping is not available in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
-which fping6 > /dev/null
+which fping6 >/dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fping6 is not available in \$PATH, assuming fping 4.0 or later" >&2
     FPING="fping -4"
     FPING6="fping -6"
 fi
 
-KILL_EXEC=`which kill`
+KILL_EXEC=$(which kill)
 if [ $? -ne 0 ]; then
     echo "$0: kill not found in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
 
-if [ ! -x "${openvpn}" ]
-then
+if [ ! -x "${openvpn}" ]; then
     echo "no (executable) openvpn binary in current build tree. FAIL." >&2
     exit 1
 fi
 
-if [ ! -w . ]
-then
+if [ ! -w . ]; then
     echo "current directory is not writable (required for logging). FAIL." >&2
     exit 1
 fi
 
-if [ -z "$TEST_RUN_LIST" ] ; then
+if [ -z "$TEST_RUN_LIST" ]; then
     echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
@@ -72,16 +70,14 @@
 
 # make sure we have permissions to run ifconfig/route from OpenVPN
 # can't use "id -u" here - doesn't work on Solaris
-ID=`id`
-if expr "$ID" : "uid=0" >/dev/null
-then :
+ID=$(id)
+if expr "$ID" : "uid=0" >/dev/null; then
+    :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
         # Check if we have a valid kerberos ticket
         klist -l 1>/dev/null 2>/dev/null
-        if [ $? -ne 0 ];
-        then
+        if [ $? -ne 0 ]; then
             # No kerberos ticket found, skip ksu and fallback to RUN_SUDO
             PREFER_KSU=0
             echo "$0: No Kerberos ticket available.  Will not use ksu."
@@ -90,8 +86,7 @@
         fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
         echo "$0: this test must run be as root, or RUN_SUDO=... " >&2
         echo "      must be set correctly in 't_client.rc'. SKIP." >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -99,20 +94,19 @@
         # We have to use sudo. Make sure that we (hopefully) do not have
         # to ask the users password during the test. This is done to
         # prevent timing issues, e.g. when the waits for openvpn to start
-	if $RUN_SUDO $KILL_EXEC -0 $$
-	then
-	    echo "$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
-	else
-	    echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
-	    exit "${TCLIENT_SKIP_RC}"
-	fi
+        if $RUN_SUDO $KILL_EXEC -0 $$; then
+            echo "$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
+        else
+            echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
+            exit "${TCLIENT_SKIP_RC}"
+        fi
     fi
 fi
 
-LOGDIR=t_client-`hostname`-`date +%Y%m%d-%H%M%S`
+LOGDIR=t_client-$(hostname)-$(date +%Y%m%d-%H%M%S)
 LOGDIR_ABS="$PWD/$LOGDIR"
-if mkdir $LOGDIR
-then :
+if mkdir $LOGDIR; then
+    :
 else
     echo "can't create log directory '$LOGDIR'. FAIL." >&2
     exit 1
@@ -132,21 +126,28 @@
 output_start()
 {
     case $V in
-	0) outbuf="" ;;			# no per-test output at all
-	1) printf "$@\n"			# compact, details only on failure
-           outbuf="\n" ;;
-	*) printf "\n$@\n" ;;		# print all, with a bit formatting
+        0) outbuf="" ;; # no per-test output at all
+        1)
+            printf "$@\n" # compact, details only on failure
+            outbuf="\n"
+            ;;
+        *) printf "\n$@\n" ;; # print all, with a bit formatting
     esac
 }
 
 output()
 {
-    END_NL="\n"; if [ "X$1" = "X-n" ] ; then END_NL="" ; shift ; fi
+    END_NL="\n"
+    if [ "X$1" = "X-n" ]; then
+        END_NL=""
+        shift
+    fi
     case $V in
-	0) ;;				# no per-test output at all
-	1) outbuf="$outbuf$@${END_NL}"	# print details only on failure
-           ;;
-	*) printf "$@${END_NL}" ;;	# print everything
+        0) ;; # no per-test output at all
+        1)
+            outbuf="$outbuf$@${END_NL}" # print details only on failure
+            ;;
+        *) printf "$@${END_NL}" ;; # print everything
     esac
 }
 
@@ -154,62 +155,61 @@
 fail()
 {
     output "FAIL: $@\n"
-    fail_count=$(( $fail_count + 1 ))
+    fail_count=$(($fail_count + 1))
 }
 
 # print "all interface IP addresses" + "all routes"
 # this is higly system dependent...
 get_ifconfig_route()
 {
-    UNAME=`uname -s`
+    UNAME=$(uname -s)
     case $UNAME in
-	Linux)
+        Linux)
             # linux / iproute2? (-> if configure got a path)
-            if [ -n "@IPROUTE@" ]
-            then
+            if [ -n "@IPROUTE@" ]; then
                 echo "-- linux iproute2 --"
-                @IPROUTE@ addr show     | grep -v valid_lft
+                @IPROUTE@ addr show | grep -v valid_lft
                 @IPROUTE@ route show
                 @IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
             else
-	        echo "-- linux / ifconfig --"
-	        LANG=C @IFCONFIG@ -a |egrep  "( addr:|encap:)"
-	        LANG=C @NETSTAT@ -rn -4 -6
+                echo "-- linux / ifconfig --"
+                LANG=C @IFCONFIG@ -a | egrep "( addr:|encap:)"
+                LANG=C @NETSTAT@ -rn -4 -6
             fi
             ;;
-	FreeBSD|NetBSD|Darwin)
-	   echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
-	   @IFCONFIG@ -a | egrep "(flags=|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	OpenBSD)
-	   echo "-- OpenBSD --"
-	   @IFCONFIG@ -a | egrep "(flags=|inet)" | \
-		sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	SunOS)
-	   echo "-- Solaris --"
-	   @IFCONFIG@ -a | egrep "(flags=|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
-	AIX)
-	   echo "-- AIX --"
-	   @IFCONFIG@ -a | egrep "(flags=|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
+        FreeBSD | NetBSD | Darwin)
+            echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+            @IFCONFIG@ -a | egrep "(flags=|inet)"
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+            ;;
+        OpenBSD)
+            echo "-- OpenBSD --"
+            @IFCONFIG@ -a | egrep "(flags=|inet)" |
+                sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+            ;;
+        SunOS)
+            echo "-- Solaris --"
+            @IFCONFIG@ -a | egrep "(flags=|inet)"
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+            ;;
+        AIX)
+            echo "-- AIX --"
+            @IFCONFIG@ -a | egrep "(flags=|inet)"
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+            ;;
         *)
-           echo "get_ifconfig_route(): no idea how to get info on your OS (`uname -s`).  FAIL." >&2
-           exit 20
-           ;;
+            echo "get_ifconfig_route(): no idea how to get info on your OS ($(uname -s)).  FAIL." >&2
+            exit 20
+            ;;
     esac
 
     # another round of per-platform information gathering, for DNS info
     # for most of the platforms "cat /etc/resolv.conf" is good enough
     # except Linux and MacOS
     case $UNAME in
-	Linux)
-            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then
+        Linux)
+            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ]; then
                 echo "-- linux resolvectl --"
                 resolvectl status
             else
@@ -217,7 +217,7 @@
                 cat /etc/resolv.conf
             fi
             ;;
-	Darwin)
+        Darwin)
             echo "-- MacOS scutil --dns"
             scutil --dns
             ;;
@@ -234,19 +234,19 @@
 #  arg2: IPv4/IPv6 address that must show up in out of "get_ifconfig_route"
 check_ifconfig()
 {
-    proto=$1 ; shift
+    proto=$1
+    shift
     expect_list="$@"
 
-    if [ -z "$expect_list" ] ; then return ; fi
-    if [ "$expect_list" = "-" ] ; then return ; fi
+    if [ -z "$expect_list" ]; then return; fi
+    if [ "$expect_list" = "-" ]; then return; fi
 
-    for expect in $expect_list
-    do
-	if get_ifconfig_route | fgrep "$expect" >/dev/null
-	then :
-	else
-	    fail "check_ifconfig(): expected IPv$proto address '$expect' not found in ifconfig output."
-	fi
+    for expect in $expect_list; do
+        if get_ifconfig_route | fgrep "$expect" >/dev/null; then
+            :
+        else
+            fail "check_ifconfig(): expected IPv$proto address '$expect' not found in ifconfig output."
+        fi
     done
 }
 
@@ -257,47 +257,48 @@
 #  arg3... -> fping arguments (host list)
 run_ping_tests()
 {
-    proto=$1 ; want=$2 ; shift ; shift
+    proto=$1
+    want=$2
+    shift
+    shift
     targetlist="$@"
 
     # "no targets" is fine
-    if [ -z "$targetlist" ] ; then return ; fi
+    if [ -z "$targetlist" ]; then return; fi
 
     case $proto in
-	4) cmd="$FPING" ;;
-	6) cmd="$FPING6" ;;
-	*) echo "internal error in run_ping_tests arg 1: '$proto'" >&2
-	   exit 1 ;;
+        4) cmd="$FPING" ;;
+        6) cmd="$FPING6" ;;
+        *)
+            echo "internal error in run_ping_tests arg 1: '$proto'" >&2
+            exit 1
+            ;;
     esac
 
     case $want in
-	want_ok)   sizes_list="64 1440 3000" ;;
-	want_fail) sizes_list="64" ;;
+        want_ok) sizes_list="64 1440 3000" ;;
+        want_fail) sizes_list="64" ;;
     esac
 
-    for bytes in $sizes_list
-    do
-	output "run IPv$proto ping tests ($want), $bytes byte packets..."
+    for bytes in $sizes_list; do
+        output "run IPv$proto ping tests ($want), $bytes byte packets..."
 
-	echo "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:fping.out
-	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
+        echo "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:fping.out
+        $cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
 
-	# while OpenVPN is running, pings must succeed (want='want_ok')
-	# before OpenVPN is up, pings must NOT succeed (want='want_fail')
+        # while OpenVPN is running, pings must succeed (want='want_ok')
+        # before OpenVPN is up, pings must NOT succeed (want='want_fail')
 
-	rc=$?
-	if [ $rc = 0 ] 				# all ping OK
-	then
-	    if [ $want = "want_fail" ]		# not what we want
-	    then
-		fail "IPv$proto ping test succeeded, but needs to *fail*."
-	    fi
-	else					# ping failed
-	    if [ $want = "want_ok" ]		# not what we wanted
-	    then
-		fail "IPv$proto ping test ($bytes bytes) failed, but should succeed."
-	    fi
-	fi
+        rc=$?
+        if [ $rc = 0 ]; then                 # all ping OK
+            if [ $want = "want_fail" ]; then # not what we want
+                fail "IPv$proto ping test succeeded, but needs to *fail*."
+            fi
+        else                               # ping failed
+            if [ $want = "want_ok" ]; then # not what we wanted
+                fail "IPv$proto ping test ($bytes bytes) failed, but should succeed."
+            fi
+        fi
     done
 }
 
@@ -308,8 +309,7 @@
 SUMMARY_SKIP=
 SUMMARY_FAIL=
 
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     # get config variables
     eval test_prep=\"\$PREPARE_$SUF\"
     eval test_check_skip=\"\$CHECK_SKIP_$SUF\"
@@ -336,11 +336,13 @@
 
     if [ -n "$test_check_skip" ]; then
         output "check whether we need to skip: '$test_check_skip'"
-        if eval $test_check_skip; then :
+        if eval $test_check_skip; then
+            :
         else
             output "skip check failed, SKIP test $SUF."
-	    SUMMARY_SKIP="$SUMMARY_SKIP $SUF"
-	    printf "$outbuf" ; continue
+            SUMMARY_SKIP="$SUMMARY_SKIP $SUF"
+            printf "$outbuf"
+            continue
         fi
     fi
 
@@ -355,13 +357,14 @@
     output "\nrun pre-openvpn ping tests - targets must not be reachable..."
     run_ping_tests 4 want_fail "$ping4_hosts"
     run_ping_tests 6 want_fail "$ping6_hosts"
-    if [ "$fail_count" = 0 ] ; then
+    if [ "$fail_count" = 0 ]; then
         output "OK.\n"
     else
-	fail "make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF."
-	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
-	exit_code=31
-	printf "$outbuf" ; continue
+        fail "make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF."
+        SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
+        exit_code=31
+        printf "$outbuf"
+        continue
     fi
 
     pidfile="$LOGDIR_ABS/openvpn-$SUF.pid"
@@ -376,18 +379,17 @@
     # to $ovpn_init_check times.
     ovpn_init_check=30
     ovpn_init_success=0
-    while [ $ovpn_init_check -gt 0 ];
-    do
-       sleep 1  # Wait for OpenVPN to initialize and have had time to write the pid file
-       grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >/dev/null
-       if [ $? -eq 0 ]; then
-           ovpn_init_check=0
-           ovpn_init_success=1
-       fi
-       ovpn_init_check=$(( $ovpn_init_check - 1 ))
+    while [ $ovpn_init_check -gt 0 ]; do
+        sleep 1 # Wait for OpenVPN to initialize and have had time to write the pid file
+        grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >/dev/null
+        if [ $? -eq 0 ]; then
+            ovpn_init_check=0
+            ovpn_init_success=1
+        fi
+        ovpn_init_check=$(($ovpn_init_check - 1))
     done
 
-    opid=`cat $pidfile`
+    opid=$(cat $pidfile)
     if [ -n "$opid" ]; then
         output "  OpenVPN running with PID $opid"
     else
@@ -398,16 +400,17 @@
     if [ $ovpn_init_success -ne 1 -o -z "$opid" ]; then
         output "$0:  OpenVPN did not initialize in a reasonable time"
         if [ -n "$opid" ]; then
-           $RUN_SUDO $KILL_EXEC $opid
+            $RUN_SUDO $KILL_EXEC $opid
         fi
         $RUN_SUDO $KILL_EXEC $sudopid
-	output "tail -5 $SUF:openvpn.log"
-	output "`tail -5 $LOGDIR/$SUF:openvpn.log`"
-	fail "skip rest of sub-tests for test run $SUF."
-	trap - 0 1 2 3 15
-	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
-	exit_code=30
-	printf "$outbuf" ; continue
+        output "tail -5 $SUF:openvpn.log"
+        output "$(tail -5 $LOGDIR/$SUF:openvpn.log)"
+        fail "skip rest of sub-tests for test run $SUF."
+        trap - 0 1 2 3 15
+        SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
+        exit_code=30
+        printf "$outbuf"
+        continue
     fi
 
     # make sure openvpn client is terminated in case shell exits
@@ -418,17 +421,16 @@
     output "save ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt
 
-    if [ "$expect_ifconfig4" = "-" ] ; then
+    if [ "$expect_ifconfig4" = "-" ]; then
         output "skip ifconfig+route check"
     else
-	output -n "compare pre-openvpn ifconfig+route with current values..."
-	if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
-		$LOGDIR/$SUF:ifconfig_route.txt >/dev/null
-	then
-	    fail "no differences between ifconfig/route before OpenVPN start and now."
-	else
-	    output " OK!\n"
-	fi
+        output -n "compare pre-openvpn ifconfig+route with current values..."
+        if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
+            $LOGDIR/$SUF:ifconfig_route.txt >/dev/null; then
+            fail "no differences between ifconfig/route before OpenVPN start and now."
+        else
+            output " OK!\n"
+        fi
     fi
 
     # post init script needed?
@@ -449,8 +451,8 @@
     $RUN_SUDO $KILL_EXEC $opid
     wait $!
     rc=$?
-    if [ $rc != 0 ] ; then
-	fail "OpenVPN return code $rc, expect 0"
+    if [ $rc != 0 ]; then
+        fail "OpenVPN return code $rc, expect 0"
     fi
 
     output "\nsave post-openvpn ifconfig + route..."
@@ -458,23 +460,22 @@
 
     output -n "compare pre- and post-openvpn ifconfig + route..."
     if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
-	    $LOGDIR/$SUF:ifconfig_route_post.txt >$LOGDIR/$SUF:ifconfig_route_diff.txt
-    then
-	output " OK.\n"
+        $LOGDIR/$SUF:ifconfig_route_post.txt >$LOGDIR/$SUF:ifconfig_route_diff.txt; then
+        output " OK.\n"
     else
-	output "\n\n" "`cat $LOGDIR/$SUF:ifconfig_route_diff.txt`" "\n"
-	fail "differences between pre- and post-ifconfig/route."
+        output "\n\n" "$(cat $LOGDIR/$SUF:ifconfig_route_diff.txt)" "\n"
+        fail "differences between pre- and post-ifconfig/route."
     fi
-    if [ "$fail_count" = 0 ] ; then
+    if [ "$fail_count" = 0 ]; then
         output "test run $SUF: all tests OK.\n"
-	SUMMARY_OK="$SUMMARY_OK $SUF"
+        SUMMARY_OK="$SUMMARY_OK $SUF"
     else
-	if [ "$V" -gt 0 ] ; then
-	    printf "$outbuf"
-	    echo "test run $SUF: $fail_count test failures. FAIL."
+        if [ "$V" -gt 0 ]; then
+            printf "$outbuf"
+            echo "test run $SUF: $fail_count test failures. FAIL."
         fi
-	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
-	exit_code=30
+        SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
+        exit_code=30
     fi
 
     if [ -n "$test_cleanup" ]; then
@@ -484,9 +485,9 @@
 
 done
 
-if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=" none"; fi
-if [ -z "$SUMMARY_SKIP" ] ; then SUMMARY_SKIP=" none"; fi
-if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=" none"; fi
+if [ -z "$SUMMARY_OK" ]; then SUMMARY_OK=" none"; fi
+if [ -z "$SUMMARY_SKIP" ]; then SUMMARY_SKIP=" none"; fi
+if [ -z "$SUMMARY_FAIL" ]; then SUMMARY_FAIL=" none"; fi
 echo "Test sets succeeded:$SUMMARY_OK."
 echo "Test sets skipped:$SUMMARY_SKIP."
 echo "Test sets failed:$SUMMARY_FAIL."
diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh
index 6b7df65..03c3845 100755
--- a/tests/t_cltsrv.sh
+++ b/tests/t_cltsrv.sh
@@ -24,50 +24,58 @@
 trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
 addopts=
-case `uname -s` in
+case $(uname -s) in
     FreeBSD)
-    # FreeBSD jails map the outgoing IP to the jail IP - we need to
-    # allow the real IP unless we want the test to run forever.
-    if test "`sysctl 2>/dev/null -n security.jail.jailed`" = 1 \
-    || ps -ostate= -p $$ | grep -q J; then
-	addopts="--float"
-	if test "x`ifconfig | grep inet`" = x ; then
-	    echo "###"
-	    echo "### To run the test in a FreeBSD jail, you MUST add an IP alias for the jail's IP."
-	    echo "###"
-	    exit 77
-	fi
-    fi
-    ;;
+        # FreeBSD jails map the outgoing IP to the jail IP - we need to
+        # allow the real IP unless we want the test to run forever.
+        if test "$(sysctl 2>/dev/null -n security.jail.jailed)" = 1 ||
+            ps -ostate= -p $$ | grep -q J; then
+            addopts="--float"
+            if test "x$(ifconfig | grep inet)" = x; then
+                echo "###"
+                echo "### To run the test in a FreeBSD jail, you MUST add an IP alias for the jail's IP."
+                echo "###"
+                exit 77
+            fi
+        fi
+        ;;
 esac
 
 # make sure that the --down script is executable -- fail (rather than
 # skip) test if it isn't.
 downscript="../tests/t_cltsrv-down.sh"
 root="${top_srcdir}/sample"
-test -x "${root}/${downscript}" || chmod +x "${root}/${downscript}" || { echo >&2 "${root}/${downscript} is not executable, failing." ; exit 1 ; }
+test -x "${root}/${downscript}" || chmod +x "${root}/${downscript}" || {
+    echo >&2 "${root}/${downscript} is not executable, failing."
+    exit 1
+}
 echo "The following test will take about two minutes." >&2
 echo "If the addresses are in use, this test will retry up to two times." >&2
 
 # go
 success=0
-for i in 1 2 3 ; do
-  set +e
-  (
-  "${openvpn}" --script-security 2 --cd "${root}" ${addopts} --setenv role srv --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-server" &
-  "${openvpn}" --script-security 2 --cd "${top_srcdir}/sample" ${addopts} --setenv role clt --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-client"
-  ) 3>log.$$.signal >log.$$ 2>&1
-  e1=$?
-  wait $!
-  e2=$?
-  grep 'TCP/UDP: Socket bind failed on local address.*in use' log.$$ >/dev/null && {
-    echo 'address in use, retrying in 150 s'
-    sleep 150
-    continue
-  }
-  grep -v ':inactive$' log.$$.signal >/dev/null && { cat log.$$.signal ; echo ; cat log.$$ ; exit 1 ; }
-  success=1
-  break
+for i in 1 2 3; do
+    set +e
+    (
+        "${openvpn}" --script-security 2 --cd "${root}" ${addopts} --setenv role srv --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-server" &
+        "${openvpn}" --script-security 2 --cd "${top_srcdir}/sample" ${addopts} --setenv role clt --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-client"
+    ) 3>log.$$.signal >log.$$ 2>&1
+    e1=$?
+    wait $!
+    e2=$?
+    grep 'TCP/UDP: Socket bind failed on local address.*in use' log.$$ >/dev/null && {
+        echo 'address in use, retrying in 150 s'
+        sleep 150
+        continue
+    }
+    grep -v ':inactive$' log.$$.signal >/dev/null && {
+        cat log.$$.signal
+        echo
+        cat log.$$
+        exit 1
+    }
+    success=1
+    break
 done
 
 set -e
@@ -75,14 +83,14 @@
 # exit code - defaults to 0, PASS
 ec=0
 
-if [ $success != 1 ] ; then
-  # couldn't run test -- addresses in use, skip test
-  cat log.$$
-  ec=77
-elif [ $e1 != 0 ] || [ $e2 != 0 ] ; then
-  # failure -- fail test
-  cat log.$$
-  ec=1
+if [ $success != 1 ]; then
+    # couldn't run test -- addresses in use, skip test
+    cat log.$$
+    ec=77
+elif [ $e1 != 0 ] || [ $e2 != 0 ]; then
+    # failure -- fail test
+    cat log.$$
+    ec=1
 fi
 
 rm log.$$ log.$$.signal
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 6802506..058206f 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -37,51 +37,56 @@
 test_start()
 {
     case $V in
-        0) outbuf="" ;;                  # no per-test output at all
-        1) outbuf="$@" ;;                # compact, details only on failure
-        *) printf "$@" ;;                # print all
+        0) outbuf="" ;;   # no per-test output at all
+        1) outbuf="$@" ;; # compact, details only on failure
+        *) printf "$@" ;; # print all
     esac
 }
 test_end()
 {
-    RC=$1 ; LOG=$2
-    if [ $RC != 0 ]
-    then
+    RC=$1
+    LOG=$2
+    if [ $RC != 0 ]; then
         case $V in
-            0) ;;                                # no per-test output
-            1) echo "$outbuf" "FAIL (RC=$RC)"; cat $LOG ;;
-            *) echo "FAIL (RC=$RC)"; cat $LOG ;;
+            0) ;; # no per-test output
+            1)
+                echo "$outbuf" "FAIL (RC=$RC)"
+                cat $LOG
+                ;;
+            *)
+                echo "FAIL (RC=$RC)"
+                cat $LOG
+                ;;
         esac
         e=1
-        tests_failed=$(( $tests_failed + 1 ))
+        tests_failed=$(($tests_failed + 1))
     else
         case $V in
-            0|1) ;;                              # no per-test output for 'OK'
-            *) echo "OK"                         # print all
+            0 | 1) ;;       # no per-test output for 'OK'
+            *) echo "OK" ;; # print all
         esac
-        tests_passed=$(( $tests_passed + 1 ))
+        tests_passed=$(($tests_passed + 1))
     fi
 }
 
 # if running with V=1, give an indication what test runs now
-if [ "$V" = 1  ] ; then
+if [ "$V" = 1 ]; then
     echo "$0: running with V=$V, only printing test fails"
 fi
 
-
 # Get list of supported ciphers from openvpn --show-ciphers output
-CIPHERS=$(${openvpn} --show-ciphers | \
-            sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^[[:space:]]*$/d')
+CIPHERS=$(${openvpn} --show-ciphers |
+    sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^[[:space:]]*$/d')
 
 # SK, 2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
 # broken (see http://rt.openssl.org/Ticket/Display.html?id=2867), so exclude
 # that cipher from this test.
 # GD, 2014-07-06 so is DES-CFB1
 # GD, 2014-07-06 do not test RC5-* either (fails on NetBSD w/o libcrypto_rc5)
-CIPHERS=$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)' )
+CIPHERS=$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)')
 
 e=0
-if [ -z "$CIPHERS" ] ; then
+if [ -z "$CIPHERS" ]; then
     echo "'openvpn --show-ciphers' FAILED (empty list)"
     e=1
 fi
@@ -91,10 +96,9 @@
 
 set +e
 
-for cipher in ${CIPHERS}
-do
+for cipher in ${CIPHERS}; do
     test_start "Testing cipher ${cipher}... "
-    ( "${openvpn}" --test-crypto --cipher ${cipher} ) >log.$$ 2>&1
+    ("${openvpn}" --test-crypto --cipher ${cipher}) >log.$$ 2>&1
     test_end $? log.$$
 done
 
@@ -121,7 +125,7 @@
     >log.$$ 2>&1
 test_end $? log.$$
 
-if [ "$V" -ge 1  ] ; then
+if [ "$V" -ge 1 ]; then
     echo "$0: tests passed: $tests_passed  failed: $tests_failed"
 fi
 
diff --git a/tests/t_net.sh b/tests/t_net.sh
index 8134832..17e028e 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -9,7 +9,6 @@
 top_builddir="${top_builddir:-..}"
 openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 
-
 # bail out right away on non-linux. NetLink (the object of this test) is only
 # used on Linux, therefore testing other platform is not needed.
 #
@@ -69,7 +68,6 @@
     done
 }
 
-
 ## execution starts here
 
 # t_client.rc required only for RUN_SUDO definition
@@ -89,21 +87,18 @@
     exit 77
 fi
 
-
 # Ensure PREFER_KSU is in a known state
 PREFER_KSU="${PREFER_KSU:-0}"
 
 # make sure we have permissions to run the networking unit-test
-ID=`id`
-if expr "$ID" : "uid=0" >/dev/null
-then :
+ID=$(id)
+if expr "$ID" : "uid=0" >/dev/null; then
+    :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
         # Check if we have a valid kerberos ticket
         klist -l 1>/dev/null 2>/dev/null
-        if [ $? -ne 0 ];
-        then
+        if [ $? -ne 0 ]; then
             # No kerberos ticket found, skip ksu and fallback to RUN_SUDO
             PREFER_KSU=0
             echo "$0: No Kerberos ticket available.  Will not use ksu."
@@ -112,16 +107,14 @@
         fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
         echo "$0: no RUN_SUDO=... in t_client.rc or environment, defaulting to 'sudo'." >&2
         echo "      if that does not work, set RUN_SUDO= correctly for your system." >&2
         RUN_SUDO="sudo"
     fi
 
     # check that we can run the unit-test binary with sudo
-    if $RUN_SUDO $UNIT_TEST test
-    then
+    if $RUN_SUDO $UNIT_TEST test; then
         echo "$0: $RUN_SUDO $UNIT_TEST succeeded, good."
     else
         echo "$0: $RUN_SUDO $UNIT_TEST failed, cannot go on. SKIP." >&2
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index 74ffd52..c633614 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -2,7 +2,7 @@
 #
 TSERVER_NULL_SKIP_RC="${TSERVER_NULL_SKIP_RC:-77}"
 
-if ! [ -r "./t_server_null.rc" ] ; then
+if ! [ -r "./t_server_null.rc" ]; then
     echo "${0}: cannot find './t_server_null.rc. SKIPPING TEST.'" >&2
     exit "${TSERVER_NULL_SKIP_RC}"
 fi
@@ -22,11 +22,10 @@
 # make sure we have permissions to run ifconfig/route from OpenVPN
 # can't use "id -u" here - doesn't work on Solaris
 ID=$(id)
-if expr "$ID" : "uid=0" >/dev/null
-then :
+if expr "$ID" : "uid=0" >/dev/null; then
+    :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
         # Check if we have a valid kerberos ticket
         if klist -l 1>/dev/null 2>/dev/null; then
             RUN_SUDO="ksu -q -e"
@@ -37,26 +36,24 @@
         fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
         echo "${0}: this test must run be as root, or RUN_SUDO=... " >&2
         echo "      must be set correctly in 't_server_null.rc'. SKIP." >&2
         exit "${TSERVER_NULL_SKIP_RC}"
     else
-	# Run a no-op command with privilege escalation (e.g. sudo) so that
-	# we (hopefully) do not have to ask the users password during the test.
-	if $RUN_SUDO "${KILL_EXEC}" -0 $$
-	then
-	    echo "${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
-	else
-	    echo "${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
-	    exit "${TSERVER_NULL_SKIP_RC}"
-	fi
+        # Run a no-op command with privilege escalation (e.g. sudo) so that
+        # we (hopefully) do not have to ask the users password during the test.
+        if $RUN_SUDO "${KILL_EXEC}" -0 $$; then
+            echo "${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
+        else
+            echo "${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
+            exit "${TSERVER_NULL_SKIP_RC}"
+        fi
     fi
 fi
 
 srcdir="${srcdir:-.}"
-export t_server_null_logdir=t_server_null-`hostname`-`date +%Y%m%d-%H%M%S`
+export t_server_null_logdir=t_server_null-$(hostname)-$(date +%Y%m%d-%H%M%S)
 
 # Create directory for server and client logs
 mkdir $t_server_null_logdir
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 1745de5..3203cc2 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -1,9 +1,10 @@
 #!/bin/sh
 
-should_run_test() {
+should_run_test()
+{
     test_name="$1"
 
-    if echo "$test_name"|grep -q _lwip; then
+    if echo "$test_name" | grep -q _lwip; then
         if [ "$has_lwipovpn" = "no" ]; then
             return 1
         fi
@@ -12,7 +13,8 @@
     return 0
 }
 
-launch_client() {
+launch_client()
+{
     test_name=$1
     log="${test_name}.log"
     pid="${test_name}.pid"
@@ -30,7 +32,8 @@
         --log "${t_server_null_logdir}/${log}" &
 }
 
-ping_and_kill() {
+ping_and_kill()
+{
     if fping -q -c 5 $1; then
         echo "PASS: fping lwipovpn client $target"
     else
@@ -46,9 +49,10 @@
     kill -15 $2
 }
 
-ping_lwip_clients() {
+ping_lwip_clients()
+{
     if [ "$has_lwipovpn" = "yes" ]; then
-        lwip_client_count=$(echo "$lwip_test_names"|wc -w|tr -d " ")
+        lwip_client_count=$(echo "$lwip_test_names" | wc -w | tr -d " ")
     else
         lwip_client_count=0
     fi
@@ -60,10 +64,10 @@
     count=0
     maxcount=10
     while [ $count -le $maxcount ]; do
-        lwip_client_ips=$(cat ./*.lwip 2>/dev/null|wc -l)
+        lwip_client_ips=$(cat ./*.lwip 2>/dev/null | wc -l)
         if [ $lwip_client_ips -lt $lwip_client_count ]; then
             echo "Waiting for LWIP clients to start up ($count/$maxcount)"
-            count=$(( count + 1))
+            count=$((count + 1))
             sleep 1
         else
             echo "$lwip_client_ips/$lwip_client_count LWIP clients up"
@@ -73,8 +77,8 @@
 
     wait_pids=""
     for line in $(cat ./*.lwip 2>/dev/null); do
-        target_ip=$(echo $line|cut -d "," -f 1)
-        client_pid=$(echo $line|cut -d "," -f 2)
+        target_ip=$(echo $line | cut -d "," -f 1)
+        client_pid=$(echo $line | cut -d "," -f 2)
         ping_and_kill $target_ip $client_pid &
         wait_pids="$wait_pids $!"
     done
@@ -84,7 +88,8 @@
     test -e ./lwip_failed && return 1 || return 0
 }
 
-wait_for_results() {
+wait_for_results()
+{
     tests_running="yes"
 
     # Wait a bit to allow an OpenVPN client process to create a pidfile to
@@ -106,12 +111,13 @@
     done
 }
 
-get_client_test_result() {
+get_client_test_result()
+{
     test_name=$1
     should_pass=$2
     log="${test_name}.log"
 
-    grep "Initialization Sequence Completed" "${t_server_null_logdir}/${log}" > /dev/null
+    grep "Initialization Sequence Completed" "${t_server_null_logdir}/${log}" >/dev/null
     exit_code=$?
 
     if [ $exit_code -eq 0 ] && [ "${should_pass}" = "yes" ]; then
@@ -144,7 +150,7 @@
 server_max_wait=15
 while [ $count -lt $server_max_wait ]; do
     servers_up=0
-    server_count=$(echo "$TEST_SERVER_LIST"|wc -w|tr -d " ")
+    server_count=$(echo "$TEST_SERVER_LIST" | wc -w | tr -d " ")
 
     # We need to trim single-quotes because some shells return quoted values
     # and some don't. Using "set -o posix" which would resolve this problem is
@@ -152,13 +158,13 @@
     #
     # While inactive server configurations may get checked they won't increase
     # the active server count as the processes won't be running.
-    for i in $(set|grep 'SERVER_NAME_'|cut -d "=" -f 2|tr -d "[\']"); do
-        server_pid=$(cat "$i.pid" 2> /dev/null)
-        if [ -z "$server_pid" ] ; then
+    for i in $(set | grep 'SERVER_NAME_' | cut -d "=" -f 2 | tr -d "[\']"); do
+        server_pid=$(cat "$i.pid" 2>/dev/null)
+        if [ -z "$server_pid" ]; then
             continue
         fi
-        if $RUN_SUDO kill -0 $server_pid > /dev/null 2>&1; then
-            servers_up=$(( $servers_up + 1 ))
+        if $RUN_SUDO kill -0 $server_pid >/dev/null 2>&1; then
+            servers_up=$(($servers_up + 1))
         fi
     done
 
@@ -168,7 +174,7 @@
         retval=0
         break
     else
-        count=$(( count + 1))
+        count=$((count + 1))
         sleep 1
     fi
 
@@ -199,15 +205,14 @@
 # safe to check the test results.
 test_names=""
 lwip_test_names=""
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     eval test_name=\"\$TEST_NAME_$SUF\"
     eval client_exec=\"\$CLIENT_EXEC_$SUF\"
     eval client_conf=\"\$CLIENT_CONF_$SUF\"
 
     test_names="${test_names} ${test_name}"
 
-    if echo "$test_name"|grep -q _lwip; then
+    if echo "$test_name" | grep -q _lwip; then
         lwip_test_names="${lwip_test_names} ${test_name}"
     fi
 
@@ -219,13 +224,11 @@
 ping_lwip_clients
 retval=$?
 
-
 # Wait until all OpenVPN clients have exited
 (wait_for_results)
 
 # Check test results
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     eval test_name=\"\$TEST_NAME_$SUF\"
     eval should_pass=\"\$SHOULD_PASS_$SUF\"
 
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index e1775f0..a8d7268 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-launch_server() {
+launch_server()
+{
     server_name=$1
     server_exec=$2
     server_conf=$3
@@ -17,10 +18,10 @@
 
     # Try to launch the server
     $RUN_SUDO "${server_exec}" \
-               $server_conf \
-               --status "${status}" 1 \
-               --writepid "${pid}" \
-               --explicit-exit-notify 3 > "$log" 2>&1 &
+        $server_conf \
+        --status "${status}" 1 \
+        --writepid "${pid}" \
+        --explicit-exit-notify 3 >"$log" 2>&1 &
 
     sleep 1
 
@@ -44,8 +45,7 @@
 retval=0
 
 # Launch test servers
-for SUF in $TEST_SERVER_LIST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval server_name=\"\$SERVER_NAME_$SUF\"
     eval server_exec=\"\$SERVER_EXEC_$SUF\"
     eval server_conf=\"\$SERVER_CONF_$SUF\"
@@ -57,8 +57,7 @@
 # the test run.
 #
 export server_pid_files=""
-for SUF in $TEST_SERVER_LIST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval server_name=\"\$SERVER_NAME_$SUF\"
     server_pid_files="${server_pid_files} ./${server_name}.pid"
 done
@@ -69,12 +68,11 @@
 count=0
 maxcount=4
 while [ $count -le $maxcount ]; do
-    if ls t_server_null_client.sh*.pid > /dev/null 2>&1
-    then
+    if ls t_server_null_client.sh*.pid >/dev/null 2>&1; then
         count=0
         sleep 1
     else
-	count=$(( count + 1))
+        count=$((count + 1))
         sleep 1
     fi
 done
@@ -85,11 +83,10 @@
 # server process does not exit in 15 seconds assume it never will, move on and
 # hope for the best.
 echo "Waiting for servers to exit"
-for PID_FILE in $server_pid_files
-do
+for PID_FILE in $server_pid_files; do
     SERVER_PID=$(cat "${PID_FILE}")
 
-    if [ -z "$SERVER_PID" ] ; then
+    if [ -z "$SERVER_PID" ]; then
         echo "WARNING: could not kill server ${PID_FILE}!"
         continue
     fi
@@ -99,17 +96,16 @@
 
     count=0
     maxcount=75
-    while [ $count -le $maxcount ]
-    do
-        $RUN_SUDO kill -0 "${SERVER_PID}" 2> /dev/null || break
-        count=$(( count + 1))
+    while [ $count -le $maxcount ]; do
+        $RUN_SUDO kill -0 "${SERVER_PID}" 2>/dev/null || break
+        count=$((count + 1))
         sleep 0.2
     done
 
     # If server is still up send a SIGKILL
     if [ $count -ge $maxcount ]; then
         $RUN_SUDO $KILL_EXEC -9 "${SERVER_PID}"
-        SERVER_NAME=$(basename $PID_FILE|cut -d . -f 1)
+        SERVER_NAME=$(basename $PID_FILE | cut -d . -f 1)
         echo "ERROR: had to send SIGKILL to server ${SERVER_NAME} with pid ${SERVER_PID}!"
         echo "Tail of server log:"
         tail -n 20 "${t_server_null_logdir}/${SERVER_NAME}.log"
diff --git a/tests/t_server_null_stress.sh b/tests/t_server_null_stress.sh
index 0bb9452..2fc9fde 100755
--- a/tests/t_server_null_stress.sh
+++ b/tests/t_server_null_stress.sh
@@ -7,8 +7,7 @@
 . ./t_server_null_default.rc
 
 export pid_files=""
-for SUF in $TEST_SERVER_LIST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval server_name=\"\$SERVER_NAME_$SUF\"
     pid_files="${pid_files} ./${server_name}.pid"
 done
@@ -18,16 +17,16 @@
 
 count=0
 while [ $count -lt $ITERATIONS ]; do
-    count=$(( count + 1 ))
-    make check TESTS=t_server_null.sh SUBDIRS= > /dev/null 2>&1
+    count=$((count + 1))
+    make check TESTS=t_server_null.sh SUBDIRS= >/dev/null 2>&1
     retval=$?
 
-    echo "Iteration ${count}: return value ${retval}" >> "${LOG_BASEDIR}/make-check.log"
+    echo "Iteration ${count}: return value ${retval}" >>"${LOG_BASEDIR}/make-check.log"
     if [ $retval -ne 0 ]; then
-	DIR="${LOG_BASEDIR}/make-check-${count}"
+        DIR="${LOG_BASEDIR}/make-check-${count}"
         mkdir -p "${DIR}"
         cp t_server_null*.log "${DIR}/"
         cp test-suite.log "${DIR}/"
-        ps aux|grep openvpn|grep -vE '(suppress|grep)' > "${DIR}/psaux"
+        ps aux | grep openvpn | grep -vE '(suppress|grep)' >"${DIR}/psaux"
     fi
 done
diff --git a/tests/update_t_client_ips.sh b/tests/update_t_client_ips.sh
index 96e3826..777a286 100755
--- a/tests/update_t_client_ips.sh
+++ b/tests/update_t_client_ips.sh
@@ -5,12 +5,12 @@
 
 RC="$TOP_BUILDDIR/t_client_ips.rc"
 
-grep EXPECT_IFCONFIG4_$TESTNUM= $RC > /dev/null 2>&1
+grep EXPECT_IFCONFIG4_$TESTNUM= $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then
-    echo "EXPECT_IFCONFIG4_$TESTNUM=$ifconfig_local" >> $RC
+    echo "EXPECT_IFCONFIG4_$TESTNUM=$ifconfig_local" >>$RC
 fi
 
-grep EXPECT_IFCONFIG6_$TESTNUM= $RC > /dev/null 2>&1
+grep EXPECT_IFCONFIG6_$TESTNUM= $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then
-    echo "EXPECT_IFCONFIG6_$TESTNUM=$ifconfig_ipv6_local" >> $RC
+    echo "EXPECT_IFCONFIG6_$TESTNUM=$ifconfig_ipv6_local" >>$RC
 fi


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
