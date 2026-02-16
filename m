Date: Mon, 16 Feb 2026 16:19:30 +0100 (CET)
Message-Id: <202602161519.61GFJUS4068307@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260216145205.14958-1-gert@...1296...>
References: <20260216145205.14958-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove NTLM support
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

So this is the first "real 2.8" patch - removing NTLM support.  This code
base was in need for an overhaul for a long time, but if Microsoft drops
NTLM anyway, so can we... (if people come running and screaming, we can
bring it back :-) )

Stared-at-code (easy), and had buildbot compile & test it.

Your patch has been applied to the master branch.

commit 70ab9347f893a34010a0fa39722c597f1754b8da
Author: Frank Lichtenheld
Date:   Mon Feb 16 15:51:59 2026 +0100

     Remove NTLM support

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1453
     Message-Id: <20260216145205.14958-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35650.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


