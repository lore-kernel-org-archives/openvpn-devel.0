References: <1476996158-5390-1-git-send-email-davids@...515...>
	<aa47d230-4e40-4ca3-9851-faf2470b7258@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3d760f92-29ed-727e-edfe-65493b9b097d@...2080...>
Date: Mon, 7 Nov 2016 21:30:24 +0100
MIME-Version: 1.0
In-Reply-To: <aa47d230-4e40-4ca3-9851-faf2470b7258@...277...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/11/16 16:07, debbie10t wrote:
> Hi,
>=20
> I have tested these two unit files on Archlinux, CentOS7, Debian8,=20
> Fedora 24, OpenSuse 42 and Ubuntu 16.04 and they all work. I tested
> for a week, starting ,stopping, restarting and rebooting on 1=20
> server and 1 client per OS. (And two instance of 2x client and 2x=20
> server)
>=20
> Notes: The problems I encountered were rectified by modifying my
> openvpn config files.
>=20
> One issue remains when rebooting: Services fail to start
> complaining about the RuntimeDirectory file exists.  This only
> happens on reboot not starting or restarting. I could not determine
> which file exists but changing this fixed it:
>=20
> (Diff style): -RuntimeDirectory=3Dopenvpn=20
> +RuntimeDirectory=3Dopenvpn-%i
>=20
> (As suggested by thermi)

This does not work on Scientific Linux 7.2 at all (RHEL7.2 clone).  I
did a similar thing, and it created /run/openvpn-%i and did not swap
out %i with the config name.  Thus making at least the server part
fail, as it does not find the proper directory for the --status file.

So currently, I'm NAKing such a change and stand by the current version.

Systemd version used for testing this: systemd-219-19.el7_2.13.x86_64


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYIORgAAoJEIbPlEyWcf3y5ukQAIavRA1nZPi65Zmg+KmvXUuc
L+DaRP2sAxuH+aJhHbAgfISig2u7v2Qf7f+lncR/DQptlwWc4NKcO/UmkJF7UAv8
iKCbszbcwtst/7beevXYHu3HqiswydxhSzETrnOzxGggrdnQoKJN+kqUB/5A93dA
nwMzLeHp7h+1vx5CkbIbkQR3J/NHoem0UnzVz+RitwJ1ru50aUvgpt6CWR96c4au
5YEti/kn6m7ze25kXtV8Vve4SgKc29a1M+QdtmVDxA6NdO1679chGYa+tbc65qCM
M0cjqx3FRB51OXdT6W+CrNzrQDvqarUXtZumjiI74CqwTf1iktBEUP+P5cfSGYZa
shhPCtOfoGA/whWlY3prnq5oogi2ttkrzagmOMwTJZLa5njwQ1B8MTudj7Ei8suv
sKjpBNORnk0aipATbdPe6ZwEhS3t8AkcxTcMIP8W6m4zxpXXb/NI9/dFgfjcA1S1
/ijhCjGD7P5fIlGWj20muq+A5autDxtbsYGF3/rpsuCiWp0DnHcjF5DVi+i4Ie2z
wD9Od+Y/tx9L/ZAPiqXpvadIBVbFCz+Xw4lyASIvFjnqq6rEHOFX9luKWF3wJdks
A6YNrBnkXrbwdUPiiTvhzAUqmsGF62SOWRhj9i4HgD7ceZiqPV6u4iH/WjtSV9zK
HTFRwQWNehPdgO4P0Lrj
=3Dfb8M
-----END PGP SIGNATURE-----

