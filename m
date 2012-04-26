MIME-Version: 1.0
In-Reply-To: <20120426180156.GU1359@...1296...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
	<20120426172410.GT1359@...1296...>
	<4F9986A2.10900@...1114...>
	<CAOazyz0Tv0_9Fqr_b8smQ0z00qk5fQ2AUaHz_75K-gQoEANDOg@...278...>
	<20120426180156.GU1359@...1296...>
Date: Thu, 26 Apr 2012 21:06:19 +0300
Message-ID: <CAOazyz3NsxGOaG97DXaksx6zfAXGBSvM-1YCbB=wkFKY5fmm-w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
 capable at build time
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Apr 26, 2012 at 9:01 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Thu, Apr 26, 2012 at 08:35:54PM +0300, Alon Bar-Lev wrote:
>> At embedded system and several distros like Gentoo, the ipv6 should be
>> made enable/disabled, just like any other project.
>> It is the same #ifdef as we already have these in code.
>> Even in 2012 kernels can be compiled without ipv6.
>
> Enabling/disabling IPv6 for "just some piece of random code that can
> open up network sockets" is easy, and usually not even worth the extra
> lines of code ("just pass different options to getaddrinfo() and/or
> bind()").
>
> Given the nature of OpenVPN, and that almost everything in the code
> (except for the crypto stuff) is related to IP packets or IP addresses,
> it's not that straightforward here.
>
> Adding IPv6 to the OpenVPN code base touched well over 100 different
> places of the code, and to really make it optional (to get the space
> saving worth for an embedded system) you'd have to have #ifdef's at
> all these places, in the config data structures, and so on - this is
> lots of work, especially maintaining both code paths and testing all
> this, with dubious benefits. =C2=A0As I said, we got bitten by JJO's
> decision to make IPv6 transport conditonal, and decided to get *rid*
> of those #ifdefs for the sake of "less code paths, less maintenance
> effort".
>
>
> I'm not sure you can find packages that have had working IPv6 support,
> and then decided to make it conditional afterwards. =C2=A0Usually IPv6 was
> added at some point, and it was added conditionalized, because that
> package can also be compiled on older systems without IPv6 - since we
> have the luxury of not supporting anything that has no tun/tap interface,
> we have the same luxury of not having to bother with anything that has
> no IPv6. =C2=A0(Even if you compile the Linux kernel and glibc without IP=
v6,
> the API stuff - getaddrinfo(), inet_ntop(), etc., will still be there,
> because they are IP version agnostic - they will fail if you actually
> try to *use* them for IPv6, but you can compile and run the same
> applications just fine).
>

Right, the ipv6 was added indeed differently, without this conditionals.
Because of this I did not perform this task as part of the major build
cleanup, and left this for the next phase.
Most of the lowlevel network code already has #ifdefs, I will try my
best to find a way to do the conditional without much changes.

Alon.

