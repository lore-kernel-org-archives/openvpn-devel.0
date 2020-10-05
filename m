Date: Mon, 5 Oct 2020 08:52:16 +0200 (CEST)
Message-Id: <202010050652.0956qGe0072456@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200825073643.15920-1-arne@...1227...>
References: <20200825073643.15920-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move openvpn specific key
 expansion into its own function
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

Your patch has been applied to the master branch.

(Since this is only needed for the new PRF functionality and it's
very unlikely that we'll see bugfixes for "master *and* 2.5" for this
code in future, the refactoring is also not needed in 2.5)

Whitespace has been fixed :-) (we really need T-Shirts with
"the whitespace dragon made me do this" on them...)

Tested on the client side against an umodified server, works fine.

commit 15d0524327a10c2999f37375688196f8452f1029
Author: Arne Schwabe
Date:   Tue Aug 25 09:36:42 2020 +0200

     Move openvpn specific key expansion into its own function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Message-Id: <20200825073643.15920-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20815.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


