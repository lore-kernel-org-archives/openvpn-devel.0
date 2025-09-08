Date: Mon, 8 Sep 2025 11:48:07 +0200 (CEST)
Message-Id: <202509080948.5889m76P035368@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250908081124.17933-1-gert@...1296...>
References: <20250908081124.17933-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: backport OS-independent
 part of peer float support
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

For the sake of the archives... this is a slightly complicated patch - Ralf
did the "master" patch, which added "backend independent" code + Linux +
Windows.  It wasn't backported to 2.6, because there was no need, as 
"the DCO implementations on Linux and Windows that 2.6 supports" do not
support float notifications, and it will not be added.

Later, FreeBSD DCO learned to send float notifications, and since there
is no difference in kernel API, this can happen to a 2.6.14 server running
on a very recent FreeBSD 14-STABLE system - leading to unexpected issues
(see https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=289303).

So I backported the "backend independent" parts of Ralf's patch, with
an "#if 0" (no backend uses this) - so this patch really does not much
yet (it adds the "do not let an instance float to itself" crashbug fix),
but does so with the same code as in master.  Ralf verified that I got
all the bits right.

Your patch has been applied to the release/2.6 branch.

commit b0b123b3a7d6b64e236bc0b9836cb73d76c130e2 (release/2.6)
Author: Ralf Lici
Date:   Mon Sep 8 10:11:18 2025 +0200

     dco: backport OS-independent part of peer float support

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Ralf Lici <ralf@...2726...>
     Message-Id: <20250908081124.17933-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59230454/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


