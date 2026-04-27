Date: Mon, 27 Apr 2026 17:56:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ae-HJXDIfzSo7zMa@...1296...>
References: <20260421055357.21708-1-gert@...1296...>
 <202604271511.63RFBxFs078611@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/K6nDCtXW/P3xJXO"
Content-Disposition: inline
In-Reply-To: <202604271511.63RFBxFs078611@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Mbed TLS: Error out if we
 have no valid tls-groups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2918...>
Cc: openvpn-devel@lists.sourceforge.net

--/K6nDCtXW/P3xJXO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 27, 2026 at 05:11:59PM +0200, Gert Doering wrote:
> Haven't tested this, but the change is quite obvious, and it's only
> error handling in a particular niche case, so "reasonably safe".
>=20
> Your patch has been applied to the master branch.
>=20
> I'm not sure we need or want this in release/2.7 - you or Arne tell me ;-)
>=20
> commit b2e3e0f0cf21a712b96efb8c053b740ca1947f54 (master)
> Author: Max Fillinger
> Date:   Tue Apr 21 07:53:50 2026 +0200
>=20
>      Mbed TLS: Error out if we have no valid tls-groups

Arne told me, so here we are...

commit 573ccf82e90f03de3d65fb26aac9310a25c3e4ec (release/2.7)
Author: Max Fillinger <maximilian.fillinger@...2918...>
Date:   Tue Apr 21 07:53:50 2026 +0200

    Mbed TLS: Error out if we have no valid tls-groups

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/K6nDCtXW/P3xJXO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmnvhxwACgkQHYKe/spW
KBLGgwv/dBIdThoAxOCCY1PPXfdI5RmtTAxSKWe1bmjkxB8L06OnhnPVFRfwlhMw
B2eVYXhToZqYJMBzic0GIC7qywWUd8/b3lK1hW7ikuc/yq73H8RJOoVm99YPLEQK
M0CaQFrv2NKy2W97iA9OVrltjEYwH2KVfBpHlE5UhWJn8LMFqWUMcRwAaOgtqxf4
JbaFtU/Od5gsHSYlh2dzlJ5o2I/9PsGU77Z2LmmOFGWlxruMc18WaZkCO0fe/Qzc
yJRTGMzQkdNiRPTXenT0YUu6Q+JtJDPSQK7KaQBmjTvuanSxnidLK9qeftmabYbj
Ou19UEG5gvZ9uu6EEifsC0FW6DpJeUwPnlVRZ9eW5/9ZYrvAY6W1kgM5eLFOJqYn
Loj5ZFN5D5Ji/CCDPvQInLYgxsFHpJoSv08JjiQMy8C3uNou6j897upbG21ckLKi
lhvRHwTFvkPXeep7I8g8vm88My+dD46VLTewaJFT879xTpfUqrOQrFA1ExBnnKnL
sZ36LUfz
=edR+
-----END PGP SIGNATURE-----

--/K6nDCtXW/P3xJXO--

