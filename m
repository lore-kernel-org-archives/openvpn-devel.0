Date: Mon, 14 Nov 2022 12:19:26 +0100 (CET)
Message-Id: <202211141119.2AEBJQem085526@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221109154810.1268403-1-arne@...1227...>
References: <20221109154810.1268403-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow tun-mtu to be pushed
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

This is a step towards being able to adjust MTU in a server-controlled
way, and to either enable large-MTU setups (9000), or to reduce MTU
to "outside packets never need to be fragmented".  This does not change
defaults, so no behavioural changes are to be expected.

Thanks to all the previous reviewers - since v5 is a bit different again,
I've only recorded my own ACK, but the previous reviews helped.


Stare-at-code I was wondering why we introduce a new OPT_P_PUSH_MTU
now, but this is needed for "changed option handling".

Tested on the generic testbed, and then with a server instance pushing
"tun-mtu 1300" and t_client on the other end (leading to a semi-intentional
MTU mismatch).  Works, as the buffers are always sized appropriately
(and, interstingly enough, the OS tun interfaces accept incoming 1500 byte
packets even if set to mtu 1300).

Modifications, as discussed on IRC:

 - removed the "Cipher is considered safe" comment, this code does not
   exist anymore
 - reworded the error message to "Server-pushed tun-mtu is too large, ..."
 - reworded the manpage slightly, to document that reducing the max-mtu
   (below the 1600 default) is not possible

Your patch has been applied to the master branch.

commit 01aed6a5df193a09d8d3c28c5a1580241e0a5e05
Author: Arne Schwabe
Date:   Wed Nov 9 16:48:09 2022 +0100

     Allow tun-mtu to be pushed

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221109154810.1268403-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25498.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


