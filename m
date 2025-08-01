Date: Fri, 1 Aug 2025 15:30:54 +0200 (CEST)
Message-Id: <202508011330.571DUsOE033270@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250801130302.372311-1-frank@...2641...>
References: <20250801130302.372311-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco linux: avoid redefining
 ovpn enums (2.6)
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

As the commit message says, this is a backport of the master commit
1d3c2b67a73a with a slight change in the header inclusion order (needed
for the 2.6 code base).  Antonio has ACKed it, the BBs confirm it does not
break anything.

Your patch has been applied to the release/2.6 branch.

commit 1fbbe91d292fb925f5af73b512d7d1c83abfe714
Author: Frank Lichtenheld
Date:   Fri Aug 1 15:03:02 2025 +0200

     dco linux: avoid redefining ovpn enums (2.6)

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Message-Id: <20250801130302.372311-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32470.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


