Date: Sun, 28 Feb 2010 15:28:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100228142856.GL9556@...1296...>
References: <1267361435-11982-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1267361435-11982-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Add CID to the management status
	overview
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

On Sun, Feb 28, 2010 at 01:50:35PM +0100, David Sommerseth wrote:
> There are commands in the management interface which require the cid. The
> only way at the moment to get the cid of connected clients is to have
> always a management connection established. The patch adds the CID to the
> status output.

What is "cid"?  Client-ID?

I can't ACK this, as I don't understand the implications.  The code itself
looks harmless, but without knowing who might read the output and whether
an additional field will be silently ignored or whether consumer applications
may fail, I really can't say.

Is there documentation available for this?


Something I do not like about this patch:

> @@ -777,7 +777,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
>  
>  	  status_printf (so, "END");
>  	}
> -      else if (version == 2 || version == 3)
> +      else if (version == 2 || version == 3 )
>  	{
>  	  const char sep = (version == 3) ? '\t' : ',';
>  

In the grand scheme of things, small whitespace changes might later on 
lead to a merge conflict with another patch in this line (like "introduce 
version 4" or so), and so I'd avoid changes that are purely cosmetic in 
a "feature" patch.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

