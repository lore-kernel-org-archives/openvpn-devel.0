Date: Fri, 25 Dec 2020 20:30:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201225193053.GY976@...1296...>
References: <20201220105430.GP976@...1296...>
 <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
 <20201220185402.GQ976@...1296...>
 <CAKuzo_ja=a9XxHkQX5Vv2_UTT1vWNfO8S-XLvvKZ_CQ6f-U1uQ@...278...>
 <20201221070420.GW976@...1296...>
 <CAKuzo_gMh+ZJ0YovjkUdyHzDO8cLsM_2Djsk_Hrx6N3AZMPw7w@...278...>
 <65cbacc6-0c9f-4c46-04aa-6e707c7d5efd@...1147...>
 <CAKuzo_ga6XVniU7gCBka4nGBV5kMD5AfUc6FcRPDoFWnyhN=kQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z3u/O37xo+EJLZNr"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ga6XVniU7gCBka4nGBV5kMD5AfUc6FcRPDoFWnyhN=kQ@...278...>
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--z3u/O37xo+EJLZNr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 25, 2020 at 12:08:16PM -0500, Selva Nair wrote:
> I find it hard to imagine why everyone seems to be avoiding "echo" and
> trying to find alternatives.

Well, in the beginning of this thread, having all forgotten about the
previous thread (still puzzling me) I only had the nagging memory that
"nobody understands 'echo' but it does not do what I want".

Since then I have been converted to the One True Echo and agree with
you that *for this purpose* it's the approach that needs the least
changes to existing infrastructure, and will get the job done.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z3u/O37xo+EJLZNr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJf5j3tAAoJEB2Cnv7KVigS9+MMAKOD48q4qxLdB9FRO2xCqW2l
8u0U6+CwSoz+uCWIuqFvHsrbXX8H8GJMpMYl06l8zR5sHm4FZ0qyFnCUqJKXrA9K
LAYPel146A7k2tZ01jgSJKOlXMVu1WVbctzeJ6SfHS1nGkH6m7mbv9HeNzmnXEBh
6Z+p2aWsIyVUTENhh+85TPtp6HSb6CqtNci9Y0PvYhtlL/yRsVhb/CgnO8nil2n9
QSgOiwml7k2/6ENrSr/CewvqEy/H/MmoPwXx48HqnfGbxBqi6SCHiUjSejp3APTD
yLskjKNcHz+/qG0gBadfx3riRyd06AC51psQeamRvwtzAkIY9WsBvnh4s4Dsj0ES
dmLYISLonV+dLOFFcgB63LdF4ncUINk+Zec9fcjxnTpEw1oo0w3Imta6+hqa5v90
G7QMF6BzqEsN5HBwAhKUs86Id4/6pQU2H3CgBFytToJnlahkCJk3QHQIgACFM7U/
CqwNL+gtB60eV5s8xTLKTKv6JZK3QnDYRbP0e936iA==
=IRMm
-----END PGP SIGNATURE-----

--z3u/O37xo+EJLZNr--

