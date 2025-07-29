Date: Tue, 29 Jul 2025 14:23:32 +0200 (CEST)
Message-Id: <202507291223.56TCNWwR098804@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250729104045.27582-1-gert@...1296...>
References: <20250729104045.27582-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE: Allow OpenVPN in
 client mode to receive and handle PUSH UPDATE control messages to allow
 options updating at runtime.
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

So, this has been quite a journey... (and thanks, Marco, for keeping your
patience).  Lev has tested and +2'ed v11, which was then lost in the
"rebase / avoid conflict" for v12.  Up to v20, only reviews, and then I
asked for lots of stylistic / code organizational changes which then
brought this up to v22...

I have stared a lot at the code, and I have run the full "normal client
and server side test" bed on it.  I have not actually tested incoming
PUSH_UPDATE messages, so at this point I have good faith that this does
what it is supposed to do - and I'm pretty sure that it does not break
anything.  Lev has given 808+809+810 another test run on the "modified
community server" (thanks!), and Corp QA has been asked to test against
OpenVPN Inc commercial server infrastructure (so we'll hear if it does
not work).

(Staring again, I *did* find one thing we should fix, namely the 
amount of options passed to apply_push_options() now, but this can
be done in a new patch)


My plan for future testing is to integrate this into the t_client/t_server
testbeds, setting up one instance that will do PUSH_UPDATE to send over
the routes that are needed for ping success - but this needs #869 and
quite a bit of new "drive management interface" infrastructure to get
done.  Soon.  *cough*.

Your patch has been applied to the master branch.

commit 80b62545881cbe39e813c85c23984e62aaa76860
Author: Marco Baffo
Date:   Tue Jul 29 12:40:39 2025 +0200

     PUSH_UPDATE: Allow OpenVPN in client mode to receive and handle PUSH UPDATE control messages to allow options updating at runtime.

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250729104045.27582-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32406.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


