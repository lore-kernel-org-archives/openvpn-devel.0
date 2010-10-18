Date: Mon, 18 Oct 2010 16:35:14 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4CBC9C8B.6090302@...1299...> (from Jason.Haar@...1299...
	on Mon Oct 18 14:14:19 2010)
Message-Id: <1287437714.3484.3@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Intelligent OpenVPN service?
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
To: Jason Haar <Jason.Haar@...1299...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/18/2010 02:14:19 PM, Jason Haar wrote:
>  On 10/19/2010 07:43 AM, Davide Brini wrote:
> > Sorry for the silly question, but how do you expect the OpenVPN=20
> link
> to be
> > established if the computer "does not already have a connection"?
> >
> > What do you mean with the above statement?
> I think he means: if the machine is on the corporate network, then
> don't
> kick off an openvpn connection to the corporate network
>=20
> We did that here using firewall trickery. We block access to the
> openvpn
> server ports from the corporate network - that way openvpn can remain
> permanently running on all clients, and it will only work when=20
> clients
> connect from non-corporate networks.
>=20
> It's a kludge (hard to scale when you have dozens of corporate
> Internet
> address ranges) - what's really needed is a "--pre-connection" option
> -
> so that we can run scripts before the openvpn service even starts.
> Then
> the "pre" script could explicitly check if the corporate network is
> available (eg attempt to download a HTTPS page from an exclusively
> internal server) and error if it is - causing openvpn to not attempt
> to
> make a connection

How would that work if, say, the laptop leaves the building and
loses wireless to the corporate network?   In the setup you
describe all the connections die because the network goes
down. Seems to me it would
be better to always have a open vpn connection but don't
route to it when you're inside the firewall.  Some solution involving
a routing protocol would do this and then established connections=20
would not break.

Routing protocols are supposed to deal with paths going up and down,
so why reinvent the wheel?




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


