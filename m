From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 16 Jul 2012 16:43:52 +0200
Message-ID: <1403139.dzVK3VN5gj@...1526...>
In-Reply-To: <4e6f25371d6bd0.07599718@...1498...>
References: <4e6f25371d6bd0.07599718@...1498...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 0/3] better --auto-proxy support for
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krashan Brahmanjara <krokodylowy3@...1498...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday 13 September 2011 11:41:11 Krashan Brahmanjara wrote:
> At this moment main problem is invalid proxy search sequence.
> I'm in network with high protection policy. Proxy got password and IE
> settings are available but password is not visible. Only proxycfg data are
> visible and Firefox problablu use them with success.

I know it's been a while, but could you elaborate on this? I'm currently 
implementing auto-proxy support into the Windows GUI (decided that it's better 
off there at our meeting at FOSDEM earlier this year) and am curious about 
your environment. Where do the proxy credentials get stored? With the WinHTTP 
proxy settings? What output does `netsh winhttp show proxy` give?

> So in auto-proxy mode proxycfg setting should be checked before IE settings.

I'll do some tests tomorrow to see how the major browsers behave regarding 
proxy settings detection and will follow in their footsteps.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


