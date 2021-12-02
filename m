From: Arne Schwabe <arne@...1227...>
Date: Thu,  2 Dec 2021 14:51:24 +0100
Message-Id: <20211202135124.2598645-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Adjust cipher-negotiation.rst with
 compat-mode changes
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

This explains that 2.6 will ignore --cipher without --compat-mode and
restructures the whole paragraph to better readable.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/cipher-negotiation.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index 423b5ab6a..6e872962a 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -15,12 +15,15 @@ with a AUTH_FAILED message (as seen in client log):
 
     AUTH: Received control message: AUTH_FAILED,Data channel cipher negotiation failed (no shared cipher)
 
-OpenVPN 2.5 will only allow the ciphers specified in ``--data-ciphers``. To ensure
-backwards compatibility also if a cipher is specified using the ``--cipher`` option
-it is automatically added to this list. If both options are unset the default is
-:code:`AES-256-GCM:AES-128-GCM`. In 2.6 and later the default is changed to
+OpenVPN 2.5 and higher will only allow the ciphers specified in ``--data-ciphers``.
+ If ``--data-ciphers`` is not set the default is :code:`AES-256-GCM:AES-128-GCM`.
+In 2.6 and later the default is changed to
 :code:`AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305` when Chacha20-Poly1305 is available.
 
+For backwards compatibility OpenVPN 2.6.0 and later with ``--compat-mode 2.4.x``
+(or lower) or OpenVPN 2.5.x will automatically add a cipher specified using the
+``--cipher`` option to this list.
+
 OpenVPN 2.4 clients
 -------------------
 The negotiation support in OpenVPN 2.4 was the first iteration of the implementation
-- 
2.33.0


