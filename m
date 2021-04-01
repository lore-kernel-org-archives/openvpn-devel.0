References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
 <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
 <69feee58-499e-98c7-5fec-e78368198d4a@...1227...>
 <20210401121014.GK976@...1296...>
 <962534bc-5687-0ffb-df63-0e968d6e68d1@...2181...>
 <20210401123701.GN976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4b4fa699-5a20-c5a2-c6bb-1658e7137e6c@...1227...>
Date: Thu, 1 Apr 2021 14:45:49 +0200
MIME-Version: 1.0
In-Reply-To: <20210401123701.GN976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: Tony He <huangya90@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 01.04.21 um 14:37 schrieb Gert Doering:
> Hi,
> 
> On Thu, Apr 01, 2021 at 02:16:25PM +0200, Antonio Quartulli wrote:
>>> (Of course it makes lots of sense to defer this to iptables etc. on
>>> all platforms that have DCO *and* a reasonable firewall layer... dco-win
>>> will be interesting)
>>
>> Features that are not compatible with DCO are being documented in the
>> code as we go.
>>
>> If you try to explicitly use one of those with DCO, openvpn2 will log a
>> big warning and will tell you that it is switching to non-DCO mode to
>> make sure your connection can work.
> 
> Which is actually interesting for mssfix, as that is "on by default",
> so "all configs are incompatible with DCO", by that definition :-)

Yes. With DCO we currently discovering that the OpenVPN way of doing
things with MTU set to 1500, doing mssfix and hoping that this will
clamp everything to 1450-overhead, while working quite well has a lot of
problems compared to just setting a proper MTU in the first case.

Currently setting tun-mtu 1400 manually workaround these problems but we
need to figure out a good way to solve this MTU mess. The current
working idea is to allow MTU 1500 on receive but use a correct MTU on
receive and on the interface (at least on platforms where you can
receive larger packets than MTU).

But currently we are just on the "we are aware of it" stage. And too
busy with other things to actually tackle that too right now.

Arne

