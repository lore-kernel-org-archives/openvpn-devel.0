Date: Tue, 10 Nov 2015 20:21:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151110192157.GQ24952@...1296...>
References: <20151109205639.GL24952@...1296...>
	<1447172335-27411-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H14uD12u8nekTETJ"
Content-Disposition: inline
In-Reply-To: <1447172335-27411-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH for gui v2] Do not disconnect on suspend
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

--H14uD12u8nekTETJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 10, 2015 at 11:18:55AM -0500, Selva Nair wrote:
> On Mon, Nov 9, 2015 at 3:56 PM, Gert Doering <gert@...1296...> wrote:
> > On Mon, Nov 09, 2015 at 03:35:23PM -0500, Selva Nair wrote:
> >> Requires the installer to update the registry during an upgrade of exi=
sitng
> >> installations, or notify the end user of the change in the default val=
ue of
> >> disconnect_on_suspend (0).
> >
> > What does this patch *do*?  Is this the "set up registry key on first
> > start" part (so we set the default differently now)?
> >
> > But that implies that an upgrade will not change the default, right?
>=20
> On further thought, its better to go more bold on this.=20
> Here is version 2 which culls the suspend processing.

I like the approach of "the installer changes the default, but if someone
*wants* this functionality, they can still enable it by changing the
(poorly documented, alas) registry key" better...

Leaving it in but having it disabled-by-default might be useful for=20
different deployment scenarios than you have in mind.  It's there for
a reason, and much longer than the tap6 driver existed, so it fixed
other issues...  (like, "reconnect on a laptop after network change",
where you might need to wait for a --ping timeout otherwise)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H14uD12u8nekTETJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkJD06kuBuNlUUl1AQJ37wP+NU7bzsTJk2SLV5kdNC1jqUyvkwzvt2ao
DDz9Iqj+esTq0ZXqHTJG6Fj0/JTk8LlREK7CgyreHp6WkA3AK1lw+H7ehNjeVvov
gdinX4CWY9gLlKpPr2N8gGWDTdIbwT/fmPr4mtVqQX2rLP3r/TKtVoVH/bVrEyaI
Z8bPMwbmEfM=
=hMSE
-----END PGP SIGNATURE-----

--H14uD12u8nekTETJ--

