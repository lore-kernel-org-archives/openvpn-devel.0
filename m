Date: Thu, 30 Mar 2023 13:11:06 +0200 (CEST)
Message-Id: <202303301111.32UBB66p032529@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230330094215.487924-1-frank@...2641...>
References: <20230330094215.487924-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not include net/in_systm.h
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

Acked-by: Gert Doering <gert@...1296...>

"Buildbot says it still compiles on ALL platforms!" - and that is
all I would have tested anyway (Buildbot isn't testing AIX, but I am
reasonably sure AIX does not need that either).

This is refactoring / code cleanup, which goes to master (only), unless
needed for a bugfix.

Your patch has been applied to the master branch.

commit dbd7e3bea41e8be3fa637a17827236b1fc6db18b
Author: Frank Lichtenheld
Date:   Thu Mar 30 11:42:15 2023 +0200

     Do not include net/in_systm.h

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230330094215.487924-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26559.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


