Date: Mon, 10 Feb 2020 11:16:05 +0100 (CET)
Message-Id: <202002101016.01AAG55s019517@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1581309200-27870-1-git-send-email-selva.nair@...277...>
References: <1581309200-27870-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Swap the order of checks for
 validating interactive service user
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

Your patch has been applied to the master branch.

I have not tested this in any way, but since Lev has reviewed & tested 
v2 (and found a bug) and reviewed & tested v3, I do not think I would
add much value anyway.

commit c6cc66a13568dd1078bfbeb763998c1b9e2a2999
Author: Selva Nair
Date:   Sun Feb 9 23:33:20 2020 -0500

     Swap the order of checks for validating interactive service user

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1581309200-27870-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19388.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


