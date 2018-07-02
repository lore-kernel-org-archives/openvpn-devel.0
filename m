References: <023bf67a-02c2-93ca-7c97-3219b24d3411@...2181...>
 <20180701195938.2541-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2ed5d3d8-c3f6-c829-7537-a67a242396a1@...2181...>
Date: Mon, 2 Jul 2018 10:12:29 +0800
MIME-Version: 1.0
In-Reply-To: <20180701195938.2541-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kLoNWLgGU82dLyLzyA4pDnSgFl89UMilP"
Subject: Re: [Openvpn-devel] [PATCH] Extend push-remove to also handle
 'ifconfig'.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kLoNWLgGU82dLyLzyA4pDnSgFl89UMilP
Content-Type: multipart/mixed; boundary="23jIlYzmp7WhhqSIRxwsCHzVi0gKia4am";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2ed5d3d8-c3f6-c829-7537-a67a242396a1@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Extend push-remove to also handle
 'ifconfig'.
References: <023bf67a-02c2-93ca-7c97-3219b24d3411@...2181...>
 <20180701195938.2541-1-gert@...1296...>
In-Reply-To: <20180701195938.2541-1-gert@...1296...>

--23jIlYzmp7WhhqSIRxwsCHzVi0gKia4am
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/07/18 03:59, Gert Doering wrote:
> Push-remove (introduced in commit 970312f1850) did not handle "ifconfig"
> yet, as both "ifconfig" and "ifconfig-ipv6" are handled differently from
> all other pushed options.  Since there was no valid use-case to not-push
> "ifconfig" (no support on the client side for running IPv6-only) this
> was not an issue so far - but with the recent commits to enable ipv6-only
> operation it can be a desirable feature.
>=20
> The implementation is similar to "push-remove ifconfig-ipv6" - namely,
> flagging via a new context option (c->options.push_ifconfig_ipv4_blocked)
> and then not creating the push statement in "send_push_reply()".
>=20
> While not truly elegant, it's much less invasive than the alternatives
> (storing the list of "push-remove" statements somewhere and then checking
> in push_option_ex())
>=20
> Trac: #1072
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
>=20
> ---
> v2: style changes, manpage note about exact match

Acked-by: Antonio Quartulli <a@...2181...>


--=20
Antonio Quartulli


--23jIlYzmp7WhhqSIRxwsCHzVi0gKia4am--

--kLoNWLgGU82dLyLzyA4pDnSgFl89UMilP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAls5ig0ACgkQB6U8WA7y
zXRRPw/9GbowxbgyMN8t3FcRR+YlQkDmSi1cTpvZOU+qs6NCusca5Az0+Ez21ER/
ylgHOU6dRzakh86zIYvGQIQ+QgK6FDJlYrx24aazWZ33OXQVS4INONmahmLIPFSG
P+kTvJGFgJreWu/qtz3b1ypP1CD75kE55/3Za04MjywnubeeTwuVHG1y7GhEQlau
siyCsWlPfNvicysERIPxU7tXEF+UI5M+rlG4YgQ2nji0VzGupSDZFEfAPyTi8hPv
2BYX5BPEFHEXKezRbsONjDGGIGoz3wpmWspEfmoIdB30/vNneMOlEXpz+jZM0vJ4
Y51qQ6nB7dRcbDdsoDhkhf3IyfVX+uRTq/5smfMw3WigtTxkMwEj3SHHIJLJNF3C
eKB3PRJjcr6n1xfjAE7pZMtKmUjiKpiTVykdtwc8NK0tBGE4GgY57mqpNKCBrMrc
voWnwPmiXKJz3sr/l/m0PPo8mby2g2iQ4euiFMNA68xbL4AgFOS5S9EKKPsw2Erz
pQFDydjqOOGJ+hDZwCQC7dDWH0TZ9ME5S5CTjP9wcxcnMpYa7QUWhKFxSjEmkavn
SqntlgKVE86S/00RO5XutXQwluST920DN2TFaJokW55Nhn9nCRf9AJs+J6Q9ubcQ
k4qXsVesObQRwKSkbiPx6223GSnzDXzcZW5qomjvbuw3EC8JEes=
=AjkT
-----END PGP SIGNATURE-----

--kLoNWLgGU82dLyLzyA4pDnSgFl89UMilP--

