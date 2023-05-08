Date: Mon, 8 May 2023 17:18:50 +0200 (CEST)
Message-Id: <202305081518.348FIoDv007975@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230331154214.613245-2-frank@...2641...>
References: <20230331154214.613245-2-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports/pkcs11-helper: Make
 compatible with mingw build
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

I have only tested this by subjecting to a MinGW and a GHA build (to make
sure I did not break the whitespace-broken patches on merge).  Green!

Your patch has been applied to the master branch.

commit 17746e53f65249b42017256056c5415099df288d
Author: Frank Lichtenheld
Date:   Fri Mar 31 17:42:12 2023 +0200

     vcpkg-ports/pkcs11-helper: Make compatible with mingw build

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230331154214.613245-2-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26572.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


