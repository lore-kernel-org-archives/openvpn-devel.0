From: samuli@...515...
Date: Mon, 26 Jan 2015 10:38:23 +0200
Message-Id: <1422261503-1412-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add more dash escaping to the man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Alberto Gonzalez Iniesta <agi@...64...>

This patch continues the work started in commit 886593ac4ae ("The man page =
needs
dash escaping in UTF-8 environments"). This patch is one of the patches inc=
luded
in Debian's OpenVPN packages.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 doc/openvpn.8 | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a8c189c..62aaa63 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -21,13 +21,13 @@
 .\"  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 .\"
 .\" Manual page for openvpn
-.\
+.\"
 .\" SH section heading
 .\" SS subsection heading
 .\" LP paragraph
 .\" IP indented paragraph
 .\" TP hanging label
-.\
+.\"
 .\" .nf -- no formatting
 .\" .fi -- resume formatting
 .\" .ft 3 -- boldface
@@ -2611,7 +2611,7 @@ command.
 .B \-\-management-signal
 Send SIGUSR1 signal to OpenVPN if management session disconnects.
 This is useful when you wish to disconnect an OpenVPN session on
-user logoff. For --management-client this option is not needed since
+user logoff. For \-\-management-client this option is not needed since
 a disconnect will always generate a SIGTERM.
 .\"*********************************************************
 .TP
@@ -3990,7 +3990,7 @@ is 15 seconds.
 This option is only relevant in UDP mode, i.e.
 when either
 .B \-\-proto udp
-is specifed, or no
+is specified, or no
 .B \-\-proto
 option is specified.
=20
@@ -5173,7 +5173,7 @@ not specified, OpenVPN will use the SystemRoot enviro=
nment variable.
=20
 This option have changed behaviour in OpenVPN 2.3.  Earlier you had to
 define
-.B --win-sys env
+.B \-\-win-sys env
 to use the SystemRoot environment variable, otherwise it defaulted to C:\\=
WINDOWS.
 It is not needed to use the
 .B env
@@ -5216,7 +5216,7 @@ virtual DHCP server address.  In
 .B \-\-dev tun
 mode, OpenVPN will cause the DHCP server to masquerade as if it were
 coming from the remote endpoint.  The optional offset parameter is
-an integer which is > -256 and < 256 and which defaults to 0.
+an integer which is > \-256 and < 256 and which defaults to 0.
 If offset is positive, the DHCP server will masquerade as the IP
 address at network address + offset.
 If offset is negative, the DHCP server will masquerade as the IP
@@ -5550,20 +5550,20 @@ and increments by +1 for every new client (linear m=
ode).  The
 setting controls the size of the pool.  Due to implementation details,
 the pool size must be between /64 and /112.
 .TP
-.B --ifconfig-ipv6-push ipv6addr/bits ipv6remote
+.B \-\-ifconfig-ipv6-push ipv6addr/bits ipv6remote
 for ccd/ per-client static IPv6 interface configuration, see
-.B --client-config-dir
+.B \-\-client-config-dir
 and
-.B --ifconfig-push
+.B \-\-ifconfig-push
 for more details.
 .TP
-.B --iroute-ipv6 ipv6addr/bits
+.B \-\-iroute-ipv6 ipv6addr/bits
 for ccd/ per-client static IPv6 route configuration, see
-.B --iroute
+.B \-\-iroute
 for more details how to setup and use this, and how
-.B --iroute
+.B \-\-iroute
 and
-.B --route
+.B \-\-route
 interact.
=20
 .\"*********************************************************
@@ -6049,7 +6049,7 @@ or configuration file.
 .TP
 .B peer_cert
 Temporary file name containing the client certificate upon
-connection.  Useful in conjunction with --tls-verify
+connection.  Useful in conjunction with \-\-tls-verify
 .\"*********************************************************
 .TP
 .B script_context
--=20
1.9.1


