From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20060301001938.GA27903@...33...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
Subject: [Openvpn-devel] PATCH 2.0: revise t_cltsrv.sh (again FreeBSD jail support)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Feb 28 16:20:04 2006
To: openvpn-devel@lists.sourceforge.net
Cc: jim@...41...

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

please apply the attached patch (against 2.0.6rc*, but probably also
needed for 2.1.*) to fix the t_cltsrv.sh file in FreeBSD 4 jails.
(FreeBSD 4 is obsolete, and I don't have it any more, but 4.11 is still
supported, so it deserves the fix.)

This patch has been made with the help of
Dirk Meyer (dinoex OF freebsd.org) and
Vasil Dimov (vd OF freebsd.org).

Thank you,

-- 
Matthias Andree

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-t_cltsrv.sh.diff"

Index: t_cltsrv.sh
===================================================================
--- t_cltsrv.sh	(Revision 913)
+++ t_cltsrv.sh	(Arbeitskopie)
@@ -1,7 +1,7 @@
 #! /bin/sh
 #
 # t_cltsrv.sh - script to test OpenVPN's crypto loopback
-# Copyright (C) 2005  Matthias Andree
+# Copyright (C) 2005,2006  Matthias Andree
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
@@ -19,7 +19,6 @@
 # 02110-1301, USA.
 
 set -e
-echo "the following test will run about two minutes..." >&2
 trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
 addopts=
@@ -27,11 +26,19 @@
     FreeBSD)
     # FreeBSD jails map the outgoing IP to the jail IP - we need to
     # allow the real IP unless we want the test to run forever.
-    if test `sysctl -n security.jail.jailed` != 0 ; then
+    if test "`sysctl 2>/dev/null -n security.jail.jailed`" = 1 \
+    || ps -ostate= -p $$ | grep -q J; then
 	addopts="--float"
+	if test "x`ifconfig | grep inet`" = x ; then
+	    echo "###"
+	    echo "### To run the test in a FreeBSD jail, you MUST add an IP alias for the jail's IP."
+	    echo "###"
+	    exit 1
+	fi
     fi
     ;;
 esac
+echo "the following test will take about two minutes..." >&2
 set +e
 (
 ./openvpn --cd "${srcdir}" ${addopts} --down 'echo "srv:${signal}" >&3 ; : #' --tls-exit --ping-exit 180 --config sample-config-files/loopback-server &

--pWyiEgJYm5f9v55/--

