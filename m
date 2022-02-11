Date: Fri, 11 Feb 2022 10:55:43 +0100 (CET)
Message-Id: <202202110955.21B9thV6087498@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220210162632.3309974-2-arne@...1227...>
References: <20220210162632.3309974-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change the default for mssfix
 to mssfix 1492 mtu
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

The code does what it says on the lid, and the resulting program run
confirms it:

2022-02-11 10:43:41 us=304654   mssfix = 1492
2022-02-11 10:43:41 us=304660   mssfix_encap = ENABLED

I have not actually tested the resulting SYN/SYN-ACK values for IPv4
transport, as the other end of my test setup is on an older code base 
and would interfere with the tests (both sides modify MSS by default, 
in both directions, and the one with the lower MSS value "wins").  I 
have tested "mssfix ... mtu" before, so I'm reasonably sure it will 
do the right thing for "1492 mtu" now.

It does the right thing, for IPv6, though :-)

 - IPv4 over IPv6, BF-CBC -> mss 1362 -> UDP payload 1440, IPv6 len 1488
 - IPv6 over IPv6, BF-CBC -> mss 1342 -> UDP payload 1440, IPv6 len 1488
 - IPv6 over IPv4, AES-GCM -> mss 1379 -> UDP payload 1444, IPv6 len 1492
 - IPv6 over IPv6, AES-GCM -> mss 1359 -> UDP payload 1444, IPv6 len 1492


For reference, this was 07/14 in v3 of the patchset, and was neither
ACKed nor NAKed there (I had the same concerns as I voiced in my
preceding e-mail here, but did only mention them on IRC).

Your patch has been applied to the master branch.

commit 0d86da32695539a96848b96149484af41bba83c5
Author: Arne Schwabe
Date:   Thu Feb 10 17:26:26 2022 +0100

     Change the default for mssfix to mssfix 1492 mtu

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220210162632.3309974-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23754.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


