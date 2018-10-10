Date: Wed, 10 Oct 2018 20:19:18 +0200 (CEST)
Message-Id: <201810101819.w9AIJILS054293@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1539022378-24485-1-git-send-email-lstipakov@...277...>
References: <1539022378-24485-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive.c: fix usage of
 potentially uninitialized variable
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

Your patch has been applied to the master and release/2.4 branch (bugfix).

Thanks, Selva, for the extra pair of eyes.  I was fine with the v2, but
had hoped to see an extra review from you in case I overlooked something
("you know this code best").

Test built on ubuntu 16.04.

commit d1f0e2cf83c378b4064f316a2127c7a3d7c6ca21 (master)
commit 773c086367c8dd94d71a10bd2b32f09b4a0840ae (release/2.4)
Author: Lev Stipakov
Date:   Mon Oct 8 21:12:58 2018 +0300

     interactive.c: fix usage of potentially uninitialized variable

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <1539022378-24485-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17663.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


