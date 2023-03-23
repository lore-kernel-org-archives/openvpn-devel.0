Date: Thu, 23 Mar 2023 13:29:09 +0100 (CET)
Message-Id: <202303231229.32NCT98u042600@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230322192757.20767-1-a@...2181...>
References: <20230322192757.20767-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-linux: implement
 dco_get_peer_stats{, multi} API
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This only touches linux only files, so only tested on Linux (builds with
and without DCO).  The patch looks larger than it is because of a new
argument to ovpn_nl_msg_send(), but for the "existing code" this is
unused (extra argument to the callback function), so no change.  The
actual new code looks quite reasonable.

Testing confirms that we have counters now, for both server (status file)
and client (SIGUSR2) use.

There is a catch to it - the userland side has support for "link bytes"
and "tun bytes" (which end up in dco*bytes), but the "recommended kernel
version" from ChangeLog does not have the link counters yet - so all
queries end up with output like this:

tun-udp-p2mp[492454]: dco_update_peer_stat: no link RX bytes provided in reply for peer 0
tun-udp-p2mp[492454]: dco_update_peer_stat: no link TX bytes provided in reply for peer 0
tun-udp-p2mp[492454]: dco_update_peer_stat / tun_read_bytes: 5600
tun-udp-p2mp[492454]: dco_update_peer_stat / tun_write_bytes: 3592

upgrading kernel commit to commit 726fdfe0f brings both counters (and
the values correlate to "which peer did what?").

tun-udp-p2mp[493935]: dco_update_peer_stat / dco_read_bytes: 132176
tun-udp-p2mp[493935]: dco_update_peer_stat / dco_write_bytes: 131600
tun-udp-p2mp[493935]: dco_update_peer_stat / tun_read_bytes: 128096
tun-udp-p2mp[493935]: dco_update_peer_stat / tun_write_bytes: 127640



Your patch has been applied to the master and release/2.6 branch.

commit 5a8fb55ac8cf4019afee884d3be545ddf87435a4 (master)
commit 1fd69b9085f4c21542ec506d101eb73b3cd0abc4 (release/2.6)
Author: Antonio Quartulli
Date:   Wed Mar 22 20:27:57 2023 +0100

     dco-linux: implement dco_get_peer_stats{, multi} API

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230322192757.20767-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26481.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


