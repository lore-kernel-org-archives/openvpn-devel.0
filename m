References: <99D61A626FDA8A4B90A270669121BE1089628FC9@...2294...>
 <DM5PR2101MB11127F120677A779CB43A8D4B07D0@...2412...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <431d0dae-f48c-a550-a2fc-5e9ec78206e7@...515...>
Date: Fri, 15 Jun 2018 09:28:09 +0300
MIME-Version: 1.0
In-Reply-To: <DM5PR2101MB11127F120677A779CB43A8D4B07D0@...2412...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] tap-windows6 and AppVeyor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Jon Kunkee <jkunkee@...2393...>, Simon Rozman <simon@...2293...>, "chipitsine@...277..." <chipitsine@...277...>
Cc: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

Perhaps we could make the ISO available as a network share?

Il 14/06/2018 23:43, Jon Kunkee ha scritto:
> As I read the license (IANAL), consumers of the EWDK can copy, 'install',=
 and run=20
> it pretty much anywhere in support of building software for Windows, just=
 not=20
> as a public download.
>=20
> A 5GB download is prohibitive, but do note that 'unpacking' is as simple =
as=20
> mounting the ISO file.
>=20
> -----Original Message-----
> From: Simon Rozman <simon@...2293...>=20
> Sent: Thursday, June 14, 2018 10:35 AM
> To: chipitsine@...277...; Jon Kunkee <jkunkee@...2393...>
> Cc: Samuli Sepp=E4nen (samuli@...515...) <samuli@...515...>; openvpn-deve=
l (openvpn-devel@lists.sourceforge.net) <openvpn-devel@lists.sourceforge.ne=
t>
> Subject: tap-windows6 and AppVeyor
>=20
> Hi!
>=20
> Given all the recent updates to tap-windows6 building process, the AppVey=
or
> integration needs an update too.
>=20
> Now the Microsoft EWDK is used to build the driver, I wasn't able to find
> any such build environment on AppVeyor.
>=20
> If the EWDK licence allows us, we could put EWDK online and have the
> AppVeyor download and unpack it before build. Although portable, the EWDK=
 is
> 5GB making this option far from ideal.
>=20
> Or, we could politely ask AppVeyor to introduce an EWDK building
> environment. :)
>=20
> Does anybody have any idea how to address this challenge?
>=20
> Best regards,
> Simon
>=20


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

