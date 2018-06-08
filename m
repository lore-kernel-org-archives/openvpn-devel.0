Date: Fri, 8 Jun 2018 16:20:09 +0200 (CEST)
Message-Id: <201806081420.w58EK9jO009977@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1528229170-6175-1-git-send-email-selva.nair@...277...>
References: <1528229170-6175-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace M_DEBUG with D_LOW as
 the former is too verbose
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

Your patch has been applied to the master and release/2.4 branch
(I consider this a bugfix, as "someone" just didn't understand that
M_DEBUG is not for what it sounds it is - D_LOW makes sense)

commit 68441882e55b8e6c3c55a4078fbfdd76c7ada6bc (master)
commit 935d17062f68868fe922bbc446476b4de6fa3d45 (release/2.4)
Author: Selva Nair
Date:   Tue Jun 5 16:06:10 2018 -0400

     Replace M_DEBUG with D_LOW as the former is too verbose

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1528229170-6175-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16964.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


