Date: Tue, 09 Mar 2010 10:41:00 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B967465.3070909@...1114...> (from
	openvpn.list@...1114... on Tue Mar  9 10:16:37 2010)
Message-Id: <1268152860.24740.8@...1207...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

On 03/09/2010 10:16:37 AM, David Sommerseth wrote:

> > Over-automating things will cause people headaches.
> > You don't want to willy-nilly startup a dhcp client
> > and have all your interfaces configured with dhcp without
> > your consent.
>=20
> Exactly!  Which again moves it more in the direction of some built-in
> DHCP client in OpenVPN, but as stated earlier - that mostly solves=20
> the
> core DHCP issues - but not the resolv.conf issue.

I'm not at all sure it solves the core issues, which is that
an already running dhcp client won't have auto-detected
the tap interface that OpenVPN creates -- iff OpenVPN is=20
started after the dhcp client.=20=20

This is the
core issue, right?  Otherwise it would just work so long
as dhcp is turned on.  I think we need to decide where
the problem really is before we decide how to fix it.

If you build a dhcp client into openvpn you push the problem in
the other direction.  Now you've, potentially, got
multiple dhcp clients running and you need to do
something to keep them from interfering with each other.
You can't rely on processes being started and stopped
in boot-time order because the sysadmin might start
and stop services as needed to maintain the system
and you don't want surprising things to happen.
(The principle of least surprise is a good one.)
You may as well just statically configure your existing
dhcp client so that it knows to go looking for the
tap device.

I think the only way to go is to integrate with
anything that the local admin may decide to use
for dhcp/resolv.conf/etc.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


