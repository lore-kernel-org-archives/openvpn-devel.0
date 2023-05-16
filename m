Date: Tue, 16 May 2023 09:00:45 +0200 (CEST)
Message-Id: <202305160700.34G70jXL042671@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230515142116.33135-1-frank@...2641...>
References: <20230515142116.33135-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: DCO: fix memory leak in
 dco_get_peer_stats_multi for Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Good catch!

I have done a basic "does it still compile and not crash?" test on the
server-with-DCO test rig.  Does not crash :-) - and the patch looks good.

Your patch has been applied to the master and release/2.6 branch.

commit 276f7c86d70666bc2ab4e6192ef5f1dcbd6a230f (master)
commit 5e8a571af165c867ccb9c4c9e6334620f42013ac (release/2.6)
Author: Frank Lichtenheld
Date:   Mon May 15 16:21:16 2023 +0200

     DCO: fix memory leak in dco_get_peer_stats_multi for Linux

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230515142116.33135-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26659.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


