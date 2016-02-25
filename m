Date: Thu, 25 Feb 2016 13:50:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160225125008.GD24952@...1296...>
References: <1455398109-28880-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AgfKiFnDqiC530Rn"
Content-Disposition: inline
In-Reply-To: <1455398109-28880-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 0/2] Support "block-outside-dns" through
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--AgfKiFnDqiC530Rn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 13, 2016 at 04:15:07PM -0500, Selva Nair wrote:
> The patch is split into two commits for ease of review
> (i) Refactor the code changing no functionality
>     -- most of win_wfp_block_dns is moved to a new  file and
>        made independent of the rest of the code
>=20
> (ii) Implement a handler for blocking dns in the interactive service
>=20
>=20
> With (i) and (ii) --block-outside-dns should work without admin privileges
> if the interactive service installed and running and GUI is started as us=
er.

This looks good to me.  Alas, I also need to ask you for a v2 of the
(i) patch - I've just merged Valdikss' patch to make the block-outside-dns
code work on Vista (trac #648), and now the code slab that gets moved=20
out of win32.c has been changed.

Of course I could adjust (i) accordingly, but for maximum transparency,
I would perfer to have the actual change on the list and in the archives...

thanks

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AgfKiFnDqiC530Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVs74f6kuBuNlUUl1AQI3NAQAvmI8flIzgheGkptZ3dQpAhFUGm8ZtyPK
6GWHCmm/5Fn7MxDAdtm6/gwFvZ0Dxltkzjr3l1xaX3pBNhoZZenRR0kcKJ8Ri41P
LJ3Yuwyl2tI19/lHWcRrmEvqBsdFivUqT52ESuIYUp2mOYr+ibylEs+5v5+W3eEY
UCuUfEf0t08=
=VYuH
-----END PGP SIGNATURE-----

--AgfKiFnDqiC530Rn--

