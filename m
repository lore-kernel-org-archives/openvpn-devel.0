From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20051104124852.GA19426@...33...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] self-test updates, fix unterminated loop in BSD jails
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
Date: Fri Nov  4 04:50:33 2005
To: openvpn-devel@lists.sourceforge.net

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

Dirk 'dinoex' Meyer reported issues when the self-test is run inside a
FreeBSD "jail" (see below), in that t_cltsrv.sh never completes and he
also provided logs:

| ...
| Fri Nov  4 11:12:55 2005 UDPv4 link local (bound): 127.0.0.1:16001
| Fri Nov  4 11:12:55 2005 UDPv4 link remote: 127.0.0.1:16000
| Fri Nov  4 11:12:55 2005 TCP/UDP: Incoming packet rejected from A.B.C.D:16001[2], expected peer address: 127.0.0.1:16001 (allow this incoming source address/port by removing --remote or adding --float)

This is consistent with the jail(2) documentation on FreeBSD 5-STABLE.

A BSD "jail" is mainly a locked-down chroot where network communication
is tied to a particular IP address. This IP address is configured at
jail setup time and even "loopback" communication is remapped to the
jail's IP. This creates the problem above.

The sample-config-files/loopback-* scripts however do not terminate
openvpn if the connection cannot be established.

To fix this by adding --float if running in a FreeBSD, and to address
and some minor issues (t_lpback leaves log.$$ behind if successful;
tests should perhaps print "SKIP" rather than "FAIL" if aborted), I
suggest the attached updates to the t_* scripts, against SVN trunk
(version 2.0.5).  Tested on FreeBSD 5.4 i586, SUSE Linux 9.3 i686,
Solaris 8 sun4u sparc.

Please apply to 2.0 and 2.1.

-- 
Matthias Andree

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testupdates.patch"

Index: t_lpback.sh
===================================================================
--- t_lpback.sh	(revision 774)
+++ t_lpback.sh	(working copy)
@@ -19,11 +19,13 @@
 # 02110-1301, USA.
 
 set -e
-trap "rm -f key.$$ log.$$ ; false" 1 2 3 15
+trap "rm -f key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
+trap "rm -f key.$$ log.$$ ; exit 1" 0 3
 ./openvpn --genkey --secret key.$$
 set +e
 ( ./openvpn --test-crypto --secret key.$$ ) >log.$$ 2>&1
 e=$?
 if [ $e != 0 ] ; then cat log.$$ ; fi
-rm key.$$
+rm key.$$ log.$$
+trap 0
 exit $e
Index: t_cltsrv.sh
===================================================================
--- t_cltsrv.sh	(revision 774)
+++ t_cltsrv.sh	(working copy)
@@ -20,19 +20,33 @@
 
 set -e
 echo "the following test will run about two minutes..." >&2
-trap "rm -f log.$$ ; false" 1 2 3 15
+trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
+trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
+addopts=
+case `uname -s` in
+    FreeBSD)
+    # FreeBSD jails map the outgoing IP to the jail IP - we need to
+    # allow the real IP unless we want the test to run forever.
+    if test `sysctl -n security.jail.jailed` != 0 ; then
+	addopts="--float"
+    fi
+    ;;
+esac
 set +e
 (
-./openvpn --cd "${srcdir}" --config sample-config-files/loopback-server &
-./openvpn --cd "${srcdir}" --config sample-config-files/loopback-client
-) >log.$$ 2>&1
+./openvpn --cd "${srcdir}" ${addopts} --down 'echo "srv:${signal}" >&3 ; : #' --tls-exit --ping-exit 180 --config sample-config-files/loopback-server &
+./openvpn --cd "${srcdir}" ${addopts} --down 'echo "clt:${signal}" >&3 ; : #' --tls-exit --ping-exit 180 --config sample-config-files/loopback-client
+) 3>log.$$.signal >log.$$ 2>&1
 e1=$?
 wait $!
 e2=$?
+grep -v ":inactive$" log.$$.signal >/dev/null && { cat log.$$.signal ; echo ; cat log.$$ ; exit 1 ; }
+
 set -e
 
 if [ $e1 != 0 ] || [ $e2 != 0 ] ; then
     cat log.$$
     exit 1
 fi
-rm log.$$
+rm log.$$ log.$$.signal
+trap 0

--rwEMma7ioTxnRzrJ--

