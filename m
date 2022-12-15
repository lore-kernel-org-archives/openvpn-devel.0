Date: Thu, 15 Dec 2022 13:38:09 +0100 (CET)
Message-Id: <202212151238.2BFCc9fO083230@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221214211426.227-1-lstipakov@...277...>
References: <20221214211426.227-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce dco_get_peer_stats
 API and Windows implementation
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stare-at-code suggests that this might work.  I haven't tested this, but
Selva did, and the "on reconnect the timers get lost" issue is being
addressed by Lev in the win-dco driver itself - so, good to go.

I have pushed to github, to see if it passes compile & actions there,
and it does (https://github.com/cron2/openvpn/actions/runs/3703823801) -
and I have tested this on FreeBSD and Linux, with and without DCO, just
to be sure it won't break anything due to #ifdef oversights.  Doesn't.


Your patch has been applied to the master branch.

commit 74d5ece4a035fbbd962ba5ea73c19118b82f8f45 (master)
commit 73cab72281deb631979cbcc1a2b36462b4be622f (release/2.6)
Author: Lev Stipakov
Date:   Wed Dec 14 23:14:26 2022 +0200

     Introduce dco_get_peer_stats API and Windows implementation

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221214211426.227-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25703.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


