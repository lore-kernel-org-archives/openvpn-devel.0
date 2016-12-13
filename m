References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
Date: Tue, 13 Dec 2016 01:15:03 +0100
MIME-Version: 1.0
In-Reply-To: <1481543265-21474-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fVGpujs1JnlhnVX3N6pq8OIbL08exUvE5"
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
 --enable-plugins
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fVGpujs1JnlhnVX3N6pq8OIbL08exUvE5
Content-Type: multipart/mixed; boundary="oLXVpqXfTNwEXr3C4X11sRCOIRwdKujQ1";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
	--enable-plugins
References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1481543265-21474-1-git-send-email-lstipakov@...277...>

--oLXVpqXfTNwEXr3C4X11sRCOIRwdKujQ1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 12/12/16 12:47, Lev Stipakov wrote:
> Async push functionality makes sense only with deferred authentication,
> which requires plugins.
>=20
> Trac #783
>=20
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  configure.ac | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/configure.ac b/configure.ac
> index 27bdcc3..946f3db 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1204,6 +1204,10 @@ if test "${enable_plugin_auth_pam}" =3D "yes"; then
>  fi
>=20=20
>  if test "${enable_async_push}" =3D "yes"; then
> +	if test "${enable_plugins}" =3D "no"; then
> +		AC_MSG_ERROR([--enable_async_push requires --enable-plugins])
> +	fi
> +
>  	AC_CHECK_HEADERS(
>  		[sys/inotify.h],
>  		AC_DEFINE([ENABLE_ASYNC_PUSH], [1], [Enable async push]),
>=20

Coupling --enable-async-push with --enable-plugins makes a lot of sense.
 By the way, there is a typo in the errror message though
(--enable_async_push should be --enable-async-push).

But I am wondering if it would be better to just do this in syshead.h
instead:

  #if !defined(ENABLE_PLUGIN) && defined(ENABLE_ASYNC_PUSH)
  #undef ENABLE_ASYNC_PUSH
  #endif

Or another more verbose patch would be to have all
#ifdef ENABLE_ASYNC_PUSH updated to also check for
defined(ENABLE_PLUGIN), but I think that's overdoing it a bit.

My point is that there's no real point of screaming about missing
--enable-plugins if you have added --enable-auth-push.  If you build
without plugins support, --plugin in configurations won't work
regardless.  I think it is more likely that those adding
--disable-plugins (it is enabled by default) believe --enable-async-push
does something completely different.  Rather have in the help line of
--enable-async-push that it depends on the plug-in feature.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--oLXVpqXfTNwEXr3C4X11sRCOIRwdKujQ1--

--fVGpujs1JnlhnVX3N6pq8OIbL08exUvE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYTz2HAAoJEIbPlEyWcf3yofEQAKEgpQgNS/on6zw9ffBHuBqO
1MJKF1MvBYuYYIPXM2e7wnW4+nuS2U2QH98DYNA7NMn6cfu/MgAGnWU88ZD3MJV6
OS2l4XuVAfJ3dxkjMG//hO82+UE0z0sLp/kt6IESyTZUtKkYA8m+jXl0WX8Lg+jM
cqegOZkkxeewn9Fd+QuUwWhR7Ri0Cj6Bb2H1qsbQ5JgngBHzfVlqYYMyLBZkVvyn
iesRL8Aav5voUi21hqm578HRYgyHlEgej+db/ql2zXjmCpfjw0G1d6p7msKbP+nL
ey6FD1HskpCYxvzJ0ZwmfrumRdAURuaQsIecizNEODaa/DENb0bx9JkIqmtGuhXy
ZfwUlVkjunsuJRpD7g3YA8wS04rMGq4EemloihGiHXpHG1HMlYaLDDKcVzDiPaOZ
avj29lvLIfvdCkBghK/pDm8l+n6bB5ap1gQe5JZ2T/zcICcfkTz6okGyjjSsMrd/
WzhBWGpXGZmcLnaUIT1f6IlXcr/n6OnN6/isz00I6WcfHop66ROrYC4/IQQiit6j
FjM1G5ztij7pEUxYVJVVEUe7ERmic/aW6qEfThMPrqtorSVh9nrn8OrypFMFljHZ
NZGsix3XXDk4z1fOf4NYklWe5vL9inqj2U6PiNCr6hagb13f306hw9D12qmcKPSZ
IuteFKYoRMo9/QomwuOl
=ufyv
-----END PGP SIGNATURE-----

--fVGpujs1JnlhnVX3N6pq8OIbL08exUvE5--

