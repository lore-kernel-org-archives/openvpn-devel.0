References: <20181011184200.22175-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <aeffe81c-4261-bb68-fdfe-628fa5f6d232@...2181...>
Date: Fri, 12 Oct 2018 02:44:33 +0800
MIME-Version: 1.0
In-Reply-To: <20181011184200.22175-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fK8Gai9WoalMS2pKV6Q3BJ4KRmNfrEXib"
Subject: Re: [Openvpn-devel] [PATCH v2 0/7] introduce networking API and add
 netlink support for Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Antonio Quartulli <a@...2181...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fK8Gai9WoalMS2pKV6Q3BJ4KRmNfrEXib
Content-Type: multipart/mixed; boundary="VMRuuniC1nBICyQyel1wxm06CaxKAiO6g";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Cc: Antonio Quartulli <a@...2181...>
Message-ID: <aeffe81c-4261-bb68-fdfe-628fa5f6d232@...2181...>
Subject: Re: [PATCH v2 0/7] introduce networking API and add netlink support
 for Linux
References: <20181011184200.22175-1-a@...2181...>
In-Reply-To: <20181011184200.22175-1-a@...2181...>

--VMRuuniC1nBICyQyel1wxm06CaxKAiO6g
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/10/18 02:41, Antonio Quartulli wrote:
> From a high level description of this patchset, please refer to
> "[PATCH 0/4] add netlink support for Linux" sent to the mailing list on
> Apr, 20th 2018.
>=20
> Changes from v1:
> - introduced opaque context object containing implementation specific
>   state;
> - fixed env passed to ip command (thanks to opaque context);
> - rebased on to pof latest master (00d78cd5)

The last rebase was on top of ed31cf2a

Regards,


--=20
Antonio Quartulli


--VMRuuniC1nBICyQyel1wxm06CaxKAiO6g--

--fK8Gai9WoalMS2pKV6Q3BJ4KRmNfrEXib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu/mhEACgkQ9FVsWUWD
Dm0HwhAAhZM2xmMVYJDLHGeiGmwe4jzp4FOo4ietLwA2uB/DRFqRXVdnb1V2BdZS
pnPHkXDcHBK9gPEF71UgVL1bIdSxYZl2DG1rs05TCpclMwaeeMtj3SZxed8SOdJJ
9dWslMNSW/yfW8ovw9uMiaS+BxQmU2eAxMaLUiQvfsh43Yhi8jxRNv9qWm4YLFhw
Fk+Tm6+CSJ9z7q/rK/SP3c2oIt7u9x9+VdYCg5+Qe8Fw7wn/nFTT7L5Zru3UxDBL
MsIJRJd/+K8U/bWGCwf/+iKoRQZ7cSgmpaog1F5XsWd/CGdjHW3mQ+5kuyK4Dbdu
n3S2D99IIu7H+DdxAiGPMaLr98/dinnT5CPZDVy7g6nM22T3tXC3LoFJ2fquwaE0
qjmhieUSCg9v8LLL2/KsuaFWp8dF4uBHYmaga86qsEPy2HsWl0g2wFKquZAXLrTw
hr8BAPVGionIAv4LLMS0ozbyjz32KWtv/ljGX7lbd25iN+fcjrd2tAQ8gTejuUzl
SJaUL1mWGz5lzr6F/ocNOVZ0H9+7J50s+3Zbz3CW3FbsRtUYzyD/GL8PPTZK4914
LqX1heAFsvjrYJSEeyHyzCRUWcj3nwehD/BJKRGJULqqpv/FIYNBcSqNiymkqFDr
83VfYAWUNiXDy9xnGPDsF1rV+o3t6AdkNvdU0RPhyCP5V2Y0dUc=
=gYM1
-----END PGP SIGNATURE-----

--fK8Gai9WoalMS2pKV6Q3BJ4KRmNfrEXib--

