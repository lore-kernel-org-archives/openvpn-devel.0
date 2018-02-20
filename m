Date: Tue, 20 Feb 2018 13:23:53 +0100 (CET)
Message-Id: <201802201223.w1KCNrwC066890@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1511026858-23281-1-git-send-email-selva.nair@...277...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure strings read from
 registry are null-terminated
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Because it makes sense" (checked with the Windows API documentation, and
compile-tested on ubuntu 16.04).

Your patch has been applied to the master and release/2.4 branch.

There was one issue with your patch that you might want to look into - it
seems to be based on a private branch that has a "#define REG_KEY" which
does not exist in my tree, and which I could not find any references to
on the mailing list either.  It broke applying the patch as it appeared
in patch context - but since none of the actual code line reference this,
I decided to apply the patch nonetheless (it has been lingering for way
too long already).

commit b1263b06db40f21a8fd20e0efd0c12e37ce89a2c (master)
commit b00dab5422669fca7304f4af111b7c259b8a0a55 (release/2.4)
Author: Selva Nair
Date:   Sat Nov 18 12:40:57 2017 -0500

     Ensure strings read from registry are null-terminated

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1511026858-23281-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15893.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


