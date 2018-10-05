Date: Fri, 5 Oct 2018 14:46:36 +0200 (CEST)
Message-Id: <201810051246.w95CkatL041866@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1538510474-27602-1-git-send-email-selva.nair@...277...>
References: <1538510474-27602-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move get system directory to a
 separate function
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

Another ACK from me, looks good.

Your patch has been applied to the master and release/2.4 branch.

(This is refactoring so normally shouldn't go to 2.4, but since the 
"set interface to DHCP" patch really is really fixing an omission in 
the initial 2.4 interactive service implementation, I see this as a 
necessary prerequisite to a bugfix)

Test compiled on ubuntu1604/mingw, did not actually run.

commit 4eb465537ce06e07ee63c2fc93c7b192dd4e29de (master)
commit f0516a803fdcf588be67159a240d6ec840ad0090 (release/2.4)
Author: Selva Nair
Date:   Tue Oct 2 16:01:12 2018 -0400

     Move get system directory to a separate function

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Alon Bar-Lev <alon.barlev@...277...>
     Message-Id: <1538510474-27602-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17518.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


