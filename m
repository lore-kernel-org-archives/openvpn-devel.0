Date: Tue, 11 Apr 2023 16:33:20 +0200 (CEST)
Message-Id: <202304111433.33BEXKEj009579@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230406071546.1056-1-lstipakov@...277...>
References: <20230406071546.1056-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support of DNS domain for
 DHCP-less drivers
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

I haven't tested this beyond "compiles with MinGW" and "Github actions",
but stared a bit at the code and it looks okay.

This can be considered a bugfix, so 2.6 as well.

Your patch has been applied to the master and release/2.6 branch.

commit 6cf7ce4eb33626b861031f965b35c3107d75e843 (master)
commit 77a74357e3f9a5a18665d387e7c268f0c8cb975c (release/2.6)
Author: Lev Stipakov
Date:   Thu Apr 6 10:15:46 2023 +0300

     Support of DNS domain for DHCP-less drivers

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230406071546.1056-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26582.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


