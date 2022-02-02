Date: Wed, 2 Feb 2022 14:20:48 +0100 (CET)
Message-Id: <202202021320.212DKmat028357@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220124025459.1042317-1-arne@...1227...>
References: <20220124025459.1042317-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change buffer allocation
 calculation and checks to be more static
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

Acked-by: Gert Doering <gert@...1296...>

Tested on client and server side, all "regular" stuff works, but
it breaks my TCP/P2P/P2P-NCP test case for big packets, namely...

2022-02-02 12:57:19 TCP/UDP packet too large on write to [AF_INET6]2001:608:0:814::f000:11:51204 (tried=1520,max=1499)

(expected result: oversized packet, fragment/segment on outer layer)

After discussion on IRC, decided to go forward anyway, as this is only
one specific corner case (P2P NCP), and it gets fixed for good in 13/14 
- removing EXPANDED_SIZE() in forward.c, replacing it with just 
"buf.payload_size", which always has "sufficient headroom" - tested,
fixes this corner case, doesn't break anything else.


(For reference, this was 10/21 in v1 of the patchset, 03/14 in v3, and
standalone patches v4+v5 - but neither of the previous ones got an ACK
or NAK, just MaxF finding ways to crash v3 and v4 ;-) )

Your patch has been applied to the master branch.

commit 65a21eb14f4afd80864e88ff425f5d9ef8d8fdec
Author: Arne Schwabe
Date:   Mon Jan 24 03:54:59 2022 +0100

     Change buffer allocation calculation and checks to be more static

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220124025459.1042317-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23638.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


