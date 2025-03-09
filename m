Date: Sun, 9 Mar 2025 18:01:21 +0100 (CET)
Message-Id: <202503091701.529H1Ld8054638@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250309165500.21796-1-gert@...1296...>
References: <20250309165500.21796-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused function
 check_subnet_conflict
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

Haven't tested this (beyond "does it compile") as there is not much to
test - the function called is completely #if 0'ed, and there are no side
effects in the calls.

I'm a bit sad to see it go (the idea behind it is useful), but it did not
work the way it was written, was not adjusted to recent updates, and should
propably need to take IPv6 into account - so quite a project.  But if
someone wants to bring it back and make it useful, be by guest ;-)

Your patch has been applied to the master branch.

commit 536809792da2e4f540015f032ab656680021be03
Author: Frank Lichtenheld
Date:   Sun Mar 9 17:55:00 2025 +0100

     Remove unused function check_subnet_conflict

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250309165500.21796-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31083.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


