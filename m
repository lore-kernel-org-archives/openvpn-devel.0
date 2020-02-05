From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20200205124615.15758-3-domagoj@...2540...>
Date: Wed,  5 Feb 2020 13:46:15 +0100
In-Reply-To: <20200205124615.15758-1-domagoj@...2540...>
References: <20200205124615.15758-1-domagoj@...2540...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Fix linking issues on MinGW
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

MinGW linking fails for several files due to a missing "static"
declaration in functions tuntap_is_wintun() and tuntap_ring_empty().

Signed-off-by: Domagoj Pensa <domagoj@...2540...>
---
 src/openvpn/tun.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 97d28f45..327d7927 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -224,13 +224,13 @@ tuntap_defined(const struct tuntap *tt)
 }
=20
 #ifdef _WIN32
-inline bool
+static inline bool
 tuntap_is_wintun(struct tuntap *tt)
 {
     return tt && tt->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN;
 }
=20
-inline bool
+static inline bool
 tuntap_ring_empty(struct tuntap *tt)
 {
     return tuntap_is_wintun(tt) && (tt->wintun_send_ring->head =3D=3D tt->=
wintun_send_ring->tail);
--=20
2.25.0



