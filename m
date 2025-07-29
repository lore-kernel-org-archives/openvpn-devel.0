From: Kristof Provost <kprovost@...2661...>
Date: Tue, 29 Jul 2025 11:38:57 +0200
Message-ID: <20250729093857.37832-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] dco-freebsd: pass address scope to the
 kernel
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

To support link-local (IPv6) addresses we must pass the scope to the kernel as
well. We should also extract it from the kernel notification for float events.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/dco_freebsd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 8add41af..306ecd31 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -62,6 +62,7 @@ sockaddr_to_nvlist(const struct sockaddr *sa)
             const struct sockaddr_in6 *in6 = (const struct sockaddr_in6 *)sa;
             nvlist_add_binary(nvl, "address", &in6->sin6_addr, sizeof(in6->sin6_addr));
             nvlist_add_number(nvl, "port", in6->sin6_port);
+            nvlist_add_number(nvl, "scopeid", in6->sin6_scope_id);
             break;
         }
 
@@ -118,6 +119,11 @@ nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
             assert(len == sizeof(in6->sin6_addr));
             memcpy(&in6->sin6_addr, data, sizeof(in6->sin6_addr));
             in6->sin6_port = nvlist_get_number(nvl, "port");
+
+            if (nvlist_exists_number(nvl, "scopeid"))
+            {
+                in6->sin6_scope_id = nvlist_get_number(nvl, "scopeid");
+            }
             break;
         }
 
-- 
2.50.1


