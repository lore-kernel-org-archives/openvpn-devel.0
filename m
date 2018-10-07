References: <20171110163946.7656-1-fkooman@...2318...>
 <20181007071059.GX962@...1296...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <c21e083b-351f-f590-efed-99724f6baf2d@...2318...>
Date: Sun, 7 Oct 2018 21:57:49 +0200
MIME-Version: 1.0
In-Reply-To: <20181007071059.GX962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dwuldGPRZKPnzdFrlylGWWtP7D7O1LV4L"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dwuldGPRZKPnzdFrlylGWWtP7D7O1LV4L
Content-Type: multipart/mixed; boundary="x5InKQPkuaSBwxFDEprfz7FXBSJqyydgH";
 protected-headers="v1"
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <c21e083b-351f-f590-efed-99724f6baf2d@...2318...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
References: <20171110163946.7656-1-fkooman@...2318...>
 <20181007071059.GX962@...1296...>
In-Reply-To: <20181007071059.GX962@...1296...>

--x5InKQPkuaSBwxFDEprfz7FXBSJqyydgH
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/7/18 9:10 AM, Gert Doering wrote:
> Hi,

Hi Gert,

>  - most voices argued for "do not require an external library"
>    (for *creation*).  Not sure if we managed to convince David in=20
>    the end, though :-)

In the meantime I had some "great" experience with manually generating
JSON in another project. That was a terrible mistake ;-) So I would not
recommend following this path any longer. Maybe not even JSON, but
something typed and/or even binary.

> ... but then it just died off, and the patch is sitting in patchwork
> (where I moved it to "changes requested" just now).
>=20
> Is there interest in moving forward, or shall we just let it go?

I'm not really interested in it anymore, and I brought it up ;-) So if
no one else is interested, maybe better let it go...

Cheers,
Fran=E7ois


--x5InKQPkuaSBwxFDEprfz7FXBSJqyydgH--

--dwuldGPRZKPnzdFrlylGWWtP7D7O1LV4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYje68UGKkH2qmOqnnF7dZFpXHrIFAlu6ZUAACgkQnF7dZFpX
HrKpcBAAkR/BWGuekgZrWcWHBlTXwocD0+DyoXu0UinP0Bh48pGSCniI6+eTMxMx
Y4CuRCG4CvdJvqczIcues8iuuMOVyKonds6ijkMbSXsqFkSOyUrW4cQEjVEEvdLT
F8eQuGXO4a2vCeN/YgXqgiCcrUHA8VV3tWvceyX7/V/qOKw3/H2b2AYmYKxQa0kQ
LdCwqLPAHSBeNbZmY59v5lPlZydhMvS8U4gRzS/tSNRWmf4Py8j6H/iv2f/bvW2A
LDstsnc5DVcQ6hSiLWzQ5StiVN4zIdRyDjiPxWasiiQaLMyS/O7NkTnLlOfyqhnJ
SBPjmSvC7tIMget88qzD7ABhp6qTuRfUv7GtWls86shHHF8JptfXjh99WeazwmPx
+apFktzWDMKl16HPJ/grFlZ3XOTmfmcPb8I29pIGcQDoiT2gjzcu0vq7jfRPDcee
EGNWiIP+wqJi3GtGR9TbeH7KaiAeYXN6Qzi6fHf/CB354NMFXNVTOv7aX/ZH5BaI
MOPaXk6Mnbsx+jvp//NXtgdTvdi7rAYXbgsGUYDEGILqmA+Yn/DPQS21z6OSqz89
S2B++hY7GboNv7s+9Qqrxdi/gGv0wRuRuftxCq7M9InTGsmzXbiIdCc9Rl5Rcz79
LVucwNT64TH64IJPwXa//rBEBxfWFIVYakYzK8O1+kYeEfDUai4=
=b/25
-----END PGP SIGNATURE-----

--dwuldGPRZKPnzdFrlylGWWtP7D7O1LV4L--

