Date: Mon, 20 Mar 2017 18:59:37 +0100 (CET)
Message-Id: <201703201759.v2KHxbRp063418@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170319191049.23970-1-gert@...1296...>
References: <20170319191049.23970-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix installation of IPv6 host
	route to VPN server when using iservice.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Got it tested by now, works :-)

Patch has been applied to the master and release/2.4 branch.

commit 27740b376c1ca89a43dcff5c8309f1e1afecc5c9 (master)
commit 46e65494194f0bba0c63be8360b56ed595949720 (release/2.4)
Author: Gert Doering
Date:   Sun Mar 19 20:10:49 2017 +0100

     Fix installation of IPv6 host route to VPN server when using iservice.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20170319191049.23970-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14282.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


