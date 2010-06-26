Date: Sat, 26 Jun 2010 13:41:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100626114157.GV361@...1296...>
References: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...>
	<4C20D014.7050802@...1147...>
	<AANLkTim766amj5ebXyzKWKKqjk2ndJiqyu-Drw26Mt1e@...278...>
	<4C21B352.1030203@...1147...> <20100623194825.GA361@...1296...>
	<AANLkTikd4bxVpYdOHRO-JXnx-o1Dv4OC-AxuuT2J7044@...278...>
Mime-Version: 1.0
In-Reply-To: <AANLkTikd4bxVpYdOHRO-JXnx-o1Dv4OC-AxuuT2J7044@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Is it possible to access
	Windows XP shares over port 445?
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
To: Henno =?iso-8859-1?Q?T=E4ht?= <henno.taht@...277...>
Cc: openvpn-devel@lists.sourceforge.net, OpenVPN Users <openvpn-users@lists.sourceforge.net>

Hi,

On Wed, Jun 23, 2010 at 10:50:45PM +0300, Henno T=E4ht wrote:
> On Wed, Jun 23, 2010 at 22:48, Gert Doering <gert@...1296...> wrote:
> > On Wed, Jun 23, 2010 at 09:10:10AM +0200, Jan Just Keijser wrote:
> > > assigns a 169.254 address. If this works for you as well then maybe t=
he
> > > tap-win32 developers can dive deeper into this and find out why windo=
ws
> > > treats the 'always connected' adapter differently from an 'application
> > > controlled' adapter .
> >
> > I'd assume that windows services are not "bound" to "dynamic" interface=
s...
>=20
> By dynamic interface you mean an interface which has  "Obtain IP address
> automatically" set?

No, I was thinking about interfaces that sort of "are not always there".

But that was a misconception, the TAP interface *is* always there - what's
application controlled is whether it's "connected to an ethernet cable"=20
(virtual, of course) all the time, or only if openvpn tells it so.

But in that my idea doesn't really make sense - it's as if windows wouldn't
start windows sharing if the ethernet cable is not plugged in at boot time.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

