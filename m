Date: Mon, 26 Jan 2026 16:40:58 +0100 (CET)
Message-Id: <202601261540.60QFewKx093611@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260126151122.588-1-gert@...1296...>
References: <20260126151122.588-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Run openvpnserv UT for
 MinGW builds
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

Tested this by pushing to my own GH Repo, and looking at the results - while
GH does have a bad day (half the "do things on a windows worker" things failed
without any explanation beyond "This job failed"), it *did* build and run
the test that is interesting here, so in it goes.  Thanks :-)

Your patch has been applied to the master branch.

commit 447d04fe5058c782d727419f44a3f8248a3007ce
Author: Frank Lichtenheld
Date:   Mon Jan 26 16:11:16 2026 +0100

     GHA: Run openvpnserv UT for MinGW builds

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1487
     Message-Id: <20260126151122.588-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


