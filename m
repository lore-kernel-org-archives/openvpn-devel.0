Date: Thu, 11 Apr 2013 11:38:56 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20130411093856.GC6022@...1820...>
References: <20130411083001.GI569@...1296...>
	<20130411083657.GD6312@...1820...>
	<20130411093607.GK569@...1296...>
MIME-Version: 1.0
In-Reply-To: <20130411093607.GK569@...1296...>
Subject: Re: [Openvpn-devel] users of the OpenVPN management interface?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Gert Doering, le Thu 11 Apr 2013 11:36:08 +0200, a =E9crit :
> On Thu, Apr 11, 2013 at 10:36:57AM +0200, Samuel Thibault wrote:
> > Gert Doering, le Thu 11 Apr 2013 10:30:02 +0200, a =E9crit :
> > > Now, I'm wondering who is actually *using* the management interface on
> > > the server side (where stuff like "status 2" makes a bigger differenc=
e).
> >=20
> > We use kill to shut down the current VPN session of somebody who has
> > stopped paying for the service.
>=20
> To clarify: of these variants are you using?
>=20
> kill cn                : Kill the client instance(s) having common name c=
n.

This one: when the user has stopped paying for the service, the radius
account gets disabled, and then we kill the cn to make sure all existing
sessions are shut down, and the user can't establish another one. We
don't really care how he is connected.

Samuel

