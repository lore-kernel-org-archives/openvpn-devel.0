Date: Thu, 6 Mar 2025 12:00:37 +0100 (CET)
Message-Id: <202503061100.526B0box084019@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250306095928.10229-1-gert@...1296...>
References: <20250306095928.10229-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for simultaneous
 use of UDP and TCP sockets
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This was really a tough one... we've wanted this for years, but digging
deeply enough into the event handling for a p2mp server to make "TCP and
UDP, at the same time" happen is a major achievement.  A big thanks to
Gianmarco and Antonio :-)

It also really needed "going up to v20" to become robust in the face of
all the nasty things I tried - but now it just works.  I ran this with
4 listening sockets, 2x UDP, 2x TCP, and 100 concurrent clients 
connecting and disconnecting randomly for 2 hours, and "it just works"
(and of course it survives the normal server side testbeds just fine,
but *that* was already achieved at v16 or so).

I have no doubts that there are some surprises still lurking, so having
lots of real world exposure and testing will certainly be welcome...

Your patch has been applied to the master branch.

commit 619c3e9a067255f97e129bf02914f5ada5107b51
Author: Gianmarco De Gregori
Date:   Thu Mar 6 10:59:28 2025 +0100

     Add support for simultaneous use of UDP and TCP sockets

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250306095928.10229-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31028.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


