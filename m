References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
Date: Tue, 28 Mar 2017 14:11:26 +0200
MIME-Version: 1.0
In-Reply-To: <668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QMDxbJs04gdtIMODl6PQoW7rd0IjIA1d8"
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QMDxbJs04gdtIMODl6PQoW7rd0IjIA1d8
Content-Type: multipart/mixed; boundary="kTDfLHle4t4deiDgcN00dPgL3eugg6mxH";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
	"crypto.c:823:32: error: invalid application of ???sizeof??? to
	incomplete type ???cipher_ctx_t"
References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
In-Reply-To: <668fd081-d9b4-1727-f506-07395cf0b475@...1435...>

--kTDfLHle4t4deiDgcN00dPgL3eugg6mxH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 28/03/17 10:39, Steffan Karger wrote:
> Hi,
>=20
> On 28-03-17 10:33, Emmanuel Deloget wrote:
>> =E2=80=8BI should be able to push a new version of the remaining patches=
 in the
>> foreseeable future (let's say today or tomorrow, because I will be
>> unavailable at the end of this week).
>>
>> I found a solution to overcome the big X509_check_purpose() issue, so
>> now I'm able to propose a solution that does not change the behavior of
>> OpenVPN.
>=20
> That's great!  This way, 2.4 does not have to change it's behaviour.
> Still, I think it makes sense to deprecate --ns-cert-type, and remove it
> in favour or --remote-cert-tls in openvpn 2.5.

Based on the feedback and discussions in Fedora regarding to us removing
--tls-remote .... I actually think 2.5 is too early.  We need to have a
patch very soon complaining loudly in the log files and get in touch
with at least NetworkManager guys to ensure they have time to implement
a solution when this goes away.  So I think 2.6 is more realistic.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--kTDfLHle4t4deiDgcN00dPgL3eugg6mxH--

--QMDxbJs04gdtIMODl6PQoW7rd0IjIA1d8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY2lLuAAoJEIbPlEyWcf3yGIgP/AqE8cGj0DAkTVr2fdg7rVTD
kOswSytRT8cwK4/ysLhTJ1pisr5e8zFqTt58X82euZgx3Jrazt0LOWSP11bMmhND
GoPJ2bMX0uCP/6PKCP1rQ8Efb31OZI/yHby3RitR2DnvrOsO9gwguYFRQl1ucDL7
wY1iH29oYwAklJHBpZ1P3i9LzjGkPc/uvKfoG1dQM0O4zFxdyO5MJ85i2xhtGjwt
ya71ZYWOIslCO3BwJeWEoPri38d+NeV7KDpOPQNrbikLMrUwFSNfFJn4TPM7jtTk
Zqvpo+jCVGqdmhs9mg1IAgxp8IuRHO45Wl12U0KQgJKoTO0/8MvA28N0mJ/QKglb
PW/XCWE0dPL3Sw7Obm5GeMSosGJBvEtPTjERMknOmPcYMi1mlWui3r1SswIS+F52
BqneTLyPTsT/iddX6G7eyMMK25nJI1om9vMVdhtsH8bZFzle2ZYDO8SkyGlCSBgX
a8Ro9qbPlQX0QRdQ9i3pq5oFE2mUh2dRgmdCK4wERKIQjwP180zkOynqmWoGvoc8
asj/KU2PgCOjMLyFYkLEKZ0gMgrbM02c0SSn1OUdo2LEajqrChdltTgGR5RXChIL
buuBOKkwdZX6s0OJAzepl636wHyARLvVMOCvWXeHI2u074QA4NWzxU2mnO5jmDcp
zRJpUvw31bXO1Vg8cMK3
=1/8k
-----END PGP SIGNATURE-----

--QMDxbJs04gdtIMODl6PQoW7rd0IjIA1d8--

