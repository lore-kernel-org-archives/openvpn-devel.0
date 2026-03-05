Date: Thu, 5 Mar 2026 09:29:25 +0100 (CET)
Message-Id: <202603050829.6258TPRT078666@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260304164502.15449-1-gert@...1296...>
References: <20260304164502.15449-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: cryptoapi: Change signature of
 parse_hexstring to match code
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

This has had an ACK quite a while ago, but the prerequisite patch that
adds all these #pragmas-to-be-removed was not in yet... so here we go.

Change makes sense, BB happy, ACK from Antonio :-) - and unittest as well!

Your patch has been applied to the master branch.

commit 3451c18fe1a8afb288a55704295cc89c4eadce8b
Author: Frank Lichtenheld
Date:   Wed Mar 4 17:44:55 2026 +0100

     cryptoapi: Change signature of parse_hexstring to match code

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1492
     Message-Id: <20260304164502.15449-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35901.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


