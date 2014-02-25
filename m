Message-ID: <530D2491.8050605@...1856...>
Date: Wed, 26 Feb 2014 00:17:37 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...>
	<20140218085500.GU16637@...1296...>	<530340C4.5060702@...277...>	<20140218115015.GW16637@...1296...>	<5304AFE4.2050702@...277...>
	<530917A4.4050905@...1528...>	<53093043.9080808@...277...>
	<5309B31C.50208@...1856...>	<530A9219.8050809@...277...>	<530BE62F.4090709@...1856...>
	<20140225082237.GN16637@...1296...>
	<CAA1AbxJAmvsPUQwiW7p4qP0fXMwwsiDjarp0nPjhwQj5d6PcPA@...278...>
	<530D0FE5.1050400@...1147...>
In-Reply-To: <530D0FE5.1050400@...1147...>
Subject: Re: [Openvpn-devel] [Patch] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 25-02-14 22:49, Jan Just Keijser wrote:
> read up on the original ticket too:
>   https://forums.openvpn.net/topic8404-30.html
> 
> there's some useful commands/description in there on how to generate
> ECDSA certificates.

Thanks. I've added support for ECDSA to EasyRSA 3 a little while ago, so
that should simplify the certificate generation a lot.

-Steffan

