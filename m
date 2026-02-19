Date: Thu, 19 Feb 2026 10:26:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aZbXP4m3gmbm82Rm@...1296...>
References: <20260218214738.27158-1-gert@...1296...>
 <202602190911.61J9B80r029712@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="reQVC16CllUVRd5C"
Content-Disposition: inline
In-Reply-To: <202602190911.61J9B80r029712@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: dns: fix discards 'const'
 qualifier from pointer target type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rudi Heitbaum <rudi@...2993...>
Cc: openvpn-devel@lists.sourceforge.net

--reQVC16CllUVRd5C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 19, 2026 at 10:11:08AM +0100, Gert Doering wrote:
> Your patch has been applied to the master and release/2.7 branch.
>=20
> The way this was handled might look a bit confusing - normally "patch
> on the list, ACK on the list, take it from there and merge it" is perfect=
ly
> fine, but in this case it went through our Gerrit to verify that the
> change would not cause -Werror fails on other platforms.  So we basically
> have 3 copies of the patch now, "list", "gerrit master" and "gerrit 2.7",
> and they are all the same.
>=20
> I'm taking the "gerrit master" one, and cherrypick to 2.7, because that's
> less work for me (and it's the normal workflow "patches to master, cherry=
pick
> from there to all affected branches").
>=20
> commit 0157e7fb8ae29b637537a6b98ce85217c6daf5a3 (master)
> commit 188d3d68855e2f0d0bd2afc21b66cbe3d98bc41f (release/2.7)

And also

commit 7cf6e1f8dcc424d8cd1079cb66adb470f29599e1 (release/2.6)

admittedly I got a bit confused which branches are affected for what
patch...

Since this is all "long term maintenance", and "low impact", 2.6.x is in
scope.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--reQVC16CllUVRd5C
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmmW1zwACgkQHYKe/spW
KBLmbAv+Pvh6rHfhNLJHZ0rq6NK95LoTl7+joCL7G/vZtSi/4d+tCIujXIHgeaYn
rHdWY0/67UlxtqdBq74vKjYsUhHIWzf0gbFw0x5ulONsDyXkAlK8vU+aAyWmR5cC
mAQOPgdTb4OcOHa7XtjL+9tHWMbfZth3kHZ2pLgrjRcsT/+Mw4qXS0vch5KJact5
avLh24PvxJdrU6nt1U3dSs1N0o3yK6gADEOnGxPn82T0uDmyVP5A327EOQm00Q+p
efDXejPBM60SwzuF3DIcffGLsKlLjAWB4nuiMRYUHj74ETqnCHzuNn+u1DDBk1mm
CbIlSwzhzXf/qpnhzRHi6TUPf4K8fg4EqV86+isNrDzhLMTh31FUDPFbnvKnKYtR
YITaqB2wspoPc3OJACPcXzzIRhEBzlIdG27uVf1+CN5dXVB5Tkj6bLgoZJhA2q+Y
1Cl005Yn/py+wgSyl5wY4x27SWxrX9tjK/7GvJ5p37X/MN30o3Fr1gT9DwDWNNFL
DBnZN9O5
=7aoT
-----END PGP SIGNATURE-----

--reQVC16CllUVRd5C--

