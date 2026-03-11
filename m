Date: Wed, 11 Mar 2026 15:57:21 +0100 (CET)
Message-Id: <202603111457.62BEvLFD021674@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260306162925.2359-1-gert@...1296...>
References: <20260306162925.2359-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: Avoid sign-compare issues
 in tun_read_queue
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

Changes all look good, and make BB happy.

Eventually we might be able to get rid of all these tap driver warnings :-)

Your patch has been applied to the master branch.

commit 4f98585e40ee370ace71cd6ef379d01b4c516460
Author: Frank Lichtenheld
Date:   Fri Mar 6 17:29:19 2026 +0100

     tun: Avoid sign-compare issues in tun_read_queue

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1525
     Message-Id: <20260306162925.2359-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35956.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


