Date: Fri, 12 Sep 2025 17:04:38 +0200 (CEST)
Message-Id: <202509121504.58CF4cbC094297@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250911201719.25773-1-gert@...1296...>
References: <20250911201719.25773-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpn_PRF: Change API to use
 size_t for lengths
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

Makes lots of sense, does not break any buildbot tests, has an ACK
from MaxF.

Subject ("lenghts") fixed as requested :-)

The mail-archive.org list is broken again (claims this was never posted),
so linking to sf.net and gerrit.

Your patch has been applied to the master branch.

commit 6269eb43a08392d621a51626c9effd800130d542
Author: Frank Lichtenheld
Date:   Thu Sep 11 22:17:13 2025 +0200

     openvpn_PRF: Change API to use size_t for lengths

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250911201719.25773-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59232185/
     URL: https://gerrit.openvpn.net/c/openvpn/+/1135
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


