From: Heiko Hund <hhund@...194...>
Date: Wed, 7 Apr 2010 15:20:01 +0200
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
	<201004070959.09215.hhund@...194...> <4BBC71F6.7040802@...1147...>
In-Reply-To: <4BBC71F6.7040802@...1147...>
MIME-Version: 1.0
Message-Id: <201004071520.01477.hhund@...194...>
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

On Wednesday 07 April 2010 13:52:22 Jan Just Keijser wrote:
> > We've contacted Microsoft tech support about this issue. If anything
> > like a
> > fix comes out of that I'll post an update here. If not we'll have to
> > consider
> > a workaround of some kind, but let's wait with that discussion until
> > we're
> > sure it's not fixable the right way.
>=20
> isn't
>   ipconfig /flushdns

No, that doesn't do it.

> or
>   net stop dnscache
>   net start dnscache

That works as well as `ipconfig /renew`. Even `ipconfig /registerdns` helps=
=20
because it does an implicit /renew.

> enough? This might be related to
>  http://support.microsoft.com/kb/311218

Sadly it's not. Seems to have effect on MS RAS protocols only. PPTP and L2T=
P=20
get their DNS settings via PPP IPCP, so it's kind of clear that this fix do=
es=20
not apply to the ones from openvpn via DHCP.

> I've recommended to people on the -users list to use an 'up' script with
>   net stop dnscache
>   net start dnscache
> this has worked in 99% of the cases.

True, but it's not the solution I'm looking for, but a rather high level=20
workaround.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro AG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Executive Board: Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nelli=
ssen
Chairman of the Supervisory Board: Stanley J. Krasnow
Headquarter Location: Karlsruhe
Commercial Register: Mannheim HRB 108997

