From: Steffan Karger <steffan@...1856...>
Date: Sun,  3 Jun 2018 12:11:56 +0200
Message-Id: <1528020718-12721-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/3] man: add security considerations to
 --compress section
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

As Ahamed Nafeez reported to the OpenVPN security team, we did not
sufficiently inform our users about the risks of combining encryption
and compression.  This patch adds a "Security Considerations" paragraph
to the --compress section of the manpage to point the risks out to our
users.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 4114f40..0e5d467 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2516,6 +2516,16 @@ If the
 parameter is empty, compression will be turned off, but the packet
 framing for compression will still be enabled, allowing a different
 setting to be pushed later.
+
+.B Security Considerations
+
+Compression and encryption is a tricky combination.  If an attacker knows or is
+able to control (parts of) the plaintext of packets that contain secrets, the
+attacker might be able to extract the secret if compression is enabled.  See
+e.g. the CRIME and BREACH attacks on TLS which also leverage compression to
+break encryption.  If you are not entirely sure that the above does not apply
+to your traffic, you are advised to *not* enable compression.
+
 .\"*********************************************************
 .TP
 .B \-\-comp\-lzo [mode]
-- 
2.7.4


