Date: Fri, 13 Mar 2026 18:56:22 +0100 (CET)
Message-Id: <202603131756.62DHuMlG070601@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260313153007.31810-1-gert@...1296...>
References: <20260313153007.31810-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Install aws-lc under
 /opt/aws-lc
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is a build fix, so no actual code change - just ensure that our
GH actions actually *do* build with AWS-LC (... and subsequently
discover the error fixed by the just-applied commit)

Mildly tested by pushing to my GH repo.

Your patch has been applied to the master and release/2.7 branch.

commit 30c1c8cd61db9eb35f6c263a0ca3ec0714c88eb4 (master)
commit 7158e76feb980443d97ebe321b2a7a54659b7ab4 (release/2.7)
Author: Arne Schwabe
Date:   Fri Mar 13 16:30:01 2026 +0100

     GHA: Install aws-lc under /opt/aws-lc

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1565
     Message-Id: <20260313153007.31810-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36106.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


