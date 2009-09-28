MIME-Version: 1.0
In-Reply-To: <h9l743$6ii$1@...1062...>
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...> 
	<h9l743$6ii$1@...1062...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Mon, 28 Sep 2009 12:09:32 +0200
Message-ID: <7bb795fd0909280309g3287cab3we47308cbf768adec@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Bernhard Schmidt <berni@...376...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Bernhard,

On Sat, Sep 26, 2009 at 4:05 PM, Bernhard Schmidt <berni@...376...> wrote:
> JuanJo Ciarlante <jjo+ml@...410...> wrote:
>
> Hello JuanJo,
>
>> I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
>> please refer to README.ipv6[1] and TODO.ipv6[2] for more details.
>>
>> All snapshots are unittested for correct {udp,tcp}v{4,6} operation
>> under GNU/Linux and win32 (the latter x-compiled under the former ;).
>
> Thank you very much, your work is highly appreciated!

heh ... thanks :)

>
> I've updated my Ubuntu PPA repository of IPv6-enabled OpenVPN with your
> patch. It contains the Ubuntu Karmic 2.1~rc19-1ubuntu2 package patched
> for IPv6 transport, compiled for Karmic and Intrepid. The Intrepid
> version should work fine on Debian Lenny as well.

wohooo ... thanks a lot!, with you help this effort will be able
to reach ++people .

>
> You can find those packages on
> https://launchpad.net/~berni/+archive/ipv6/+packages .

Cool, I added this to README.ipv6.

> I have not
> observed any problems in my easy usecase (static Point-to-point tunnel
> over UDPv6), but no guarantees for anything.

heh... I sieve my changes thru a set of crude but effective unittests
for basic protocol xchg and conn establishment for {tcp,udp}x{4,6};
surprisingly nuff, both for ./openvpn and ./openvpn.exe :P

>
> Regards,
> Bernhard
>

Cheers,

-- 
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

