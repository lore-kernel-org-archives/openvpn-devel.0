From: Heiko Hund <hhund@...194...>
Date: Thu, 9 Sep 2010 11:13:09 +0200
References: <201008132145.25557.hhund@...194...>
	<201009082232.56460.hhund@...194...>
	<4C87F888.10907@...1400...>
In-Reply-To: <4C87F888.10907@...1400...>
MIME-Version: 1.0
Message-Id: <201009091113.09853.hhund@...194...>
Subject: Re: [Openvpn-devel] New openvpn-gui snapshot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <schwabe@...1400...>
Cc: Samuli, openvpn-devel@lists.sourceforge.net

On Wednesday 08 September 2010 22:56:40 Arne Schwabe wrote:
>   On 08.09.2010 22:32, Heiko Hund wrote:
> > On Wednesday 08 September 2010 17:34:28 you wrote:
> >> We found one problem in the GUI already: if you only have a single
> >> openvpn config file (foo.ovpn) in your config directory, the gui
> >> crashes if you double-left-click on the tray icon.  It works if you
> >> right-click on the tray icon and then click on "connect".  (Heiko can
> >> reproduce it, so it's fixable :-) ).
> >=20
> > I just uploaded a new OpenVPN GUI snapshot to [1]. It should fix the
> > issues found by Gert. Please report if you run into problems.
>=20
> Can you build the openvpn gui with the "this application need
> Adminstrator rights" flag? In our expriences the amount of user
> questions "vpn does not work" is just too big otherwise.

I believe this is the wrong approach. A better solution would be not to=20
require any privileges for the GUI at all. The switch to the openvpn=20
management interface for communication was the first step in the transition=
=20
towards achieving that. In the midterm I envision the Windows service to be=
=20
enhanced to allow starting OpenVPN on behalf of the GUI. However, I suppose=
=20
this will take a while to happen. If you need a solution right now the thre=
ad=20
at http://www.astaro.org/astaro-gateway-products/vpn-site-site-remote-
access/32659-ssl-vpn-non-admin-vista-win7.html may be interesting for you.

@Samuli: is there some time left in the meeting tonight to kick off the=20
discussion on that? If so, I'd like this topic to be added to the agenda.

Regards
Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

