From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 17 Jul 2012 17:40:51 +0200
Message-ID: <2558565.UxQt4QKoI1@...1526...>
In-Reply-To: <1403139.dzVK3VN5gj@...1526...>
References: <4e6f25371d6bd0.07599718@...1498...> <1403139.dzVK3VN5gj@...1526...>
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
To: openvpn-devel@lists.sourceforge.net
Cc: Krashan Brahmanjara <krokodylowy3@...1498...>

On Monday 16 July 2012 16:43:52 Heiko Hund wrote:
> I'll do some tests tomorrow to see how the major browsers behave regarding
> proxy settings detection and will follow in their footsteps.

Seems neither IE 9, Firefox 14 nor Chrome 20 takes care about the WinHTTP 
default proxy settings added with netsh/proxycfg. So, I'll ignore that setting 
as well for now.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


