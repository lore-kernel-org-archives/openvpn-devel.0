Date: Mon, 5 May 2025 17:00:26 +0200 (CEST)
Message-Id: <202505051500.545F0Qca017508@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250505142224.24935-1-gert@...1296...>
References: <20250505142224.24935-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add information-gathering about
 DNS resolvers configured to t_client.sh(.in)
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

Thanks for the review.

Patch has been tested on ubuntu 20.04 with systemd-resolvd and FreeBSD
with resolvconf (cat /etc/resolv.conf), and BB has tested all the other
platforms (... to the point that nothing breaks, the DNS stuff is still
not in yet).

Patch has been applied to the master branch.

commit b4e31e57bc69819e6ea61ea1bc08ad199b2be272
Author: Gert Doering
Date:   Mon May 5 16:22:16 2025 +0200

     Add information-gathering about DNS resolvers configured to t_client.sh(.in)

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250505142224.24935-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31568.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


