From: Arne Schwabe <arne@...1227...>
Date: Wed, 18 Aug 2021 23:33:54 +0200
Message-Id: <20210818213354.687736-2-arne@...1227...>
In-Reply-To: <20210818213354.687736-1-arne@...1227...>
References: <20210818213354.687736-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Include Chacha20-Poly1305 into default
 --data-ciphers when available
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

Most TLS 1.3 libraries inlcude the Chacha20-Poly1305 based cipher suite
beside the AES-GCM based ones int he list of default ciphers suites.
Chacha20-Poly1305 is accepted as good alternative AEAD algorithm to the
AES-GCM algorithm by crypto community.

Follow this and include Chacha20-Poly1305 by default in data-ciphers
when available. This makes picking Chacha20-Poly1305 easier as it only
requires to change server (by changing priority) or client side (removing
AES-GCM from data-ciphers) to change to Chacha20-Poly1305.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                             |  5 +++++
 doc/man-sections/cipher-negotiation.rst |  3 ++-
 doc/man-sections/protocol-options.rst   |  3 ++-
 src/openvpn/options.c                   | 25 ++++++++++++++++++++++++-
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 0323a7f7a..637ed97a6 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -65,6 +65,11 @@ Deprecated features
     This option mainly served a role as debug option when NCP was first
     introduced. It should now no longer be necessary.
 
+
+User-visible Changes
+--------------------
+- CHACHA20-POLY1305 is included in the default of ``--data-ciphers`` when available.
+
 Overview of changes in 2.5
 ==========================
 
diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index a2feb5f9c..423b5ab6a 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -18,7 +18,8 @@ with a AUTH_FAILED message (as seen in client log):
 OpenVPN 2.5 will only allow the ciphers specified in ``--data-ciphers``. To ensure
 backwards compatibility also if a cipher is specified using the ``--cipher`` option
 it is automatically added to this list. If both options are unset the default is
-:code:`AES-256-GCM:AES-128-GCM`.
+:code:`AES-256-GCM:AES-128-GCM`. In 2.6 and later the default is changed to
+:code:`AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305` when Chacha20-Poly1305 is available.
 
 OpenVPN 2.4 clients
 -------------------
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 5ae780e1f..0fef90f7b 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -192,7 +192,8 @@ configured in a compatible way between both the local and remote side.
 --data-ciphers cipher-list
   Restrict the allowed ciphers to be negotiated to the ciphers in
   ``cipher-list``. ``cipher-list`` is a colon-separated list of ciphers,
-  and defaults to :code:`AES-256-GCM:AES-128-GCM`.
+  and defaults to :code:`AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305` when
+  Chacha20-Poly1305 is available and otherwise :code:`AES-256-GCM:AES-128-GCM`.
 
   For servers, the first cipher from ``cipher-list`` that is also
   supported by the client will be pushed to clients that support cipher
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7e146db90..9c01d6a1d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -842,7 +842,6 @@ init_options(struct options *o, const bool init_gc)
     o->stale_routes_check_interval = 0;
     o->ifconfig_pool_persist_refresh_freq = 600;
     o->scheduled_exit_interval = 5;
-    o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
     o->authname = "SHA1";
     o->prng_hash = "SHA1";
     o->prng_nonce_secret_len = 16;
@@ -3077,6 +3076,29 @@ options_postprocess_verify(const struct options *o)
     }
 }
 
+/**
+ * Checks for availibility of Chacha20-Poly1305 and sets
+ * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
+ * AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305.
+ */
+static void
+options_postprocess_setdefault_ncpciphers(struct options *o)
+{
+    if (o->ncp_ciphers)
+    {
+        /* custom --data-ciphers set, keep list */
+        return;
+    }
+    else if (cipher_kt_get("CHACHA20-POLY1305"))
+    {
+        o->ncp_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+    }
+    else
+    {
+        o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
+    }
+}
+
 static void
 options_postprocess_cipher(struct options *o)
 {
@@ -3137,6 +3159,7 @@ options_postprocess_mutate(struct options *o)
     helper_keepalive(o);
     helper_tcp_nodelay(o);
 
+    options_postprocess_setdefault_ncpciphers(o);
     options_postprocess_cipher(o);
     options_postprocess_mutate_invariant(o);
 
-- 
2.32.0


