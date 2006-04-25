From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] Any news about WinCE porting?
Message-ID: <000d01c668e0$7dcae610$0100a8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <444E4917.8070800@...626...>
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
Date: Tue Apr 25 20:22:06 2006
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: 'Florent Thiery' <Florent.Thiery@...626...>, openvpn-devel@lists.sourceforge.net

> -----Original Message-----
(...)
> Hi, i wanted to know if the WinCE TAP rewriting had any=20
> news... Thanx a lot
(...)

I release the first alpha a couple weeks ago (well 1.5 weeks ago):

Here's the main page I set up; links therein to binaries, source, and a
forum kindly set up by Krzysztof Sobolewski:

http://www.ziggurat29.com/OVPNPPCAlpha/OVPNPPCAlpha.htm

Short story:

TAP driver largely works fine but there has been a report that it doesn't
load on an Axim x51v, which I don't have on-hand to test.
The GUI, aka 'Connection Manager', provides a serviceable interface for
starting/stopping VPN interfaces, though it is a bit bare-bone.  I should be
doing another build in the next day or so which will have a lot more of the
stuff in the management interface exposed for useability.

If you'd like to give it a whirl that would be great, especially for the
feedback on problems/suggestions.

-Dave


