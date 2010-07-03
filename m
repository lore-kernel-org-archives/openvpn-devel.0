Message-ID: <4C2F6409.6000504@...1114...>
Date: Sat, 03 Jul 2010 18:23:37 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C298338.2050003@...1114...>	<4C2E25B1.7040302@...1114...>
	<90465121.20100703001742@...449...>
In-Reply-To: <90465121.20100703001742@...449...>
Subject: Re: [Openvpn-devel] Beta 2.2 branch pushed
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
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/07/10 00:17, Carsten Kr=FCger wrote:
> Hello,
>=20
>> So it was considered better if a new SVN branch for the beta2.2 would be
>> created, branched out from r5701 (the latest SVN change).
>=20
> Why didn't James switch to git, too?
> Using svn & git in parallel isn't effective and causes such problems.
> And as far as I know is git a complete superset of subversion.
>=20

Just to bring in a little bit of history.  When I volunteered to
maintain the -testing tree, I saw that git would be more efficient and
easier to work with than SVN.  I have no intention of forcing James or
OpenVPN Technologies, Inc. to move over to git.  But I personally do
like git more than SVN, based on experiences with performance and work
efficiency, and I do agree to your statement about git being a superset
of SVN.  I have used both over time, but when I learned git, using
git-svn became my preferred working method.

Having that said, I do know James is (over?)loaded with a lot of work.
So if he wants to move over to git for beta2.2, that must come as a wish
from his side.  Changing something as important as an SCM/VCS when you
have your plate more than full enough with tasks, is no fun - then you
just want as few changes as possible to things which do work for you.
If James wants to move over to git, I will do my best to support James.
 And if not, we need to live with some of these challenges a SVN/git
integration gives us.  We just need to figure out "which path to take"
among the different possibilities we're given.


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwvZAkACgkQDC186MBRfrqc0wCeIP7jQRGPlB1yr5eZqzAndwbx
EUUAoI3PbI6ZzBvvAtp6A3jYWYifxHg+
=3DoRRq
-----END PGP SIGNATURE-----

