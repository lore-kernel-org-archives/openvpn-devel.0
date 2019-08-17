Date: Sat, 17 Aug 2019 20:54:38 +0200 (CEST)
Message-Id: <201908171854.x7HIscAD061465@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190805092529.9467-5-a@...2181...>
References: <20190805092529.9467-5-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: undo_ifconfig_ipv4/6
 remove useless gc argument
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Looks like a reasonable change, tested on Linux/iproute2 and FreeBSD
(to cover the "#ifndef TARGET_LINUX" part).

Your patch has been applied to the master branch.

commit e64d9c47d580427ed5e3d176dbcb7aa2ea55c4ba
Author: Antonio Quartulli
Date:   Mon Aug 5 11:25:27 2019 +0200

     tun.c: undo_ifconfig_ipv4/6 remove useless gc argument

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190805092529.9467-5-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18726.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


