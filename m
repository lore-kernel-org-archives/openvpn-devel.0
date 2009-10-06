Date: Tue, 6 Oct 2009 11:41:01 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20091006094101.GA5064@...30...>
References: <002101ca45f3$536cf720$fa46e560$@hu>
MIME-Version: 1.0
In-Reply-To: <002101ca45f3$536cf720$fa46e560$@hu>
Subject: Re: [Openvpn-devel] openvpn + utf8 ?
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
To: openvpn-devel@lists.sourceforge.net

On Mon, Oct 05, 2009 at 09:37:49PM +0200, Kosztyu Andr=E1s wrote:
> Hi,
>=20
> Does openvpn support utf8 encoding (unicode?) for usernames and passwords?
>=20
> I could not find anything about it, only a very old mail
> (http://openvpn.net/archive/openvpn-devel/2006-04/msg00044.html)
>=20
>=20=20
>=20
> I've been using 2.1 rc18 as server for months now without any trouble, but
> now i got a report that special character passwords are not working.=20
>=20
> The authentication is done by a simple bash script. Added a line to this
> script to check if it gets the passwords with wrong charset or gets it at
> all (echo $username:$password:TEST >> /var/log/openvpn/test) but it shows
> nothing for the password.=20

Hi,

You need --script-security 3 in order to get passwords passed to
scripts.

Regards,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

