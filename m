References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180729193400.GX55859@...1296...>
 <CAKuzo_hSzz=bqMCuYBMoUOTn1uruXN-KcGA9nCbu89Xm9UBe-Q@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <53a5faf4-3b97-6b11-f68f-87c64b276334@...2181...>
Date: Mon, 30 Jul 2018 22:31:21 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hSzz=bqMCuYBMoUOTn1uruXN-KcGA9nCbu89Xm9UBe-Q@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YojVtPGxfetKYDcd0c6T1PJTFY7jBWnuo"
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YojVtPGxfetKYDcd0c6T1PJTFY7jBWnuo
Content-Type: multipart/mixed; boundary="m92v07HZj9WT2ae9N4c8WxhJPfDSvuwK5";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <53a5faf4-3b97-6b11-f68f-87c64b276334@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180729193400.GX55859@...1296...>
 <CAKuzo_hSzz=bqMCuYBMoUOTn1uruXN-KcGA9nCbu89Xm9UBe-Q@...278...>
In-Reply-To: <CAKuzo_hSzz=bqMCuYBMoUOTn1uruXN-KcGA9nCbu89Xm9UBe-Q@...278...>

--m92v07HZj9WT2ae9N4c8WxhJPfDSvuwK5
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 30/07/18 04:16, Selva Nair wrote:
> Yes that's the base64 patch. What is stopping it is not the
> disagreement on that patch but an "error" [*] in the plugin header
> that I had discovered.  David wants to fix that before this one, but
> it seems he is too busy with other things.
>=20
> And there is a pending patch to fix that :
> https://patchwork.openvpn.net/patch/87/
>=20

[CUT]


>=20
> [*] A function signature uses a pointer to an opaque handle (a void *)
> while it should be just the handle. It generates no warning as it is
> void * vs void ** and all existing codes out there must be correctly
> passing the pointer (handle) ignoring the signature in the header --
> else they wont work. I wanted the header to be fixed and David seems
> to agree with that.
>=20

I remember discussing this patch with David as well and the general
feeling was that the patch was correct.

Maybe David wanted to spend some more time on this patch, but it slipped
off the plate.

As Selva said, if users of that function were following the header they
would see a lot of explosions, while this is not the case.
Therefore it should be happily applied with no risk.


Cheers,

--=20
Antonio Quartulli


--m92v07HZj9WT2ae9N4c8WxhJPfDSvuwK5--

--YojVtPGxfetKYDcd0c6T1PJTFY7jBWnuo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltfITkACgkQB6U8WA7y
zXQyNg/7B8ER1cl3Qb7pF0wyoMfOwdb5jAreUp2ZujSC3kuYrbiJZ5m2IYhSabrg
AQr0Z/VU+jVd17T6W6+KG5OS604gW3AySq74RIuBASA8qFn8VkYbEMhMPnwtsvxR
4CClZi1mvk+CIGhioT7nVD+nqddR4E5BXq7Wy++MEwYM8wjTe0wSep7FvD8xj+93
0V7KZHOBn6NFR38HgqtHsOR3UO/N4ZFSnGIO2BF//OTSbvIil8uI+3wuLTAmUanz
zAOfi1OK3JI/z2SJ7bleAfdDdGKTfUuzMB0JxuxT1DmuIvr8z0d8GJluyE4TLg1Q
muW2s0PNw1Dx8CJ+p+bBNpIx0kMw7UNaxzfRCjiVX0tPTHqHd7Kc9cqDwFmbq7R+
HTC9ouhzK3VD9L6GlgmzWiEO/ocYFFBUULobRlmfSVKxiyk+iGyfXzbuj5kCusu3
dDX0smN5BK0JbRJzd3xfaa2WG7QMm4g/BHRDaxj4RCDIGlzYLRZAlZVgRDpNhaZe
6Lsd7HmA6nLSbBdadR9dFIKbD8q5aO/4lsac60v0qiyB10K3ESCIXHqzSIwlm41j
FR+gYiMYrxicS8SO5bUt/QFfn4kquKSQ0nySrF5q41ADnmzG/FnZOrxoTJe0iogQ
UE22yRnmivPaCqI4pY4+eQL5sHDPKEdQ1X5iVGmL8AyhiXzYcMs=
=UZMN
-----END PGP SIGNATURE-----

--YojVtPGxfetKYDcd0c6T1PJTFY7jBWnuo--

