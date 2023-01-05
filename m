Date: Thu, 5 Jan 2023 15:21:34 +0100 (CET)
Message-Id: <202301051421.305ELYDM018760@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230101215109.1521549-2-selva.nair@...277...>
References: <20230101215109.1521549-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Preparing for better signal
 handling: some code refactoring
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

Acked-by: Gert Doering <gert@...1296...>

(Lightly) tested on Linux, FreeBSD - namely, does it compile, pass t_client
tests (which send SIGTERM), pass t_server tests (which uses per-instance
SIGUSR1/SIGTERM).  Plus "push to github, does it break windows?".

Stared at the code for a long time - most of it is really straightforward
replacement, but the "easy" ones tend to create oversights.  I'm not
sure I fully understand the nuances why we went from "c" to "c->sig",
but I assume this is due to "definition of 'c' not available in all the
places that need the new code".  But even if the latter could be made
possible (opaque struct pointer etc), having "just the signal stuff"
passed to register_signal() sounds more clean anyway.

The continued existance of "volatile int *signal_received" in
dco_connect_wait() confused me at first, but is needed for get_signal()
(and that is needed for "do not set signal if there already is one",
which should be covered much more nicely by 4/5... not there yet).

Generally speaking, using signal_reset() and register_signal() everywhere
is much nicer, especially (old) code like this

-            c->sig->signal_received = SIGUSR1;
-            c->sig->signal_text = "remote-exit";
+            register_signal(c->sig, SIGUSR1, "remote-exit");

.. should have never been accepted in the first place...


The /* */ comment here is arguably wrong, and was wrong before...

@@ -555,8 +554,8 @@ send_push_request(struct context *c)
..
         msg(D_STREAM_ERRORS, "No reply from server to push requests in %ds",
..
+        /* SOFT-SIGUSR1 -- server-pushed connection reset */
+        register_signal(c->sig, SIGUSR1, "no-push-reply");



I've left this on the list for a few days so people had the chance to
stand up and complain "this is all the wrong way to do it" - nobody came
up, so I consider this as "no objection".


Your patch has been applied to the master and release/2.6 branch.

commit 05715485b45816e18b52ffb9b47ca22a55abb334 (master)
commit 264ce74c409018f42b178ba2cab544bdcecb1767 (release/2.6)
Author: Selva Nair
Date:   Sun Jan 1 16:51:05 2023 -0500

     Preparing for better signal handling: some code refactoring

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230101215109.1521549-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25874.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


