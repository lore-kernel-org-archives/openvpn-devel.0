References: <1571304533-15614-1-git-send-email-lstipakov@...277...>
 <25c5ecd5-cd2c-1867-07ef-bcc90327cc73@...2318...>
From: Lev Stipakov <lstipakov@...277...>
Message-ID: <1093a271-04e6-5f7d-4e13-96d40551a1f9@...277...>
Date: Thu, 17 Oct 2019 15:10:10 +0300
MIME-Version: 1.0
In-Reply-To: <25c5ecd5-cd2c-1867-07ef-bcc90327cc73@...2318...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lRxdf8n47KujKqVxPBKHneMLEx371YUrM"
Subject: Re: [Openvpn-devel] [PATCH] msvc: OpenSSL 1.1.0 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lRxdf8n47KujKqVxPBKHneMLEx371YUrM
Content-Type: multipart/mixed; boundary="sxLv2IHiEvlYpK3ojf83nzVuzgGtYwS6C"

--sxLv2IHiEvlYpK3ojf83nzVuzgGtYwS6C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Fran=C3=A7ois,

Fran=C3=A7ois Kooman kirjoitti 17.10.2019 klo 13.39:

> "Version 1.1.0 will be supported until 2019-09-11" [1].
>=20
> Is there a plan to update to 1.1.1 for the Windows client?

Indeed, there is probably no reason to not to switch to newer version.
We'll include 1.1.1 into the next release.

This patch works just fine with 1.1.1, but I'll send v2 which states
that it supports 1.1.x instead of 1.1.0.

-Lev


--sxLv2IHiEvlYpK3ojf83nzVuzgGtYwS6C--

--lRxdf8n47KujKqVxPBKHneMLEx371YUrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEW3OHsN2W3CfLpAQqiGcL4li5wlgFAl2oWiIACgkQiGcL4li5
wlh2oxAAgxk0sZLfGDV2McZLq90dJK5yZwa96K83mKxXp5qjjlLjvjFruBC5Hgjw
sJkVq3h0yMgiCnDyH9T4P5o2lTBooRR6xYHXPxQCndcmW7yE8W+DVwtJe/QciUtS
T1NtdnMKJu1j5MWwqS3wXqk0dqw2/aPHd3ewgSv3/0s0vxHLkSSzXQ0a4LwRHQzP
+t0JSTjgon72ND6voBCcd5g/valjqHjolJDcMfzjNhQJ/MQGPMYtM5s5va9NE46Z
u8M+LUFBAgdcyMAC6PrttiRB7KMKxscQV9AU32ZeZApaXzd4QOrGCFMJ8vjtwZVY
KlSr3OeVqlrvUDaOn8rry+fvyA3PVvr8HzIxioQQduYEzhVomU1zKJzmRrhY9OfU
FZOxtQsTmiOnKFzESl9Y5pRDskQnpeh4W7MxysjLczBXsZXr5X2z0XU90iSLV0Oj
jsWHm1B1RMkXmXr28h5+2P1E01mEeGz4VcOaBPiHO46YCBb1sz95Se296CAgLuSJ
Q7vhCrDq44zzN+qMIf30zA/vBsdXR4mxsKLod4XPxI3ZR10aiev/ts+UzTC5aJ3n
qviZly6LA6sK5HfuopM71yiZYXq/ISx3rs38P5MkU0L4hpsX2oSLVCzlDdA2lfCi
AhegpuQPwEgY8t5NhoN0Ul5cYfz6/GKq9JvUl+HdV9z4vcbCuHA=
=mVPn
-----END PGP SIGNATURE-----

--lRxdf8n47KujKqVxPBKHneMLEx371YUrM--

