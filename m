References: <3dbe8ad1-b62e-3802-06a9-920c46616451@...515...>
	<20160907094304.GG78279@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f362e0a3-56ff-887d-c85e-dbad0d110109@...2080...>
Date: Wed, 7 Sep 2016 13:43:56 +0200
MIME-Version: 1.0
In-Reply-To: <20160907094304.GG78279@...1296...>
Subject: Re: [Openvpn-devel] Dropping Windows Vista / XP support?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/09/16 11:43, Gert Doering wrote:
> Hi,
>=20
> On Wed, Sep 07, 2016 at 12:18:17PM +0300, Samuli Sepp=E4nen wrote:
>> We have already dropped XP support from OpenVPN Git "master". I
>> think now is the time to drop official XP support altogether, but
>> to maintain Vista support util the next tap-windows6 release.
>=20
> Oh, regarding Vista support: I noticed that major open source
> projects (like chrome) have already dropped Vista support - so I
> think dropping Vista for 2.4 should be OK.

I agree.  I believe the majority of most users upgraded to Win7 from
Vista, as Vista was a slow giant beast compared to Win7.  Those left
on Vista are probably not the kind of users interested in setting up
VPNs - and if they do, it would probably be one of the more commercial
offerings than configuring your own client.

Put Vista and XP in the same "support category", which basically means
OpenVPN 2.3 and we'll see how long we are willing to officially
support 2.3.

I agree with Gert that we should at least keep our latest stable 2.3
updated with the latest OpenSSL libraries to protect our users, even
though we might not put much maintenance resources into the core
OpenVPN code.  Of course, we'll fix critical bugs and so on, but I
don't see that will take a lot of resources as things are right now.
Once we officially claim XP/Vista as unsupported, we can consider to
drop OpenVPN 2.3 completely.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXz/18AAoJEIbPlEyWcf3y1X0QAKf4hCniUrMjrzxb60Go+BsE
SSoaSUzXdBCaLWoIcvEoB6VEo2SqjdvwWYB+A0ZZ6zmwl6Koau66ai/AvwCQ25N6
+vHYpZyVTSTj8nQRvAo4pALu4ZpHgeQg4egkt1Aoih2Vrfu62fsE/I+b/ylUvH1n
Gfw5K0CSg4maKR6INyw8MDWiLvlSZqjbPvsb0R45abP8LAonKMA9E9TjA4gL1FlE
aczCtg4hMOVDgBDuHLwNr0uSO8v474/5ZXkTosCj7kf3nwqF1H8Oq8u3dqdSCqpL
ruBuqbpCYbCnlHgD+4r40dMPm03clF6tUjrd9m35clr/IclQ0tRArQ9cqMYVBM/2
EavHs6uQSG5Ryj8aosMdnthSbNGPzH+2aXwDxMfcAZlHnbDjHIFbZuWEFm1FfTrD
kEqMlFGriUhLalPYAAStBVJumUtRch7dEePE666RpEmW5Y/79OJNZzybcCkdAeMr
rODB3L279VXm1TBt1xGaZ+nVyoR+ex7zFvIVndohKvaXZ5SjzA3XeZy5++epNGdJ
HhMzyEck5Cq9pdZGyTjlhM4cYYvThGncShxZrP1IGZG3JpXw+zRRa6Yda9fDPVuy
I0ah0juFKgrUw2/Alyv+ogwJx49xJfFhZn0yw+LC2Ztkfw8R/+7cmfIyPUbutWN9
qEHlkciVHasSRO9t9BK9
=3DfKS6
-----END PGP SIGNATURE-----

