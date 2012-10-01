From: Arne Schwabe <arne@...1227...>
Date: Mon,  1 Oct 2012 11:05:18 +0200
Message-Id: <1349082318-985-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Document man agent-external-key
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

Adapt commit message from cf69617bbea45a15423c4188daa9386debcbe1ec for man page and management documentation.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/management-notes.txt |   28 ++++++++++++++++++++++++++++
 doc/openvpn.8            |    5 +++++
 2 files changed, 33 insertions(+)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index a07a514..0d718e7 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -750,6 +750,34 @@ To accept connecting to the host and port directly, use this command:
 
   proxy NONE
 
+COMMAND -- rsa-sig (OpenVPN 2.3 or higher)
+------------------------------------------
+Provides support for external storage of the private key. Requires the
+--management-external-key option. This option can be used instead of "key"
+in client mode, and allows the client to run without the need to load the
+actual private key. When the SSL protocol needs to perform an RSA sign 
+operation, the data to be signed will be sent to the management interface 
+via a notification as follows:
+
+>RSA_SIGN:[BASE64_DATA]
+
+The management interface client should then sign BASE64_DATA
+using the private key and return the SSL signature as follows:
+
+rsa-sig
+[BASE64_SIG_LINE]
+.
+.
+.
+END
+
+Base64 encoded output of RSA_sign(NID_md5_sha1,... will provide a 
+correct signature.
+
+This capability is intended to allow the use of arbitrarycryptographic 
+service providers with OpenVPN via the management interface.
+
+
 OUTPUT FORMAT
 -------------
 
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index da1c0f9..6a408ed 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2464,6 +2464,11 @@ Allow management interface to override
 .B \-\-remote
 directives (client-only).
 .\"*********************************************************
+.B \-\-management-external-key
+Allows usage for external private key file instead of 
+.B \-\-key
+option (client-only).
+.\"*********************************************************
 .TP
 .B \-\-management-forget-disconnect
 Make OpenVPN forget passwords when management session
-- 
1.7.9.5


