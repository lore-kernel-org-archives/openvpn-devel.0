From: Gert Doering <gert@...1296...>
Date: Fri, 24 Jan 2025 15:18:20 +0100
Message-ID: <20250124141820.5084-1-gert@...1296...>
In-Reply-To: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
References: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v16] mroute: adapt to new protocol handling
 and hashing improvements
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Repurposing an unused field and renaming it to 'proto'
instead of introducing a new field. The hashing now
begins at the 'proto' field rather than the 'type'
field. Additionally, the changes ensure that the
correct protocol is consistently used with virtual
addresses ensuring alignment.

Change-Id: Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/765
This mail reflects revision 16 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 80e18b7..74923cf 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -454,6 +454,7 @@
                 buf_printf(&out, "UNKNOWN");
                 break;
         }
+        buf_printf(&out, "|%d", maddr.proto);
         return BSTR(&out);
     }
     else
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 8b457d4..1c44b35 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -74,7 +74,7 @@
 
 struct mroute_addr {
     uint8_t len;    /* length of address */
-    uint8_t unused;
+    uint8_t proto;
     uint8_t type;   /* MR_ADDR/MR_WITH flags */
     uint8_t netbits; /* number of bits in network part of address,
                       * valid if MR_WITH_NETBITS is set */
@@ -183,6 +183,15 @@
 {
     unsigned int ret = 0;
     verify_align_4(buf);
+
+    /*
+     * Since we don't really need the protocol on vaddresses for internal VPN
+     * payload packets, make sure we have the same value to avoid hashing insert
+     * and search issues.
+     */
+    src->proto = 0;
+    dest->proto = src->proto;
+
     if (tunnel_type == DEV_TYPE_TUN)
     {
         ret = mroute_extract_addr_ip(src, dest, buf);
@@ -216,13 +225,13 @@
 mroute_addr_hash_ptr(const struct mroute_addr *a)
 {
     /* NOTE: depends on ordering of struct mroute_addr */
-    return (uint8_t *) &a->type;
+    return (uint8_t *) &a->proto;
 }
 
 static inline uint32_t
 mroute_addr_hash_len(const struct mroute_addr *a)
 {
-    return (uint32_t) a->len + 2;
+    return (uint32_t) a->len + 3;
 }
 
 static inline void
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 6d1d5a0..62ed044 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -56,6 +56,7 @@
     mi = multi_create_instance(m, NULL, ls);
     if (mi)
     {
+        mi->real.proto = ls->info.proto;
         struct hash_element *he;
         const uint32_t hv = hash_value(hash, &mi->real);
         struct hash_bucket *bucket = hash_bucket(hash, hv);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 6137578..4f2bbd7 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -192,6 +192,7 @@
     struct mroute_addr real = {0};
     struct multi_instance *mi = NULL;
     struct hash *hash = m->hash;
+    real.proto = ls->info.proto;
 
     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3f55dd7..273aa05 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1243,6 +1243,7 @@
     CLEAR(remote_si);
     remote_si.addr.in4.sin_family = AF_INET;
     remote_si.addr.in4.sin_addr.s_addr = htonl(a);
+    addr.proto = 0;
     ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_si, false));
 
     if (netbits >= 0)
@@ -3548,7 +3549,6 @@
         const int dev_type = TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid = 0;
 
-
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));
 #endif

