Date: Sun, 4 Mar 2018 10:04:07 +0100 (CET)
Message-Id: <201803040904.w24947RE033144@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <52e860ea74ac958309368374049f14bd.squirrel@...2257...>
References: <52e860ea74ac958309368374049f14bd.squirrel@...2257...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add missing #ifdef
 SSL_OP_NO_TLSv1_1/2
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
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the release/2.4 branch.

(I've added a commit message explaining what Selva wrote about the
cherrypick etc., setting you as author)

commit 88abb911ea22a306e87fba58410da45c2baad57f
Author: Simon Matter
Date:   Fri Mar 2 08:49:31 2018 +0100

     Add missing #ifdef SSL_OP_NO_TLSv1_1/2

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <52e860ea74ac958309368374049f14bd.squirrel@...2257...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16588.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


