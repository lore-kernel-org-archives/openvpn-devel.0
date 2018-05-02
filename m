From: Jon Kunkee <jkunkee@...2393...>
Date: Wed, 2 May 2018 23:15:47 +0000
Message-ID: <DM5PR21MB0185BFF553A864FE338B6EC9B0800@...2394...>
References: <DM5PR21MB0185FC110A99E76426A1603FB08D0@...2394...>
 <9fb8c0a0-b1d1-2834-dd42-d0abece8529e@...515...>
 <99D61A626FDA8A4B90A270669121BE10862E0950@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10862E0950@...2294...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN on ARM64 Windows
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
To: Simon Rozman <simon@...2293...>, =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Marc Sweetgall <marcs@...2393...>

Hi Simon,

What system are you using to generate MSIs? Marc (CC'd) has a
patch for WIX that adds support for generating ARM64 MSIs.

Are you wrapping two arch-specific MSIs in an EXE, or doing one
mixed MSI? Two MSIs will be very simple to add ARM64 to, while
one mixed MSI will be harder.

As for tapinstall, a standalone tapinstall under VS2017 will work
perfectly with what I'm building since the EWDK consumes the
vcxproj and sln files directly.

In other news, I should have a groundwork/cleanup PR ready today!=20

Thanks,
Jon

-----Original Message-----
From: Simon Rozman <simon@...2293...>=20
Sent: 05/02/2018 9:36 AM
To: Samuli Sepp=E4nen <samuli@...515...>; Jon Kunkee <jkunkee@...2393...>; =
openvpn-devel@lists.sourceforge.net
Cc: Marc Sweetgall <marcs@...2393...>
Subject: RE: [Openvpn-devel] OpenVPN on ARM64 Windows

Hi,

> We intend to switch away from NSIS to MSI packages. I believe Simon
> already did some work in there but he was rather busy for an extended
> period of time. But now he is back, so migrating away from NSIS might make
> sense at this point. Thoughts Simon?

I have already started working on it. I am writing a tapinstall.exe utility
from scratch. I am using Visual Studio 2017 for building, so this is pretty
much inline with what Jon is using. Otherwise, the utility will be quite
simple to build using a Makefile approach too, so it could use existing TAP
driver build system as well.

Regards,
Simon

