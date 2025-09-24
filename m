Date: Wed, 24 Sep 2025 14:31:47 +0200 (CEST)
Message-Id: <202509241231.58OCVlfn063556@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250924121901.13532-1-gert@...1296...>
References: <20250924121901.13532-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: Fix bug in error handling
 when talking to script
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

So all this integer warning work has actually *found* something - in
the error case, this would spin and loop, and not properly abort the
attempt.  C is... weird at times.

Your patch has been applied to the master branch.

commit bd27319f2afae4c990502a434df425ff23e1e031
Author: Frank Lichtenheld
Date:   Wed Sep 24 14:18:55 2025 +0200

     dns: Fix bug in error handling when talking to script

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Heiko Hund <heiko@...515...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1208
     Message-Id: <20250924121901.13532-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59238099/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


