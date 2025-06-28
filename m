Date: Sat, 28 Jun 2025 18:22:32 +0200 (CEST)
Message-Id: <202506281622.55SGMWGH081720@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250626093006.24789-1-gert@...1296...>
References: <20250626093006.24789-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: run forced --dns-updown without
 --script-security
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for addressing this imbalance wrt --script-security - I have not
tested the various combinations, just --dns-updown $builddir/... 
in my t_client tests (still works, and correctly still requires
script-security).  A brief stare at the code also looks reasonable.

The message "I am going to run *this* script now" is still a bit barebones,
though ;-)

2025-06-28 18:18:00 ../distro/dns-scripts/dns-updown
2025-06-28 18:18:00 WARNING: External program may not be called unless '--script-security 2' or higher...

Your patch has been applied to the master branch.

commit cbf3621825c9e2f2542a370f4c049411c71d2329
Author: Heiko Hund
Date:   Thu Jun 26 11:30:00 2025 +0200

     run forced --dns-updown without --script-security

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250626093006.24789-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31994.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


