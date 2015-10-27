Date: Tue, 27 Oct 2015 08:57:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151027075735.GU22054@...1296...>
References: <562EBDA0.9010205@...1490...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GQufdoSbDcjCUPBs"
Content-Disposition: inline
In-Reply-To: <562EBDA0.9010205@...1490...>
Subject: Re: [Openvpn-devel] any reason output_peer_info_env isn't in 2.3.8?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason_Haar@...1490...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--GQufdoSbDcjCUPBs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 27, 2015 at 12:56:16PM +1300, Jason Haar wrote:
> I've been running on openvpn-git for some time (2.3.4-ish?) due to my
> desire to rely on UV_* variables being passed from the client to the
> server/router. Anyway, I saw some other "git" features I used were in
> 2.3.8, so I decided to try that and discovered it still doesn't have the
> server components for parsing environment vars pushed by the client
>=20
> Is there any reason that "feature" still isn't present? I mean - it's a
> bug - there's no point in having the client support a feature that the
> server can't even interpret?

It's not a bug.  It's a fairly intrusive code addition, and our guidelines
for "what goes where" see "small and isolated changes and bug fixes" in 2.3,
and "larger and potentially breakage-causing changes" in git master / 2.4

(The feature might look small from the outside, but the actual changes are
deeply tied into the SSL authentication bits on the server side, so it's
truly falling into the "larger changes" bin).

Another feature that you really want on the server is server-side peer-id=20
support :-) - and that one is even more intrusive, so I'd just stay at
git master for the server.  Which is what I do on my servers, so we=20
usually discover breakage of the *server* component fairly quickly...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GQufdoSbDcjCUPBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVi8ubqkuBuNlUUl1AQKF9gP/agrSZhcZuLqrCRQDuv1iTXD7cb8mvO1U
C/IAxDGD0uTwmGnth2nHsrxZNaL/kSdlMYAXc5ZlTekww22+vD1+NhS+UetoQbcY
/4G0D6UCH8rWbxWmS/5FOZZeQ3U9gvdj0BCrgF1wV75QHuxpymtJIw7SkmTYoaCf
fVrBkV0UXrg=
=Fi2z
-----END PGP SIGNATURE-----

--GQufdoSbDcjCUPBs--

