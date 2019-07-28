Date: Sun, 28 Jul 2019 22:22:16 +0200 (CEST)
Message-Id: <201907282022.x6SKMGIC097746@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1563442503-11119-1-git-send-email-lstipakov@...277...>
References: <1563442503-11119-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto.c: fix Visual Studio
 build
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

Your patch has been applied to the master branch.

(The code is not in 2.4, so no need to backport).  Slightly tested with
a "make check" run.

commit 2df27b2fa3932372075afd0db6b706a38e0a9dc3
Author: Lev Stipakov
Date:   Thu Jul 18 12:35:03 2019 +0300

     crypto.c: fix Visual Studio build

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1563442503-11119-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18676.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


