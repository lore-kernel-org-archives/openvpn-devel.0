Date: Fri, 11 Sep 2020 11:55:13 +0200 (CEST)
Message-Id: <202009110955.08B9tDVh057559@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1599689729-25906-1-git-send-email-selva.nair@...277...>
References: <1599689729-25906-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a remark on dropping
 privileges when --mlock is used
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

Additional documentation of possible consequences of --mlock + --user is 
good, and pointers to "what to do about it" are always useful :-)

Your patch has been applied to the master and release/2.5 branch.

I have not backported it to .8 format for 2.4 - I do not think it's
critically important enough to to so.

commit 5b815eb449314a43e2b73325948edea8a4cfb215 (master)
commit be68b361a9c95218c671ee86d25a29019bab7239 (release/2.5)
Author: Selva Nair
Date:   Wed Sep 9 18:15:29 2020 -0400

     Add a remark on dropping privileges when --mlock is used

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1599689729-25906-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20937.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


