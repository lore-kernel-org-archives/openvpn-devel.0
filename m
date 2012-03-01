From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 1 Mar 2012 12:07:00 +0100
Message-ID: <1484458.TVn1BunqfZ@...1526...>
In-Reply-To: <1015941915.20120301114051@...449...>
References: <4F4CE4FE.3010009@...515...> <7462163.ufeuZ1iJur@...1526...>
	<1015941915.20120301114051@...449...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
To: Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thursday 01 March 2012 10:40:51 Carsten Kr=FCger wrote:
> >  If that works out, all that is needed is the service increasing the
> >  tokens integrity>=20
> > level before starting openvpn and the user will have limited access to =
the
> > running openvpn process.
>=20
> a) this didn't work, you can lower the level and but not higher

Did you try it? I hope that it doesn't work for a normal user. The service=
=20
should have sufficient rights to modify it I guess. Again these are only=20
assumptions. If you have practical experience please be more verbose.

> b) dll injection is ONE example of how a user can manipulate his own
> process. I'm no expert at hacking windows but you can trust me, it
> exists 1001 possibilities to do the same. You have no chance to block
> them.

I file that under FUD until you're more explicit.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


