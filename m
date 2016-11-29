Date: Tue, 29 Nov 2016 09:04:30 +0100 (CET)
Message-Id: <201611290804.uAT84UDN009666@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1480386424-30876-1-git-send-email-selva.nair@...277...>
References: <1480386424-30876-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Map restart signals from event
	loop to SIGTERM during exit-notification wait
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

ACK, thanks a lot.

I could reproduce the effect as well -- set "--explicit-exit-notify 5",
try to connect to a non-responsive server (unused IP address, ...), and 
~2 seconds before the 60 second timeout, press ctrl-c.  Flooding of
SIGUSR1 messages, no way to stop it (except "kill -9"), quite an annoyance.

With your patch, this changes to

  Tue Nov 29 08:55:19 2016 UDPv4 link remote: [AF_INET]199.102.77.82:51189
  ^C
  Tue Nov 29 08:56:17 2016 event_wait : Interrupted system call (code=4)
  Tue Nov 29 08:56:17 2016 SIGTERM received, sending exit notification to peer
  Tue Nov 29 08:56:19 2016 TLS Error: TLS key negotiation failed to occur within 60 seconds (check your network connectivity)
  Tue Nov 29 08:56:19 2016 TLS Error: TLS handshake failed
  Tue Nov 29 08:56:19 2016 Converting soft SIGUSR1 received during exit notification to SIGTERM
  Tue Nov 29 08:56:19 2016 SIGTERM[soft,exit-with-notification] received, process exiting

.. which fixes the issue for good.

"Real signals" are still ignored (kill -USR1 from another window):

Tue Nov 29 08:58:19 2016 event_wait : Interrupted system call (code=4)
Tue Nov 29 08:58:19 2016 Ignoring SIGUSR1 received during exit notification

(or pressing ctrl-c a second time while it's waiting for the exit notification
to proceed)


(Also, the explanation and the code change make sense :-) )


I've added a blank to the comment line ("true.If" -> "true. If").

Your patch has been applied to the master branch.

commit f25a0217e35f53c3110ebb226e1d1f3528152cb5
Author: Selva Nair
Date:   Mon Nov 28 21:27:04 2016 -0500

     Map restart signals from event loop to SIGTERM during exit-notification wait

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1480386424-30876-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13284.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


