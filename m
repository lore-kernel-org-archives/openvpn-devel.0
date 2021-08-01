Date: Sun, 1 Aug 2021 18:55:15 +0200 (CEST)
Message-Id: <202108011655.171GtF80045280@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210726223920.144-1-lstipakov@...277...>
References: <20210726223920.144-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: GitHub Actions: fix MSVC builds
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

I do not need to understand this... but it's basically upgrading 
build prerequisites only for GH Actions, which does not affect 
anything else = if Lev says it's good, so I believe :-)

Your patch has been applied to the master branch.

commit 852d98efbd9dde09ff6dfedac19e54aeca1feee6
Author: Lev Stipakov
Date:   Tue Jul 27 01:39:20 2021 +0300

     GitHub Actions: fix MSVC builds

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210726223920.144-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22678.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


