Date: Wed, 22 Nov 2017 17:42:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171122164212.GD631@...1296...>
References: <00bb01d363a1$2428e260$6c7aa720$@carroll.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <00bb01d363a1$2428e260$6c7aa720$@carroll.com>
Subject: Re: [Openvpn-devel] OpenVPN + OpenSSL FIPS Object Module v2.0
 causes OpenVPN to SIGSEGV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jim Carroll <jim@...2322...>
Cc: openvpn-devel@lists.sourceforge.net

--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 22, 2017 at 09:49:47AM -0500, Jim Carroll wrote:
> I'm not sure how to resolve this issue. tls1_PRF() is building data chann=
el
> keys exchanged between the client and server. It would appear to me that =
MD5
> is "baked into" the OpenVPN key negotiation in away that cannot be simply
> omitted/skip/replaced, without a coordinated code change to all downstream
> client code as well (including IOS). Is that correct?

This is correct.  MD5 for the PRF is essential for the wire protocol,
and changing this will be incompatible with all unchanged clients.

OTOH, MD5 is perfectly fine in FIPS code *iff* it's not used as a hash
but for other purposes.  I seem to remember that there is a magic call
you need to do to tell the FIPS side of things "hey, this invocation of
MD5 is good".

We had the discussion on the openvpn-devel list some time ago (two years
maybe?) so google might find something more authoritative here.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaFajkAAoJEB2Cnv7KVigS00IL/jyOMjh7rekn3DT4wFA2URZB
RHt77Om0lnmwU3QoIPxbnLFwOYOdSkTlBXx8WDerLCMso6zJvSID013tO7+nj1IU
pgTll3wlivMlKYs30gnxTCgjxjp0vYvtPAi5dFaK2xT4kmLjQuA7zkLQFzzuf/WU
cL5O3AiJ2Plmg++tajfnBjwDULFwDP2YBDOyts+q4mYgaqSLIu/aYfWc84Ep6ntZ
udKpdJp6HusiXoet+RVfTlX05/XjoENo0gL3Ws2upryTgKKRAyNfSh4IF9CtTalO
3irOglyPdBXSFlfWoeSf4sROBxLs1DJTOgIsl4PxoehRP7KiafMdtabGHwF00mP0
XWC+dad3T9xV+CBBTRv1m1bIhC3I7chzv+4HxnVIne2xhP+5ugatCWmWLn+glgLj
Hn/hmSJG/28fgQfyKxolvt4Fe/phKOY9FvFPP1Bn99RAPM4piPQ70g/OkwJCzDHa
OMV6WtwclUrj5KqXiYQw03IoJL0xLsc+daVwLWf+9Q==
=RS60
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

