Date: Wed, 9 Oct 2019 12:55:43 +0200 (CEST)
Message-Id: <201910091055.x99AthPR035720@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1570539154-31784-1-git-send-email-lstipakov@...277...>
References: <1570539154-31784-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: push.c: fix Visual Studio build
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

Arne has already ACKed the first one, but this is more in line with
what we've done in "more recent code" - and also thanks for changing
the other occurrence.

"Stared at code" and lightly tested on Linux and FreeBSD.

Your patch has been applied to the master branch.

commit 4431d0903d4e23ef01a5582960990b77e9522ab2
Author: Lev Stipakov
Date:   Tue Oct 8 15:52:33 2019 +0300

     push.c: fix Visual Studio build

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1570539154-31784-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18904.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


