Date: Thu, 29 Dec 2022 16:40:10 +0100 (CET)
Message-Id: <202212291540.2BTFeAWJ058856@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221229134729.1474034-1-selva.nair@...277...>
References: <20221229134729.1474034-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Properly unmap ring buffer
 file-map in interactive service
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

I have not tested this beyond "push to github, see MSVC compile succeed"
(but trust Selva and Lev to get this right, and the code change seems
to match the discussion in the issue)

Your patch has been applied to the master and release/2.6 branch.

commit 64f8833e119e31cf01dfe198538fbb5566fabf8f (master)
commit f87aed6ae2f6c4165b19c00fe4d39c44232cf44e (release/2.6)
Author: Selva Nair
Date:   Thu Dec 29 08:47:29 2022 -0500

     Properly unmap ring buffer file-map in interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20221229134729.1474034-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25859.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


