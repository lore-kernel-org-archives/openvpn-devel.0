Message-ID: <53BA771C.3070403@...1227...>
Date: Mon, 07 Jul 2014 12:31:56 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1402409073-54067216-1-git-send-email-gert@...1296...>	<1402409073-54067216-2-git-send-email-gert@...1296...>
	<1402409073-54067216-3-git-send-email-gert@...1296...>
In-Reply-To: <1402409073-54067216-3-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Add tap driver initialization and
 ifconfig for AIX.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: Gert Doering <gd@...1505...>

Am 10.06.14 16:04, schrieb Gert Doering:
> From: Gert Doering <gd@...1505...>
>
> AIX is special... ifconfig only works if it can add the data to
> the ODM right away, so setup a local enviromnment set that has
> "ODMDIR=/etc/objrepos" in it (hard-coded, nobody changes that).
>
> Only --dev tap or --dev tapNN are supported right now.  AIX has no
> tun driver (so tun mode would need to dynamically add/remove ethernet
> headers to/from AIX).
>
ACK on the basis of "cannot test, but looks sane and does not touch
other platforms"

Arne

