From: Antonio Quartulli <a@...2181...>
Date: Wed, 13 Jul 2022 00:16:55 +0200
Message-Id: <20220712221655.19333-1-a@...2181...>
In-Reply-To: <20220624083809.23487-8-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH pre-07/25] tun: create tun_name_is_fixed
 helper
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
Cc: Antonio Quartulli <a@...2181...>

This helper encloses the (simple) logic used by OpenVPN to determine if
the name passed to --dev has to be considered a fixed interface name or
just a pattern.

Having a helper is useful because when this logic is required elsewhere,
we can just re-use this logic without duplicating the code (which may
mean introducing bugs if a future logic change should not update all
spots).

The logic is actually fairly simple: check if the name contains a number
(i.e. tun0). If so, consider the name a fixed device name.

While at it make has_digit() accept a signed argument because strings
are normally signed (also isdigit() accepts a signed argument).

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/buffer.h | 4 ++--
 src/openvpn/tun.c    | 7 ++++++-
 src/openvpn/tun.h    | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 231f1b0d..fece6336 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -356,9 +356,9 @@ strncpynt(char *dest, const char *src, size_t maxlen)
 
 /* return true if string contains at least one numerical digit */
 static inline bool
-has_digit(const unsigned char *src)
+has_digit(const char *src)
 {
-    unsigned char c;
+    char c;
     while ((c = *src++))
     {
         if (isdigit(c))
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f17db280..108090d0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1718,6 +1718,11 @@ read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 }
 #endif /* if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H) */
 
+bool
+tun_name_is_fixed(const char *dev)
+{
+    return has_digit(dev);
+}
 
 #if !defined(_WIN32)
 static void
@@ -1772,7 +1777,7 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
             else
 #endif
 
-            if (dynamic && !has_digit((unsigned char *)dev))
+            if (dynamic && !tun_name_is_fixed(dev))
             {
                 int i;
                 for (i = 0; i < 256; ++i)
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index cf02bf43..8ec8f51f 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -694,5 +694,6 @@ tun_set(struct tuntap *tt,
 }
 
 const char *tun_stat(const struct tuntap *tt, unsigned int rwflags, struct gc_arena *gc);
+bool tun_name_is_fixed(const char *dev);
 
 #endif /* TUN_H */
-- 
2.35.1


