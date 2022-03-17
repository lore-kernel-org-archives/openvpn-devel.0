Date: Thu, 17 Mar 2022 14:01:15 +0100 (CET)
Message-Id: <202203171301.22HD1FbJ067911@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220218235004.269-1-lstipakov@...277...>
References: <20220218235004.269-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: adjust build options to
 harden binaries
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

Lots of magic XML... only actual code change is #pragma

Your patch has been applied to the master branch.

commit 2612125d7cf5e3c8687a3fab8fba61670ac12f35
Author: Lev Stipakov
Date:   Sat Feb 19 01:50:04 2022 +0200

     msvc: adjust build options to harden binaries

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220218235004.269-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23851.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


