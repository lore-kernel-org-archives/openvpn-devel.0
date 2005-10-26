From: Gunter Ohrner <G.Ohrner@...484...>
Message-ID: <djp9ut$8k5$1@...165...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Assertion failed at multi.c:1561
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 26 19:03:38 2005
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi!

We're experiencing regular assertion failures and subsequent OpenVPN server
crashes on one of our servers.

The assertion failure is always the same:=20

,----
| Assertion failed at multi.c:1561
| Exiting
`----

The crash seems to leave openvpn's network device, tap0 in our case, in a
state which blocks all processes subsequently trying to access to device.
The crashes happen every few days and a restart of the server machine is
needed.

Does anyone have any quick idea of this behaviour's cause? Unfortunately
according to Google we're the only ones on Linux 2.6 with this crash. ;)

http://openvpn.net/archive/openvpn-users/2005-08/msg00011.html mentions a
similar problem but running kernel 2.2.25 and no solution has been provided
so far, a suggested patch did not fix the problem for the reporter.

,----[ Some details about our setup ]
| * Debian Sarge i386
| * Kernel 2.6.12.6 32 Bit Opteron optimized
| * Debian's 2.0-1sarge1 openvpn package
| * Dual Opteron 246 2,0GHz
`----

,----[ OpenVPN configuration (excerpts) ]
| * bind to single interface/port
| * use udp
| * use tap0
| * PSK authentication
`----

The server is also routing traffic and we do traffic limiting for some
traffic (destination dependant, to comply with a leased link policy). This
limiting is not done on the device on which the encrypted openvpn traffic
leaves the machine but on an IMQ device before the incoming traffic enters
tap0, so openvpn should not see anything from it.

Are there any further details needed to chase this bug, in whichever kind o=
f=20
software we're using it may be?

Greetings,

  Gunter

--=20
By and large, the only skill the alchemists of Ankh-Morpork had=20
discovered so far was the ability to turn gold into less gold.       =20
-- (Terry Pratchett, Moving Pictures)
*** PGP-Verschl=FCsselung bei eMails erw=FCnscht :-) *** PGP: 0x1128F25F ***


