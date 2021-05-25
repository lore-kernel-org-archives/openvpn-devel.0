Date: Tue, 25 May 2021 22:25:51 +0200 (CEST)
Message-Id: <202105252025.14PKPpCS041390@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210522033232.20548-1-selva.nair@...277...>
References: <20210522033232.20548-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make it explicit that WIndows
 build requires UNICODE support
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

Have not tested anything, just looked a bit at the changes.  ACK from 
Lev is good enough :-) - and getting rid of #ifdef is even better.

Your patch has been applied to the master branch.

commit 455d0997931f968ed8c42812106c44941c4ca69b
Author: Selva Nair
Date:   Fri May 21 23:32:30 2021 -0400

     Make it explicit that WIndows build requires UNICODE support

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210522033232.20548-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22437.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


