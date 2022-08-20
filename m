Date: Sat, 20 Aug 2022 11:20:27 +0200 (CEST)
Message-Id: <202208200920.27K9KRvo009688@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220819182439.71531-1-gert@...1296...>
References: <20220819182439.71531-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: FreeBSD-DCO: repair device
 iteration to find first free interface.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

To avoid any fat fingers on my side, I've merged this and then subjected
the resulting branch to a round of FreeBSD DCO server tests, which all
behaved quite nicely :-)  (iroute missing, because not merged yet, but
the rest works - TCP [no DCO], UDP [DCO, if topology subnet], etc)

Aug 20 11:18:59 fbsd14 tun-udp-p2mp[79256]: GLOBAL_STATS,dco_enabled,1
Aug 20 11:18:59 fbsd14 tun-udp-p2mp-topology-subnet[79278]: GLOBAL_STATS,dco_enabled,1

Patch has been applied to the master branch.

commit efebdfe2de8dd5125fb42d646d03a958b7dc3eea
Author: Gert Doering
Date:   Fri Aug 19 20:24:39 2022 +0200

     FreeBSD-DCO: repair device iteration to find first free interface.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Kristof Provost <kprovost@...2661...>
     Message-Id: <20220819182439.71531-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25034.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


