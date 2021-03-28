Date: Sun, 28 Mar 2021 10:52:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210328085248.GB976@...1296...>
References: <CAALvpZTo6VYxcLXtXXyMsUU-n3JRSOJ-62fny7Zfi28WSDYXmA@...278...>
 <b63128cc-14cf-b1a4-684d-4c3fcb291f04@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aufv34C1tHTDo7r3"
Content-Disposition: inline
In-Reply-To: <b63128cc-14cf-b1a4-684d-4c3fcb291f04@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Stop using deprecated getpass()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: =?iso-8859-1?Q?T=F5ivo_Leedj=E4rv?= <toivol@...277...>, openvpn-devel@lists.sourceforge.net

--aufv34C1tHTDo7r3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 28, 2021 at 01:52:51AM +0100, Antonio Quartulli wrote:
> I believe termios.h should normally be available on any *nix system,
> therefore it should be ok to switch to it.

Well, on everything that is recent enough to have tun/tap and sockets,
termios.h will exist.

On the necessity for the patch, I have mixed feelings - I do not see
any OS remove getpass() any time soon, as it would break applications...

But I need to have a close look at the patch again - give that we already
do the /dev/tty handling etc., it might effectively make the code easier.

[..]
> > +    {
> > +        (void) tcsetattr(fileno(fp), TCSAFLUSH, &tty_save);
>=20
> We should not need to cast to void - I don't think we have warnings set
> for non-checked return values.

Actually we should catch errors here and log them.  If tcsetattr() fails,=20
the tty will be in a messed-up state - so we want to know that it happened,
and possibly also the "why".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aufv34C1tHTDo7r3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgYEPfAAoJEB2Cnv7KVigSfl0MAJvNzQmnVO3Vs6wr6Ryi4Yyq
gWN6s//C/MYAF/oevIsLJlsxqNhgSSRGSl15c5M7duUebUQ/vWHIqKb1Kexv4GV6
moEQ1tPesCySm3KoEODrUFdMZhstw9r8R+aVZmwZ4iShSWMoDTj79/lnLTLcbXzq
iABeSWAncoPe9YGR+sIY9iMKZ2OOCL3LsoDij9wc29cIV0PVc/oHZ6ZpCHj4mS73
IBQgNKqBycKlKA1SM0TCLKRK4vrQIYbeitjTeidMdSggWAUGvVfCyG810NhTRnRy
saRgBn4ZdDMHf4n0NT5gWhjE/V4fqdhe6srXeodnJE3otnKg854Ja6IVF1XMRdci
tQTymdLDpGCx6fpIJCJygaseqIrB3JKIpMKXIpZa4MdO9PTrTDDm0L860tC6Y4zG
2MMrEoSI5Rg1G5rIAj2npMpZMrsGiHDKk1efcoLFZPfBoCeW1l+VqfN52/FIx9DV
xuamBVdYTgLdx6vCIV/uZqZZJJrO1z8ug459TFhH9Q==
=2e1I
-----END PGP SIGNATURE-----

--aufv34C1tHTDo7r3--

