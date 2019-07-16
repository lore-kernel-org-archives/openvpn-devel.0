Date: Tue, 16 Jul 2019 21:33:56 +0200 (CEST)
Message-Id: <201907161933.x6GJXu1n034011@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190715144609.19616-1-a@...2181...>
References: <20190715144609.19616-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: route.c: use sitnl to implement
 get_default_gateway_ipv6()
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

Acked-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>

Passes the manual "--show-gateway <thing>" test now, and survived 
staring-at-the-code.  Though that one turned up things elsewhere that
I do not like very much (but which have already been merged) - see
next mail.

I said before I'm not a big fan of having an "int flags" declaration
at the beginning of a function for a single-use helper variable further 
down - C99 permits "int flags = ..." right where the thing is needed, 
and I find that much more readable (I wouldn't introduce "flags" at 
all, but if you do, having to look in two places "what is this?  is 
this used anywhere else?" is more review effort).  But you ignored that
comment, and I'm not disliking this enough for a NAK.

Your patch has been applied to the master branch.

commit c454b21e7ce458ce6f5bcaf6c313ab3ba3dd5baf
Author: Antonio Quartulli
Date:   Mon Jul 15 16:46:09 2019 +0200

     route.c: use sitnl to implement get_default_gateway_ipv6()

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190715144609.19616-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18667.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


