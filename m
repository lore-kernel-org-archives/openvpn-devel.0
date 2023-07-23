Date: Sun, 23 Jul 2023 11:28:18 +0200 (CEST)
Message-Id: <202307230928.36N9SIIB029241@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230128215901.2207208-1-selva.nair@...277...>
References: <20230128215901.2207208-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve signal handling using
 POSIX sigaction
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

Sorry for taking so long on this - it hit post-release fatigue...

I did test this by running t_client test (which use signals to kill
running openvpn) across all supported OSes, and server side tests on
Linux, with and without DCO.  Of course this is not really excercising
the signal handling code, but at least it confirms that nothing is
grossly broken.

Stared at the code & the manpages as well.  Following my path through
the twisty maze of passages (especially halt_low_priority_signals())
was not easy, but "it seems to make sense" (this blocks signals, but
there is no new code to unblock - if I'm reading this right, this is
because we are at "exit (single) instance" time, and unblocking signals
will be done at init_instance_handle_signals() on the reconnection).

The actual "change to POSIX ways" part of this is fairly trivial
and easy to understand :-) - though I do wonder why you're using
an extra variable for block_mask -> sa.sa_mask, and not using
sigfillset(&sa.sa_mask) - at least on BSD on Linux, both are sigset_t,
so it should do the same thing in a slightly more direct way.

Your patch has been applied to the master branch.

commit 3abfc0fb5ea522fb5fc45fddbf35c3cc5c8e9ef1
Author: Selva Nair
Date:   Sat Jan 28 16:59:00 2023 -0500

     Improve signal handling using POSIX sigaction

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230128215901.2207208-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26087.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


