From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Aug 2019 11:25:24 +0200
Message-Id: <20190805092529.9467-2-a@...2181...>
In-Reply-To: <20190805092529.9467-1-a@...2181...>
References: <20190805092529.9467-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/6] sitnl: harden strncpy() by forcing
 arguments to have the same length
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

At the moment a strcpy() (without length check!) is performed between a
string long IFNAMSIZ bytes and one of 16 bytes. This is ok right now
because IFNAMSIZ is defined as 16, however this bit is not under our
control and may change in he future without us being warned.

For this reason, force both strings to use IFNAMSIZ as size and, since
this constant may not exist on every platform, ensure it is always
defined.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/networking_sitnl.c | 2 +-
 src/openvpn/route.h            | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 4e29d8ba..ea730ec7 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -494,7 +494,7 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
 
     /* save result in output variables */
     memcpy(best_gw, &res.gw, res.addr_size);
-    strcpy(best_iface, res.iface);
+    strncpy(best_iface, res.iface, IFNAMSIZ);
 err:
     return ret;
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 31d38e36..2e68091c 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -184,7 +184,11 @@ struct route_ipv6_gateway_info {
 #ifdef _WIN32
     DWORD adapter_index; /* interface or ~0 if undefined */
 #else
-    char iface[16]; /* interface name (null terminated), may be empty */
+    /* non linux platform don't have this constant defined */
+#ifndef IFNAMSIZ
+#define IFNAMSIZ 16
+#endif
+    char iface[IFNAMSIZ]; /* interface name (null terminated), may be empty */
 #endif
 
     /* gateway interface hardware address */
-- 
2.22.0


