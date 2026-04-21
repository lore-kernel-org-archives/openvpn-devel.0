Date: Tue, 21 Apr 2026 16:21:59 +0200 (CEST)
Message-Id: <202604211421.63LELxiP015454@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260421084906.5720-1-gert@...1296...>
References: <20260421084906.5720-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: backport immediate
 notification processing on Linux and FreeBSD
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

As the commit message says, this is a backport from the revised
notification handling in 2.7/master to the old DCO code - the relevant
parts are basically the same, the underlying problem is as well
(incoming peer stats messages can get intermixed with peer timeout
messages, which get then ignored because "we're not interested in
that right now", and subsequently userland and kernel disagree on
the state of affected peers...)

I've subjected this to full client/server tests on FreeBSD and Linux,
with and without DCO, and things work as expected.

The Linux side was further subjected to a Gremlin Horde Attach - namely,
many 1000s of very short-lived OpenVPN connects/disconnects, up to 100
in parallel, which is very good in exposing race conditions in event
handling.  The server did what this patch wants to achieve - do proper
cleanup, do proper logging, do not overcount clients, very good.

Your patch has been applied to the release/2.6 branch.

commit e78a8af2f5ce5ef3bbfefc2dc8efeca84027c018
Author: Ralf Lici
Date:   Tue Apr 21 10:49:01 2026 +0200

     dco: backport immediate notification processing on Linux and FreeBSD

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1632
     Message-Id: <20260421084906.5720-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36707.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


