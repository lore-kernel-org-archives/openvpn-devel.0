Date: Sat, 17 Aug 2019 20:40:06 +0200 (CEST)
Message-Id: <201908171840.x7HIe61h052785@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190816202654.19388-1-a@...2181...>
References: <20190816202654.19388-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking: extend API for
 better memory management
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

Things look much nicer now - less casts, less free() calls :-) - thanks.

Tested on Linux/iproute2 and Linux/sitnl (t_client tests).

Your patch has been applied to the master branch.

commit 59fde742a113a450fe65a4d6b2cb9122425c1920
Author: Antonio Quartulli
Date:   Fri Aug 16 22:26:54 2019 +0200

     networking: extend API for better memory management

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190816202654.19388-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18780.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


