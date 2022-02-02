Date: Wed, 2 Feb 2022 20:25:23 +0100 (CET)
Message-Id: <202202021925.212JPNBY039295@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220101162532.2251835-6-arne@...1227...>
References: <20220101162532.2251835-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement optional mtu
 parameter for mssfix
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

Change makes sense, to take IPv4/IPv6 encap into account.

Code looks reasonable.

Tested with my previous mssfix test setup (and looking very carefully 
at tcpdump-reported "length" values, which one is "packet" and which 
one is "UDP encap" length :-) - that got me confused last time...).

 - BF-CBC, LZ4 (conf), --mssfix 1000 mtu, over IPv4
     v4 TCP -> MSS 890, resulting UDP payload 968, IP size 996 bytes
     v6 TCP -> MSS 870, resulting UDP payload 968, IP size 996 bytes
     (= OK, CBC rounding on 8 byte boundaries)
 - BF-CBC, LZ4 (conf), --mssfix 1000 mtu, over IPv6
     v4 TCP -> MSS 874, resulting UDP payload 952, IP size 1000 bytes
     v6 TCP -> MSS 854, resulting UDP payload 952, IP size 1000 bytes

 - AES256GCM, LZ4, --mssfix 1000 mtu, over IPv4
     v4 TCP -> MSS 907, resulting UDP payload 972, IP size 1000 bytes
     v6 TCP -> MSS 887, resulting UDP payload 972, IP size 1000 bytes
 - AES256GCM, LZ4, --mssfix 1000 mtu, over IPv6
     v4 TCP -> MSS 887, resulting UDP payload 952, IP size 1000 bytes
     v6 TCP -> MSS 867, resulting UDP payload 952, IP size 1000 bytes

"just for completeness" I've re-tested "without 'mtu'" for a few cases

  
 - BF-CBC, LZ4 (conf), --mssfix 1000 mtu, over IPv4
     v4 TCP -> MSS 922, resulting UDP payload 1000, IP size 1028 bytes
     v6 TCP -> MSS 902, resulting UDP payload 1000, IP size 1028 bytes

 - AES256GCM, LZ4, --mssfix 1000, over IPv4
     v4 TCP -> MSS 935, resulting UDP payload 1000, IP size 1028 bytes
     v6 TCP -> MSS 915, resulting UDP payload 1000, IP size 1028 bytes
 - AES256GCM, LZ4, --mssfix 1000, over IPv6
     v4 TCP -> MSS 935, resulting UDP payload 1000, IP size 1048 bytes
     v6 TCP -> MSS 915, resulting UDP payload 1000, IP size 1048 bytes

  (this is "as before", so the previously documented behaviour is not
   broken)


The "if (p[2]..." part of options.c is not perfect (it will check this
even if p[1] was already found to be NULL) but given the calling 
environment, it's well defined as all of p[] is CLEAR()ed on every 
line.

As discussed on IRC, I have adjusted the man page entry somewhat
(1473 was just plain wrong, 1478 is correct math, but I found the
"pass IPv4 packets" text still misleading wrt inside/outside IPv4)


For reference, this was 13/21 in the v1 and v2 series, got feedback
from Frank Lichtenheld.  I have adjusted the commit message according
to this (make the sentence a bit clearer).  The RST formatting comments
have been addressed in v2.

Your patch has been applied to the master branch.

commit 0fcb7cadb225d7f43e29c3ad6a1e9c34abbb8a63
Author: Arne Schwabe
Date:   Sat Jan 1 17:25:23 2022 +0100

     Implement optional mtu parameter for mssfix

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220101162532.2251835-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23495.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


