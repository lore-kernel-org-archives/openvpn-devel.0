Date: Sat, 9 Nov 2024 13:09:30 +0100 (CET)
Message-Id: <202411091209.4A9C9U11068857@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241106131705.11069-1-gert@...1296...>
References: <20241106131705.11069-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: sitnl: replace NLMSG_TAIL macro
 with noinline function
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

I'm generally not very much in favour of working around compiler silliness,
but this gets in the way of testing on Linux with -Werror, so what shall
we do... - it's not time critical, so inline/noinline does not really
matter much here.  Tested on Gentoo and Ubuntu, client / server side, 
with and without DCO.  So I claim it's a working replacement :-)

Your patch has been applied to the master branch.

commit 648e1606496adc6ec37a9d862810e465dab64dc0
Author: Antonio Quartulli
Date:   Wed Nov 6 14:17:03 2024 +0100

     sitnl: replace NLMSG_TAIL macro with noinline function

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20241106131705.11069-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29710.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


