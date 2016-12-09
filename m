References: <20161129120559.5be3e4ad@...1799...>
	<20161129110716.3946-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5448e007-8871-9933-6f12-765d4c1a9e54@...2080...>
Date: Fri, 9 Dec 2016 22:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <20161129110716.3946-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7OclA8kwwGuAoKG78lLldOg9FVxLQc5sa"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Clean up plugin path handling
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7OclA8kwwGuAoKG78lLldOg9FVxLQc5sa
Content-Type: multipart/mixed; boundary="QNW3So446wGhe5UCQfEHumucG5oUd5JSS";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>
Message-ID: <5448e007-8871-9933-6f12-765d4c1a9e54@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Clean up plugin path handling
References: <20161129120559.5be3e4ad@...1799...>
	<20161129110716.3946-1-list@...1798...>
In-Reply-To: <20161129110716.3946-1-list@...1798...>

--QNW3So446wGhe5UCQfEHumucG5oUd5JSS
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 29/11/16 12:07, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> Drop --with-plugindir, instead use an environment variable PLUGINDIR
> to specify the plugin directory.
>=20
> This always defines PLUGIN_LIBDIR and enables plugin search path.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  configure.ac            | 14 ++++++--------
>  src/openvpn/Makefile.am |  3 ++-
>  2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index f4073d0..5fe652e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -301,13 +301,12 @@ AC_ARG_WITH(
>  	[with_crypto_library=3D"openssl"]
>  )
>=20=20
> -AC_ARG_WITH(
> -	[plugindir],
> -	[AS_HELP_STRING([--with-plugindir], [plugin directory @<:@default=3DLIB=
DIR/openvpn@:>@])],
> -	,
> -	[with_plugindir=3D"\$(libdir)/openvpn/plugins"]
> -)
> -
> +AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=3DLIBDIR/=
openvpn/plugins@:>@])
> +if test -n "${PLUGINDIR}"; then
> +	plugindir=3D"${PLUGINDIR}"
> +else
> +	plugindir=3D"\${libdir}/openvpn/plugins"
> +fi

Finally had some time to dig into this one.  I like the idea here, I
think it makes sense.  But I'm not sure ${libdir} is correct by default.
 I think that should be /usr/local/lib64 by default on a 64bit system.

My google-foo isn't helpful for me today ... This is somewhat related,
especially towards the end of this doc page:
<https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Site-=
Defaults.html>

But I believe there are better ways to do this.

I haven't checked this in detail what happens with 'make install'.  We
should ensure that the plug-ins we ship (./src/plugins) which are built
are installed as well into this directory.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--QNW3So446wGhe5UCQfEHumucG5oUd5JSS--

--7OclA8kwwGuAoKG78lLldOg9FVxLQc5sa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSyQIAAoJEIbPlEyWcf3yPXcP/R3tx9//zrzniU7DfuwFksTk
J9lhVQx47ONt3M26SWaEezpu59b6DtN/sjf8yP0SIPWM6UkHYWO9gwwk5bw2Ewmv
u4hf1hJ4D18Wg6QNWc6KfXI5qrbLBOTN6Vr6b/b8t9uJNfYTTw0jV2SSmOWobtCe
tKJZhGa1WycWOziUGp+OeWrIrrlTTdnwWQ573p/2oHU83oUC/UNtykK8HVnWaV6L
RNwLUSpHxB7CRB42joanpnvFMWua7hkFwUNrxlwLdlcQlwwAQG5FJrwX5LyHDCxS
83itnzSxe9y7WlEmBseTHeAM/oKiIf6NsxoIbNQ3tcex75C5xtFjmJilz9WZNyer
7eaNrrs7dn3rn2CMsoUO3vxM6wN30KfT8AEiamzqJb6/9RdloaLWlm2zLNlBhDyz
uyw86d7YVxGjjzqEHCAAGbT+Rgoq5vkj1eAxOrAMkzJIx98cONK642vqZ9yCqOyr
7L8dzvBAVCTfEgOm62t+xHWv8f/+Oiptr14s854Jbg3u/vnOi5Z2JuWyHYHj87CL
hX5xLdj8GAJKVhw6zdjByjE9ym6LnlupZkyidbeDBe9Vbr0NC0yLReQ3p3ElGcAD
wSWNRjf5p6bskn3ehHG3ynAjcTW4/yW1LM+x73X6ABx9bkPWyXervAFyX0Vzcnfv
eO2Y2+ko6f+Zch40isKq
=K6CJ
-----END PGP SIGNATURE-----

--7OclA8kwwGuAoKG78lLldOg9FVxLQc5sa--

