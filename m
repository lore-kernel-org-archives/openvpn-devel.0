Date: Mon, 29 Dec 2025 17:09:20 +0100 (CET)
Message-Id: <202512291609.5BTG9KxW030129@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251219134706.164040-1-frank@...2641...>
References: <20251219134706.164040-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix warnings on Android about
 unused variables/methods
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is much better than the previous one - not adding #ifdef's, but actually
taking some away - nice trick that ;-)

BB says "it compiles for all platforms, including Android, with no warnings
anymore".  GHA is happy as well.  So is Frank.  In it goes!

Your patch has been applied to the master branch.

commit 4859d259f2eccb1dae7c432da944ba93467d1d5d
Author: Arne Schwabe
Date:   Fri Dec 19 14:47:06 2025 +0100

     Fix warnings on Android about unused variables/methods

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/894
     Message-Id: <20251219134706.164040-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35156.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


