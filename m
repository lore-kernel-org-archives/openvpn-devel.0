Date: Sun, 6 Mar 2016 14:48:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160306134836.GX24952@...1296...>
References: <1457241722-23433-1-git-send-email-selva.nair@...277...>
	<201603060931.u269VG0n045886@...2054...>
	<CAKuzo_h+RsgPKVJDCYf+5V5RBacdfHwYDxm9eTpoWbD4JmzJVw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jvbbzz+93Hvb4jrV"
Content-Disposition: inline
In-Reply-To: <CAKuzo_h+RsgPKVJDCYf+5V5RBacdfHwYDxm9eTpoWbD4JmzJVw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Use appropriate buffer size
 for WideCharToMultiByte output in interactive.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--jvbbzz+93Hvb4jrV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 06, 2016 at 08:34:38AM -0500, Selva Nair wrote:
> On Sun, Mar 6, 2016 at 4:31 AM, Gert Doering <gert@...1296...> wrote:
>=20
> > I'm not sure if I understand in which scenarios data is fed to the
> > nascent openvpn.exe on stdin - buf if done at all, we should better do
> > it right :-) - I do wonder, though, if WriteFile() could block here,
> > leading to a dead worker thread...  all other pipe operations seem to
> > go through AsyncPipeOp() - but that is orthogonal to this fix)
>=20
>=20
> This is used for writing the management password to stdin. The GUI sends =
an
> "ascii" password, but a client could potentially use some char set that
> needs 3 or 4 bytes per char.

Ah!  Tanks for the explanation, this is showing my lack of familiarity=20
with using the management interface in a programmatic fashion...  (I use
it on the server side and manually telnet to it, having the password in
a file)

> And you are right, the write should not block. We don't see any deadlock
> even when openvpn errros out early, because of buffering, I suppose.. But
> bettter to make this non-blocking.

For "short" writes, it shouldn't block, no.  On a unix pipe, you'd get
blocking if the buffers fill up and the reader is just sitting there and
not fetching the data - if the reader *dies*, the server would get an=20
error back (since nobody could ever read it).

Probably not very important, just wondering.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jvbbzz+93Hvb4jrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVtw1M6kuBuNlUUl1AQIwtwQAvkUrCIy2eFTa+EJQDjh+XOquSUAm+Vcl
3ShivDfvmO/S95gwqyFpvqcTiEJDHtYdgXfAQ4dy3K148dAXyZaVqd2TLRT9ctSU
hg09g6lKLbs/XtXiru7AoE8jhwydGGw5I8TOtX2r95cx81HEYfFcQXZ9y9HfO94N
vhy3kOAlg1Q=
=U6Wo
-----END PGP SIGNATURE-----

--jvbbzz+93Hvb4jrV--

