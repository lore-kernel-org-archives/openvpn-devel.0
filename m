Date: Sat, 13 Aug 2022 14:22:55 +0200 (CEST)
Message-Id: <202208131222.27DCMtaw040249@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220812134154.16729-2-kprovost@...2661...>
References: <20220812134154.16729-2-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: ovpn-dco: introduce FreeBSD
 data-channel offload support
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared at the code, stared at the diff, the changes are what I asked
for (thanks :-) ).  I'm sure we'll find more stuff to polish, but I want
this to proceed so the merge conflict with dco-win can be fixed by 
rebasing that other tree... (which is needed anyway).

Uncrustify complained about a few tab-vs-space things, which I adjusted
(mostly in ovpn_dco_freebsd.h).

I have also adjusted the "TCP is bah" message to be more in line with
the other "does not work with DCO" messages:

+        msg(msglevel, "NOTE: TCP transport disables data channel offload on FreeBSD.");

(and indeed, this is what it does -> tests 1* succeed now)


I have tested this on Linux and FreeBSD "without DCO" (full client and
server test, though there is no actual new code that would be compiled
for Linux or for non-DCO FreeBSD), Linux "with DCO" (works), and 
FreeBSD 14 with DCO enabled, which looks good, besides the "double fragment
fails" issue - which is not a userland thing.

So far I have only tested the client side (p2p), the server side needs
the iroute patch in 2/2 for full test coverage - "soon".

Your patch has been applied to the master branch.

commit f08fcc2f1eb15941292d6e4e520642a4e474fd1e
Author: Kristof Provost
Date:   Fri Aug 12 15:41:53 2022 +0200

     ovpn-dco: introduce FreeBSD data-channel offload support

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220812134154.16729-2-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24894.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


