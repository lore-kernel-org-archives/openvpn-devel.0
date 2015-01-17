MIME-Version: 1.0
In-Reply-To: <1421434930.394813972@...2013...>
References: <1421434930.394813972@...2013...>
Date: Sat, 17 Jan 2015 17:56:38 +0600
Message-ID: <CAFHpkQEWRAJhrFYaVSxUnTtBG4T4oJawjU4KUzYbZvi6-EEmNg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] Windows TAP driver profiling
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
To: Dan Moulding <dan.moulding@...2012...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

have a look at wire speed of tap adapter,  https://yadi.sk/i/zz4WbnOHe3hJf
I see 10mb

2015-01-17 0:02 GMT+05:00 Dan Moulding <dan.moulding@...2012...>:
> Hello all,
>
> I have been extensively testing OpenVPN recently, for potential deploymen=
t with some other systems I have been developing. One thing I have noticed =
during this testing is that performance of Windows clients connected to a L=
inux server is significantly slower than the performance of Linux clients w=
ith identical configurations.
>
> I'm suspecting that it's either the Windows network stack itself (seems a=
 little doubtful) or the Windows implementation of the TAP driver that is c=
ausing the poor performance. I'm hoping I can profile the TAP driver code t=
o see if I can confirm the latter (and maybe contribute some optimizations =
if it all works out).
>
> Has anyone here ever tried profiling the Windows TAP driver code before? =
Any pointers or suggestions from someone who is familiar with the TAP drive=
r would be really appreciated.
>
> Thanks,
>
> Dan Moulding
> Software Engineer
> RackWare, Inc.
>
>
>
> -------------------------------------------------------------------------=
-----
> New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
> GigeNET is offering a free month of service with a new server in Ashburn.
> Choose from 2 high performing configs, both with 100TB of bandwidth.
> Higher redundancy.Lower latency.Increased capacity.Completely compliant.
> http://p.sf.net/sfu/gigenet
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

