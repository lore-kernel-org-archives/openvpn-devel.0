Date: Fri, 5 Nov 2021 21:54:45 +0100 (CET)
Message-Id: <202111052054.1A5KsjvH092638@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211102042314.19113-1-selva.nair@...277...>
References: <20211102042314.19113-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix tls-version-min default
 once again
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

Thanks.  The old one "looked good", but the MIN_MASK would have needed
a shift (indeed) and this way it's more readable anyway.

I have not tested this beyond "it compiles and passes make check".

Your patch has been applied to the master branch.

commit 3037d2bd348eb184ed924a590012a23f68a1b47f
Author: Selva Nair
Date:   Tue Nov 2 00:23:14 2021 -0400

     Fix tls-version-min default once again

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211102042314.19113-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23091.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


