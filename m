Date: Thu, 20 Jun 2024 17:20:57 +0200 (CEST)
Message-Id: <202406201520.45KFKvYH024170@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240620144230.19586-1-gert@...1296...>
References: <20240620144230.19586-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Add
 -Wstrict-prototypes and -Wold-style-definition
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

"Because it makes sense" - we try to keep our style consistent and clean,
and this will ensure we'll notice new commits with func() instead of
func(void) prototypes.  Plus fixing the inconsistencies we already had.

The buildbots and GH say "this works on all supported platforms", so in
it goes.

Your patch has been applied to the master branch.

commit 56355924b4945ec808500b18c714c111387697f9
Author: Frank Lichtenheld
Date:   Thu Jun 20 16:42:30 2024 +0200

     configure: Add -Wstrict-prototypes and -Wold-style-definition

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240620144230.19586-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28823.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


