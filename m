From: Arne Schwabe <arne@...1227...>
Date: Mon, 13 Dec 2021 16:25:29 +0100
Message-Id: <20211213152529.3995394-1-arne@...1227...>
In-Reply-To: <0211202135124.2598645-1-arne@...1227...>
References: <0211202135124.2598645-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Adjust cipher-negotiation.rst with
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

Patch V2: Adjust grammar, use consistently "and later"

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/cipher-negotiation.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index 423b5ab6a..efa4c6c94 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -5,7 +5,7 @@ OpenVPN 2.4 and higher have the capability to negotiate the data cipher that
 is used to encrypt data packets. This section describes the mechanism in more detail and the
 different backwards compatibility mechanism with older server and clients.
 
-OpenVPN 2.5 and higher behaviour
+OpenVPN 2.5 and later behaviour
 --------------------------------
 When both client and server are at least running OpenVPN 2.5, that the order of
 the ciphers of the server's ``--data-ciphers`` is used to pick the the data cipher.
@@ -15,12 +15,15 @@ with a AUTH_FAILED message (as seen in client log):
 
     AUTH: Received control message: AUTH_FAILED,Data channel cipher negotiation failed (no shared cipher)
 
-OpenVPN 2.5 will only allow the ciphers specified in ``--data-ciphers``. To ensure
-backwards compatibility also if a cipher is specified using the ``--cipher`` option
-it is automatically added to this list. If both options are unset the default is
-:code:`AES-256-GCM:AES-128-GCM`. In 2.6 and later the default is changed to
+OpenVPN 2.5 and later will only allow the ciphers specified in ``--data-ciphers``.
+ If ``--data-ciphers`` is not set the default is :code:`AES-256-GCM:AES-128-GCM`.
+In 2.6 and later the default is changed to
 :code:`AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305` when Chacha20-Poly1305 is available.
 
+For backwards compatibility OpenVPN 2.6 and later with ``--compat-mode 2.4.x``
+(or lower) and OpenVPN 2.5 will automatically add a cipher specified using the
+``--cipher`` option to this list.
+
 OpenVPN 2.4 clients
 -------------------
 The negotiation support in OpenVPN 2.4 was the first iteration of the implementation
-- 
2.33.0


