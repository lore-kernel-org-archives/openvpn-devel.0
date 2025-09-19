Date: Fri, 19 Sep 2025 13:44:03 +0200 (CEST)
Message-Id: <202509191144.58JBi38n023264@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250919113207.25440-1-gert@...1296...>
References: <20250919113207.25440-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Makefile: fix 'make dist'
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

Yeah, silly oversight on my side - I really should remember "if there is a
new file, make sure to run 'make distcheck'"...

So, applied, tested on gentoo with "make distcheck" and it works.

Your patch has been applied to the release/2.6 branch.

commit 7f6d228f8d9426358e359f8c3278250414fd6618 (release/2.6)
Author: Lev Stipakov
Date:   Fri Sep 19 13:31:58 2025 +0200

     Makefile: fix 'make dist'

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1201
     Message-Id: <20250919113207.25440-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33085.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


