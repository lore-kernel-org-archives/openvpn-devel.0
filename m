Date: Fri, 3 Feb 2012 16:19:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120203151931.GI13929@...1296...>
References: <20120203084426.GA24955@...1296...>
	<ae352eb1958ae39e2805169386bb144e@...1528...>
Mime-Version: 1.0
In-Reply-To: <ae352eb1958ae39e2805169386bb144e@...1528...>
Subject: Re: [Openvpn-devel] IPv6 enhancement: non-/64 prefix lengths for
	IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Michael <michael-developer@...1528...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Feb 03, 2012 at 03:10:37PM +0100, Michael wrote:
> the patch does not remove
> 
> +++ b/push.c
> @@ -245,8 +245,9 @@ send_push_reply (struct context *c)
>        /* TODO: push "/netbits" as well, to allow non-/64 subnet sizes
>         *       (needs changes in options.c, options.h, and other 
> places)
>         */
> 
> though the code now does it?

Indeed, thanks.  I overlooked that.

(Need to check with Dazo how to get that into the same commit...)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

