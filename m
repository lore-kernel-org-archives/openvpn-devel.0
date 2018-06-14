From: Jon Kunkee <jkunkee@...2393...>
Date: Thu, 14 Jun 2018 20:43:55 +0000
Message-ID: <DM5PR2101MB11127F120677A779CB43A8D4B07D0@...2412...>
References: <99D61A626FDA8A4B90A270669121BE1089628FC9@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1089628FC9@...2294...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] tap-windows6 and AppVeyor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>, "chipitsine@...277..." <chipitsine@...277...>
Cc: =?iso-8859-1?Q?Samuli_Sepp=E4nen_=28samuli=40openvpn=2Enet=29?= <samuli@...515...>, "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

As I read the license (IANAL), consumers of the EWDK can copy, 'install', a=
nd run=20
it pretty much anywhere in support of building software for Windows, just n=
ot=20
as a public download.

A 5GB download is prohibitive, but do note that 'unpacking' is as simple as=
=20
mounting the ISO file.

-----Original Message-----
From: Simon Rozman <simon@...2293...>=20
Sent: Thursday, June 14, 2018 10:35 AM
To: chipitsine@...277...; Jon Kunkee <jkunkee@...2393...>
Cc: Samuli Sepp=E4nen (samuli@...515...) <samuli@...515...>; openvpn-devel =
(openvpn-devel@lists.sourceforge.net) <openvpn-devel@lists.sourceforge.net>
Subject: tap-windows6 and AppVeyor

Hi!

Given all the recent updates to tap-windows6 building process, the AppVeyor
integration needs an update too.

Now the Microsoft EWDK is used to build the driver, I wasn't able to find
any such build environment on AppVeyor.

If the EWDK licence allows us, we could put EWDK online and have the
AppVeyor download and unpack it before build. Although portable, the EWDK is
5GB making this option far from ideal.

Or, we could politely ask AppVeyor to introduce an EWDK building
environment. :)

Does anybody have any idea how to address this challenge?

Best regards,
Simon


