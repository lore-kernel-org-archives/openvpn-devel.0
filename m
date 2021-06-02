Date: Wed, 2 Jun 2021 16:14:28 +0200 (CEST)
Message-Id: <202106021414.152EESZD029786@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210602034253.19984-3-selva.nair@...277...>
References: <20210602034253.19984-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix parsing of IV_SSO string
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

I have not tested anything ("for the archives"), but the change makes
sense, is not going to cause build failures anywhere :-) and Arne has
ACKed it.

Your patch has been applied to the master branch.

commit 28240c4a6e9e8134d6a62822918436dbd62b7fde
Author: Selva Nair
Date:   Tue Jun 1 23:42:53 2021 -0400

     Fix parsing of IV_SSO string

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210602034253.19984-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22474.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


