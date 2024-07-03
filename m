From: Gert Doering <gert@...1296...>
Date: Wed,  3 Jul 2024 19:41:58 +0200
Message-ID: <20240703174158.7137-1-gert@...1296...>
In-Reply-To: <gerrit.1720021020000.Ibc641388d8016533c94dfef3618376f6dfa91f4e@...2715...>
References: <gerrit.1720021020000.Ibc641388d8016533c94dfef3618376f6dfa91f4e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] mbedtls: Warn if --tls-version-min is
 too low
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

From: Max Fillinger <maximilian.fillinger@...2507...>

Recent versions of mbedtls only support TLS 1.2. When the minimum
version is set to TLS 1.0 or 1.1, log a warning and use 1.2 as the
actual minimum version.

Change-Id: Ibc641388d8016533c94dfef3618376f6dfa91f4e
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/684
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dbe1425..64e67aa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8942,6 +8942,15 @@
             msg(msglevel, "unknown tls-version-min parameter: %s", p[1]);
             goto err;
         }
+
+#ifdef ENABLE_CRYPTO_MBEDTLS
+        if (ver < TLS_VER_1_2)
+        {
+            msg(M_WARN, "--tls-version-min %s is not supported by mbedtls, using 1.2", p[1]);
+            ver = TLS_VER_1_2;
+        }
+#endif
+
         options->ssl_flags &=
             ~(SSLF_TLS_VERSION_MIN_MASK << SSLF_TLS_VERSION_MIN_SHIFT);
         options->ssl_flags |= (ver << SSLF_TLS_VERSION_MIN_SHIFT);

