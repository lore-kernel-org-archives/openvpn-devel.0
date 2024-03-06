Date: Wed, 6 Mar 2024 10:41:33 +0100 (CET)
Message-Id: <202403060941.4269fX86023186@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240304163313.2326923-1-frank@...2641...>
References: <20240304163313.2326923-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re:
 openvpn-[client|server].service: Remove syslog.target
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
To: Martin Rys <martin@...2790...>
Cc: openvpn-devel@lists.sourceforge.net

I have no idea and I do not want to know details about systemd, but
the explanation "this target has not existed for a long time" makes
sense, plus it has an ACK from someone who does understand Linux ;-)

Your patch has been applied to the master and release/2.6 branch.

commit 15b74036a9b180e862ed4cb23f1e351c08706527 (master)
commit 04e682653993212b1b7f9432791e325d92c470b6 (release/2.6)
Author: Martin Rys
Date:   Mon Mar 4 17:33:13 2024 +0100

     openvpn-[client|server].service: Remove syslog.target

     Signed-off-by: Martin Rys <martin@...2790...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240304163313.2326923-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28318.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


