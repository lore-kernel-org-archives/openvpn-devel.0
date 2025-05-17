Date: Sat, 17 May 2025 10:46:12 +0200 (CEST)
Message-Id: <202505170846.54H8kCNh077485@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250517083231.27977-1-gert@...1296...>
References: <20250517083231.27977-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: fix peer stats
 parsing with new ovpn kernel module
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at code, discussed what this "netlink uint" thing is (it's a magic
data type which is sent in netlink data structures as 32 or 64 bit,
depending on need - so, when going over 4G, you get 64 bit counters,
and when not, saving on bandwidth).

Tested, and lo and behold, counters do appear, with values that look
reasonable

    tun-udp-p2mp[58643]: dco_update_peer_stat / dco_read_bytes: 1013248
    tun-udp-p2mp[58643]: dco_update_peer_stat / dco_write_bytes: 1059016
    tun-udp-p2mp[58643]: dco_update_peer_stat / tun_read_bytes: 867928
    tun-udp-p2mp[58643]: dco_update_peer_stat / tun_write_bytes: 911344

Your patch has been applied to the master branch.

commit 6c33e3761ecb476d047bc14e7948ffddba800915
Author: Antonio Quartulli
Date:   Sat May 17 10:32:23 2025 +0200

     dco_linux: fix peer stats parsing with new ovpn kernel module

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250517083231.27977-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31666.html
     Signed-off-by: Gert Doering <gert@...1296...>

--
kind regards,

Gert Doering


