Date: Sat, 25 Feb 2023 17:04:29 +0100 (CET)
Message-Id: <202302251604.31PG4TTq076782@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230216160129.994-1-lstipakov@...277...>
References: <20230216160129.994-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add logging for windows driver
 selection process
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

While I do have no idea about windows drivers and such, having some
helpful debug output for "adapter not found" issues is good.

I have stared at the code for a bit, and it's all fairly trivial
msg()'ing of strings and integers (plus an M_ERRNO added in one
of the error paths).  MinGW compile says "it's the correct data
types for each msg() call", so, good enough for me :-)

Your patch has been applied to the master and release/2.6 branch.

commit 5b748ad099ed69b893124e2805b5ddeb6b0ec8fc (master)
commit dff1e78957fa97b3258d5e1b0ef05ad3f853ada2 (release/2.6)
Author: Lev Stipakov
Date:   Thu Feb 16 18:01:29 2023 +0200

     Add logging for windows driver selection process

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230216160129.994-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26281.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


