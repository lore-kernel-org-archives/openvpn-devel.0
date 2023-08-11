Date: Fri, 11 Aug 2023 16:43:57 +0200 (CEST)
Message-Id: <202308111443.37BEhvBE086233@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230728131246.694-1-lstipakov@...277...>
References: <20230728131246.694-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set WINS servers via
 interactice service
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

NOTE: this is merging the v3 of the patch from Gerrit, which has an
ACK in gerrit

  https://gerrit.openvpn.net/c/openvpn/+/321

there are some diffs from v1 to v2, and rebase context from v2 to v3,
but the gist of the patch is the same.

I have not tested this beyond "does it look safe wrt memory/array
usage" and "does GHA like it?".

Your patch has been applied to the master and release/2.6 branch
(it's somewhat of a bugfix, to restore missing functionality in the
"with DCO" case).

commit 18826de5737789cb74b48fc40a9ff5cb37d38d98 (master)
commit 64a75e75b8929f1290ba984f60d0c13447a41407 (release/2.6)
Author: Lev Stipakov
Date:   Thu Jul 27 18:47:06 2023 +0300

     Set WINS servers via interactice service

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230728131246.694-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26903.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


