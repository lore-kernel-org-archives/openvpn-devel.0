From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 8 Aug 2011 10:25:49 +0200
References: <1312714757-10317-1-git-send-email-beber@...1472...>
	<4E3F99EF.7060608@...515...>
	<20110808081747.GA1470@...1493...>
In-Reply-To: <20110808081747.GA1470@...1493...>
MIME-Version: 1.0
Message-Id: <201108081025.49506.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] Allow to fill Details tab for exe files
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
To: openvpn-devel@lists.sourceforge.net

On Monday 08 August 2011 10:17:48 Bertrand Jacquin wrote:
> > > Is there a windres equivalent for msvc ?
> > There certainly a way to do the same thing using msvc or Python code
> > that runs after the build. Does windres simply convert the resource file
> > to another format?
>=20
> Yes and check the format :
>=20
> $ file openvpn-res.o
> openvpn-res.o: ACB archive data

See http://msdn.microsoft.com/en-us/library/aa381055%28v=3DVS.85%29.aspx fo=
r=20
information on how to invoke the Platform SDK Ressource Compiler.

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

