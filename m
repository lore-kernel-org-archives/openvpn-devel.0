References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
 <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <69feee58-499e-98c7-5fec-e78368198d4a@...1227...>
Date: Thu, 1 Apr 2021 12:47:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 01.04.21 um 04:38 schrieb Tony He:
> Hi Antonio, Arne,
> 
> According to the dump, this issue is caused by fragment. If I set
> link-mtu to 1472 in the condition of encryption "none", it's gone.
> I also can reproduce the fragment in my Linux x86-64 PC and Linux VM .
> They use kernel 5.4. Fragment affects the performance
> in the low-end devices. It also consumes more CPU resource in low-end
> and high-end devices.  If I'm not mistaken, we don't need
> to set link-mtu without dco. Is this a bug? Can you reproduce? Do I
> still need to upload my dump? If so, maybe I need to provide a link.

Yes that is expected. Use tun-mtu 1400. The mtu 1500 leading to
fragmentation is a longstanding issue but ist almost entirely masked by
mssfix being enabled by default. In your dco to dco setup you probably
don't have mssfix on either side unless you explicitly added iptables
rules for that.


Arne

