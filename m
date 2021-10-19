Date: Tue, 19 Oct 2021 17:25:46 +0200 (CEST)
Message-Id: <202110191525.19JFPko4091070@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019034118.28987-1-selva.nair@...277...>
References: <20211019034118.28987-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Require Windows CNG keys for
 cryptoapicert
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

I have not tested this, as I have no cryptoapi-environment around
(and especially no "old tokens").  I have test built with GH Actions
and it succeeded both on MSVC and MinGW :-)

Your patch has been applied to the master branch.

commit 60c83cce885d2f89d0cc150b730b409538a59625
Author: Selva Nair
Date:   Mon Oct 18 23:41:16 2021 -0400

     Require Windows CNG keys for cryptoapicert

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211019034118.28987-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22953.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


