Date: Thu, 25 Apr 2013 20:56:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130425185601.GA20843@...1296...>
References: <1366467768-16260-1-git-send-email-arne@...1227...>
	<1366467768-16260-4-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <1366467768-16260-4-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] Android platform specific changes.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 20, 2013 at 04:22:47PM +0200, Arne Schwabe wrote:
> index 05c6da2..9fdfd88 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1125,7 +1125,9 @@ show_tuntap_options (const struct tuntap_options *o)
>  }
>=20=20
>  #endif
> +#endif
>=20=20
> +#if defined(WIN32) || defined(TARGET_ANDROID)=20
>  static void
>  dhcp_option_address_parse (const char *name, const char *parm, in_addr_t=
 *array, int *len, int msglevel)

I'm not sure if I understand these bits, will have to look at the patched
result.  It looks a bit confusing why there would be anything you need
to have "on WIN32 and Android, and nowhere else".

> +#elif defined (TARGET_ANDROID)
> +
> +    struct user_pass up;=20=20=20=20
> +    struct buffer out =3D alloc_buf_gc (64, &gc);
> +
> +    buf_printf (&out, "%s %s", network, netmask);
> +
> +    strcpy(up.username, buf_bptr(&out));
> +    management_query_user_pass(management, &up , "ROUTE", GET_USER_PASS_=
NEED_OK,(void*) 0);
> +
> +

But this is what I want to comment on.  I can see what you're doing, and
I'm fine with that - but I strongly don't like the resulting code - what=20
do you think about hiding this behind a wrapper

  management_android_control( management, buf_bptr(&out), "ROUTE" );

or such, which takes a "char *" or a "struct buffer *", and does the
same thing internally?  Having "struct user_pass" all over the code,
using it as a generic "transport this string to the management interface"
container will mightily confuse people looking for "ok, so what is this
code doing, and what does it have to do with username and password
queries on the management interface"?

> +#elif defined(TARGET_ANDROID)
> +  msg (M_NONFATAL, "Sorry, deleting routes on Android is not possible. T=
he VpnService API allows routes to be set on connect only.");

For this message, I'm wondering how useful it is.  Isn't this printed on
*every* disconnect?=20

[..]
> +    if(tt->options.domain) {
> +        strcpy(up.username , tt->options.domain);
> +        management_query_user_pass(management, &up , "DNSDOMAIN", GET_US=
ER_PASS_NEED_OK,(void*) 0);
> +    }

The wrapper mentioned above could even have a check for "if the pointer
is NULL, silently don't do anything", so this would collapse to

  management_android_control( management, tt->options.domain, "DNSDOMAIN" );

"just sayin'" :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUXl8QakuBuNlUUl1AQICXwP/XQACe0uAEZBrRgzY3Drn7PjKuq+Qv61r
mktQUaUWZPP9VUHkQh1mFMtOtTXqjYhhScT43NT4MRbVVjF8BEUKJih8JgIz3EYa
aOaqpNZRw7oO+O62cNCr1DpXf+n8LkwK4w/3uhWbjdKyXfoGuhTcUsM7c4ZeQzh6
+plC42z0tWI=
=7oiS
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

