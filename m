Date: Wed, 17 Aug 2022 21:33:38 +0200 (CEST)
Message-Id: <202208171933.27HJXcqb045246@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220813211104.411554-1-arne@...1227...>
References: <20220813211104.411554-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Include DCO status in
 GLOBAL_STATS status v2 output
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

I have lightly tested it, by sending SIGUSR2 as Lev has suggested.  It's
not visible in the client GLOBAL_STATS (unsurprisingly, since added to 
multi_print_status()... but maybe a followup patch?) but on the servers
it nicely shows...

Aug 17 21:31:59 ubuntu2004 tap-udp-p2mp[2183229]: GLOBAL_STATS,dco_enabled,0
Aug 17 21:32:01 ubuntu2004 tun-tcp-p2mp[2183195]: GLOBAL_STATS,dco_enabled,1
Aug 17 21:32:05 ubuntu2004 tun-udp-p2mp-fragment[2183260]: GLOBAL_STATS,dco_enabled,0
Aug 17 21:32:09 ubuntu2004 tun-udp-p2mp-topology-subnet[2183217]: GLOBAL_STATS,dco_enabled,1
Aug 17 21:32:11 ubuntu2004 tun-udp-p2mp[2183208]: GLOBAL_STATS,dco_enabled,1


Did not test management interface, but that's the same code anyway.

I have adjusted the commit message + subject as suggested by Lev.

Your patch has been applied to the master branch.

commit b421a0d55afc6e7a566b97cf9b687824be5a9118
Author: Arne Schwabe
Date:   Sat Aug 13 23:11:04 2022 +0200

     Include DCO status in GLOBAL_STATS status v2 output

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20220813211104.411554-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24923.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


