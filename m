Date: Tue, 23 Sep 2025 16:35:08 +0200 (CEST)
Message-Id: <202509231435.58NEZ8XL019145@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250923140854.21766-1-gert@...1296...>
References: <20250923140854.21766-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable a subset of -Wextra
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

Stared at the changes, some are "huh, wat?" (like the const <-> static
reordering, but so what), one [[fallthrough]] was obviously forgotten
in commit fed37d0, and the struct assignment gets easier to read this
way, so double benefit :-) - wrt the CMakeFile change, GHA is fine with
it, and I don't have to understand it.

Your patch has been applied to the master branch.

commit 45eb7e1807060a927ff805b0d01fbb8cfbb772c8 (master)
Author: Frank Lichtenheld
Date:   Tue Sep 23 16:08:48 2025 +0200

     Enable a subset of -Wextra

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1202
     Message-Id: <20250923140854.21766-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59237558/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


