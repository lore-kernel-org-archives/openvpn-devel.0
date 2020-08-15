From: Magnus Kroken <mkroken@...277...>
Date: Sat, 15 Aug 2020 14:05:22 +0200
Message-Id: <20200815120522.1404-3-mkroken@...277...>
In-Reply-To: <20200815120522.1404-1-mkroken@...277...>
References: <20200815120522.1404-1-mkroken@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] doc: fix typos in cipher-negotiation.rst
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

Signed-off-by: Magnus Kroken <mkroken@...277...>
---
 doc/man-sections/cipher-negotiation.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index f1433052..a2feb5f9 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -38,7 +38,7 @@ options to avoid this behaviour.
 OpenVPN 3 clients
 -----------------
 Clients based on the OpenVPN 3.x library (https://github.com/openvpn/openvpn3/)
-do not have a configurable ``--ncp-ciphers`` or ``--data-cipher`` option. Instead
+do not have a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option. Instead
 these clients will announce support for all their supported AEAD ciphers
 (`AES-256-GCM`, `AES-128-GCM` and in newer versions also `Chacha20-Poly1305`).
 
@@ -90,7 +90,7 @@ version. The default was never changed to ensure backwards compatibility.
 In OpenVPN 2.5 this behaviour has now been changed so that if the ``--cipher``
 is not explicitly set it does not allow the weak ``BF-CBC`` cipher any more
 and needs to explicitly added as ``--cipher BFC-CBC`` or added to
-``-data-ciphers``.
+``--data-ciphers``.
 
 We strongly recommend to switching away from BF-CBC to a
 more secure cipher as soon as possible instead.
-- 
2.20.1


