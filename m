Date: Mon, 15 Aug 2022 12:29:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvogFJdhB+8n3qrK@...1296...>
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
 <YvoXzZNWGa49RJ6D@...1296...>
 <41d3a297-83f3-5b13-49f7-dd70b0d8daee@...2669...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KrXjD8qFGF1s8Og/"
Content-Disposition: inline
In-Reply-To: <41d3a297-83f3-5b13-49f7-dd70b0d8daee@...2669...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, berni@...376...

--KrXjD8qFGF1s8Og/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 15, 2022 at 12:14:23PM +0200, Timo Rothenpieler wrote:
> > Unfortunately, it seems that our approach to "if SITNL is used, we hard
> > require that setting CAP_NET_ADMIN succeeds" is too strong for the twis=
ted
> > ways that people use openvpn.
>=20
> That's not how the patch operates.
> It only hard-requires the capability retention is dco_enabled() returns=20
> true.
> In all other cases, it will try to retain capabilities, but continue=20
> with a warning if it fails.

Yes, but we do have DCO here, setting CAP_NET_ADMIN fails, and we abort,
instead of having a working client connect.

> Making the dco_enabled() case a "try but continue" would be a matter of=20
> changing a 1 to a -1. But given that DCO can't really work then, I'm not=
=20
> sure if that's desirable.

*DCO* can work fine, from the looks of that bug report (because all
the DCO open happens before capability drop on a --client config).

"Calling ifconfig and installing routes" cannot, but this is exactly what
we are not doing if --ifconfig-noexec + --route-noexec are set.

Please look closely at the log in the bug report, and keep in mind
that NM will do all the "SITNL" stuff for the user in that scenaro,
not OpenVPN itself.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KrXjD8qFGF1s8Og/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi+iAUAAoJEB2Cnv7KVigS2f4L/R+L7PUYo/cBYXO8Ld6U6K7L
VYHLrqri5Eoz2ANJIY2IO1chzX4B4rijtjJYeF0tPvDbA/88OXJAg4OvijmVh1Ry
85B8Kf+MMkIDXaScJL+o0/EMFfyJRAiecd5KHzINDmQYrrj4YOgwOkw2yHOBcgzC
saEGHj3zxokk8UELq5Vc0/lYeG3adwmyBtai0Aq81FPL/k07HoMKcn/RAJr2jv0f
1U2ENojAl7g+tD5gZ4f/4ujSaof7+tTH5FLcGj2Yc4W9lselGt/Qe/irG7sjrZzj
Rfvl9+pk+AT8+CavK3xM+AO+khmfkY7CzsZFrcZdOCYSwuC/PHMHsdhGuQAuw+xm
BincGjTzPG2VrR9i2tHv6z4MYam14kijK32H8OA2eEeaCrh90GNB4Dxke7+YUlC/
iBlweRlzzh2mrVu1VLQp28APfTr4+SZJwH8cDXeQgufyXwBKdH2SK+1DQZ2itQ3T
dWga4ZvGV172+BMIr0mfNtCqecC6K8KRlIA8XoJu4w==
=nbJR
-----END PGP SIGNATURE-----

--KrXjD8qFGF1s8Og/--

