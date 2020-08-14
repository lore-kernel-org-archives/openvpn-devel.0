Date: Fri, 14 Aug 2020 14:40:51 +0200 (CEST)
Message-Id: <202008141240.07ECepJL017678@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200813101301.12720-1-gert@...1296...>
References: <20200813101301.12720-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix stack overflow in
 OpenSolaris NEXTADDR()
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master, 2.5 and 2.4 branch (bugfix).

commit 7e65483d1227adfb855844467e4d30894ffc355d (master)
commit 7b9dd9b091a3cad126642314ea945bafa4e91481 (release/2.5)
commit 5f88c077de8da4a4c5369ae67f5815e4abc50edc (release/2.4)
Author: Gert Doering
Date:   Thu Aug 13 12:13:01 2020 +0200

     Fix stack overflow in OpenSolaris NEXTADDR()

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200813101301.12720-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20731.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


