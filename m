From: Arne Schwabe <arne@...1227...>
Date: Wed, 24 Mar 2021 23:23:30 +0100
Message-Id: <20210324222330.455-4-arne@...1227...>
In-Reply-To: <20210324222330.455-1-arne@...1227...>
References: <20210324222330.455-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/4] Use correct types for OpenSSL and
 Windows APIs
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

The error code of OpenSSL is a long. On most Unics systems
(mac, Linux...) this happens to be the same as size_t. But on Windows
as LP64, long is a 32 bit type and size_t is a 64 bit type. So use the
same type as OpenSSL.

When calling the Windows API use DWORD for the functions that want a
DWORD.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 2 +-
 src/openvpn/cryptoapi.c      | 2 +-
 src/openvpn/route.c          | 9 +++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 4486d246..573beaed 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -199,7 +199,7 @@ crypto_clear_error(void)
 void
 crypto_print_openssl_errors(const unsigned int flags)
 {
-    size_t err = 0;
+    unsigned long err = 0;
 
     while ((err = ERR_get_error()))
     {
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index a992441b..ded8c914 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -997,7 +997,7 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
     }
 
     msg(D_LOW, "cryptoapicert: calling priv_enc_CNG with alg = %ls", alg);
-    *siglen = priv_enc_CNG(cd, alg, tbs, (int)tbslen, sig, *siglen,
+    *siglen = priv_enc_CNG(cd, alg, tbs, (int)tbslen, sig, (int)*siglen,
                            cng_padding_type(padding), (DWORD)saltlen);
 
     return (*siglen == 0) ? 0 : 1;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 5e1dca67..c6b3dc58 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2701,12 +2701,11 @@ get_default_gateway_row(const MIB_IPFORWARDTABLE *routes)
     struct gc_arena gc = gc_new();
     DWORD lowest_metric = MAXDWORD;
     const MIB_IPFORWARDROW *ret = NULL;
-    int i;
     int best = -1;
 
     if (routes)
     {
-        for (i = 0; i < routes->dwNumEntries; ++i)
+        for (DWORD i = 0; i < routes->dwNumEntries; ++i)
         {
             const MIB_IPFORWARDROW *row = &routes->table[i];
             const in_addr_t net = ntohl(row->dwForwardDest);
@@ -3167,14 +3166,13 @@ void
 show_routes(int msglev)
 {
     struct gc_arena gc = gc_new();
-    int i;
 
     const MIB_IPFORWARDTABLE *rt = get_windows_routing_table(&gc);
 
     msg(msglev, "SYSTEM ROUTING TABLE");
     if (rt)
     {
-        for (i = 0; i < rt->dwNumEntries; ++i)
+        for (DWORD i = 0; i < rt->dwNumEntries; ++i)
         {
             msg(msglev, "%s", format_route_entry(&rt->table[i], &gc));
         }
@@ -4023,8 +4021,7 @@ test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)
     const MIB_IPFORWARDTABLE *rt = get_windows_routing_table(&gc);
     if (rt)
     {
-        int i;
-        for (i = 0; i < rt->dwNumEntries; ++i)
+        for (DWORD i = 0; i < rt->dwNumEntries; ++i)
         {
             const MIB_IPFORWARDROW *row = &rt->table[i];
             const in_addr_t net = ntohl(row->dwForwardDest);
-- 
2.30.1


