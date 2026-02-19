Date: Thu, 19 Feb 2026 13:19:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aZb_wOvGBMcaw5aQ@...1296...>
References: <20260218214437.26912-1-gert@...1296...>
 <202602190918.61J9InJI029898@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6g3E0cJ4kOpuvT+c"
Content-Disposition: inline
In-Reply-To: <202602190918.61J9InJI029898@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: ntlm: fix discards 'const'
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

--6g3E0cJ4kOpuvT+c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 19, 2026 at 10:18:49AM +0100, Gert Doering wrote:
> thanks for this.  So *this* patch only goes to release/2.6 (because the
> NTLM code in release/2.7 is different, and there is no more NTLM code
> in master)...
>=20
> Your patch has been applied to the release/2.6 branch.
>=20
> commit b5087dcf3fe3d4aa226dd3e727991bfe8a3a5efb

Too many patches, too many branches, sorry - for whatever reason, "git am"
was not cooperating, and I did not look in the right place, came to the
wrong conclusion.  Of course this needs to go into release/2.7 as well

commit 18b38ffc69f8ad96c2b3d7b86bd0eec015ffc376 (release/2.7)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6g3E0cJ4kOpuvT+c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmmW/V4ACgkQHYKe/spW
KBK1MwwAtFceslgAbuDuSumZ3gpykQ61ckTPwRX4KiXwi1fL+YJRYiXNxaTJKcxq
rMKGS52VzQq7GJluYNB6Fu5F0A/a6R+6r07axNnwcjiJah1IsRDkTpTgKhLtMxAj
0JIAijoyLlrQ5InMVLcxDSTKEyeuzzMjuz2p14YqJzUZlz1U9yUMuRpySCXVmOWd
lremkI7ea/9crYHxmhNhIzadHvOW2K+AcmeHTPfuavlNr9pDJAU2jxfBLipPfWqw
DrS1WCM2n+tpEUumcKN9moUnOvMgq951o3CjmGziXMTnLUPg42mUnEgyeCwa9abE
FMwBH0USCgXtg7pA421fYwkUtSEPsfbx0amHpIqUmDTv+F3KTfH2rWAjWZyvhrNh
10Q88QIE/f/yY5jC1ff83U8vF/rr7E+6QHYekmSRuzEQZCyQOkBSrpC/ujzB67dU
MfgXgR0dGaKglkUtxOpfizA1JchQTo0cOqJIGrjpYp48SevzpBrpLKbFbfVu3fRk
qdNOfhcu
=bEus
-----END PGP SIGNATURE-----

--6g3E0cJ4kOpuvT+c--

