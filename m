From: Davide Brini <dave_br@...1278...>
Date: Fri, 23 Apr 2010 11:35:05 +0100
References: <20100422111337.7ABB521DCF7@...1353...>
	<201004222237.31646.dave_br@...1278...>
	<4BD172C1.5090604@...1114...>
In-Reply-To: <4BD172C1.5090604@...1114...>
MIME-Version: 1.0
Message-Id: <201004231135.05402.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH-fixed] revocation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Friday 23 Apr 2010 11:13:21 David Sommerseth wrote:

> On 22/04/10 23:37, Davide Brini wrote:
> > --- openvpn-2.1.1/ssl.c	2010-02-28 22:17:45.000000000 +0000
> > +++ openvpn-2.1.1-a/ssl.c	2010-04-22 22:33:40.000000000 +0100
> > @@ -788,9 +788,28 @@ verify_callback (int preverify_ok, X509_
> >
> >    /* export serial number as environmental variable */
> >    {
> > -    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber
> > (ctx->current_cert)); +    BIO *bio = NULL;
> > +    char serial[1024] = {0};
> 
> Do we need 1024 bytes?  RFC5280 indicates 20 octets (read: bytes) as the
> expected maximum size.  To print 20 octets as hex, you need 40 bytes,
> and with delimiters for each octet it will be 59 bytes.

Right. Even if the variable is short-lived, and even anticipating future 
needs...I suppose 100 bytes will do for now.
 
> The initialisation is also rather bogus, as it will only put \0 in the
> first byte, not the complete string.  It's better to instead use
> CLEAR (serial) afterwards (which is a wrapper for memset()).

Ok, will do that. But anyway, since it's meant to be a string, I thought that 
initializing it to '\0' would mean "empty string".
 
> > +    int n;
> > +
> > +    if ((bio = BIO_new (BIO_s_mem ())) == NULL) {
> > +      msg (M_WARN, "CALLBACK: Cannot create BIO (for tls_serial_%d)",
> > ctx->error_depth); +    }
> > +    else {
> > +      /* "prints" the serial number onto the BIO */
> > +      i2a_ASN1_INTEGER(bio, X509_get_serialNumber (ctx->current_cert));
> > +      n = BIO_read (bio, serial, sizeof (serial)-1);
> > +      if (n < 0) {
> > +        serial[0] = '\x0';
> > +      }
> > +      else {
> > +        serial[n] = 0;
> > +      }
> 
> This if-block is really not needed if you memset() serial first, unless
> there are known issues with OpenSSL that it might place garbage after
> the n'th byte.  I don't think that is the case, though.

Neither do I, but I thought that "better safe then sorry". And btw, I saw that 
other OpenVPN code is /already/ doing the same thing (in fact, I wrote my code 
modeled after that): see pkcs11.c, from line 935.
 
> It should also be some error checking here as well.
> 
> Another thing is if BIO_read() returns 0, the serial number should not
> result in an empty string.  I'm wondering if it would be appropriate for
> us to return "0" zero as a string) or "-1" as a string to the
> environmental variable.  The former implementation would probably return
> 0, but I'm wondering if -1 would be even better to indicate an error.

Unfortunately, both 0 and negative numbers are all possible serial numbers 
(although they are now forbidden and not found in practice, but the openssl 
routines DO handle them). The RFC also says

"CAs MUST force the serialNumber to be a non-negative integer.
...
Note: Non-conforming CAs may issue certificates with serial numbers that are 
negative or zero.  Certificate users SHOULD be prepared to gracefully handle 
such certificates."

So I maintain that an empty string is the right thing to do. It will then be 
up to whatever code uses the environment variable to check that it's not empty 
(or negative, etc.).
 
> Maybe even consider to check the return value of i2a_ASN1_INTEGER() as
> well.

See above. Since the other code fragment doesn't do that, neither did I. But 
right, I will add a check and a warning if it returns a value < 0, which will 
result in an empty string put into the environment variable.

Let me know what you think, and I'll send a revised patch (yes, with summary, 
Signed-off-by and all that; I'm learning, slowly).
Thanks for reviewing!

-- 
D.

