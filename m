Date: Fri, 4 Dec 2020 15:01:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201204140135.GX976@...1296...>
References: <20201004223614.12429-1-themiron@...2010...>
 <20201115220857.9307-1-themiron@...2010...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uzoI8dTrMX2TZbEU"
Content-Disposition: inline
In-Reply-To: <20201115220857.9307-1-themiron@...2010...>
Subject: Re: [Openvpn-devel] [PATCH v9] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

--uzoI8dTrMX2TZbEU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 16, 2020 at 03:08:57AM +0500, Vladislav Grishenko wrote:
> DNS SRV remote host discovery allows to have multiple OpenVPN servers for
> a single domain w/o explicit profile enumeration, to move services from
> host to host with little fuss, and to designate hosts as primary servers
> for a service and others as backups.
> Feature has been asked several times already, should be useful in case of
> substantial number of clients & servers deployed.

So, Arne has ACKed it, and I went work on it today.  One problem showed
up on FreeBSD - the code uses EAI_NODATA, which is found in <netdb.h>
on FreeBSD, but with this comment:

#if 0
/* obsoleted */
#define EAI_NODATA       7      /* no address associated with hostname */=20
#endif

I'm not sure what to make out of this, but as it stands, the patchset
does not work.

If I just add

  #define EAI_NODATA 7

to socket.c, it compiles and passes my regular client tests (no SRV tests
yet), but I do not think this is the correct solution.

(I have no idea *why* FreeBSD considers this "obsoleted", or what this
define is used for - have not yet investigated in any way)


If you need to test on FreeBSD, openvpn-vagrant has boxes that get
installed with all prerequisites (or I can give you access to one of
my buildslaves).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uzoI8dTrMX2TZbEU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfykE+AAoJEB2Cnv7KVigSCzwMAKFKJ6lqf8ca/fLHs2x/1HP+
FBDcFnhPDFYx7KajEEELnaES6BQGPfhuJwCcZsBPJKWaRHqHqx+pChzm5prsAsos
tLR2uDw8ixMaucedz8VeAvYqifLtLR4W6Qo6zr59TWMKG8uXNA8XuIGo9EMqLJJL
xRhxGMNI8qN5mblbCb1mTEILPvrMdKDivhhJJ+DrIYW3GYIj321qL5r14CsnXf5X
ro0QB1BHyttWtvyvbV0AXs8YtBLbUwRE3zlSU+/yILXWR0zq4Bq3ni4VHpKyve9b
E1ErHNiCfvsbCo7vz7yfZMWCgzyPdy11Q++e9Vr3BQfXzUjHzTPoK+USX3tvc56N
aUfvdKvSaJq4JP1UUplZuFMrkNlL20owDUuORjROprfLRFjAZofvAJEbjCeVtprD
l2hdMlKILMX+/BmVAS0dAedLfGE40RnYGlu5VyoA/B6rNnMPTZkMcEpZPWK8+SfC
DN+sToYWCREh8nOiHgyHGzEf3xFh+Yjgx9+ypzZhKA==
=L1nu
-----END PGP SIGNATURE-----

--uzoI8dTrMX2TZbEU--

