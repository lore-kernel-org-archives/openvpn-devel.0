Date: Sat, 24 Jan 2026 17:02:03 +0100 (CET)
Message-Id: <202601241602.60OG23pR045598@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260120155547.116088-1-frank@...2641...>
References: <20260120155547.116088-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Fix conversion
 warnings in interactive.c
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

This is windows related, so I can't really test this (beyond "does it
compile?").  Took a few attempts discussing "length" and "size", but now
everbody seems to be happy - thanks to Heiko for the review.

(I do think "length" inside RegWStringSize() should also be named "size",
though, but that can be done in a followup patch - proceeding here, because
I want the unit tests in, and this is prerequisite)

Your patch has been applied to the master branch.

commit fdfe0abeefaf74a0be011688af068929cbd9d246
Author: Frank Lichtenheld
Date:   Tue Jan 20 16:55:47 2026 +0100

     openvpnserv: Fix conversion warnings in interactive.c

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Heiko Hund <heiko@...515...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1457
     Message-Id: <20260120155547.116088-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35356.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


