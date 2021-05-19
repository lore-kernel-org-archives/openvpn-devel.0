Date: Wed, 19 May 2021 09:24:40 +0200 (CEST)
Message-Id: <202105190724.14J7OeVr002698@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210511075739.158-1-lstipakov@...277...>
References: <20210511075739.158-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: properly schedule
 reboot in the end of installation
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

While I do not understand all the intricacies of MSI and WiX, the
fact that Simon has approved the corresponding openvpn-build PR 215
tells me that this one also should go forward.  I have stared a bit
at the code, and it seems to be doing what the commit says :-)

I have not tested anything.

Your patch has been applied to the master and release/2.5 branch
(bugfix).

commit 2f0e3fe1c6c57dd3989951d167e94fe4debe5405 (master)
commit 3ea57e0c46a922ac87295769283b7691e2dcbdd3 (release/2.5)
Author: Lev Stipakov
Date:   Tue May 11 10:57:39 2021 +0300

     openvpnmsica: properly schedule reboot in the end of installation

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210511075739.158-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22335.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


