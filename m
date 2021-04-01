References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
 <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
 <69feee58-499e-98c7-5fec-e78368198d4a@...1227...>
 <20210401121014.GK976@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <962534bc-5687-0ffb-df63-0e968d6e68d1@...2181...>
Date: Thu, 1 Apr 2021 14:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <20210401121014.GK976@...1296...>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: Tony He <huangya90@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 01/04/2021 14:10, Gert Doering wrote:
> Hi,
> 
> On Thu, Apr 01, 2021 at 12:47:46PM +0200, Arne Schwabe wrote:
>> In your dco to dco setup you probably
>> don't have mssfix on either side unless you explicitly added iptables
>> rules for that.
> 
> Ah, this is interesting and needs to be documented - "if you want feature
> <a>, <b>, <c> together with DCO, it needs to be done in iptables".
> 
> (Of course it makes lots of sense to defer this to iptables etc. on
> all platforms that have DCO *and* a reasonable firewall layer... dco-win
> will be interesting)

Features that are not compatible with DCO are being documented in the
code as we go.

If you try to explicitly use one of those with DCO, openvpn2 will log a
big warning and will tell you that it is switching to non-DCO mode to
make sure your connection can work.

However, we will definitely make some larger doc explaining what we
decided that DCO should not do and what are possible alternatives.



Regards,

-- 
Antonio Quartulli

