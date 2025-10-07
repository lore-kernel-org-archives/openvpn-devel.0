Date: Tue, 7 Oct 2025 09:36:44 +0200 (CEST)
Message-Id: <202510070736.5977aisd027786@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251006210127.28679-1-gert@...1296...>
References: <20251006210127.28679-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dhcp: Fix conversion warnings
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

One learns something new about C every day :-) - had to look up what
an "intptr_t" is ("it's an integer type big enough to hold any pointer
type"), so that's the correct thing for pointer differences as well
(even though it's not really relevant *here*, as we're not talking
about ">4 Gbyte difference, in a 32/64 bit addressing model").

Anyway.  Patch makes sense. BBs are happy.  Not tested beyond a build
test on ubuntu/mingw.

Your patch has been applied to the master branch.

commit d446715c537764076ea8d61233bf37d3bafa7624
Author: Frank Lichtenheld
Date:   Mon Oct 6 23:01:21 2025 +0200

     dhcp: Fix conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1241
     Message-Id: <20251006210127.28679-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243110/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


