From: =?iso-8859-2?Q?Kosztyu_Andr=E1s?= <kosztyua@...1229...>
References: <002101ca45f3$536cf720$fa46e560$@hu>
	<20091006094101.GA5064@...30...>
In-Reply-To: <20091006094101.GA5064@...30...>
Date: Tue, 6 Oct 2009 12:01:23 +0200
Message-ID: <00cb01ca466b$f6ce7150$e46b53f0$@hu>
MIME-Version: 1.0
Content-Language: hu
Subject: Re: [Openvpn-devel] openvpn + utf8 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Thank you for the reply,
I have script-security 3 in my configs. All have been working just fine, and
still working - except when using special characters in the password.=20
An example: password1 is "pass", and its accepted and everything is working
fine. Password2 is "passw=F6rd=E9", but the auth script will only see "pass=
wrd"
from this, skipping the special character.=20
So, it simply skips the "not printable" characters.=20

Andras

-----Original Message-----
From: Alberto Gonzalez Iniesta [mailto:agi@...64...]=20
Sent: Tuesday, October 06, 2009 11:41 AM
To: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] openvpn + utf8 ?

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

----------------------------------------------------------------------------
--
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay=20
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


