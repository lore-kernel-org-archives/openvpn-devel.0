From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 30 Apr 2013 10:24:37 +0200
Message-ID: <1940880.YvJhRzDkm5@...1526...>
In-Reply-To: <517F0CE5.6050507@...95...>
References: <517F0CE5.6050507@...95...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn-gui build error (cross-compile for
	Windows)
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
To: openvpn-devel@lists.sourceforge.net

Hi Felix

On Tuesday 30 April 2013 02:14:29 spockyf@...95... wrote:
> proxy.c:417:23: error: 'WINHTTP_AUTO_DETECT_TYPE_DHCP' undeclared (first
> use in this function)
> proxy.c:417:55: error: 'WINHTTP_AUTO_DETECT_TYPE_DNS_A' undeclared
> (first use in this function)
> proxy.c:438:32: error: 'WINHTTP_AUTOPROXY_CONFIG_URL' undeclared (first
> use in this function)

Your mingw-w64-x86-64-dev is too old, missing support for WinHTTP. Try with 
testing/unstable or install them directly from upstream.

Regards
Heiko

