Date: Tue, 18 Dec 2018 15:39:36 +0100 (CET)
Message-Id: <201812181439.wBIEdaBo043544@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181205214037.70783-1-gert@...1296...>
References: <20181205214037.70783-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Stop complaining about IPv6
 routes without gateway address.
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

Patch has been applied to the master branch.

I haven't put it into release/2.4 as this is more a "make things nicer"
than a bugfix - plus it needs the "--route-ipv6-gateway" feature from
d24e1b179b95, which is "new feature" and thus not in 2.4.

Reformatted braces as suggested.  Interesting enough, our uncrustify 
rules permit both "a space before the closing bracked" and "no space" 
(and I think this is good enough, sometimes you just want the extra 
space for readability - but maybe not in this case).

I've left the message as it was, because "putting it all in one line" 
creates a 220 characters wide line - which is definitely in "Steffan
will come and kick me" land.

commit 14d7e0e496f15563005fffc6d4791a95444ddf23 (master)
Author: Gert Doering
Date:   Wed Dec 5 22:40:37 2018 +0100

     Stop complaining about IPv6 routes without gateway address.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20181205214037.70783-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17990.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


