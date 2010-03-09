Date: Mon, 08 Mar 2010 19:20:44 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <jwvsk8aif6m.fsf-monnier+inbox@...1269...> (from
	monnier@...1268... on Mon Mar  8 17:09:49 2010)
Message-Id: <1268097644.11342.2@...1207...>
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
To: Stefan Monnier <monnier@...1268...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

On 03/08/2010 05:09:49 PM, Stefan Monnier wrote:
> >> I think if the user just starts the dhcp client on an interface
> >> independently from the moment the interface goes up (or down),=20
> this
>=20
> >> is simply a misconfiguration.
> > I'm not sure I understand.  Are you saying that manually starting
> > a dhcp client means that the system is mis-configured because
> > it's not configured to do the right thing automatically?
>=20
> No, I mean if the dhcp client is started for example in the
> boot scripts.

I see the boot scripts as problematic.  The boot order
that makes sense to me is:

bring the interfaces up
start dhcp client (if not triggered directly from the interfaces)
start openvpn

The problem is that if the dhcp client is started before openvpn
and openvpn is creating the tap interface then it's too late
for the dhcp client to autodetect (at least at startup).
You could start openvpn before the dhcp client, and that could be
a good solution, but it does not work if there are tun
interfaces because the interfaces won't have yet
gotten an ip address from dhcp.

Or am I missing something?



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


