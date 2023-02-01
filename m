Date: Wed, 1 Feb 2023 17:27:21 +0100 (CET)
Message-Id: <202302011627.311GRLZs018886@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230130172936.3444840-4-arne@...1227...>
References: <20230130172936.3444840-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add printing USAN stack trace
 on github actions
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

I haven't tested it yet, but will have a close look at the GH test
runs after I push this - the route.c fix hasn't been merged yet
(want to stare more at it) so the MacOS/ASAN build should trigger
something now...  non-fatal, but red :-)

Your patch has been applied to the master and release/2.6 branch.

commit 98f295004391194d4770a450fda79a30dbaf7d60 (master)
commit 0deb1afdba185de464d0c542f60de71712a34b80 (release/2.6)
Author: Arne Schwabe
Date:   Mon Jan 30 18:29:35 2023 +0100

     Add printing USAN stack trace on github actions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230130172936.3444840-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26102.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


