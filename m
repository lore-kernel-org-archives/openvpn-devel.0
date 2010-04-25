Message-ID: <4BD4CCA3.5030705@...1114...>
Date: Mon, 26 Apr 2010 01:13:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
In-Reply-To: <1272210565-9312-1-git-send-email-dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, fixed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/04/10 17:49, Davide Brini wrote:
> ssl.c:
>          correctly manage and export serial numbers of any size (as
>          parsed by OpenSSL) into the environment. Set to empty string
>          in case of errors, as 0 and negative numbers are all possible
>          (although illegal) certificate serial numbers. Use an OpenSSL
>          BIO object to do the job.
> 
> openvpn.8:
>          Added some notes about $tls_serial_{n} format and usage to the
>          existing description.
> 
> contrib/OCSP_check.sh:
>          New barebone script to demonstrate how to use $tls_serial_{n}
>          to perform simple OCSP queries using OpenSSL command line
>          "openssl ocsp".
> 
> Signed-off-by: Davide Brini <dave_br@...1278...>

Hi Davide,

Thanks for sending an updated patch!  This is looking a lot better.
However, I have a few comments to this patch as well.  But this one is
getting closer to be accepted :)

Btw!  Very good idea by introducing the OCSP_check.sh example!  And even
a proper git patch!  I like that :)

> ---
>  contrib/OCSP_check.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
>  openvpn.8             |    7 ++++-
>  ssl.c                 |   26 +++++++++++++++++--
>  3 files changed, 96 insertions(+), 4 deletions(-)
>  create mode 100755 contrib/OCSP_check.sh
> 
> diff --git a/contrib/OCSP_check.sh b/contrib/OCSP_check.sh
> new file mode 100755
> index 0000000..63665fc
> --- /dev/null
> +++ b/contrib/OCSP_check.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +
> +# Sample script to perform OCSP queries with OpenSSL
> +# given a certificate serial number.
> +
> +# If you run your own CA, you can set up a very simple
> +# OCSP server using the -port option to "openssl ocsp".
> +
> +# Full documentation and examples:
> +# http://www.openssl.org/docs/apps/ocsp.html
> +
> +
> +# Edit the following values to suit your needs
> +# *** NO SPACES IN PATHS ANYWHERE ***
> +
> +# OCSP responder URL (mandatory)
> +ocsp_url="http://some.ocsp.server/"
> +#ocsp_url="https://some.secure.ocsp.server/"

Wouldn't it be better to use a more valid URL?  Or at least uncomment
both of them ... and have a check that this variable is set?  If unset,
exit with error.

> +
> +# Path to issuer certificate (mandatory)
> +issuer="-issuer /path/to/CAcert.crt"
> +
> +# use a nonce in the query, set to "-no_nonce" to not use it
> +nonce="-nonce"
> +
> +# Verify the response?
> +verify="-CAfile /path/to/CAcert.crt"
> +# you can also use -CApath
> +# If you do not want to verify, set the following
> +#verify="-noverify"
> +
> +# Depth in the certificate chain where the cert to verify is.
> +# Set to -1 to run the verification at every level (NOTE that
> +# in that case you need a more complex script as the various
> +# parameters for the query will likely be different at each level)
> +# "0" is the usual value here, where the client certificate is
> +check_depth=0
> +
> +cur_depth=$1     # this is the *CURRENT* depth
> +common_name=$2   # in case you need it
> +
> +# begin
> +if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
> +  eval serial="\$tls_serial_${cur_depth}"
> +
> +  # Check that the serial is not empty
> +  if [ -n "$serial" ]; then
> +
> +    # This is only an example; you are encouraged to run this command (without
> +    # redirections) manually against your or your CA's OCSP server to see how
> +    # it responds, and adapt accordingly.
> +    # Sample output:
> +    #
> +    # Response verify OK
> +    # 0x428740A5: good
> +    #      This Update: Apr 24 19:38:49 2010 GMT
> +    #      Next Update: May  2 14:23:42 2010 GMT
> +
> +    openssl ocsp $issuer \
> +                 $nonce \
> +                 $verify \
> +                 -url "$ocsp_url" \
> +                 -serial "0x${serial}" >/dev/null 2>&1
> +  else
> +    exit 1
> +  fi
> +fi
> diff --git a/openvpn.8 b/openvpn.8
> index 45e61fa..23e7c46 100644
> --- a/openvpn.8
> +++ b/openvpn.8
> @@ -5321,7 +5321,12 @@ where
>  is the verification level.  Only set for TLS connections.  Set prior
>  to execution of
>  .B --tls-verify
> -script.
> +script. This is in the form of a hex string like "37AB46E0", which is
> +suitable for doing serial-based OCSP queries (with OpenSSL, you have
> +to prepend "0x" to the string). If something goes wrong while reading
> +the value from the certificate it will be an empty string, so your
> +code should check that.
> +See the contrib/OCSP_check.sh script for an example.
>  .\"*********************************************************
>  .TP
>  .B tun_mtu
> diff --git a/ssl.c b/ssl.c
> index 1b275af..a0ff732 100644
> --- a/ssl.c
> +++ b/ssl.c
> @@ -788,9 +788,29 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
>  
>    /* export serial number as environmental variable */
>    {
> -    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber (ctx->current_cert));
> -    openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx->error_depth);
> -    setenv_int (opt->es, envname, serial);
> +    BIO *bio = NULL;
> +    char serial[100];
> +    int n;
> +
> +    CLEAR (serial);
> +    if ((bio = BIO_new (BIO_s_mem ())) == NULL) {
> +      msg (M_WARN, "CALLBACK: Cannot create BIO (for tls_serial_%d)", ctx->error_depth);
> +    }
> +    else {
> +      /* "prints" the serial number onto the BIO and read it back */
> +      if ( (i2a_ASN1_INTEGER(bio, X509_get_serialNumber (ctx->current_cert)) >= 0) &&
> +           (( n = BIO_read (bio, serial, sizeof (serial)-1) ) >= 0) ) {
> +        serial[n] = 0;

This should really not be needed when you've CLEAR()'ed serial earlier
on.  You should trust that BIO_read() do not exceed it's limits or place
other garbage after the value.

> +      }
> +      else {
> +        msg (M_WARN, "CALLBACK: Error reading/writing BIO (for tls_serial_%d)", ctx->error_depth);
> +        serial[0] = 0;   /* empty string */

Hmmm ... My first thought was that this should not be needed.  On second
thought, I realised it really might be needed - as BIO_read() *might*
have put some data here before it failed.  So if that can happen, some
data which has been parsed badly into memory is still available via the
'serial' string.

On the other hand, this might not be that critical, as setenv_str() is
pretty safe and will obey the first byte in the string.  So a
mem-info-leak is more difficult to manage, as this variable is only
available inside this function.

But consider to replace this "empty string" with yet another CLEAR(),
that's a more defensive approach.  This part of the code should
hopefulyl not be called much, unless something is really wrong - which
means that we can afford to spend a little extra time clearing this
region.  Or another approach is to only use setenv_str() using the
'serial' string only on success ... and otherwise setenv_str(opt->es,
envname, "\0")  (might even be that NULL would work as well).

I'm not convinced about any particular solution here now ... but I'm
open for other thoughts about this as well.


> +      }
> +
> +      openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx->error_depth);
> +      setenv_str (opt->es, envname, serial);
> +      BIO_free(bio);
> +    }
>    }
>  
>    /* export current untrusted IP */

One last comment is on the coding style.  This patch breaks the coding
style (yeah, I admit it - even I've been arrested on this one quite
lately).  Please correct that as well ... the current coding style (like
it or not) is based on:

	if (boolean expression)
	  {
	     do_something();
	  }
	else
	  {
	     do_something_else();
	  }

To keep the code as clean and nicely as possible, we should try to
follow the current coding style.  If you don't like the current
standard, lets discuss that first :)


Thanks again, Davide ... I hope I'm not pushing you too hard, but this
is a good improvement from the last patch, so this progress is making me
happy! :)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvUzKIACgkQDC186MBRfrqkgACgqZmCi6Sh0++tVmLCrQKRsZS0
OrsAoIz1CndbkfFCNRO4HPYxW3NHgUkC
=z2nY
-----END PGP SIGNATURE-----

