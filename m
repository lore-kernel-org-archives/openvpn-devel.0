Date: Tue, 11 Apr 2023 17:22:58 +0200 (CEST)
Message-Id: <202304111522.33BFMwjY010442@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230331132429.601635-1-frank@...2641...>
References: <20230331132429.601635-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc: run rst2* with --strict to
 catch warnings
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

Thanks for digging into this and enlightening us non-rst-enlightened
mortals with the findings :-)

Lightly tested with GH Actions (I hope we actually do build the doc
stuff there ;-) ).

Your patch has been applied to the master and release/2.6 branch.

commit fafb05f6f3a7a1b46c278961ec8d2d8970f01096 (master)
commit 2002a5ca296d60b383c6b0f20148cf26c2b87a4c (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Mar 31 15:24:29 2023 +0200

     doc: run rst2* with --strict to catch warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230331132429.601635-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26567.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


