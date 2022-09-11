Date: Sun, 11 Sep 2022 22:30:51 +0200 (CEST)
Message-Id: <202209112030.28BKUpXL039882@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220909121841.646-1-lstipakov@...277...>
References: <20220909121841.646-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco.c: check certain options
 only on startup
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

Quite a bit of shuffling around... fed to the DCO test servers on Linux
and FreeBSD, which intentinally run a few instances with dco-incompatible
options (both as client and server).  Test results look good - so all
tests that are expected to pass do so (p2p renegotion...?), and it
claims to be using DCO on some of the tunnels :-)

Sep 11 20:27:32 ubuntu2004 tun-tcp-p2mp[2950149]: GLOBAL_STATS,dco_enabled,1
Sep 11 20:27:32 ubuntu2004 tun-udp-p2mp[2950158]: GLOBAL_STATS,dco_enabled,1
Sep 11 20:27:32 ubuntu2004 tun-udp-p2mp-topology-subnet[2950167]: GLOBAL_STATS,dco_enabled,1
Sep 11 20:27:32 ubuntu2004 tun-udp-p2mp-fragment[2950207]: GLOBAL_STATS,dco_enabled,0
Sep 11 06:58:19 ubuntu2004 tap-udp-p2mp[2906314]: Note: dev-type not tun, disabling data channel offload.

(etc.)

Your patch has been applied to the master branch.

commit f7b2817b8999d3ee846bfbafe11e05eda6501e96
Author: Lev Stipakov
Date:   Fri Sep 9 15:18:41 2022 +0300

     dco.c: check certain options only on startup

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220909121841.646-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25158.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


