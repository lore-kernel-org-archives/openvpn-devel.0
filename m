Date: Sat, 18 Oct 2025 18:48:28 +0200 (CEST)
Message-Id: <202510181648.59IGmSGL032274@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251017205730.8450-1-gert@...1296...>
References: <20251017205730.8450-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: route: Add #endif comment for
 uncrustify compliance
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Yeah, this is a really silly edge-case - you fix one -Werror fail, and
that triggers an uncrustify style violation.  No code change, so nothing
to test here...

Your patch has been applied to the release/2.6 branch.

commit cf6c12f92af4391d82b1ca8e235c4cefde9ef5d2
Author: Frank Lichtenheld
Date:   Fri Oct 17 22:57:24 2025 +0200

     route: Add #endif comment for uncrustify compliance

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1284
     Message-Id: <20251017205730.8450-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33428.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


