Date: Mon, 2 Jun 2014 20:20:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140602182009.GP1118@...1296...>
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
	<1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FnOKg9Ah4tDwTfQS"
Content-Disposition: inline
In-Reply-To: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Get NTLMv1 and NTLMv2 up and running
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--FnOKg9Ah4tDwTfQS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Holger,

sorry for drag this so long.  I'm not trying to stare into this, but
can't really say "this is correct" or "violating specs", lacking the
NTLM auth background.

Is this used - and thus tested - by you only, or is it used by UTM=20
customers?  (This would give us confidence that it's tested by a larger
user base, and those tend to uncover issues :-) ).

Can you explain which of these changes actually fix the "not working"
bits, and which are just "make the code less ugly"?

More questions and some comments on style intermixed below...


On Wed, Apr 16, 2014 at 12:48:36PM +0200, Holger Kummert wrote:
> * Force conversion to UTF-16 of username and domain if server requires UT=
F-16.
> * Rewrite conversion function to cleanly convert UTF-8 to UTF-16.
> * Fix bug in length computation in NTLMv2-code.
> * Architecture independent access to NTLM NegotiateFlags.
>=20
> Signed-off-by: Holger Kummert <Holger.Kummert@...1516...>
> ---
>  src/openvpn/ntlm.c | 156 +++++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 134 insertions(+), 22 deletions(-)
>=20
> diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
> index 3390bdd..ed1e1a8 100644
> --- a/src/openvpn/ntlm.c
> +++ b/src/openvpn/ntlm.c
> @@ -56,6 +56,11 @@
>  #endif
>=20=20
>=20=20
> +#define NTLM_NEGOTIATE_UNICODE      (1<<0)
> +#define NTLM_NEGOTIATE_OEM          (1<<1)
> +#define NTLM_NEGOTIATE_NTLM2_KEY    (1<<19)
> +#define NTLM_NEGOTIATE_TARGET_INFO  (1<<23)
> +
>=20=20
>=20=20
>  static void
> @@ -79,8 +84,10 @@ gen_md4_hash (const char* data, int data_len, char *re=
sult)
>    const md_kt_t *md4_kt =3D md_kt_get("MD4");
>    char md[MD4_DIGEST_LENGTH];
>=20=20
> -  md_full(md4_kt, data, data_len, md);
> -  memcpy (result, md, MD4_DIGEST_LENGTH);
> +  if (data_len >=3D 0) {
> +    md_full(md4_kt, data, data_len, md);
> +    memcpy (result, md, MD4_DIGEST_LENGTH);
> +  }
>  }

Can data_len be < 0 in any reasonable circumstances?

If not, I'd rather have an "ASSERT(data_len>=3D0)" here - it would be a=20
calling convention violation, and just silently not doing anything is=20
not how OpenVPN usually handles this (as it might lead to interesting
effects later on, "result" being uninitialized).  Better crash with a=20
clear message pointing to this line of code in that case.


>  static void
> @@ -140,18 +147,89 @@ unsigned char *my_strupr(unsigned char *str)
>  }
>=20=20
>  static int
> -unicodize (char *dst, const char *src)
> +utf8_to_utf16LE (unsigned char *dst, int dst_len, unsigned char *src)
>  {
> -  /* not really unicode... */
> -  int i =3D 0;
> -  do
> +  /* Convert UTF-8 to UTF-16 little endian
> +   *
> +   * http://clang.llvm.org/doxygen/ConvertUTF_8c_source.html
> +   */

I can see why you would want to change this :-) - for clarification, is
this a true bug in the code, preventing correct operation (... for user
names / passwords with non-7bit characters in them), or is this just=20
unrelated improvement?

> +  const unsigned int uni_max_utf16      =3D 0x0010FFFF,
> +                     uni_half_base      =3D 0x00010000,
> +                     uni_half_mask      =3D 0x000003FF,
> +                     uni_half_shift     =3D 10,
> +                     uni_sur_high_start =3D 0xD800,
> +                     uni_sur_low_start  =3D 0xDC00,
> +                     uni_sur_low_end    =3D 0xDFFF;

I'm feeling slightly uneasy with these.  If these are true constants,
is there a good reason to use "const int" variables, and not follow
the usual convention

#define UNI_MAX_UTF16 ...
#define UNI_HALF_BASE ...

so it's more obvious to the reader of the code that this is not something
which can change at run time?


> +      if (ch <=3D 0xFFFF)
> +      {
> +        if (ch >=3D uni_sur_high_start && ch <=3D uni_sur_low_end) {
> +          msg (M_INFO, "Warning: Illegal character value: %x is in reser=
ved area of UTF-16 [%x, %x]", uni_sur_high_start, uni_sur_low_end);
> +          return -1;
> +        }
> +        else {    /* normal case */
> +          if (dst_len - (dst - dst_start) < 2) {
> +            msg (M_INFO, "Warning: To less space in destination buffer f=
or conversion to UTF-16");

Grammar nit ;-) - "not enough space".


[..]
>    /* fill 1st 16 bytes with md4 hash, disregard terminating null */
> -  gen_md4_hash (pwbuf, unicodize (pwbuf, p->up.password) - 2, md4_hash);
> +  gen_md4_hash (pwbuf, utf8_to_utf16LE(pwbuf, sizeof (p->up.password) * =
2, (unsigned char*)p->up.password), md4_hash);

I'm a bit confused (again).  It's called "utf8_to_utf16LE()", but the stuff
we have in OpenVPN variables, at least on unix systems, is not always
UTF8 - it's "bytes as typed", and they might be ISO8859-1.=20=20

All my systems do *not* use UTF8.

So what happens if a user uses a German umlaut as part of his password,=20
and types this into an password: prompt given by OpenVPN on an ISO8859-1
system?

(Yeah, this sucks, but this issue needs to be well understood before=20
merging)

>=20=20
> +  /* extract NegotiateFlags from bytes 20-23 */
> +  ntlm_negotiate_flags =3D (buf2[0x14] & 0xff) | (buf2[0x15] & 0xff) << =
8 | (buf2[0x16] & 0xff) << 16 | (buf2[0x17] & 0xff) << 24;

We could make "buf2" an "unsigned char", and save ourselves the & 0xff=20
orgy here... and further down setting tib_len.

> -		if (( *((long *)&buf2[0x14]) & 0x00800000) =3D=3D 0x00800000){ /* Chec=
k for Target Information block */
> -			tib_len =3D buf2[0x28];/* Get Target Information block size */
> +		if (ntlm_negotiate_flags & NTLM_NEGOTIATE_TARGET_INFO){    /* Check fo=
r Target Information block */
> +			tib_len =3D buf2[0x28] & 0xff | (buf2[0x29] & 0xff) << 8;  /* Get Tar=
get Information block size */

Yeah.  Thanks for this.  Whoever thought that accessing an arbitrary
and potentially unaligned block of memory as a (long) on "all architectures
that OpenVPN runs on" should propably be tasked with maintaining options.c
for the next 10 years, or so.


>  		/* Get blob length */
> -		ntlmv2_blob_size =3D 0x20 + tib_len;=20
> +		ntlmv2_blob_size =3D 0x1c + tib_len;

What are these magic numbers?  Was 0x20 a bug, and 0x1c is right, or is
the context different, so the magic number needs to be different?

> +    len =3D utf8_to_utf16LE(username_u, sizeof(username_u), username);
> +    if (len>=3D0) {
> +      add_security_buffer(0x24, username_u, len, phase3, &phase3_bufpos);
> +    }
> +  }
> +  else {
> +    add_security_buffer(0x24, username, strlen(username), phase3, &phase=
3_bufpos);
> +  }
> +

I can see that you did not invent add_security_buffer(), but "copying=20
arbitrary strings provided by other bits of OpenVPN into a buffer of
limited length, with no overrun checking" is not *exactly* making me
feel good at night.  So maybe this should be extended to ensure that
"*msg_bufpos + length" is not overring sizeof(phase3)...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FnOKg9Ah4tDwTfQS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU4zAWKkuBuNlUUl1AQJOKAQAqtoqQ1QsvSik7SWOpxxd+/ODynBG7keA
wEBWAoFWK11VCsp9cvjoZsF1aIvKF91G2dlA7b3wnpqqD82CX9wbAYmhO2q3oC6S
0uSS1jLicdGiXlxu8VaYRSi58bhKzjtdse1yS4SCKzoPZMgHyI1rCXXvXz8ZDHDD
zA2C73ElGik=
=guiC
-----END PGP SIGNATURE-----

--FnOKg9Ah4tDwTfQS--

