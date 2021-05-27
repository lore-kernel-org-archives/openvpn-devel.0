Date: Thu, 27 May 2021 09:26:37 +0200 (CEST)
Message-Id: <202105270726.14R7Qbax072812@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210526224919.511-1-selva.nair@...277...>
References: <20210526224919.511-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace TEXT(__FUNCTION__) by
 __FUNCTION__ in openvpnmscia.c
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

Change looks reasonable and matches the explanation.  Not tested.

Your patch has been applied to the master branch.

commit 890225c1783d0f11b2092495ff902a46d7d0d4cd
Author: Selva Nair
Date:   Wed May 26 18:49:19 2021 -0400

     Replace TEXT(__FUNCTION__) by __FUNCTION__ in openvpnmscia.c

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210526224919.511-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22461.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


