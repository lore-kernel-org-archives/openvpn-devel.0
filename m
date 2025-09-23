Date: Tue, 23 Sep 2025 17:40:05 +0200 (CEST)
Message-Id: <202509231540.58NFe5bX021453@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250923151050.27336-1-gert@...1296...>
References: <20250923151050.27336-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socks: factor out
 socks_proxy_recv_char()
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

This is not truly part of the "trivial integer related fixes" series,
more of the "ugh, how did we accept such horrible code, ever?" version...

I have stared-at-code a while, and then ran all the SOCKs test (admittedly
only "successful", so not testing timeouts and the like) but since this
is really 1:1 the same code (except for "return false" in the new function),
I do not expect surprises there.  Tests all pass ;-)

Your patch has been applied to the master branch.

commit 9178a8ce73e9c5dd259522aa5e100116b965725b
Author: Frank Lichtenheld
Date:   Tue Sep 23 17:10:44 2025 +0200

     socks: factor out socks_proxy_recv_char()

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1165
     Message-Id: <20250923151050.27336-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33171.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


