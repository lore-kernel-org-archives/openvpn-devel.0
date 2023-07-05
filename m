Date: Wed, 5 Jul 2023 18:29:41 +0200 (CEST)
Message-Id: <202307051629.365GTfRS005430@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230705122528.1625-1-lstipakov@...277...>
References: <20230705122528.1625-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: link C runtime
 statically
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

Build tested via GHA, which does mingw and MSVC builds.

Not tested actual installers.

Your patch has been applied to the master branch.

commit 3be4986ea3d6e27acd3e3a317c15dfe07688e135 (master)
Author: Lev Stipakov
Date:   Wed Jul 5 15:25:28 2023 +0300

     openvpnmsica: link C runtime statically

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230705122528.1625-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26821.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


