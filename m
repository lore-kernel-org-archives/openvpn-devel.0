Date: Wed, 18 Aug 2010 16:49:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100818144935.GT9777@...1296...>
References: <4C6BD3CB.5050009@...68...>
	<1282136643-22193-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
In-Reply-To: <1282136643-22193-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH v2] Test framework improvment - Do not
	FAIL if t_client.rc is missing
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
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Wed, Aug 18, 2010 at 03:04:03PM +0200, David Sommerseth wrote:
> This is to avoid 'make check' fail if this extra test case is not
> configured.
[..]
> +    exit 77
> +fi
> +

ACK again.  Better :)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

