References: <CAFHpkQFzZRLQhOTqoOakUuwUURo4=-Jf-FPiYfi-de86=6Q1Pw@...278...>
	<4bf6ce6c-ab68-d5b1-cd79-fb6e0dad2ffd@...1856...>
	<CAFHpkQGC8kRpVLE=2vBAYpEMkh+=VTqy_VTqfbWdhsOOr-GGUA@...278...>
	<f077c965-a063-5f11-f298-2fd551ae4f95@...1856...>
	<CAFHpkQFaUZTSEZLU02najYjtKNye6L=kEN0051q9TTCMzVeOnQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9289cd67-1aa4-7895-6404-5444ef5fc283@...2080...>
Date: Sun, 6 Nov 2016 23:18:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFaUZTSEZLU02najYjtKNye6L=kEN0051q9TTCMzVeOnQ@...278...>
Subject: Re: [Openvpn-devel] any reason to not adding tap-windows.h to
 https://github.com/OpenVPN/openvpn/tree/master/include ?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/11/16 09:19, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2016-11-05 15:53 GMT+05:00 Steffan Karger <steffan@...1856...=20
> <mailto:steffan@...1856...>>:
>=20
> Hi,
>=20
> On 05-11-16 11:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>>=20
>> 2016-11-05 13:08 GMT+05:00 Steffan Karger <steffan@...1856...
>> <mailto:steffan@...1856...> <mailto:steffan@...1856...
>> <mailto:steffan@...1856...>>>:
>>=20
>> On 05-11-16 06:52, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>>> I'm geting "build only" travis-ci mingw cross compile config=20
>>> and I came to idea that I do not understand why "tap-windows.h"
>>> must be downloaded separately
>>>=20
>>> 1) if we use some functions, we should include prototypes. it
>>> is not very common to download prototypes from different
>>> location
>>=20
>> When using external dependencies it is *not* a best practice to
>> include the headers of that dependency (or even worse, binaries)
>> into your own project repository.  I haven't seen any decent C
>> project do that.  We wouldn't include the OpenSSL, mbed TLS or
>> even libc headers either, would we?
>>=20
>> we include cmocka as git submodule. if such an approach is
>> acceptable, we can use another submodule (to tap-windows repo)
>=20
> Yes, which I'm still wondering about whether that was the right
> choice. Using configure might have made more sense.
>=20
>=20
> I would really like to hear the reason of "ACK"ing cmocka and "NOT=20
> ACK"ing tap-windows

CMocka got an ACK under doubt, because it is only useful for the git
tree, is not easily available on several platforms we run tests on and
is *NOT* distributed in any way when we create the final release
tarballs (make dist or make distcheck).  If CMocka becomes reasonable
updated all the platforms we have configured in buildbot and the
CMocka release is reasonably up-to-date on all those platforms, we
will strongly consider to kick-out the CMocka submodule.

The reason NOT to include tap-windows driver in the OpenVPN core tree
is that it is a specific driver for a specific platorm, while the
OpenVPN core is multiplatform and generic for the VPN tunnel itself,
and by design it expects a TUN/TAP driver/interface to be available.
To say it differently: We do not include the tap-windows driver as a
submodule for the same reason we don't include the tun.ko Linux driver
as a submodule, and also not the utun driver for macOS.

With that said, we used to have the tap-windows driver in the OpenVPN
core tree.  But it got quite awkward when we had updates to the
Windows driver and had to spin a complete new OpenVPN version for all
platforms.  That could be handled somewhat differently as a submodule,
but currently we see no big overall benefit of doing so.  *If* we
realize that this should change, such a discussion will not happen
before the final OpenVPN 2.4 release have stabilized.  But as things
are right now, those chances are small - we're fairly happy how the
source tree is organized, the organisation is mostly out of our way
and we figure out things quickly.

Which means: changing this isn't something which will be prioritized
in a long while.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYH6wxAAoJEIbPlEyWcf3yusQP/31vDIKtET6Qai7TMMvRAsS2
avQEbXWum1tJhOlRrSJJPEqRm9KEZ75eAmtyO+5BDxnBSAQjiL9y2Q8yn5P202/r
zIdjw6c80FUQf7eXSlo0GMmUH+dLTeVjqhmglU178eosjzpjGnFRpfoPffCaQCac
m7qsTFhvBLk5NBE/IUoLwiGxA7b7Pudt4PT8zrlShxOzpsQaG0PuObefF4DggYx8
ngjv/SafytPNUiRZHDmH8AILJbJ9vg4eh1188iigZqQsnUIVFmcaDE7qkZwFu/0M
/z9BLI+4qtM8Q5xV9/+jo6wviPe7jz3l3Ukxr/wUnTBuxYue9jCOMVE/MSH6Xq5z
oMZ2gcRYqG550xjtRJ3goq6wjwyENVZ/uUEzjsYs80EPOWBZU8gUX47+dYJUkypD
zxiwgVEWp9pB2GAsF5ek2ERnMTyV6dR92Cuza3ppvUob6sy1AYLc+fdaKbG9LTCO
TufhR6ryidknq2wb8l1/s7lq6Sc8fufAlrkrfggTOm6qmw+FP4c5gnopMop8jy1B
UPFJmoy6Yton2MeKoLiJVRFUBCT6Gi1tkyx9PDG2dcpH0lNBalJ2zOakJrO5ncvV
hZuuc94h9RjgflR3MG/JHdKiT9Mu2A0x92sBeydZ3zNIUeQx2tcnr6/mKPNU4bDV
MZinmX+F5HNotju0WtZP
=3DFbyk
-----END PGP SIGNATURE-----

