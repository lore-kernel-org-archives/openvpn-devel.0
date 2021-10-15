Date: Fri, 15 Oct 2021 17:10:53 +0200 (CEST)
Message-Id: <202110151510.19FFArpe087849@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211015043227.10679-1-selva.nair@...277...>
References: <20211015043227.10679-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix the default tls-version-min
 setting
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

Arne beat me to it (I briefly looked at the patch yesterday when it
came in, noted "it makes sense" and was distracted...).  So, yeah,
thanks for fixing our oversights.

I have not tested (beyond "it compiles") but staring at the code 
looks very reasonable.   The "|=" without masking out the corresponding
bits is something I double-checked but it is safe, as we already know 
"they are all 0".

Your patch has been applied to the master branch.

commit 51be733ba236610dff6a1c361cf59172db97473a
Author: Selva Nair
Date:   Fri Oct 15 00:32:27 2021 -0400

     Fix the default tls-version-min setting

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211015043227.10679-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22939.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


