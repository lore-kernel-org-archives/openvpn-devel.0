Date: Sun, 23 Aug 2020 14:36:44 +0200 (CEST)
Message-Id: <202008231236.07NCaiHZ011133@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200819070746.197-1-lstipakov@...277...>
References: <20200819070746.197-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: enable using wintun
 driver under SYSTEM
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

Your patch has been applied to the master and release/2.5 branch.

(I have not tested anything, but diffing tun.c to 6d19775a468~1 shows
that's it is the same code that was removed, except for a more detailed
error message)

commit ed47c097db63f8334f32bf9482da488928ff909b (master)
commit f4761dd12ec5eb10a5897ecb7dc427f54a9b0769 (release/2.5)
Author: Lev Stipakov
Date:   Wed Aug 19 10:07:46 2020 +0300

     tun.c: enable using wintun driver under SYSTEM

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20200819070746.197-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20780.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


