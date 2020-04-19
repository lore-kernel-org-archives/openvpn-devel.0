Date: Sun, 19 Apr 2020 11:57:46 +0200 (CEST)
Message-Id: <202004190957.03J9vk0e007523@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200418013123.22551-1-a@...2181...>
References: <20200418013123.22551-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: sitnl: fix TUN/TAP confusion in
 error messages
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

Yeah, "is_tun_p2p()" has always been misleading...  one could argue
for "can't add IP to *p2p* interface..." vs "*network* interface" (or
something like that), but then, it's not really adding that much extra 
value.  Out it goes.

Your patch has been applied to the master branch.

commit b9ff398884aa4576f2d9f75f2e2b54cd9688d122
Author: Antonio Quartulli
Date:   Sat Apr 18 03:31:23 2020 +0200

     sitnl: fix TUN/TAP confusion in error messages

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200418013123.22551-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19775.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


