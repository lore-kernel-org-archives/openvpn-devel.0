Date: Thu, 18 Feb 2010 21:35:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100218203510.GH9556@...1296...>
References: <1266524628-9222-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1266524628-9222-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Do not randomize resolving of IP
	addresses in getaddr()
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Hi,

ACK for the idea, but this...

On Thu, Feb 18, 2010 at 09:23:48PM +0100, David Sommerseth wrote:
> -	      /* choose address randomly, for basic load-balancing capability */
> -	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random () % n]);
> +	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[0]);
>  	    }

... is sort of redundant, because the code further up already sets

      ia.s_addr = *(in_addr_t *) (h->h_addr_list[0]);

- in about line 202 in my copy of socket.c:

---------------- snip -------------
      ia.s_addr = *(in_addr_t *) (h->h_addr_list[0]);

      if (ia.s_addr)
        { 
          if (h->h_addr_list[1]) /* more than one address returned */

---------------- snip -------------

so the if() could be reduced even further, to just print the message.

gert


-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

