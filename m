Date: Mon, 24 Jul 2023 15:02:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZL52U58dke6j6SkA@...1296...>
References: <CALn4OiNv11FHk6ZhahbUYZPa15AW53H7C85Awi+qrtgeVRPm1Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oBRfARP/9OmAJJCJ"
Content-Disposition: inline
In-Reply-To: <CALn4OiNv11FHk6ZhahbUYZPa15AW53H7C85Awi+qrtgeVRPm1Q@...278...>
Subject: Re: [Openvpn-devel] Porting OpenVPN Problems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Swan Geon <swangeon@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--oBRfARP/9OmAJJCJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 24, 2023 at 03:43:17AM -0500, Swan Geon wrote:
> I am trying to port OpenVPN to Haiku OS and I am currently having an issue
> as I run this test command from the PORTS
> <https://github.com/OpenVPN/openvpn/blob/master/PORTS#L73> file `./openvpn
> --remote 64.233.160.0 --verb 9 --ping 1 --dev tun` as I get the expected
> output (comparing it to Linux at least) until it just hangs on the line `=
I/O
> WAIT status=3D0x0004`. I am not sure if this is a problem caused by the
> driver I am writing or OpenVPN not being able to run the do_ifconfig()
> command that has a TARGET_HAIKU definition and I wanted to ask you all
> about it.=20

Well, it would be helpful to actually see the few lines *before* that -
so we can tell you what it did, and whether it's ifconfig or not.

> Here
> <https://review.haiku-os.org/c/haiku/+/6608/15/src/add-ons/kernel/drivers=
/network/tun/driver.cpp>
> I have the driver source code, here
> <https://review.haiku-os.org/c/haiku/+/6608/15/src/add-ons/kernel/network=
/devices/tun/tun.cpp>
> is the interface source code, and here
> <https://github.com/Swangeon/Haiku-Openvpn/commit/9954e48fa35dcb4f77fe088=
63b1d12f0f3e29b72>
> I have a forked version of the OpenVPN source code where I added the
> definition for the OS and info on how to do the ifconfig command on the
> system. I know that UDP sockets are working normally within Haiku since I
> can switch the line `--dev tun` to `--dev null` and it will work just fin=
e.
> One problem that I think might be there is that it's not setting up a tun
> interface properly and/or it might be going off of the assumption of a
> Linux driver where the driver and the interface are the same when in this
> case they are two separate things.=20

It's always "two things" - one is the interface that the network stack=20
sees ("ifconfig tun", route, etc) and the other is the file descriptor
that OpenVPN uses to receive packets from the tun interface, and send
packets back.

You need to find out how tun interface creation works on your system -
on some (FreeBSD, for example), the program just does open("/dev/tun3")
and magically a "tun3" interface is created, which can then be configured
with "ifconfig".  On Linux, it's slightly more complicated, and on
Solaris it's very very complicated.

So before adding code to OpenVPN, you need to understand how tun interfaces
are configured and created on Haiku.  Is there a manpage ("man tun")?  On
FreeBSD, most of the questions are answered in the manpage...

> If I manually make an interface using
> ifconfig, it still doesn't change where it hangs though interestingly
> enough if I set the address within the command to that of the interface,
> then the interface will respond with `read from TUN/TAP returned 44`
> followed by `Recursive routing detected, drop tun packet to []AF_INET]
> 1.1.1.1:1194` 1.1.1.1 being the address of the interface but only once and
> that's it. Maybe I am confused about how that specific command works and/=
or
> I have something set up wrong somewhere down the line. I know that this is
> a complicated issue with many facets and I am new to OpenVPN so I'm not
> super sure how to debug it currently so please please be patient with me
> and ask questions so that I can do my best to answer them.

"recursive routing detected" will happen if the tun interface receives
a packet destined for the VPN gateway - which must not be sent *into*
the tunnel, because then there is no way to send it "out to the Internet".

This will become a relevant question when you go into "redirect-gateway"
land.  Start first with a dedicated VPN subnet ("10.8.0.0/24"), which=20
uses distinct addresses from "the VPN server" and "the LAN interface"
(on all machines involved).


If this is all voodoo to you, then you'll need to make yourself=20
comfortable with "how does openvpn work?  what does it do?  what should
be in the log files, at which point?" on an already-supported platform -
starting with too many unknows at the same time will not give you
satisfying results.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--oBRfARP/9OmAJJCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkvnZTAAoJEB2Cnv7KVigS6cAL/1PTSD+8RCWsEZsAxCGLzx55
/CprYrxKMWfCvpxMyKFV0UIDXgWVOHVDo8ykcnjRXCNjPeksOKp8Uw/N+5eWIfvC
cL6TPfQs3EaHOZlholUKJrqykiobtyNs6hiX1wCoTb7HKM0MIAeh9FWhgMPOdK0I
FeemyzuiJ+aRLxMAhnbPjijtocVxwv0Ptb72a9KgnJHUrOFlkcFxUGgoWDnapoaJ
qtwjcOrIz9zZgPO4bbvWHXdRr/xoycMHtv+DcwSMvtOoE7bhSOLa/LwS8z7mIhgL
zyJUSEvK/8cx1lICh1L2wOHrPcLn5VAq8UsFfzqop7wSHTvW4/Pb50to4PKu/lY4
iaZvrxd+oleugYyXxg8DHYZtlmjTmzIvQrHM3VW+BmVUBLquQTlYHzvyN+vatETN
BX5sVNRjKk5NX4CoRKKYzk83oFMAWD1fNCXKuOk3kQ8xEJD9JKVO9LqhyDSUIvxC
t6axAIOjjiGtc2wwnAKbAiR9GiP2idcyEGrdAbZahg==
=6LPp
-----END PGP SIGNATURE-----

--oBRfARP/9OmAJJCJ--

