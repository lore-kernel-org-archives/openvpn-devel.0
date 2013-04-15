Date: Mon, 15 Apr 2013 19:03:19 +0200 (CEST)
Message-Id: <201304151703.r3FH3JNQ026255@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <516BCEA2.6000608@...1435...>
References: <516BCEA2.6000608@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fixed usage of stale define
	USE_SSL to ENABLE_SSL
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK (since this matches what I assumed it should be :-) - thanks for
the extra explanation).

Your patch has been applied to the master and release/2.3 branches.

commit 1d561d4eaebe8652768270b6373023177b8d706d (master)
commit eb16a92894b3d93c69b6f56a5b852c5089a5304f (master)

Author: Steffan Karger
Date:   Mon Apr 15 10:45:28 2013 +0200

     Fixed usage of stale define USE_SSL to ENABLE_SSL

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <516BCEA2.6000608@...1435...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7509
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


