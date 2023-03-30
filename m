Date: Thu, 30 Mar 2023 12:56:49 +0200 (CEST)
Message-Id: <202303301056.32UAuneS032153@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230330101536.533080-1-frank@...2641...>
References: <20230330101536.533080-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg: request tools feature of
 openssl for MSVC build
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

I have no idea what this is about, but I do not need to :-) - Frank and
Lev do building, and if they say this is what is needed...

Since it's related to MSI building, it needs to go into 2.6 as long
as we provide 2.6.x MSU builds ("for a while").

Your patch has been applied to the master and release/2.6 branch.

commit b1fc3f25bc27462100bf96d9b677d6a3c31d3303 (master)
commit 253a87dccf8c9645fade2426177489fcd8dd0ec8 (release/2.6)
Author: Frank Lichtenheld
Date:   Thu Mar 30 12:15:36 2023 +0200

     vcpkg: request tools feature of openssl for MSVC build

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230330101536.533080-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26561.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


