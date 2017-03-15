Date: Wed, 15 Mar 2017 16:28:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170315152840.GR93896@...1296...>
References: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dQ2UWBmeJhPxzxhA"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
Subject: Re: [Openvpn-devel] why "ifconfig" is required during build ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--dQ2UWBmeJhPxzxhA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 15, 2017 at 08:15:08PM +0500, ???????? ?????????????? wrote:
> I'm playing with AppVeyor, and I figured out that I have no idea why does
> "ifconfig" is checked during build process:
>=20
> [ilia@...23... openvpn]$ grep ifconfig configure.ac
> AC_PATH_PROGS([IFCONFIG], [ifconfig],,
> [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
> AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig tool=
])
>         test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is requir=
ed
> but missing])
> [ilia@...23... openvpn]$
>=20
>=20
> well, it makes sense that it might be required for running openvpn. but w=
hy
> to check it during build ?

To find the path that we're going to call the binary with.  We do not
rely on $PATH resolution at runtime.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dQ2UWBmeJhPxzxhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYyV2nAAoJEB2Cnv7KVigSd10L+QEnkH6LqJVYAwjfwZ0SbjO+
S5oMV4T78o2aomGMLogaSJfs8BX7vNkYd0mHzOtve3/4vpb7ygyCLjrX/2NE7MFL
6wKsS0QZAXVbw8TLyENZvjJ3Xqx/S6NtOVLTX/QzFLVDf/3AUs9fedUZ6WgWhOga
JRFc5jhC8STt/EsDqEImtOr887tUbT2pJayUxoSmneUA8H6MRt9DfQ1ubdwG3Jjn
VAvGDndfsyIL/ZR7rvHB44plF0NeZNt7VaAdVG4AFcnk5tmDEFRGq5ptIS4nUvLK
TclMMZRUb5DTpmLJysUUVGbebrerCgAUnyqErNmNsfMFVp1j+9/aG2zRScguHGPQ
4lCdcVygBnLe+/C6jLfeLr+ar0IS8h+shWyajewP0MaFUCtHX2hhszzov0oEa2PG
v5RHDXA4IDmJq+eqjSg384AupEyNDZkNYE7RsBCIe5w7t/jWg3T0U/FONhUjJyR7
BarOS/bJBKVqopYW8V1I88RSR7kl+291HskblS4CoA==
=KlJp
-----END PGP SIGNATURE-----

--dQ2UWBmeJhPxzxhA--

