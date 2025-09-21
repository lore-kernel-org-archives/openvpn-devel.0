Date: Sun, 21 Sep 2025 19:45:45 +0200 (CEST)
Message-Id: <202509211745.58LHjjjD027790@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250915110507.20557-1-sebastian-git-2016@...2913...>
References: <20250915110507.20557-1-sebastian-git-2016@...2913...>
Subject: [Openvpn-devel] [PATCH applied] Re: Bugfix: Set broadcast address
 on interface.
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
To: Sebastian Marsching <sebastian-git-2016@...2913...>
Cc: openvpn-devel@lists.sourceforge.net

I have tested this on Linux "without DCO" and "with DCO", client 
and server.  The non-DCO server version isn't really helpful as it
puts all tun interface into p2p mode ("routing happens inside OpenVPN"),
but the TAP interfaces shows the expected "broadcast" setting - as does
the "tun / topology subnet" client.  On the DCO "tun" servers the 
handling of routes/iroutes is different, and the expected netmask + brd
shows up.  And the tests still pass :-)

Your patch has been applied to the master and release/2.6 branch
(whether it's "a bugfix" stands to be debated - but it is not very
intrusive and has passed all my system tests, and if the lack of
broadcast did break people's working 2.5 setups they will well
consider it a "bug"... so, "bugfix")

commit 0df0edc49ce4acb96c8e16bdf0fcee1eedfd91f0 (master)
commit 4e46e727217cf58c7c671e36e8417e469c4e3b1d (release/2.6)
Author: Sebastian Marsching
Date:   Mon Sep 15 13:05:07 2025 +0200

     Bugfix: Set broadcast address on interface.

     Signed-off-by: Sebastian Marsching <sebastian-git-2016@...2913...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20250915110507.20557-1-sebastian-git-2016@...2913...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33131.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


