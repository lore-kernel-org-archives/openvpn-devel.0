From: Frank Lichtenheld <frank@...2641...>
Date: Sun,  8 Oct 2023 12:36:41 +0200
Message-Id: <20231008103641.19864-1-frank@...2641...>
In-Reply-To: <gerrit.1690549401000.I45cd0917d24570ae9e9db7eb6c370756e4595842@...2715...>
References: <gerrit.1690549401000.I45cd0917d24570ae9e9db7eb6c370756e4595842@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix various "Uninitialized scalar variable"
 warnings from Coverity
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

These are all not actually problems, since the
uninitialized parts are either .unused members of the
struct (mroute_addr) or only written to (buflen), but
still doesn't hurt to explicitely initialize them.

Change-Id: I45cd0917d24570ae9e9db7eb6c370756e4595842
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/318
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 81625ea..e6c99ae 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -188,7 +188,7 @@
 multi_get_create_instance_udp(struct multi_context *m, bool *floated)
 {
     struct gc_arena gc = gc_new();
-    struct mroute_addr real;
+    struct mroute_addr real = {0};
     struct multi_instance *mi = NULL;
     struct hash *hash = m->hash;
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index aad11b1..728a7b8 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1234,7 +1234,7 @@
                       bool primary)
 {
     struct openvpn_sockaddr remote_si;
-    struct mroute_addr addr;
+    struct mroute_addr addr = {0};
 
     CLEAR(remote_si);
     remote_si.addr.in4.sin_family = AF_INET;
@@ -1273,7 +1273,7 @@
                      int netbits,   /* -1 if host route, otherwise # of network bits in address */
                      bool primary)
 {
-    struct mroute_addr addr;
+    struct mroute_addr addr = {0};
 
     addr.len = 16;
     addr.type = MR_ADDR_IPV6;
@@ -3118,7 +3118,7 @@
 void
 multi_process_float(struct multi_context *m, struct multi_instance *mi)
 {
-    struct mroute_addr real;
+    struct mroute_addr real = {0};
     struct hash *hash = m->hash;
     struct gc_arena gc = gc_new();
 
@@ -3532,7 +3532,7 @@
     if (BLEN(&m->top.c2.buf) > 0)
     {
         unsigned int mroute_flags;
-        struct mroute_addr src, dest;
+        struct mroute_addr src = {0}, dest = {0};
         const int dev_type = TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid = 0;
 
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 40080ef..0ddabc7 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -166,7 +166,7 @@
     CK_RSA_PKCS_PSS_PARAMS pss_params = {0};
 
     unsigned char buf[EVP_MAX_MD_SIZE];
-    size_t buflen;
+    size_t buflen = 0;
     size_t siglen_max = *siglen;
 
     unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for DigestInfo header */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 2d765cc..58231fb 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3301,7 +3301,7 @@
 {
     struct iovec iov;
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
-    struct msghdr mesg;
+    struct msghdr mesg = {0};
     socklen_t fromlen = sizeof(from->dest.addr);
 
     ASSERT(sock->sd >= 0);                      /* can't happen */

