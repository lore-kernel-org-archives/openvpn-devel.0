Date: Fri, 18 Jul 2025 17:49:44 +0200 (CEST)
Message-Id: <202507181549.56IFniuI016878@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250718122230.14008-1-gert@...1296...>
References: <20250718122230.14008-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: Add support for float
 notifications
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

So, this was quite a bit of work from the already-+2'ed v3 :-)

The patch looks larger than it actually is, because it affects the
two low level DCO modules implemented plus the "midlayer" having to
update the peer address.  Each individual change is fairly straightforward.
I have stared at the code for quite a bit and everything looks reasonable
and works (now).

v3 had problems where it would apply the wrong logic to "does this v4
address need to be wrapped into a v6mapped v6 address?", so OpenVPN would
end up trying to send v6 packets on a v4-only socket (no good), and also
there is a race condition in the DCO message callback leading to lost
DCO notification if the timing is just right (they are read by the
"give me counters!" callback, which gets confused and just throws the
notification away) - leading to "TLS packets get sent to the old address"
and (worse) "on floating *back*, OpenVPN kills the current instance and
then SIGSEGVs".  The DCO notification race will be fixed by Antonio
ASAP - it's annoying, but with the fixes in v6, we just log a message
that makes clear what must be happened, ignore the second notification,
and do not crash.  This is really outside *this* patch to fix.


I tested this against Linux / float-notification-6.16.0-rc3-cb06c90
(Backport to ubuntu 20.04), with a Mac laptop on Wifi and LAN, plugging
and unplugging the LAN cable while an OpenVPN UDP session was active
and pings going on in the tunnel.  This nicely floats back and forth
(and fast, usually 0 or 1 packets lost).  Server had --tls-reneg 60,
which made it quickly obvious if userland's idea of "what IP address
does the client have?" was wrong (thanks to Ralf for that suggestion).

What I did not test (because it does not really happen in practice and
I couldn't get my current middleboxes to do that) is "client floats from
v4 to v6, on a dual-stacked socket" - this should work, but it needs
NAT64/NAT46 set up in a particular way which I gave up on.  If you 
are very bored, test this, and show me the float messages :-)

(In practice our client decides on 1 proto and 1 server IP, and sticks
to that, even if it *could* decide to just go to a different server IP
"because it can!" - we might add that one day, like "continuously test
latency to all server IPs and use the best path" or so, but that's more
a 2.8 feature...)

FTR, there is a v3 from Lev on the patch, which is for testing the
Windows side.  I have recorded that as well, so we have lots of ACKs
here :-)

Your patch has been applied to the master branch.

commit cb8a0f6f5741d102b667d98370ab4d553503d0b5
Author: Ralf Lici
Date:   Fri Jul 18 14:22:24 2025 +0200

     dco: Add support for float notifications

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250718122230.14008-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32210.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


