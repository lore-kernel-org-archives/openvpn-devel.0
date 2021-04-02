Date: Fri, 2 Apr 2021 20:16:02 +0200 (CEST)
Message-Id: <202104021816.132IG2w4032861@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <E1lRfW3-0001sy-VM@...2508...>
References: <E1lRfW3-0001sy-VM@...2508...>
Subject: [Openvpn-devel] [PATCH applied] Re: reliable: retransmit if 3
 follow-up ACKs are received
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have never looked into this reliable stuff before, and do not have
a test environment with a) significant amounts of control plane traffic,
and b) "just the right amount" of packet loss.  So I've just stared at
the code a bit (seems reasonable) and tested client side on Linux
(works).

I do wonder a bit under which condition this could fire - with the
larger control channel packets we introduced a few years ago, I do
not see many scenarios where "more than 3 packets" could be in-flight
at the same time...  inital TLS handshake with very large DH groups?

commit 203afbe95ee324ec941e35399f6655dc4f669f12
Author: Steffan Karger
Date:   Wed Mar 31 20:03:23 2021 +0200

     reliable: retransmit if 3 follow-up ACKs are received

     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <E1lRfW3-0001sy-VM@...2508...>
     URL: https://www.mail-archive.com/search?l=mid&q=E1lRfW3-0001sy-VM@...2508...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


