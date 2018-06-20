Date: Wed, 20 Jun 2018 23:11:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180620211158.GZ57262@...1296...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
 <CAKuzo_hAOzTi0dt=yNd8rMdjoeba87mG3_RZTaeP7FL3KQ0SrA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u08a77unfWDSo9q0"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hAOzTi0dt=yNd8rMdjoeba87mG3_RZTaeP7FL3KQ0SrA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u08a77unfWDSo9q0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 20, 2018 at 03:31:39PM -0400, Selva Nair wrote:
> > This code is a bit optimstic :-) - there is no "c" here...
>=20
> When did this change?  In a previous version this was done as

v2 to v3, because I complained that check_add_routes_dowork() is=20
hard enough to read as it is, and suggested to put the check
elsewhere.

All my fault :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--u08a77unfWDSo9q0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbKsMeAAoJEB2Cnv7KVigSKAYL/i859R5sve+y+CYAunpkQWxW
IPiSOr//ayixIS905lNJWvmEYGC5VozPLYTFGEbLMdbA78EJABTQRv5LXmR28uiL
eBw9g5w8Z2jjHhxYIe9zm08lWF/A1wRXqsgtk2cleG9prV5f3Vg4dJPS0A7rB3Sb
ji7MscIeVozoqDs1K2tdEgjyeqf70z8J1we3twbXIZs26ncOTiLph39EK8SZzNmk
Enu2dY+hYmGb4TJhJHPodOX6FzbUQifuJjtL1A8NMD2jfvklC/o1oVFtsJX24KMo
7GalD3A8ooMeEPyCT0Qcl0BUk+6K31qUCp1tQliwxq3M6RBMrLb5F4ACyVpCGyAL
iAc67qa3V7v01y/kkoLQSbOoAFvLM5EN1AJh4lH6ZgGI0/QBFlPFWC6Bq1W/dfWs
zB1ZAHsOidBA3Wg5q6pSaGP+VwtF/KRwjNdljsauFFaBJn2TESqqDCD4Z5jK3em7
trmDIJWQzGWeVpzj0sBFP5gyknHeozSjjNNIVZ7DBA==
=uhrm
-----END PGP SIGNATURE-----

--u08a77unfWDSo9q0--

