Date: Thu, 16 Oct 2025 13:20:53 +0200 (CEST)
Message-Id: <202510161120.59GBKrRm029503@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251016103143.4461-1-gert@...1296...>
References: <20251016103143.4461-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: proxy: factor out recv_char
 code common with socks proxy
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

Stared-at-code, and at "git show --color-moved", ran client/server tests
on the linux testbed (which excercises all the proxy variants except NTLM).

Test compiled on MinGW, BBs all green as well.

Your patch has been applied to the master branch.

commit 9443371628755b01161a4efa55f23fb67859874a
Author: Frank Lichtenheld
Date:   Thu Oct 16 12:31:35 2025 +0200

     proxy: factor out recv_char code common with socks proxy

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1278
     Message-Id: <20251016103143.4461-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59247456/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


