Date: Tue, 24 Mar 2020 19:37:12 +0100 (CET)
Message-Id: <202003241837.02OIbC87035506@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191021113506.30377-1-santtu.lakkala@...2530...>
References: <20191021113506.30377-1-santtu.lakkala@...2530...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix OpenSSL private key
 passphrase notices
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
To: Santtu Lakkala <santtu.lakkala@...2530...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

I haven't done any sort of qualified code review, but I have done a 
few test builds / t_client test runs, and all looks good.  If Steffan
says so, *and* it compiles, it's good enough for me anyway :-)

Sorry for the delay... "interesting times".

commit f67efa9412a62f477aa17c3179b7e9f31ac4b25f (master)
commit 7d19b2bb7b4a4976bc720d72227ee79c440e06fc (release/2.4)
Author: Santtu Lakkala
Date:   Mon Oct 21 14:35:06 2019 +0300

     Fix OpenSSL private key passphrase notices

     Signed-off-by: Santtu Lakkala <santtu.lakkala@...2530...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20191021113506.30377-1-santtu.lakkala@...2530...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18953.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


