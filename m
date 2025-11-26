Date: Wed, 26 Nov 2025 19:05:03 +0100 (CET)
Message-Id: <202511261805.5AQI53Im039296@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251126130410.19091-1-gert@...1296...>
References: <20251126130410.19091-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change '--multihome' behaviour
 regarding egress interface selection.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Tested with IPv4 and IPv6 on Linux and FreeBSD.

In the logs, the effect can be seen in

2025-11-26 19:03:35 us=135073 [server] Peer Connection Initiated with [AF_INET]199.102.77.82:51194 (via [AF_INET]194.97.140.11%[undef])

vs.

2025-11-26 19:03:26 us=817844 [server] Peer Connection Initiated with [AF_INET]199.102.77.82:51194 (via [AF_INET]194.97.140.11%enp0s18)

("if the interface shows up, 'same-interface' is in effect")

Patch has been applied to the master branch.

commit eeb866ac6ab3ee7df9148d18f05d909f05d7b77a
Author: Gert Doering
Date:   Wed Nov 26 14:04:03 2025 +0100

     Change '--multihome' behaviour regarding egress interface selection.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1383
     Message-Id: <20251126130410.19091-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34709.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


