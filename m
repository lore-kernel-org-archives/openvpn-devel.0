Date: Wed, 17 Sep 2025 18:47:06 +0200 (CEST)
Message-Id: <202509171647.58HGl6rU040390@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250917090653.25510-1-gert@...1296...>
References: <20250917090653.25510-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Fix writing
 messages to the event log
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

Same patch as commit 06919a60ae61, just adapted for different formatting
and other 2.6 <-> master/2.7 differences that "git cherry-pick" finds
hard to do, and stuff like openvpn_swprintf(), TEXT vs. L, etc...

The same caveat applies as for master: this currently breaks building
"openvpnserv.exe" with mingw+autoconf.  mingw+cmake or msvc+cmake works.

I've tested this one on Windows11/ARM, and it's indeed very nice.  So ACK
from me.  Master has an ACK from Selva, which "by normal cherrypicking
procedure" would also apply here, but technically it's a different patch,
so I'm fine to just put my ACK on it.

Your patch has been applied to the release/2.6 branch.

commit cabbf49ba267477c3015c3da9ee4bd45b1207211 (release/2.6)
Author: Lev Stipakov
Date:   Wed Sep 17 11:06:44 2025 +0200

     openvpnserv: Fix writing messages to the event log

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1185
     Message-Id: <20250917090653.25510-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33008.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


