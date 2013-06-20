From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 20 Jun 2013 14:33:05 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B901455DE1EFA@...1436...>
References: <alpine.DEB.2.02.1306201400320.10116@...1831...>
In-Reply-To: <alpine.DEB.2.02.1306201400320.10116@...1831...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Always load intermediate certificates
 from	a PKCS#12 file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heikki Hannikainen <hessu@...1822...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Heikki,

I haven't run the patch, or tried to compile it as I haven't got my dev-set=
up handy. It looks good though. Featurewise it gets an ack from me, as send=
ing intermediate certs is encouraged in the TLS standard.

One minor nit-picky point: there's a bit of whitespace fixing in there with=
 an extra newline, not sure whether that should be in a separate patch.

Adriaan

-----Original Message-----
From: Heikki Hannikainen [mailto:hessu@...1822...]=20
Sent: donderdag 20 juni 2013 13:06
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH] Always load intermediate certificates from=
 a PKCS#12 file


Hi,

This one supersedes my previous patch
(http://thread.gmane.org/gmane.network.openvpn.devel/7599) which added an e=
xtra option to load trusted CA certs from both PKCS#12 and the --ca PEM fil=
e. This new patch enables loading of extra intermediate certs from
PKCS#12 even when --ca is set, while not making those certs trusted. Does n=
ot add any extra options.


From cec65ff199443c7f95101a7bf4a75644516d7810 Mon Sep 17 00:00:00 2001
From: Heikki Hannikainen <hessu@...1822...>
Date: Thu, 20 Jun 2013 13:49:44 +0300
Subject: [PATCH] Load intermediate certificates from a PKCS#12 file and pla=
ce
  them in the extra certs chain, when trusted CA certs are
  loaded from an external PEM file with the --ca option, and
  the CA certs in PKCS#12 are not to be trusted.

Required when client PKCS#12 file is provided by a different CA than the se=
rver CA, the PKCS#12 file contains intermediate certificates required for c=
lient auth, but the server CA is not in the PKCS#12 file.

When --ca is set, the PKCS#12 provided CA certs are not trusted. Without th=
is patch, they were ignored completely - with this patch, they're loaded in=
 the extra certs chain which makes them available for chain verification bu=
t still does not make them trusted if --ca is set. Unless when, of course, =
a trusted root is found from the --ca file.
---
  src/openvpn/ssl_openssl.c |   20 +++++++++++++++++++-
  1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c index 2e=
5933d..dff4897 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -380,16 +380,34 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const c=
har *pkcs12_file,
    /* Set Certificate Verification chain */
    if (load_ca_file)
     {
+     /* Add CAs from PKCS12 to the cert store and mark them as trusted.=20
+      * They're also used to fill in the chain of intermediate certs as
+      * necessary.
+      */
       if (ca && sk_X509_num(ca))
        {
  	for (i =3D 0; i < sk_X509_num(ca); i++)
  	  {
-	      if (!X509_STORE_add_cert(ctx->ctx->cert_store,sk_X509_value(ca, i)))
+	    if (!X509_STORE_add_cert(ctx->ctx->cert_store,sk_X509_value(ca,=20
+i)))
  	      msg (M_SSLERR, "Cannot add certificate to certificate chain (X509_=
STORE_add_cert)");
  	    if (!SSL_CTX_add_client_CA(ctx->ctx, sk_X509_value(ca, i)))
  	      msg (M_SSLERR, "Cannot add certificate to client CA list (SSL_CTX_=
add_client_CA)");
  	  }
        }
+   } else {
+     /* If trusted CA certs were loaded from a PEM file, and we ignore the
+      * ones in PKCS12, do load PKCS12-provided certs to the client extra
+      * certs chain just in case they include intermediate CAs needed to
+      * prove my identity to the other end. This does not make them truste=
d.
+      */
+     if (ca && sk_X509_num(ca))
+      {
+	for (i =3D 0; i < sk_X509_num(ca); i++)
+	  {
+	    if (!SSL_CTX_add_extra_chain_cert(ctx->ctx,sk_X509_value(ca, i)))
+	      msg (M_SSLERR, "Cannot add extra certificate to chain (SSL_CTX_add_=
extra_chain_cert)");
+	  }
+      }
     }
    return 0;
  }
--
1.7.10.2 (Apple Git-33)


---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

