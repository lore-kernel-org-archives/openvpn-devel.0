From: "James Yonan" <jim@...41...>
Message-ID: <twig.1065682911.5866@...41...>
Subject: [Openvpn-devel] OpenVPN 1.5-beta10 released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Oct  9 00:03:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

OpenVPN 1.5-beta10 has been released with a number of important fixes for the
Windows version, and two changes to the crypto layer.

*****************

OpenVPN on the Win2K platform has been showing problems in several areas due
to incompatibilities between XP and Win2K.  Since until recently I did not
have access to a Win2K system, I was unable to do real testing on the
platform, aside from getting email reports about problems.  Luckily, someone
has come forward and set up a VMWare Win2K virtual machine for me which I can
remotely access.  I'm confident this will bring the 1.5 beta series on Win2K
up to the same level of quality as on XP.

I believe I've fixed the outstanding issues on Win2K:

* The install now pops up a dialog box encouraging you to reboot.  While
rebooting is unnecessary on XP, it appears to be critical on Win2K.

* When --ifconfig is used, OpenVPN now gives a choice of 3 methods for setting
the IP address and subnet mask of the TAP-Win32 adapter, using the --ip-win32
option.  In beta8 and beta9, --ifconfig was hardwired to use the netsh option.
 My newly acquired remote access to a Win2K VM has shown me that netsh is
rather broken on Win2k and shouldn't be relied upon (though it works well on
XP).  So the default operation is now to use a little-known Windows API called
the "IP Helper API" to set the address.  This option, while not having ideal
semantics, appears to work consistently on both Win2K and XP.  The --ip-win32
option is fully documented on the man page which can be viewed on the web site.

******************

The other changes which deserve some discussion involve the crypto layer.

Some of you may have read Peter Gutmann's critique on "Linux VPNs" which was
slashdotted a couple weeks ago.

Peter actually likes OpenVPN (from a crypto perspective) and has been very
forthcoming in offering his crypto expertise to our project.

CHANGE #1

One issue that has come out of these discussions is that while OpenVPN
implements protections against message duplication (i.e. replay protection) it
does not fully protect against message reordering.

There's an important reason for this, however.  When OpenVPN sends encrypted
packets via UDP, it is part of the specification of UDP that packets may
arrive in a different order than how they were sent.  So the network itself
may reorder packets as normal behavior, making it difficult to distinguish a
malicious reordering attack from innocuous network behaviour.

When OpenVPN receives packets in a different order than how they were sent, it
passes these reordered packets up to the TCP layer where they are sorted back
into their proper order.  The problem is that while TCP is able to deal with
normal reordering which occurs over the physical transport layer, one could
imagine an attacker attempting to break through the VPN security layer by
maliciously reordering packets in an attempt to sneak through the VPN security
layer and attack the TCP layer directly.  This type of attack would require
that the attacker had direct access to the VPN link with the ability to read,
delete, and insert packets.  Basically, the attacker would delete a packet
going over the wire, but make a copy of it first.  He would then insert the
packet into the ciphertext stream at a later time with the goal of confusing
TCP into thinking that the packet is part of a current session.

There would be another hurdle as well.  OpenVPN since 1.1.0 has implemented
sliding window replay protection (like IPSec) with a window size of 1024
packets.  The maliciously inserted packet would also need to be not so old
that its sequence number had slid off the end of the sliding window, in which
case it would be rejected.  So that rogue packet could be reinserted back into
the stream no later than 1024 packets since it was first extracted.  That
means that attacks that focus on TCP sequence number wraparounds would not be
feasible either.

These hurdles make the attack mostly theoretical at this point, though I do
have concern that non-IP protocols might be more vulnerable to malicious
packet reordering than TCP.  For that reason, I've strengthened the replay
protection model in 1.5-beta10.  The first change is to decrease the 1024-wide
packet window to 256.  The second change is to add a time-element to the
window of 15 seconds.  This means that any packet representing a sequence
number backtrack must arrive no later than 15 seconds after any packet with a
larger sequence number.  These constraints should prevent malicious reordering
attacks but still allow normal physical layer reordering.  This problem of
reordering attacks is not unique to OpenVPN -- IPSec has it as well.

CHANGE #2

OpenVPN (like TLS 1.0) uses a common technique for IV generation that involves
saving the residual IV state from packet n and using it as the IV for packet n+1.

Weaknessness, however, have been found in this approach.

See item #2 in this document:

http://www.openssl.org/~bodo/tls-cbc.txt

While the weakness appears to be mostly theoretical at this point, I've
modified the IV generation code in OpenVPN to use a random IV (derived from a
SHA1-based PRNG).

SUMMARY

While both changes protect against attacks that are largely theoretical at
this point, I've implemented them in the interest of thoroughness, and in
keeping with OpenVPN's crypto philosophy of remaining in sync with
developments occurring in the SSL/TLS and IPSec worlds.

It should also be noted that neither crypto change affects the OpenVPN
protocol or breaks compatibility with earlier versions of OpenVPN.

James


