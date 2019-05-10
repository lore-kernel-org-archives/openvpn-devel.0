Date: Fri, 10 May 2019 17:38:42 +0200 (CEST)
Message-Id: <201905101538.x4AFcgP2090601@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1540889615-24868-1-git-send-email-lstipakov@...277...>
References: <1540889615-24868-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix various compiler warnings
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

Your patch has been applied to the master and release/2.4 branch.

Why 2.4?  Because since this changes the calling convention of quite a 
number of functions (by removing never-used arguments) I'm fairly sure it 
will get in the way of future bugfixes that tackle "related code" - and
*those* need to go to 2.4.  So take this in, even if "refactoring" is
normally not done here.  But these are very straightforward changes.

commit 91ba1add2f8f231a7ccf4557cdd593547e625723 (master)
commit 0c1cc8d65539f5e156866056df9074d47bc3ed4b (release/2.4)
Author: Lev Stipakov
Date:   Tue Oct 30 10:53:35 2018 +0200

     Fix various compiler warnings

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1540889615-24868-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17855.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


