Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
 <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>
 <91ffd543-3f5a-e08d-ac89-379770b46b96@...2080...>
 <1f480b84-a0f8-a0a0-7bf7-0081e44d1c06@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8ead4ea9-44a3-8dee-523d-27e727ccebd5@...2080...>
Date: Mon, 22 Jan 2018 18:34:14 +0100
MIME-Version: 1.0
In-Reply-To: <1f480b84-a0f8-a0a0-7bf7-0081e44d1c06@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="os9U33Ajo2OgID0i6HYKzq0x5opUo3Ta5"
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--os9U33Ajo2OgID0i6HYKzq0x5opUo3Ta5
Content-Type: multipart/mixed; boundary="U413umgBFvvCxyvrVLbM1dlGVrVUUs34V";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8ead4ea9-44a3-8dee-523d-27e727ccebd5@...2080...>
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
 <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>
 <91ffd543-3f5a-e08d-ac89-379770b46b96@...2080...>
 <1f480b84-a0f8-a0a0-7bf7-0081e44d1c06@...1435...>
In-Reply-To: <1f480b84-a0f8-a0a0-7bf7-0081e44d1c06@...1435...>

--U413umgBFvvCxyvrVLbM1dlGVrVUUs34V
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/01/18 17:05, Steffan Karger wrote:
> Hi,
>=20
> Didn't we have this discussion before?  Gert basically NAK'd removing
> support for a library version in a dot-release, which I think is valid
> reasoning (even though I really would like to drop 0.9.8).
>=20
> Anyway, to fill in the facts:
[...snip...]
>> To me it then gets crucial that users needing openssl-0.9.8 have
>> access to a maintained distribution of that particular OpenSSL
>> version.  Otherwise, we're deluding OpenVPN users it is safe to use
>> openssl-0.9.8.
>=20
> SLES11 supports 0.9.8 upto 2022:

Ahh!  Sorry!  I once again have forgotten about the pesky SLES11.  On the
other hand, SLES 11 officially ends 31 March 2019 for normal users.  To rea=
ch
the 2022 date, you need cash out extra for a separate support agreement.

For RHEL something similar is also possible with RHEL 5. but we considered =
the
user base willing to do so to be fairly small - also as these agreements te=
nds
to be fairly costly unless you really have to.  SUSE wants to have a chat w=
ith
your before revealing any prices, so I can't tell if its the same here.  But
whenever sales wants to get in touch with you to go further, that is seldom=
 a
sign of a reasonable and affordable price.

Regardless ... we should probably document this once and for all more
properly.  Both for OpenSSL and mbed TLS.  We could add it to this draft [1]
and make that draft more official.

[1] <https://community.openvpn.net/openvpn/wiki/SupportedVersions>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--U413umgBFvvCxyvrVLbM1dlGVrVUUs34V--

--os9U33Ajo2OgID0i6HYKzq0x5opUo3Ta5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaZiCWAAoJEIbPlEyWcf3yAe8QALpUMJz7+GkO3XmSR3M4Syg5
xwyEIafKaKNAS7FYhm5+aLblQcBgQ7b1WwdYkDBB2obFaM2drFY28Hkj2bIoOJvW
5VKWOTinq5O9l5E/niNO54xPG628evasQwBRH0EwehxgWAQvMEJrTk33V97ZOZWH
1GDv2jN6BaiN8fb5q0hAWXSbgRcbInIbgZYW7Kzby/9pn9xv8IuH/yUImZ+HoX1p
hNk1WsZABFun5W9i0PT5HNWJMUoTlcHDg8L1EkS62VaJmMbH46NLD5c9dM3tp7Hz
5RJgSebN14G2cCweDPi43bYNXeukxnJ+5MkMPqZOL+FWrtMuIgeV0WFSkB4xHbgH
zjtLIa1VHSzoULb2oDEWSY2c6/CUwtffdL5U2uRbE4pPsydGUt6NkHb6n1kansZD
xzixAAcZHfNwiCtfu4Weq7gowUeNQygLKGSuRvfx0cY6T9uaJzQElRzIYucTmnr+
br1ymnMobMLIqB56WUdniIDhfHUj8H1JS/6TtstsAT5TpOxCjU0mBedRbdzlXr30
6mMYEiXFAUQtYOgcZy2Aa+jXjsZXUFxNpoW9jsburxh7dBqwcnQAhgRz53Rx/pbE
WE+gpKhxbl6CfagS70JWiCGuVzmEJ10YCwgDK30bKaWqsSXA+IbVW2mG2KhZP1rC
rkYP2qW8lyOtwew81O3O
=2w9M
-----END PGP SIGNATURE-----

--os9U33Ajo2OgID0i6HYKzq0x5opUo3Ta5--

