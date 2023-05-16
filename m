Date: Tue, 16 May 2023 12:12:35 +0200 (CEST)
Message-Id: <202305161012.34GACZgY045798@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230515155407.38647-1-frank@...2641...>
References: <20230515155407.38647-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix two unused assignments
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Quite obvious, if you look at it" :-) - since one of this is Windows,
I have at least compile-tested this on MinGW.

Your patch has been applied to the master and release/2.6 branch.

commit b5cf76cbdc0d7ef2817b71f4611d99455e2d48ea (master)
commit eb9fffe64a095a881db848839aef6960e1402ca6 (release/2.6)
Author: Frank Lichtenheld
Date:   Mon May 15 17:54:07 2023 +0200

     Fix two unused assignments

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230515155407.38647-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26662.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


