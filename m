Date: Fri, 12 Sep 2025 18:13:16 +0200 (CEST)
Message-Id: <202509121613.58CGDGpa097072@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250912131609.43444-1-frank@...2641...>
References: <20250912131609.43444-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: remove newline characters at
 the end of msg() calls
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

Not much to test here - it's just string constants, so if buildbot is 
fine & Frank is fine, all is good :-)

Again, links adjusted mail-archive.org -> sf.net + gerrit.

Your patch has been applied to the master + release/2.6 branch (bugfix).

commit 340b5b2d264a47c24aa948efb83ffa04e0e9c7e2 (master)
commit a88c33f8db062b2224fce2fa28acfc7d222907d3 (release/2.6)
Author: Gert Doering
Date:   Fri Sep 12 15:16:09 2025 +0200

     remove newline characters at the end of msg() calls

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250912131609.43444-1-frank@...2641...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59232448/
     URL: https://gerrit.openvpn.net/c/openvpn/+/1180
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


