From: Gert Doering <gert@...1296...>
Date: Tue, 14 Jul 2015 09:09:54 +0200
Message-Id: <1436857794-29419-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Document --daemon changes and consequences
	(--askpass, --auth-nocache).
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

Trac #574, #576

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8 | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3eb2493..0692a80 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2208,6 +2208,22 @@ openvpn command for a fairly reliable indication of whether the command
 has correctly initialized and entered the packet forwarding event loop.
 
 In OpenVPN, the vast majority of errors which occur after initialization are non-fatal.
+
+Note: as soon as OpenVPN has daemonized, it can not ask for usernames,
+passwords, or key pass phrases anymore.  This has certain consequences,
+namely that using a password-protected private key will fail unless the
+.B \-\-askpass
+option is used to tell OpenVPN to ask for the pass phrase (this
+requirement is new in 2.3.7, and is a consequence of calling daemon()
+before initializing the crypto layer).
+
+Further, using
+.B \-\-daemon
+together with
+.B \-\-auth-user-pass
+(entered on console) and
+.B \-\-auth-nocache
+will fail as soon as key renegotiation (and reauthentication) occurs.
 .\"*********************************************************
 .TP
 .B \-\-syslog [progname]
-- 
2.3.6


