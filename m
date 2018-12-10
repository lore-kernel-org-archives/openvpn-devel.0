Date: Mon, 10 Dec 2018 14:41:52 +0100 (CET)
Message-Id: <201812101341.wBADfqGh030463@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181010143051.27163-1-arne@...1227...>
References: <20181010143051.27163-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fallback to password
 authentication when auth-token fails
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

Commit messages amended according to the comittee proposal ;-)

Uncrustify will complain to us that the switch/case block in push.c
grew an extra nesting level but indentation didn't change... but that's
just whitespace, so fixed on the next uncrustify run.

I haven't really reviewed the code - trusting Antonio here.  (I did look
over the changes and didn't see anything glaringly broken, and it passes
full t_client tests on both 2.4 and master - though these are not doing
auth token tests today)

commit e61b401ac50d2a9cfabf0289811ad14cf3bd2751 (master)
commit 004f13b60d87fe7815f4feee9aded22ae4eacbaf (release/2.4)
Author: Arne Schwabe
Date:   Wed Oct 10 16:30:51 2018 +0200

     Fallback to password authentication when auth-token fails

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20181010143051.27163-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17718.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


