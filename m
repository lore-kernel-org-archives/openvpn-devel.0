References: <1479677932-22078-1-git-send-email-selva.nair@...277...>
	<345177b8-6ef3-b357-7fea-025b34fa0e3f@...1227...>
	<CAKuzo_jBgo-3Wq_UR797kezfn-2SUJ-1B-aSzbwnqbCxCnja=w@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c56957b6-c738-41c0-4a4a-3c3dc5843ce2@...1227...>
Date: Mon, 21 Nov 2016 18:42:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jBgo-3Wq_UR797kezfn-2SUJ-1B-aSzbwnqbCxCnja=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Handle --dhcp-option DNS6 on Windows
 using netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 21.11.16 um 05:22 schrieb Selva Nair:
> Hi,
> 
> On Sun, Nov 20, 2016 at 5:29 PM, Arne Schwabe <arne@...1227...
> <mailto:arne@...1227...>> wrote:
> 
>     Am 20.11.16 um 22:38 schrieb Selva Nair:
>     > TODO: set dns servers using the interactive service
>     >
> 
>     I was playing with ANdroid/IPv6 and this. For Android, the resolver
>     takes the DNS server always in the order that I give it. Since there are
>     now seperate lists for DNS and DNS6 I have to prefer always DNS or DNS6
>     and cannot use the order I am given from the server.
> 
>     I think we refactor the dns_list into a common dns list. I can also do
>     this later since this is probably an Android specific problem.
> 
> 
> Yeah, we'll need a single list to preserve the inter-protocol ordering
> info, if that is really important. Does android support a mixed
> ipv4/ipv6 dns server ordering?

Yeah, it does. At least the first dns server I add (IPv4 or IPv6) is
always used as DNS server and the rest is treated as fallback.

Arne


