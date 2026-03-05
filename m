From: Gert Doering <gert@...1296...>
Date: Thu,  5 Mar 2026 07:59:45 +0100
Message-ID: <20260305065952.24348-1-gert@...1296...>
In-Reply-To: <gerrit.1772309250000.I5e17e184f666317df21460108da4f70670358ece@...2715...>
References: <gerrit.1772309250000.I5e17e184f666317df21460108da4f70670358ece@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Use USER_PASS_LEN for private key
 password buffer size
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

From: Selva Nair <selva.nair@...277...>

GitHub: fixes OpenVPN/openvpn#993

Change-Id: I5e17e184f666317df21460108da4f70670358ece
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1553
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1553
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 09f23964..80aef69 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -796,7 +796,7 @@
         }
         else /* use our generic 'Private Key' passphrase callback */
         {
-            char password[64];
+            char password[USER_PASS_LEN];
             pem_password_cb *cb = SSL_CTX_get_default_passwd_cb(ctx);
             void *d = SSL_CTX_get_default_passwd_cb_userdata(ctx);
 

