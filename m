Date: Fri, 7 Jul 2023 18:28:54 +0200 (CEST)
Message-Id: <202307071628.367GSsdE062529@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230522101138.2842378-2-arne@...1227...>
References: <20230522101138.2842378-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix CR_RESPONSE mangaement
 message using wrong key_id
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

Thanks for reminding me that there was something pending here as well...

This is a bit complicated, though.  The bugfix needs to go to 2.6 as
well, so "2/2 applied", but the v2 as sent to the list has a hunk that
is really a bugfix for get_key_by_management_key_id(), which is in
1/2, and that is refactoring -> master.

So I've only applied the first hunk here, and the second hunk should
go together with all of 1/2 into a "master only" patch.  Right?

I have run this through the basic client test, which isn't exactly
excercising the management interface (not at all) but I have nothing
for that - so I'm relying on Selva's ACK and Jemmy Wang's test
results in GH #359 on "does it actually fix the bug".

Your patch has been applied to the master and release/2.6 branch.

commit 223baa9c9b818e4c542a9037f190f53ce6f7af5c (master)
commit 0caf0389454c75ae9dfeda096a820446d2d1a926 (HEAD -> release/2.6)
Author: Arne Schwabe
Date:   Mon May 22 12:11:38 2023 +0200

     Fix CR_RESPONSE mangaement message using wrong key_id

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230522101138.2842378-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26719.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


