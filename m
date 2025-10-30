Date: Thu, 30 Oct 2025 19:47:19 +0100 (CET)
Message-Id: <202510301847.59UIlJAg020887@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030182922.26448-1-gert@...1296...>
References: <20251030182922.26448-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: manage: Change kill_by_addr to
 use better types for port/proto
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

Note to self - do not apply "remove #pragma" patches because they look 
nice and easy, without ensuring that all related conversion fixes are
in *first*... - this one is missing to make things compile with -Werror 
again.

This in itself makes sense, and BB-all-green, and I should have applied
it in sequence :-)

Actually tested on the freebsd 14 BB ("master + this") and via GHA.

Your patch has been applied to the master branch.

commit cd4cac16555904ea8a8edcf0b669efb34f478609
Author: Frank Lichtenheld
Date:   Thu Oct 30 19:29:12 2025 +0100

     manage: Change kill_by_addr to use better types for port/proto

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1310
     Message-Id: <20251030182922.26448-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34054.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


