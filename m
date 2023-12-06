Date: Wed, 6 Dec 2023 13:05:07 +0100 (CET)
Message-Id: <202312061205.3B6C57cI072482@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231122143101.58483-1-dazo+openvpn@...2108...>
References: <20231122143101.58483-1-dazo+openvpn@...2108...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove --tls-export-cert
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have not explicitly verified that all code that was from the original
author is gone now - in this, I do trust David.  I *did* test that the
rest still works (client, server, GHA tests).  The actual code change
looks fairly straightforward.

I have not used the "2.6" patch for the backport, just our normal
workflow for "master and 2.6" patches, "git cherry-pick -x" from master
(so the commit ID reference is there).  Went smoothly without having
to do any manual amendments.

Your patch has been applied to the master and release/2.6 branch.

commit 12c5ef1fe6a6010362f3098d11b554566687c1f7 (master)
commit 031fe882649e7edd3e5a9c94d2f8fbf61572e251 (release/2.6)
Author: David Sommerseth
Date:   Wed Nov 22 15:31:01 2023 +0100

     Remove --tls-export-cert

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231122143101.58483-1-dazo+openvpn@...2108...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27557.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


