Message-ID: <4BD172C1.5090604@...1114...>
Date: Fri, 23 Apr 2010 12:13:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100422111337.7ABB521DCF7@...1353...>
	<201004222206.26989.dave_br@...1278...> <4BD0BFAF.4060002@...1147...>
	<201004222237.31646.dave_br@...1278...>
In-Reply-To: <201004222237.31646.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH-fixed] revocation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi Davide!

Thanks a lot!  This is looking pretty well, I have a few comments, though.

On 22/04/10 23:37, Davide Brini wrote:
> 
> --- openvpn-2.1.1/ssl.c	2010-02-28 22:17:45.000000000 +0000
> +++ openvpn-2.1.1-a/ssl.c	2010-04-22 22:33:40.000000000 +0100
> @@ -788,9 +788,28 @@ verify_callback (int preverify_ok, X509_
>  
>    /* export serial number as environmental variable */
>    {
> -    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber (ctx->current_cert));
> +    BIO *bio = NULL;
> +    char serial[1024] = {0};

Do we need 1024 bytes?  RFC5280 indicates 20 octets (read: bytes) as the
expected maximum size.  To print 20 octets as hex, you need 40 bytes,
and with delimiters for each octet it will be 59 bytes.

The initialisation is also rather bogus, as it will only put \0 in the
first byte, not the complete string.  It's better to instead use
CLEAR (serial) afterwards (which is a wrapper for memset()).

> +    int n;
> +
> +    if ((bio = BIO_new (BIO_s_mem ())) == NULL) {
> +      msg (M_WARN, "CALLBACK: Cannot create BIO (for tls_serial_%d)", ctx->error_depth);
> +    }
> +    else {
> +      /* "prints" the serial number onto the BIO */
> +      i2a_ASN1_INTEGER(bio, X509_get_serialNumber (ctx->current_cert));
> +      n = BIO_read (bio, serial, sizeof (serial)-1);
> +      if (n < 0) {
> +        serial[0] = '\x0';
> +      }
> +      else {
> +        serial[n] = 0;
> +      }

This if-block is really not needed if you memset() serial first, unless
there are known issues with OpenSSL that it might place garbage after
the n'th byte.  I don't think that is the case, though.

It should also be some error checking here as well.

Another thing is if BIO_read() returns 0, the serial number should not
result in an empty string.  I'm wondering if it would be appropriate for
us to return "0" zero as a string) or "-1" as a string to the
environmental variable.  The former implementation would probably return
0, but I'm wondering if -1 would be even better to indicate an error.

Maybe even consider to check the return value of i2a_ASN1_INTEGER() as well.

>      openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx->error_depth);
> -    setenv_int (opt->es, envname, serial);
> +      setenv_str (opt->es, envname, serial);
> +      BIO_free(bio);
> +    }
>    }


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvRcr4ACgkQDC186MBRfrqraQCggpyJ+DKcmzyK1uhmodj1cLIT
LEMAniCuXp1HZ5WM8lhrGZ9F+kyDrka7
=kgsa
-----END PGP SIGNATURE-----

