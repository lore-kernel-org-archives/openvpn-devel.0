Date: Thu, 6 Jun 2024 13:33:24 +0200 (CEST)
Message-Id: <202406061133.456BXOgs047085@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240606103441.26598-1-gert@...1296...>
References: <20240606103441.26598-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement Windows CA template
 match for Crypto-API selector
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
To: Heiko Wundram <heiko.wundram@...2614...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks, Selva, for the review.

I have not tested this beyond "does it make GH actions happy",
"does it build on the local mingw setup" (it does) and "does
the code look generally safe wrt memory etc" (it does).

As instructed I have removed the "and fallback requested" part
from the comment where "fallback" was removed from the code.

Your patch has been applied to the master branch.

commit 13ee7f902f18e27b981f8e440facd2e6515c6c83 (master)
Author: Heiko Wundram
Date:   Thu Jun 6 12:34:41 2024 +0200

     Implement Windows CA template match for Crypto-API selector

     Signed-off-by: Heiko Wundram <heiko.wundram@...2614...>
     Signed-off-by: Hannes Domani <ssbssa@...360...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20240606103441.26598-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28726.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


