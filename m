Date: Mon, 22 Nov 2021 09:22:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZtTVZDWtTEecS/v@...1296...>
References: <20211117035321.249-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9uYvVGavsmIFaek3"
Content-Disposition: inline
In-Reply-To: <20211117035321.249-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH master+release/2.5] Tune down verbosity
 for suspected retransmits
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--9uYvVGavsmIFaek3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 17, 2021 at 05:53:21AM +0200, Lev Stipakov wrote:
> OpenVPN 3, however, doesn't change packet-id on retransmission,
> which triggers replay protection and causes level 1 nonfatal errors
> in logs.
>=20
> When replay protection sees the packet with the same timestamp
> and packet-id as previously received one, this is likely retransmission
> from OpenVPN 3. To not to scare users, tune verbosity down in this case.

Wouldn't "fix this in OpenVPN 3, instead of hiding the warning in 2.x"
be a better approach?

This complicates 2.x code, which is complicated enough...

(If merged at all, this would not match our criteria for release/2.5=20
either - it's neither a bugfix, nor a long-term compatibility thing)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9uYvVGavsmIFaek3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhm1NVAAoJEB2Cnv7KVigSHi0L/1qo/7EWrAG1w0a5OrqjLeJC
qR5dJM286PGjbO3iuJjZkH1fH/GAjsFFCEPH7pLpQ3XL2l8RRxtYUFAzPQNXos3a
/vRWbUshC7/LZrFlDi8cpsyA7jzfpEv1qodDlxZFZTcnCktr3X6FxEgfNkteM/pE
KJ+1+cfI4TSOEPgrEoSRsPW8co3JRE4wIsCNQEy9u0e31gH5P7DqH46dIrhUAKdo
gA12XO+l0u7r+lbTioeZr1HGUulGyLI3l0eFuL9KToqlMHUgrh1yfGUekUpdroKj
2epHEiw2QPMyMarGlzGPkGSXMmc7uu9v8t1BaulX3dp+nVBhj9RgQxWalQcE2QRI
MHrFdbN9xHiFbAcf4OolkjN0wS3WyY+7ey7GnAfkDMzt5pHmNrnGuxYUrve4u4bC
VOjlzlSGWJEj+W+AWBmHG3BeujnP+s2jyJViHsN9FpLCbYDPB6FqoLEhaF+/Izjn
OCPTXawQz268PNUjyX0T4Uq8tfKEJ8+Glc+i8PB5vg==
=UfXo
-----END PGP SIGNATURE-----

--9uYvVGavsmIFaek3--

