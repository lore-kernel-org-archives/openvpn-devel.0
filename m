Date: Mon, 1 Oct 2018 08:18:24 +0200 (CEST)
Message-Id: <201810010618.w916IO8W099311@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1538141209-32330-1-git-send-email-lstipakov@...277...>
References: <1538141209-32330-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: support for Visual Studio
 2017
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

I have no idea what most of the stuff does, but it should not affect
building with other build systems, and there are only two minor code
changes - those I can review, and they look reasonable.  So, thanks :-)

commit b70b2fc248147c1e7f22042e75fcd0a03d912151
Author: Lev Stipakov
Date:   Fri Sep 28 16:26:49 2018 +0300

     win: support for Visual Studio 2017

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <1538141209-32330-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17499.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


