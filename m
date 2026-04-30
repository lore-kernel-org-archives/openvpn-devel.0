Date: Thu, 30 Apr 2026 15:12:10 +0200 (CEST)
Message-Id: <202604301312.63UDCAx3065912@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260430124020.23066-1-gert@...1296...>
References: <20260430124020.23066-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: minimalist fix for dnssec
 setting
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for coming up with a minimal patch quickly, until we have decided
what "we really want there" and "what windows does".

Frank has tested this, and I have fixed my testbed to actually *show* the
problem - we do windows tests, but the way I had set up the "hidden DNS
things that only resolve if --dns is applied correctly" (unbound with a
local zone) was IPSEC-agnostic - if you ask "the authoritative server"
it will always tell you "yeah, all is valid!".  So now we have an unbound
recursor in front of a local bind, with no DNSSEC, and "windows with
dnssec yes" will actually fail to resolve that...  

.. and with your patch, we're back to "the system tests pass", so, good.

(Staring at the change also seems to make sense, but I said so for
the other fix as well... so I'm glad we have good before/after tests
this time)

Your patch has been applied to the master and release/2.7 branch.

commit 919f5ced7d2863d51981979a336407b6e0818fcd (master)
commit 9683e1fe273db94ab92e1da2fe55c7929fa7291a (release/2.7)
Author: Selva Nair
Date:   Thu Apr 30 14:40:14 2026 +0200

     dns: minimalist fix for dnssec setting

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1644
     Message-Id: <20260430124020.23066-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36797.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


