Date: Tue, 18 Jul 2023 15:09:05 +0200 (CEST)
Message-Id: <202307181309.36ID95Zs013513@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230524132424.3098475-2-arne@...1227...>
References: <20230524132424.3098475-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement using
 --peer-fingerprint without CA certificates
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Tested that things work as before (the t_server testbed has fp tests,
both "should succeed" and "should fail", all pass).

I did some massaging to the text in the commit message to make the
"based on two previous commits" part easier to read.

Your patch has been applied to the master and release/2.6 branch.

commit c3746da7f04acf872f251d3673551963380c4d77 (master)
commit b241e815f16bd566a4824d26f381e468917c822b (release/2.6)
Author: Arne Schwabe
Date:   Wed May 24 15:24:24 2023 +0200

     Implement using --peer-fingerprint without CA certificates

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230524132424.3098475-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26723.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


