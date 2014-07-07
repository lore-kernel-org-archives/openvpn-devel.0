Message-ID: <53BA7712.9020500@...1227...>
Date: Mon, 07 Jul 2014 12:31:46 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1402409073-54067216-1-git-send-email-gert@...1296...>
	<1402409073-54067216-2-git-send-email-gert@...1296...>
In-Reply-To: <1402409073-54067216-2-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Recognize AIX, define TARGET_AIX
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
> force "have_tap_header=yes", as configure won't like AIX headers otherwise
> (no tun related headers, just <net/if_tap.h>).
>
> force ROUTE to be "/usr/sbin/route" - not executable by non-root users, so
> configure testing for executables will not find it
>
> force "ac_cv_header_net_if_h=no", because AIX' <net/if.h> pulls in AIX'
> <net/route.h>, which #defines ROUTE_H, disabling our "route.h"... (and
> we don't need <net/if.h> on AIX anyway)
>
>
ACK on the basis of "cannot test, but looks sane and does not touch
other platforms"

Arne

