Date: Sat, 20 Feb 2016 09:18:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160220081830.GE24952@...1296...>
References: <CAP=zTkN_=4PVZUxz6pGNYQ3=JTxJ0emjRC+_PbtYd5Zix-kc6A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dYGdVsczDW6liAPD"
Content-Disposition: inline
In-Reply-To: <CAP=zTkN_=4PVZUxz6pGNYQ3=JTxJ0emjRC+_PbtYd5Zix-kc6A@...278...>
Subject: Re: [Openvpn-devel] Disabling Encryption/Decryption ONLY at the
 server level
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Shubham Chauhan <shubham13099@...2124...>
Cc: openvpn-devel@lists.sourceforge.net

--dYGdVsczDW6liAPD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 20, 2016 at 11:51:41AM +0530, Shubham Chauhan wrote:
> Is there a way to disable encryption/decryption functionality only at the
> server level. What kind of code changes are needed at the server level?
>=20
> This is just for analysis purposes.
> If the client sends encrypted and encapsulated packets to the VPN server
> gateway, it should forward only decapsulated packets.

Encryption needs to be symmetric between client and server.  If you want
no encryption, specify "cipher none" on both sides.

Reading the man page actually helps answering some questions :-9

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dYGdVsczDW6liAPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVsghVakuBuNlUUl1AQLUUwP7B4zUQYAdIo00GvlrBkNfyQI/kxDgsdTt
FWrwKGwlSo4XPme003ZJhFq6famEhG+OTnzUV5+/aJwv5hjRaZvL3DDdDvHRHea2
PLbNZxjLbynexrYevMRG99ql4Ew5jIph+LIcsjaikN4xvSgRdKOlnTcK3quMKODd
unJJ4/umaIc=
=TRtg
-----END PGP SIGNATURE-----

--dYGdVsczDW6liAPD--

