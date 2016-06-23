Date: Thu, 23 Jun 2016 20:15:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160623181517.GL79504@...1296...>
References: <1465411141-16560-1-git-send-email-steffan@...1856...>
	<1465852669-7440-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LmcuB6YxSMQAV95c"
Content-Disposition: inline
In-Reply-To: <1465852669-7440-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCHv3 5/5] Add server-side support for
 cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--LmcuB6YxSMQAV95c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 13, 2016 at 11:17:49PM +0200, Steffan Karger wrote:
> Pushes AES-256-GCM when a connecting client advertises IV_NCP=3D2, and
> supports serving connections to clients with different data channel
> cipher configuration simultaneously.
>=20
> v2:
>  * Update manpage
>  * Add Changes.rst entry
>=20
> v3:
>  * Do not regenerate keys if the client sends a second pull request
>  * Don't postpone key generation if client has no IV_NCP support (to also
>    support clients that do not send a push request)

To me this looks generally OK.=20=20

I'll do 3/5 and 4/5 next, but would then ask for a v4 without the
merge/rebase/fix/rewort artefacts we already know about :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LmcuB6YxSMQAV95c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2wnNakuBuNlUUl1AQIGgwP/Zjxlb7S531Gv2/HzRtn7/SoBx8f/5U4I
T1D1yX/cUKZXK1rxAHLhc/fSBZLKMFD512qI3bA8hknGj1hyl2xR1lfhMAdfTUEi
IBodMrGraz8AzoxzsbvwLui7WeAs316DegFrrs7emqsCn/kN/VoeU8naZ4T1Pcdq
Y/uG5N8BYmo=
=B1ew
-----END PGP SIGNATURE-----

--LmcuB6YxSMQAV95c--

