Message-ID: <20100917184933.27824.qmail@...1287...>
Date: Fri, 17 Sep 2010 20:49:33 +0200
From: Peter Stuge <peter@...1287...>
References: <1284736735-25248-1-git-send-email-dazo@...384...>
MIME-Version: 1.0
In-Reply-To: <1284736735-25248-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed compiler warnings reported
	on	Ubuntu 10.04
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> The warnings reported where:
> --------------------------------------------------------
> misc.c:158: warning: ignoring return value of ‘nice’, declared with attribute warn_unused_result
> options.c:4033: warning: format not a string literal and no format arguments
> options.c:4043: warning: format not a string literal and no format arguments
> options.c:4053: warning: format not a string literal and no format arguments
> push.c:182: warning: format not a string literal and no format arguments
> push.c:199: warning: format not a string literal and no format arguments
> push.c:235: warning: format not a string literal and no format arguments
> status.c:171: warning: ignoring return value of ‘ftruncate’, declared with attribute warn_unused_result
> --------------------------------------------------------
> 
> Signed-off-by: David Sommerseth <dazo@...384...>

Acked-by: Peter Stuge <peter@...1287...>

