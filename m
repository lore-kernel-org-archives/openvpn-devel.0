Date: Thu, 20 Jan 2022 15:43:16 +0100 (CET)
Message-Id: <202201201443.20KEhGKs098358@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-7-selva.nair@...277...>
References: <20211214165928.30676-7-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: A helper function to import
 private key for management-external-key
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Compile tested with 3.0.1 and glanced over the code.  Not actually
tested (no management-external-key here) but I know that Arne is using
*this* in his Android app, so it got a good beating :-)

There might be a memory leak lurking here:

+#ifdef HAVE_XKEY_PROVIDER
+    EVP_PKEY *privkey = xkey_load_management_key(tls_libctx, pkey);
+    if (!privkey
+        || !SSL_CTX_use_PrivateKey(ctx->ctx, privkey))
+    {
+        goto cleanup;
+    }
+    EVP_PKEY_free(privkey);
+#else

if I read this right, the actual signing operation is happening
in SSL_CTX_use_PrivateKey() - so, if the key can be loaded fine
(privkey != NULL) but the actual signing fails, we "goto cleanup",
and never EVP_PKEY_free() it.  But I might be misunderstanding this.

Fixed one typo in a comment ("avaialble") on the fly.  Hope that 
won't come back as a "context not matching" conflict later on.


Your patch has been applied to the master branch.

commit c279986bf4814aad72f9358d8509aa35f54ff662
Author: Selva Nair
Date:   Tue Dec 14 11:59:16 2021 -0500

     A helper function to import private key for management-external-key

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-7-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23443.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


