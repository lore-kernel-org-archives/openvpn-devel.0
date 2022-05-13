Date: Fri, 13 May 2022 10:46:15 +0200 (CEST)
Message-Id: <202205130846.24D8kF8A097719@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220513083635.2199131-1-arne@...1227...>
References: <20220513083635.2199131-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove dependency on BF-CBC
 existance from test_ncp
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

Acked-by: Gert Doering <gert@...1296...>

Funny how "git cherry-pick" can sometimes do correct-looking-but-different
stuff... now the code matches what is in the master commit.

Plus, it passes "make check" with 3.0.x builds :-)

Your patch has been applied to the release/2.5 branch.

commit 263436fdb06cc2364f9667bc1adead70aeb93ecc
Author: Arne Schwabe
Date:   Fri May 13 10:36:35 2022 +0200

     Remove dependency on BF-CBC existance from test_ncp

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220513083635.2199131-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24346.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


