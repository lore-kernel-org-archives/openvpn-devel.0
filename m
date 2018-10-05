Date: Fri, 5 Oct 2018 15:24:55 +0200 (CEST)
Message-Id: <201810051324.w95DOtmi042348@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1538510474-27602-2-git-send-email-selva.nair@...277...>
References: <1538510474-27602-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable dhcp on tap adapter
 using interactive service
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

Another ACK from me.  Code looks good.  Thanks.

Your patch has been applied to the master and release/2.4 branch (bugfix,
so openvpn 2.4.x on windows can fully run unprivileged).

Test compiled on ubuntu 16.04 / mingw, not actually run.

commit b4fc8bbd6b1d0211dd6982c4accedfbe4ae7e3ed (master)
commit 78d4f0ad106720d8988e144f6d30ec11d84dee2f (master)
Author: Selva Nair
Date:   Tue Oct 2 16:01:13 2018 -0400

     Enable dhcp on tap adapter using interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1538510474-27602-2-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17517.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


