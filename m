Message-ID: <501687B9.90303@...1227...>
Date: Mon, 30 Jul 2012 15:10:17 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1343639122-8658-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1343639122-8658-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] fix regression with --http-proxy[-*]
 options
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Am 30.07.12 11:05, schrieb Heiko Hund:
> Commit af1bf85a introducing the --management-query-proxy option
> broke the initialization of HTTP proxy options by not assigning
> the allocated object to the options element in the function
> init_http_proxy_options_once().
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
>
In my test this patch worked. It also worked for reporting user. So ACK
from me.

Arne

