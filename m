Date: Thu, 31 Jul 2025 17:43:35 +0200 (CEST)
Message-Id: <202507311543.56VFhZeI095247@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250731152912.21826-1-gert@...1296...>
References: <20250731152912.21826-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix wrong byte order of --dns
 server
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

Yeah, git rebase accident in the "offending" patch (patch was written,
bug was fixed in the "to-be-moved" code, git rebase adjusted the "old"
side, but had no way to fix this for the "new" side and nobody noticed).

Let's try to get better DNS coverage into the automated Windows test rig.

As for the test, just stared at the code and did a windows compile test -
as Lev wrote, we have fixed this bug before (doubly annoying).

Your patch has been applied to the master branch.

commit 63fed92c96c23e061a64683cab431db1269e3f73
Author: Lev Stipakov
Date:   Thu Jul 31 17:29:06 2025 +0200

     Fix wrong byte order of --dns server

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250731152912.21826-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32460.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


