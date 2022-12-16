Date: Fri, 16 Dec 2022 18:22:30 +0100 (CET)
Message-Id: <202212161722.2BGHMUuJ015885@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221215190143.2107896-6-arne@...1227...>
References: <20221215190143.2107896-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Eliminate or comment empty
 blocks and switch fallthrough
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

Acked-by: Gert Doering <gert@...1296...>

This doesn't change anything code wise (where it changes the if/else,
it just gets rid of the second-to-last empty block, and by adding an
early exit gets rid of an indentation level), but improves clarity, so
very welcome.  The diffs to bio_read() work better with "git show -w".

Client-side tested that things still work :-)

Your patch has been applied to the master and release/2.6 branch.

commit f2454ec6363d5578875d020179b38074b3c10964 (master)
commit da747c3664d9330a1e38369aadddefb6ba5e8416 (release/2.6)
Author: Arne Schwabe
Date:   Thu Dec 15 20:01:40 2022 +0100

     Eliminate or comment empty blocks and switch fallthrough

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221215190143.2107896-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25735.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


