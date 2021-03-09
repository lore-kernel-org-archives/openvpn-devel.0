Date: Tue, 9 Mar 2021 13:47:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210309124712.GJ976@...1296...>
References: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cH2wZblPen7iwwR1"
Content-Disposition: inline
In-Reply-To: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
Subject: Re: [Openvpn-devel] using openssl feature wherever possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cH2wZblPen7iwwR1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 09, 2021 at 04:54:13PM +0500, ???????? ?????????????? wrote:
> if nobody minds, I can send several patches that eliminates comparison of
> OPENSSL_VERSION, for example

We do mind.  They are coded this way on purpose - so when we drop support
for OpenSSL before 1.1.0, it is clear from the code which sections can
be removed completely.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cH2wZblPen7iwwR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgR25QAAoJEB2Cnv7KVigSCqQL/RJ+RlgreT1GJGlYIBFAefF4
F7zrV+z6kz3xXYvKsqKpRMxhiFZ9Ud9aiVav0bXcp1hCv+l/Z9oXemDeEH4xbN9y
1IdRaQMiqRWj/MByp4JtXENwQ3bXmzKEZO/vdnxP7WS3cArAHmHeiwf9/3jR28LC
hUkfg5h8TSd1CneK6L3sNKKDqXCt2p9pBmnaOOmNFrHkcBq88bly20OaBUqJuLQF
s6aP4HymOYCZtuoiFpz8msm8iNEvJhCvcYR0+CUMK+Y/DeWqWf5IgydeZF9sWlVi
PLsLjRTWVPVeOzBBPtZJ422G8qENnY3kJxYrxIoAyx1yr/baK6zrO2CW9o3Nfmxe
B3SjPnprdB1h5cKW4tJ1AixqcENvMRDu47ut2Wi8aEr5zvx+OuJEGuO8wL0tNPPz
PqJXeyZ85mW3pI+xuihAwkTupM0YyIdf1U9tjMla0Jg6hxrunw91imww9ttyfy5+
5KpofY1Zq+Qn/wImQRckxKkliF+1Um1Q693gY1SDVg==
=I5g4
-----END PGP SIGNATURE-----

--cH2wZblPen7iwwR1--

