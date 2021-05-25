Date: Tue, 25 May 2021 22:33:33 +0200 (CEST)
Message-Id: <202105252033.14PKXX7C041557@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210522033232.20548-2-selva.nair@...277...>
References: <20210522033232.20548-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use C standard compliant format
 specs in wprintf functions
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

As with the last patch, I have not tested this - relying on Lev.  I have
looked at the changes a bit and "they do what it says on the tin" (though
I have not explicitly verified each char/wchar <-> %hs/%ls mapping).

Your patch has been applied to the master branch.

commit ea2b153c35723fc2bbcf54ef191a6f0e0ee5371a
Author: Selva Nair
Date:   Fri May 21 23:32:31 2021 -0400

     Use C standard compliant format specs in wprintf functions

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210522033232.20548-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22436.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


