Date: Sat, 25 Jul 2020 10:16:43 +0200 (CEST)
Message-Id: <202007250816.06P8Gh6D074150@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200724104841.89-1-lstipakov@...277...>
References: <20200724104841.89-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: remove SYSTEM elevation
 hack
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

Acked-by: Gert Doering <gert@...1296...>

Code changes look good, Makefile / .vcxproj file changes look reasonable,
and it passes my MinGW test build.

I have not tested the resulting binary because I do not hit this particular
code path anyway - and the end result is fairly trivial ("if (!iservice)
then complain") :-)

Thanks.

Your patch has been applied to the master branch.

commit 6d19775a468f0d35cd1f199b489ee18a74e6c905
Author: Lev Stipakov
Date:   Fri Jul 24 13:48:41 2020 +0300

     wintun: remove SYSTEM elevation hack

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200724104841.89-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20567.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


