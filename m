Date: Wed, 2 May 2012 21:30:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120502193033.GL1359@...1296...>
References: <1335981252-7390-1-git-send-email-davids@...1347...>
	<CAOazyz2_BbFgKYPJkyKNVTuwYo-DdbJp__NZGqs_8Ckym36hVw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jpyB8EFdrtB5Kqj7"
Content-Disposition: inline
In-Reply-To: <CAOazyz2_BbFgKYPJkyKNVTuwYo-DdbJp__NZGqs_8Ckym36hVw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Simplify check_cmd_access() function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: David Sommerseth <davids@...1347...>, openvpn-devel@lists.sourceforge.net

--jpyB8EFdrtB5Kqj7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 02, 2012 at 09:16:36PM +0300, Alon Bar-Lev wrote:
> Looks good.
> If you testing this one, please ensure symbolic links also works properly=
... :)

The man page for access() (on Linux) states:

DESCRIPTION
       access()  checks  whether the calling process can access the file pa=
th-
       name.  If pathname is a symbolic link, it is dereferenced.
...
CONFORMING TO
       SVr4, 4.3BSD, POSIX.1-2001.

so it should work for symlinks, across all POSIX compliant platforms (even=
=20
if the NetBSD and FreeBSD manpages do not mention anything about symlinks,=
=20
except ELOOP).=20=20

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jpyB8EFdrtB5Kqj7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT6GLWakuBuNlUUl1AQJffQQAtDMl8DOWJ7EiW7o6evQd65bshufGtbfW
MK9Ocvl/A0o3efEYxfnVc5ZYU0w/qtw7Ryx8arERoJsOks+6EmOqlEF0MOEBrpfh
pgg7XG0ZIhIPA5aRuPU3iF7f20sFU3sI1+K5zKy2b3+j92NrqqAXEZiSnuC5ljz8
B9K71Tk4CAY=
=aGv6
-----END PGP SIGNATURE-----

--jpyB8EFdrtB5Kqj7--

