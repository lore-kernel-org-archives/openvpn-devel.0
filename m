Date: Mon, 6 Jul 2020 13:18:26 +0200 (CEST)
Message-Id: <202007061118.066BIQai042927@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200703192029.306-1-lstipakov@...277...>
References: <20200703192029.306-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tap.c: fix adapter renaming
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

Your patch has been applied to the master branch.

I have changed the // comments to /* C */ style and word-wrapped the
commit message a bit.

I have not actually tested a .msi install, but I have test-compiled it
(at least) (unbuntu 18 / mingw) and that worked fine.

commit 5b313a3565558cd1da4723c3950df227f941cf62
Author: Lev Stipakov
Date:   Fri Jul 3 22:20:29 2020 +0300

     tap.c: fix adapter renaming

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <20200703192029.306-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20207.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


