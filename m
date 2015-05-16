Date: Sat, 16 May 2015 23:10:40 +0200 (CEST)
Message-Id: <201505162110.t4GLAebY028250@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20150516134604.GA2302@...2032...>
References: <20150516134604.GA2302@...2032...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use OPENVPN_ETH_P_* so that
	<netinet/if_ether.h> is unecessary
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
To: Felix Janda <felix.janda@...2031...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.3 branches.

commit ddb1f20a9ddbb94956c9f7b1115c89543d9b411a (master)
commit e9739fbf587e1b0516fa47b9576cc8be8b514d21 (release/2.3)

Author: Felix Janda
Date:   Sat May 16 15:59:50 2015 +0200

     Use OPENVPN_ETH_P_* so that <netinet/if_ether.h> is unecessary

     Signed-off-by: Felix Janda <felix.janda@...2031...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20150516134604.GA2302@...2032...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9690
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


