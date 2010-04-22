From: Davide Brini <dave_br@...1278...>
Date: Thu, 22 Apr 2010 22:37:31 +0100
References: <20100422111337.7ABB521DCF7@...1353...>
	<201004222206.26989.dave_br@...1278...> <4BD0BFAF.4060002@...1147...>
In-Reply-To: <4BD0BFAF.4060002@...1147...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bGM0LGjae/fAMKz"
Message-Id: <201004222237.31646.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH-fixed] revocation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--Boundary-00=_bGM0LGjae/fAMKz
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Thursday 22 April 2010, Jan Just Keijser wrote:

> > The only doubt I have is about error handling; in this case, if the
> > allocation of the BIO fails, an error message is logged and nothing is
> > done. Is this the right thing to do?
> 
> I don't know if a FATAL error is such a good thing - not being able to
> set an env var does not warrant a server crash , I'd say.

Ok, thanks. It's now a warning (with a clearer message as well).

> Also, you're not freeing the BIO as far as I can tell.

Right, well spotted! The variables are in a block which makes them local, but 
of course the memory pointed to by bio must be freed. Thanks for the heads-up.

Please find attached the revised patch.

-- 
D.

--Boundary-00=_bGM0LGjae/fAMKz
Content-Type: text/x-patch; charset="UTF-8"; name="long_serial_numbers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="long_serial_numbers.patch"

--- openvpn-2.1.1/ssl.c	2010-02-28 22:17:45.000000000 +0000
+++ openvpn-2.1.1-a/ssl.c	2010-04-22 22:33:40.000000000 +0100
@@ -788,9 +788,28 @@ verify_callback (int preverify_ok, X509_
 
   /* export serial number as environmental variable */
   {
-    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber (ctx->current_cert));
+    BIO *bio = NULL;
+    char serial[1024] = {0};
+    int n;
+
+    if ((bio = BIO_new (BIO_s_mem ())) == NULL) {
+      msg (M_WARN, "CALLBACK: Cannot create BIO (for tls_serial_%d)", ctx->error_depth);
+    }
+    else {
+      /* "prints" the serial number onto the BIO */
+      i2a_ASN1_INTEGER(bio, X509_get_serialNumber (ctx->current_cert));
+      n = BIO_read (bio, serial, sizeof (serial)-1);
+      if (n < 0) {
+        serial[0] = '\x0';
+      }
+      else {
+        serial[n] = 0;
+      }
+    
     openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx->error_depth);
-    setenv_int (opt->es, envname, serial);
+      setenv_str (opt->es, envname, serial);
+      BIO_free(bio);
+    }
   }
 
   /* export current untrusted IP */

--Boundary-00=_bGM0LGjae/fAMKz--

