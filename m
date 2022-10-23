Date: Sun, 23 Oct 2022 18:16:00 +0200 (CEST)
Message-Id: <202210231616.29NGG0QJ064775@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221022205521.29406-1-a@...2181...>
References: <20221022205521.29406-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: close_tun: print interface type
 consistently in message
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

Tested on Linux with/without --disable-dco, and the expected message
shows up.  Test compiled on FreeBSD (without DCO) and nothing breaks.

Your patch has been applied to the master branch.

commit 77829be280b3b280f35d1ca4947900f3c5e5dd26
Author: Antonio Quartulli
Date:   Sat Oct 22 22:55:21 2022 +0200

     close_tun: print interface type consistently in message

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221022205521.29406-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25449.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


