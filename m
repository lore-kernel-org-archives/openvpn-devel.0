Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFB606A33C
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HqnJZizG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EFNChTjT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ho9KzTXn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qs4lQn1xa0PhOLltnIcAhmSzywtmFnz8iEnO3iYvDA4=; b=HqnJZizGI/Ujjs
	aHoUZnFoQMhgDMWXwjWzB29v4fWRVLqrE0h7cPrkhgJWBR2onVXVNtKdzw/H7CFz75KH09i4akusN
	yHRGXw3gAp/84eSTS1GoSSAwMRiT7wee457gbDu6NIxDqLjqCxnUTGKQmXPHM7vMN7Vz2tDQAM3tx
	R94=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0ei-00000000572-13zh;
	Thu, 05 Nov 2026 16:49:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xP0eg-0000000056v-1r2L for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:49:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f8gJbccZLJprnH44WOglYNBtCyqD0AKlvpz2iJ+M5es=; b=EFNChTjTuhaMcp6ivnj9Le+6SD
 IRvzbpqXOEGrGmxli7vGBy+4Wf0tHX+4P6CK2B/fjt+sQjG2dL+rpZMBEGm0ZFS8WJDgCucBb9tmC
 0LkHFa3oSn+EuC0PS9CajlliULI1aq1i9JKXxp1h1tmguM3/Me9oaDkYv89XSmWdylPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f8gJbccZLJprnH44WOglYNBtCyqD0AKlvpz2iJ+M5es=; b=Ho9KzTXnJQeakNt6nTTEL50Y1o
 DiT2PxfBw1JdnkwvjGZr60ryxzOaBCx5l/yweGJPQpPoqxpd2EVGdru3kDuJsXQlv/wpFdeF2OHXE
 3wUJ6sgw37Idh+apzEO+p95h/5DZj44Ar8cdKCHkNHJPkq3SV3BmxvudoOasiP51L3XY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xP0ec-0000000074o-051z for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 16:49:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A5GnQXV024669
 for <openvpn-devel@lists.sourceforge.net>; Thu, 5 Nov 2026 17:49:26 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A5GnQ5A024665
 for openvpn-devel@lists.sourceforge.net; Thu, 5 Nov 2026 17:49:26 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  5 Nov 2026 17:49:21 +0100
Message-ID: <20261105164926.24646-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
References: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xP0ec-0000000074o-051z
Subject: [Openvpn-devel] [PATCH v2] backport t_client.sh changes from master
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is basically just copying in the current t_client.sh.in script from
master, with a number of changes that are not in 2.7 yet - most notably
support for "expect failure" cases.

Given that this is a test support script with no dependencies into the
OpenVPN core, and the large number of non-backported scripts that touch
one line or the other, or re-indent things, copying the whole script
instead of trying to cherry-pick all the individual change seemed like
a much better idea...

Besides t_client.sh, this also brings tests/update_t_client_ips.sh
from master, because the dc16248523 commit will break functionality
otherwise.

Here's the list:

commit e2548f6e3b7f9ed3d24020319117b17f30743656
    t_client.sh.in: Check whether addresses are in "tentative" state

commit af6a79c6a83739ca9542e52a02a3449a2f292758
    t_client.sh.in: Add ability to filter by test group

commit dc162485236b70ecfe1be639dbd9db8244a85d54
    t_client.sh.in: Allow to override the location of t_client_ips.rc
    (needs updated update_t_client_ips.sh)

commit 8b392d642eb4c9b9135dc6a442d943159467e058
    t_client.sh.in: Add utility function needs_openvpn()

commit dc162485236b70ecfe1be639dbd9db8244a85d54
    t_client.sh.in: Allow to override the location of t_client_ips.rc

commit 37ea1c7683ccb464f80d6e7e8fbcd4b8baf2ac60
    t_client.sh.in: Add support for expected test failures

commit ed427eab1683af3adf21553dd1c6b6e4b8b2f10d
    reformat-shell.sh: Add --simplify argument

commit f781227c92a3d1017e9d8a67e83e4465b43edf66
    Reformat all shell-scripts with shfmt
    (touches update_t_client_ips.sh)

commit b32d1ab45ec93786191e0dac2c8f5549d6c04258
    t_client.sh.in: Do not try to guess the absolute path to LOGDIR

commit da1b2a7081eb2791f3a675945c42d7f3189ef752
    t_client.sh.in: Use printf instead of echo -e

commit 162f19112702d1c8045efd17c5b09022fe1e04fb
    t_client.sh.in: Do not run resolvectl if systemd is not running

commit 841ab0b216a424eb0100448362f76a2c12b3a516
    t_client.sh: Do not use CA_CERT variable as indicator for good .rc file

Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2141
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.7.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2141
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 876e84a..5e924bb 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -19,57 +19,82 @@
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
 openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
-if [ -r "${top_builddir}"/t_client.rc ] ; then
-    . "${top_builddir}"/t_client.rc
-elif [ -r "${srcdir}"/t_client.rc ] ; then
-    . "${srcdir}"/t_client.rc
-else
-    echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
-    echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
-    exit "${TCLIENT_SKIP_RC}"
+t_client_ips_rc="${t_client_ips_rc:-${top_builddir}/t_client_ips.rc}"
+update_t_client_ips="${update_t_client_ips:-${srcdir}/update_t_client_ips.sh}"
+
+if [ -z "${t_client_rc}" ]; then
+    if [ -r "${top_builddir}"/t_client.rc ]; then
+        t_client_rc="${top_builddir}"/t_client.rc
+    elif [ -r "${srcdir}"/t_client.rc ]; then
+        t_client_rc="${srcdir}"/t_client.rc
+    else
+        echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
+        echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
 fi
 
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
 
-if [ -z "$CA_CERT" ] ; then
-    echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
+openvpn_version=$(${openvpn} --version | head -n 1 | cut -f2 -d" " | sed -E 's/^2\.([0123456789]+).*$/2\1/')
+
+needs_openvpn()
+{
+    needs_version=$1
+
+    [ "$openvpn_version" -ge "$needs_version" ]
+    return $?
+}
+
+. "${t_client_rc}"
+
+if [ -z "$TEST_RUN_LIST" ]; then
+    echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
 
-if [ -z "$TEST_RUN_LIST" ] ; then
-    echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
-    exit "${TCLIENT_SKIP_RC}"
+if [ -n "$TEST_RUN_GROUP" ]; then
+    FILTERED_LIST=
+    for test in $TEST_RUN_LIST; do
+        group=$(echo $test | sed -E 's/^([0123456789]+).*/\1/')
+        if [ "$group" = "$TEST_RUN_GROUP" ]; then
+            FILTERED_LIST="$FILTERED_LIST $test"
+        fi
+    done
+    if [ -z "$FILTERED_LIST" ]; then
+        echo "Filtered TEST_RUN_LIST empty (group=$TEST_RUN_GROUP), no tests defined.  SKIP test." >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
+    TEST_RUN_LIST=$FILTERED_LIST
 fi
 
 # Ensure PREFER_KSU is in a known state
@@ -77,16 +102,14 @@
 
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
@@ -95,8 +118,7 @@
         fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
         echo "$0: this test must run be as root, or RUN_SUDO=... " >&2
         echo "      must be set correctly in 't_client.rc'. SKIP." >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -104,20 +126,22 @@
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
+if [ -n "$TEST_RUN_GROUP" ]; then
+    LOGDIR="${LOGDIR}-${TEST_RUN_GROUP}"
+fi
 LOGDIR_ABS="$PWD/$LOGDIR"
-if mkdir $LOGDIR
-then :
+if mkdir $LOGDIR; then
+    :
 else
     echo "can't create log directory '$LOGDIR'. FAIL." >&2
     exit 1
@@ -137,21 +161,28 @@
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
 
@@ -159,62 +190,61 @@
 fail()
 {
     output "FAIL: $@\n"
-    fail_count=$(( $fail_count + 1 ))
+    fail_count=$((fail_count + 1))
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
@@ -222,7 +252,7 @@
                 cat /etc/resolv.conf
             fi
             ;;
-	Darwin)
+        Darwin)
             echo "-- MacOS scutil --dns"
             scutil --dns
             ;;
@@ -260,19 +290,19 @@
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
 
@@ -283,47 +313,48 @@
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
 
@@ -334,8 +365,7 @@
 SUMMARY_SKIP=
 SUMMARY_FAIL=
 
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     # get config variables
     eval test_prep=\"\$PREPARE_$SUF\"
     eval test_check_skip=\"\$CHECK_SKIP_$SUF\"
@@ -347,26 +377,32 @@
     eval expect_ifconfig6=\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_hosts=\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=\"\$PING6_HOSTS_$SUF\"
+    eval expect_fail=\"\$EXPECT_FAIL_$SUF\"
     eval fping_args=\"\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG* variables for this test are missing, run an --up
     # script to generate them dynamically.
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; then
-        up="--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --script-security 2 --up ${srcdir}/update_t_client_ips.sh"
+        up="--setenv TESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-security 2 --up ${update_t_client_ips}"
     else
         up=""
     fi
 
     output_start "### test run $SUF: '$test_run_title' ###"
+    if [ -n "$expect_fail" ]; then
+        output "### expect failure: '$expect_fail'"
+    fi
     fail_count=0
 
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
 
@@ -385,13 +421,14 @@
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
@@ -406,38 +443,77 @@
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
+        sleep 1 # Wait for OpenVPN to initialize and to write the pid file
+        if [ -n "$expect_fail" ]; then
+            grep "$expect_fail" $LOGDIR/$SUF:openvpn.log >/dev/null
+            if [ $? -eq 0 ]; then
+                ovpn_init_check=0
+                ovpn_init_success=1
+                sleep 5 # give openvpn time to quit
+            fi
+        else
+            grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >/dev/null
+            if [ $? -eq 0 ]; then
+                ovpn_init_check=0
+                ovpn_init_success=1
+            fi
+        fi
+        ovpn_init_check=$((ovpn_init_check - 1))
     done
 
-    opid=`cat $pidfile`
+    opid=$([ -e $pidfile ] && cat $pidfile)
     if [ -n "$opid" ]; then
         output "  OpenVPN running with PID $opid"
     else
-        output "  Could not read OpenVPN PID file"
+        if [ -z "$expect_fail" ]; then # print this only if unexpected
+            output "  Could not read OpenVPN PID file"
+        fi
     fi
 
-    # If OpenVPN did not start
+    # did we expect a failure?
+    if [ -n "$expect_fail" ]; then
+        if [ -n "$opid" ]; then # OpenVPN did start!
+            output "$0: OpenVPN did start up, expected failure"
+            $RUN_SUDO $KILL_EXEC $opid $sudopid
+            output "tail -5 $SUF:openvpn.log"
+            output "$(tail -5 $LOGDIR/$SUF:openvpn.log)"
+            fail "skip rest of sub-tests for test run $SUF."
+            trap - 0 1 2 3 15
+            SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
+            exit_code=32
+            printf "$outbuf"
+            continue
+        elif [ $ovpn_init_success -eq 0 ]; then
+            output "$0: OpenVPN failure did not match expected failure"
+            output "tail -5 $SUF:openvpn.log"
+            output "$(tail -5 $LOGDIR/$SUF:openvpn.log)"
+            SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
+            exit_code=33
+            printf "$outbuf"
+            continue
+        else
+            output "test run $SUF: all tests OK (saw expected failure)."
+            SUMMARY_OK="$SUMMARY_OK $SUF"
+            continue
+        fi
+    fi
+
+    # If OpenVPN did not start but should have
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
@@ -452,17 +528,16 @@
         exit 1
     fi
 
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
@@ -483,8 +558,8 @@
     $RUN_SUDO $KILL_EXEC $opid
     wait $!
     rc=$?
-    if [ $rc != 0 ] ; then
-	fail "OpenVPN return code $rc, expect 0"
+    if [ $rc != 0 ]; then
+        fail "OpenVPN return code $rc, expect 0"
     fi
 
     output "\nsave post-openvpn ifconfig + route..."
@@ -496,23 +571,22 @@
 
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
@@ -522,9 +596,9 @@
 
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
diff --git a/tests/update_t_client_ips.sh b/tests/update_t_client_ips.sh
index 96e3826..f02dc7f 100755
--- a/tests/update_t_client_ips.sh
+++ b/tests/update_t_client_ips.sh
@@ -3,14 +3,12 @@
 # This --up script caches the IPs handed out by the test VPN server to a file
 # for later use.
 
-RC="$TOP_BUILDDIR/t_client_ips.rc"
-
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
