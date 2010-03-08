Date: Mon, 08 Mar 2010 10:14:48 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B9515FF.6000704@...41...> (from jim@...41... on Mon Mar  8
	09:21:35 2010)
Message-Id: <1268064888.17518.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: James Yonan <jim@...41...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 03/08/2010 09:21:35 AM, James Yonan wrote:
> OpenVPN 2.1 has a relatively recent feature that allows a TAP-based=20
> OpenVPN session to be established where the client gets its IP=20
> address
>=20
> assignment and other attributes from the server-side DHCP server.

> I'm hoping that we can make "route-gateway dhcp" work on Unix
> platforms=20
> as well.  I'm thinking there are two possible ways we could do this:
>=20
> (1) Simple method: Trigger a DHCP client bind on TAP interfaces when=20
> they are instantiated.  (This is what Windows does automatically)

Offhand, there seem to be various ways to go.=20

A) OpenVPN restarts dhclient so that it autodetects the new interface.

B) Configure dhclient.conf with an interface directive for the
tap device.   It may be necessary to use hooks in dhclient-script.

C) A combination of A and B, where there's a separate dhclient
process run just for openvpn.  This might avoid problems with
B where the regular interfaces must also be configured because
autodetection is turned off.  It might also be more portable
across different dhcp client implimentations (or not.)

D) Use the dhcptl or omapi APIs or, perhaps even better, the omshell
command.  This would be tied to the ISC implementation,
but probably nobody cares.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


