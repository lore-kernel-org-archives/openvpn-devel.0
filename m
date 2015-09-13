References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-2-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55F5412B.6060004@...1227...>
Date: Sun, 13 Sep 2015 11:26:03 +0200
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-2-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 01/10] refactor struct route_ipv6,
 bring in line with struct route_ipv4 again
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 11.09.15 um 17:33 schrieb Gert Doering:
> adjust "struct route_ipv6" (and all users) to reflect changes
> to "struct route_ipv4" done in commit 7fb0e07e, namely:
> 
>  - new member "r6->flags"
>  - "r6->defined"        becomes "r6->flags & RT_DEFINED"
>  - "r6->metric_defined" becomes "r6->flags & RT_METRIC_DEFINED"
>  - route addition status is stored in "r6->flags & RT_ADDED"
> 
> Signed-off-by: Gert Doering <gert@...1296...>

ACK.

Arne

