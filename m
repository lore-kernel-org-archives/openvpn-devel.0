Date: Wed, 16 Oct 2024 11:57:22 +0200 (CEST)
Message-Id: <202410160957.49G9vM7j099821@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241015205643.25779-1-gert@...1296...>
References: <20241015205643.25779-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Simplify macOS builds
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

Tested via my GH repo.  To ease 2.6 maintenance, I think it might be
reasonable to have this in 2.6 as well - but the patch does not apply
"as is" (and I did not spend more time to look why).  Maybe a backport
of "GHA changes we want to have in 2.6" as one patch referencing the
relevant master patches?

Your patch has been applied to the master branch.

commit 33a700d61e5b1a724b00f17fa0ed75d694e2823a
Author: Frank Lichtenheld
Date:   Tue Oct 15 22:56:43 2024 +0200

     GHA: Simplify macOS builds

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
     Message-Id: <20241015205643.25779-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29552.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


