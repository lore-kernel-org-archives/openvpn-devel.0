Date: Sun, 8 Jan 2023 19:00:32 +0100 (CET)
Message-Id: <202301081800.308I0Wo6096107@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230101215109.1521549-4-selva.nair@...277...>
References: <20230101215109.1521549-4-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Assign and honour signal
 priority order
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

I've stared at the code for quite a bit, and this looks good, and
cleans up quite a few of the odd corner cases ("do not set signal
if some other signal is there already") that have grown over time,
like the one in proxy.c.

I have not manually tested this to see if I could break it, or reproduce
one of the "known issues" - I might go back and do so, but today I am
lacking time.  I *have* fed this to the full set of client/server tests,
FreeBSD, Linux, Linux with DCO, which do excercise the SIGUSR1/SIGTERM
on the p2mp server a bit and SIGUSR1/SIGTERM on the client, and all
is nicely well-behaved.

Your patch has been applied to the master and release/2.6 branch.

commit 3a7257925791a086c1ac88362a8eb422be518b14 (master)
commit b3b1436955b9db8e557fc58b7e37ba3a881109a6 (release/2.6)
Author: Selva Nair
Date:   Sun Jan 1 16:51:07 2023 -0500

     Assign and honour signal priority order

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230101215109.1521549-4-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25871.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


