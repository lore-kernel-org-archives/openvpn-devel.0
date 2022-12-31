Date: Sat, 31 Dec 2022 11:18:33 +0100 (CET)
Message-Id: <202212311018.2BVAIXgn001068@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221229182739.1477336-1-selva.nair@...277...>
References: <20221229182739.1477336-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use undo_lists for saving
 ring-buffer handles in interactive service
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

Thanks for bringing this in-line with the existing code style.  Light
glance-at-code looks reasonable - and there's an ACK from Lev anyway :-)

Not tested further.

Your patch has been applied to the master and release/2.6 branch.

commit 6ea9cf8146b1d72aa6a4790bc3ac2b99562b2cac (master)
commit fc96b8793ca94c23e5dc229aa1455d747cef4766 (HEAD -> release/2.6)
Author: Selva Nair
Date:   Thu Dec 29 13:27:38 2022 -0500

     Use undo_lists for saving ring-buffer handles in interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20221229182739.1477336-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25864.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


