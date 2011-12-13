From: Tiran Kaskas <Tiran.Kaskas@...1530...>
Date: Tue, 13 Dec 2011 21:23:06 +0000
Message-ID: <A273A2F6519C0D42BFF02CA9C6A825112D0059EB@...1531...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
	<20111213211924.GQ18948@...1296...>
In-Reply-To: <20111213211924.GQ18948@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

The OS I am using is OSE166, running on Infineon c166.
I am almost done, seems that openvpn works fine on 16 bit machine, with som=
e fixes I made.
I will send all changes once I am done.
Anyway, if you pass such large value, it would be a good practice to set th=
e argument type to long.

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...]=20
Sent: Tuesday, December 13, 2011 11:19 PM
To: Tiran Kaskas
Cc: Adriaan de Jong; Gert Doering; openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function

Hi

On Tue, Dec 13, 2011 at 08:22:36PM +0000, Tiran Kaskas wrote:
> The problem is that the nl package was built with 2.1 version, and I have=
 used this.

2.1+nl patches is fine.  2.0 is not what you want.

> On a different topic: I found an issue, you probably want to fix that:
> In reliable_pid_in_range1() function, the third parameter(extent) is an u=
nsigned int.
> However, this function is being called by reliable_pid_min(), passing 0x8=
0000000u as the value to extent.
> On a 16 bit machine (int is 16 bit) this will never work. The type of ext=
ent need to change to unsigned long and not int.

I don't think we currently support any 16bit machines.

What platform and operating system is this?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

