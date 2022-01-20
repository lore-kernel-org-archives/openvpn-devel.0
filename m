Date: Thu, 20 Jan 2022 18:08:54 +0100 (CET)
Message-Id: <202201201708.20KH8sJT007634@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-15-selva.nair@...277...>
References: <20211214165928.30676-15-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: pkcs11: Interface the xkey
 provider with pkcs11-helper
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

client tested with 3.0.1 (no pkcs#11 though), and stared at the code a bit.

This change looks like it really wants an "#else" and move the #endif 
to the end of the function...  (though the compiler does not warn)

 pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
                         struct tls_root_ctx *const ssl_ctx)
 {
+
+#ifdef HAVE_XKEY_PROVIDER
+    return (xkey_load_from_pkcs11h(certificate, ssl_ctx) == 0); /* inverts the return value */
+#endif
+
     int ret = 1;
     (more stuff)


This prototype looks a bit surprising

+static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;

given that the function is defined just below?  Is this to ensure
XKEY_EXTERNAL_SIGN_fn matches the actual function definition?


Your patch has been applied to the master branch.

commit 6121001ed82914f336da081bb8aefaeb055450cb
Author: Selva Nair
Date:   Tue Dec 14 11:59:24 2021 -0500

     pkcs11: Interface the xkey provider with pkcs11-helper

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-15-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23442.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


