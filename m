Date: Wed, 12 Jun 2019 07:24:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190612052402.GL1097@...1296...>
References: <CAGyAFMWpLKixwrmOqLy-OZ86h-zXwgPMyJQ3HqV8O3GQRGE1UA@...278...>
 <193E6898-A1C8-4319-8847-866E3CEB3E97@...2293...>
 <CAKuzo_ihkXkr_-2+VQ5bSaoi-MrEM+u051_WNoMtdhVdubOhAw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zpd1bWBxfrI+71+6"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ihkXkr_-2+VQ5bSaoi-MrEM+u051_WNoMtdhVdubOhAw@...278...>
Subject: Re: [Openvpn-devel] Preliminary Wintun support in OpenVPN2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zpd1bWBxfrI+71+6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 11, 2019 at 05:55:43PM -0400, Selva Nair wrote:
> A quick comment:
>=20
> IMO, we should use the interactive service to open the pipe and pass
> the handle to OpenVPN.exe. This avoids allowing arbitrary users to
> access the pipe or requiring users to start OpenVPN as admin which is
> not a safe practice. As the service only starts a well-defined
> executable present at a location read from HKLM\... and can pass a
> duplicated handle targeted for the process, such an approach looks
> safe to me. And, it should be fairly easy to implement.

Agree.  This is the first thought I had when I heard about "you must
have privileges to access wintun" - just use our existing privilege
handling mechanism.  I have no idea how to actually *do* that (=3D pass
a handle to wintun over our service pipe), but I'm all willing to=20
review and test :-)

[..]
> Lev:
> > A comment about performance. According to my measurements,
> > openvpn2 with Wintun is 27% faster comparison to tap-windows6, but
> > I think we (openvpn) can go even faster with Wintun. WSASend, which
> > we use to send data to link, allows multiple send buffers. We do
> > not use this functionality since with tap-windows6 we process packets
> > one by one. In my tests Wintun read returns about 100 IP packets
> > and I think that decreasing amount of WSASend calls by factor of
> > 100 would give us noticeable performance boost.

I wonder if we couldn't do this with tap-windows6 as well - read/write
multiple packets at once.  The driver should handle this - from what
I saw when reading patches "all is done using NBL lists"...

Steffan had some code to do multiple packets on the socket side
(sendmmsg()).

Not sure what is missing in OpenVPN 2.x to do multi-packet read/write,
not sure if there is anything missing in the tap6-driver.

What does OpenVPN 3 do on Windows?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zpd1bWBxfrI+71+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdAIxyAAoJEB2Cnv7KVigSvHUL/Re9+E29u/3WUbMAfUedISkD
sorpjFZtpN9DKgMgmJCXqmOZm8EJXFeRNlR5TqbHZfYD02IxTzRtcLZ1ccmUfkKR
j5IahB50E3LnJpD3hmkBizK7PsnsaB51jDEnorAv95XoXPYaB5ZFmik/Ha8BIKNA
FBw7tHRFHJIMiQlON3telIXbFPPhAvlfEdnVqp+02oIWFV1r4JKlz3cgkMg8jkBG
mAFvsQ5AWLsub1O5mTsrI/Gjli1XFkEb5TY/nOhHwvnySoLnzIb2Kd/8QBW6/tDn
tfU8WJSlAlnA3eKZ/EUFBUm1OREFw5FNK01zOnQ97V/evAnlUKrOX1s2JbVmT9LA
BRMcvcieORPTKsv1w6Ii1454SzRtDr5RlBpzz2qVPQe5IW4lmyDbFepQUHDax5GH
1N5FjAEXnlEBOGIt2c/wuxocfJRXvU6J9A/MhbxQeFYwFnhGMb9GGud3bmeAKPK5
4gGrqhrJ4fPuWaqSy0Fu/498q6NwTdh3dzBtl+puBQ==
=X57I
-----END PGP SIGNATURE-----

--zpd1bWBxfrI+71+6--

