Date: Thu, 9 Mar 2023 20:37:45 +0100 (CET)
Message-Id: <202303091937.329JbjD1010486@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230308150704.128797-1-frank@...2641...>
References: <20230308150704.128797-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests/unit_tests: Fix 'make
 distcheck' with subdir-objects enabled
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

Tested in-tree and out-of-tree builds, regular "make check" and also
"make distcheck", Linux and FreeBSD.  All works.

Your patch has been applied to the master and release/2.6 branch.

commit 838474145933199a62d1f59fbc2df14e4fbd57f3 (master)
commit 5eb94ce9ef2d4095004a0a3c9dbf3aeae78cf371 (release/2.6)
Author: Frank Lichtenheld
Date:   Wed Mar 8 16:07:04 2023 +0100

     tests/unit_tests: Fix 'make distcheck' with subdir-objects enabled

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230308150704.128797-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26352.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


