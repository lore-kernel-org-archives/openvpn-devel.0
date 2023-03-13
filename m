Date: Mon, 13 Mar 2023 14:39:37 +0100 (CET)
Message-Id: <202303131339.32DDdbMb000174@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230309210344.5763-1-a@...2181...>
References: <20230309210344.5763-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: don't use NetLink to
 exchange control packets
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I have tested this on ubuntu 20.04 against the kernel DCO (v2) module
from "next", commit 580608e.  All client and server side tests pass
(with and without DCO), and it survived UDP and TCP gremlin attacks
for ~1h each.  This is better than we ever had, so yay :-)

UDP gremlins still seems to make it lose track of a few clients
(kernel thinks "nothing left" and sends no more keepalive, userland
claims "6 clients left") - this is still not perfect, but no *real*
issue - if one of the clients reconnects, the session will be flushed,
and if key renegotiation comes up, it will eventually be expired.


Stare-at-code also looks good.  Taking out lots of stuff that was 
just complicating things.  I also like that this obsoletes quite
a bit of extra comments that we fought about quite a while to
make them understandable :-) - plus the #ifdef _WIN32 from my 
bandaid patch...

I have also compile-tested this for Windows (MinGW), not actually
runtime-tested it - but the logic wrt "dco_installed" -> "SF_DCO_WIN"
is clear enough (one could argue endlessly on "flag" or "bool", but
it does the same thing).

Uncrustify complains about ovpn_dco_linux.h, but since this is a
"foreign import" I ignored it (as previously).

I have added a note to the commit message that this is an API
breaking change and needs a newer kernel module (as agreed on IRC).

Your patch has been applied to the master and release/2.6 branch.

commit ac1d24286ad4788415ce6f56e97c18562d1cadbd (master)
commit 321b04fac8aaaad254fe884472109042d8fb83d7 (release/2.6)
Author: Antonio Quartulli
Date:   Thu Mar 9 22:03:44 2023 +0100

     dco: don't use NetLink to exchange control packets

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230309210344.5763-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26384.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


