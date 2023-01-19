Date: Thu, 19 Jan 2023 17:04:46 +0100 (CET)
Message-Id: <202301191604.30JG4kIP010502@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230119085959.157-1-lstipakov@...277...>
References: <20230119085959.157-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: remove dco
 installer custom actions
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

As you all guessed, I'm a big fan of ripping out large chunks of stuff
that I have no use for ;-) - seriously, moving windco into a MSM is the
right thing, so we do not need the installer code here anymore.

(I do not fully understand all the details in the grand scheme of
things, like "where have these functions been called from, previously?"
but I guess this is what the windows-build patch is about...)

Tested by pushing to my GH instance and getting a windows test build,
for good measure... but that fails because LZO downloads fail... meh.

Your patch has been applied to the master and release/2.6 branch.

commit 7217c7137ef835eb70a3e0c0fcf1cbdf3d5f65b2 (master)
commit 640c4d82611b744a4e032b827c82e365eca4f361 (release/2.6)
Author: Lev Stipakov
Date:   Thu Jan 19 10:59:59 2023 +0200

     openvpnmsica: remove dco installer custom actions

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230119085959.157-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26053.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


