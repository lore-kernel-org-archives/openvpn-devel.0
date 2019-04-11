Date: Thu, 11 Apr 2019 21:13:01 +0200 (CEST)
Message-Id: <201904111913.x3BJD1Y2089795@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190403225740.8285-1-rosenp@...277...>
References: <20190403225740.8285-1-rosenp@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove wrong poll.h include
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
To: Rosen Penev <rosenp@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"This is what the standard says" - and we checked everything that we
currently support (back to FreeBSD 7.4, old Solaris, AIX) and all
systems have a poll.h, which is either a symlink to sys/poll.h or
just does "#include <sys/poll.h>".  So it's fairly much a no-op today,
but might prevent compile-time issues on more standards-enforcing 
future systems... (very theoretical, this)

Your patch has been applied to the master branch.

commit 6206316275b14bd433a8651568f0185f4fa9f038
Author: Rosen Penev
Date:   Wed Apr 3 15:57:40 2019 -0700

     Remove wrong poll.h include

     Signed-off-by: Rosen Penev <rosenp@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190403225740.8285-1-rosenp@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18336.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


