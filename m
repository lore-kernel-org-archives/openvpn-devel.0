Date: Mon, 19 May 2025 15:01:55 +0200 (CEST)
Message-Id: <202505191301.54JD1tLH084104@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250325090121.28813-1-gert@...1296...>
References: <20250325090121.28813-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: don't transfer bind
 family to socket in case of ANY address
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This was +2'ed long ago, but got left rotting due to "I need to find a 
meaningful test case"... well, I give up on this, because this is all
very obscure corner cases (setting lport != 0, but not setting a
--local address to bind to, and the OS serving us a v6 ANY, breaking
connection to a v4 host - which would otherwise work just fine on
a v6 dual-stack socket).

Arguably what the patch does is the right behaviour - if no --local
address (or host) was specified, do not override use the address family
from --proto with the one from --local.  *Iff* a --local hostname or
explicit v4/v6 address was specified, then it makes no sense to query
"for that other family" (this path is unchanged).

Since Arne and the Android client was bitten most by the "lport -> bind"
change, and gave his +2 in gerrit, this is all we need :-)

Tested on FreeBSD and Linux, t_client with lots of v4/v6 remotes...

Your patch has been applied to the master branch.

commit c319dcf048c56098a6aba142e76166684ff5ab12
Author: Antonio Quartulli
Date:   Tue Mar 25 10:01:15 2025 +0100

     socket: don't transfer bind family to socket in case of ANY address

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250325090121.28813-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31235.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


