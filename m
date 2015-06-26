Message-ID: <558D8597.2040501@...1516...>
Date: Fri, 26 Jun 2015 19:02:15 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
	<20150626073544.GT382@...1296...> <558D2D98.70905@...1516...>
	<20150626112401.GU382@...1296...>
	<20150626143636.GY382@...1296...>
In-Reply-To: <20150626143636.GY382@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Hello,

Am 26.06.2015 um 16:36 schrieb Gert Doering:
> Hi,
>
> On Fri, Jun 26, 2015 at 01:24:02PM +0200, Gert Doering wrote:
>> This is more wondering about what we *should* do for persistant tun
>> interfaces...  (and, now, why your tun ifs behave that way even if they
>> are not actually persistant :) ).
>
> Mulling over this for a while, I think I've come to a conclusion on
> "what we should do", and "what we should do in the 'persistant tun'
> case" (#141)
>
>   - normal case: we do "ip addr add" and "delete" - proper housekeeping,
>     and having IPv4 and IPv6 in sync  (so, Holger's patch for Linux,
>     and possible similar additional code for all the other OSes)

I looked at some other OSes in tun.c and found no other with this flaw
at a first glance (other do simply a 'destroy' or 'unplumb' of the 
interface). But probably I oversaw something here.

>
>   - if someone really wants/needs a persistant device (created with
>     "openvpn --mktun --dev tun3" on Linux / "ifconfig tun3 create"
>     on *BSD), and expect it to always keep the addresses on it, they
>     should call "openvpn --ifconfig-noexec".

Yes, this sounds like a good idea to me. Had also something like
"--ifconfig-notouch" in mind, but your proposal is shorter.

>
>     This will then neither add *nor delete* the IP addresses on the
>     interface (of course, in that case you need to run the ifconfig /
>     ip addr statements manually before starting OpenVPN, or from an --up
>     script which can then choose to just ignore the error if the address is
>     already there).  So this would cover the case "I want <daemon x> to
>     listen on my tun device, but it cannot rebind if the interface goes
>     away".
>
> Simple and pragmatic enough?

I second this proposal, and it would solve a long outstanding bug.


Holger

>
> (Having OpenVPN check addresses for persistant tun interfaces, and only
> add them if needed, and actually *change* them if needed would be a cool
> thing to have, but we have no infrastructure yet to do so)
>
> gert
>

