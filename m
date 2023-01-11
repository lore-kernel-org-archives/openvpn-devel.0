From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 11 Jan 2023 13:52:42 +0100
Message-Id: <20230111125242.21025-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] documentation: update "unsupported options"
 section
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

We listed those in Changes, but did not update the documentation.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/unsupported-options.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index 05ba3ca2..5c4e3a0e 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -17,6 +17,14 @@ longer supported
   ``key-method`` weakens the VPN tunnel security.  The old ``key-method``
   was also only needed when the remote side was older than OpenVPN 2.0.
 
+--management-client-pf
+  Removed in OpenVPN 2.6.  The built-in packet filtering (pf) functionality
+  has been removed.
+
+--ncp-disable
+  Removed in OpenVPN 2.6.  This option mainly served a role as debug option
+  when NCP was first introduced.  It should no longer be necessary.
+
 --no-iv
   Removed in OpenVPN 2.5.  This option should not be used as it weakens the
   VPN tunnel security.  This has been a NOOP option since OpenVPN 2.4.
@@ -30,3 +38,6 @@ longer supported
   in recent SSL/TLS libraries.  If your certificates does not include *key
   usage* and *extended key usage* fields, they must be upgraded and the
   ``--remote-cert-tls`` option should be used instead.
+
+--prng
+  Removed in OpenVPN 2.6.  We now always use the PRNG of the SSL library.
-- 
2.34.1


