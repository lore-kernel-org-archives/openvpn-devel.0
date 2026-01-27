Date: Tue, 27 Jan 2026 10:05:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aXh_4zDJU4B9TRpM@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="biJj7Y4VWbRg0I93"
Content-Disposition: inline
Subject: [Openvpn-devel] PLAP setup best practices?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--biJj7Y4VWbRg0I93
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

$customer is asking for advice how to setup OpenVPN on Windows in a
"pre-logon" fashion ("so the machine can talk to AD right away").

So I found

  https://gist.github.com/selvanair/1a1f12b9b2a040f5b92b9fb5f3d83f91?permal=
ink_comment_id=3D4518375

which all makes sense, except for the "pwfile" and "port" thing
(--management...) - well, of course it makes sense, but I wonder how
to automate this in a good way.  Our config files come from a config
maker tool ("you authorize to an internal host, click on what profile
type you want, and get a .ovpn for download") - which has no way to
add a password file, and no way to ensure that $port is actually *free*
on "that windows".

So, anyone here using PLAP?  How do you set up your user PCs, in a way
that does not require hours of admin time to maintain?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--biJj7Y4VWbRg0I93
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAml4f+EACgkQHYKe/spW
KBINdwwAk28XgyMEZqDQi6aWf9MNQ6u0AHgNd9jBChchwaewL03B8g9FVY0yRTkH
bn09K2LxbRe5JdGTvOU7Y67MROzUQs0HtMDxuFeG9FDZ2/ohaiG6lP1oKYDjCk6x
OLjkxz+F6K4iV+OjvpHV35fkiRC8ZnipiO62PRekBIF7E9Wu7rKdbvs5md8yFWCS
h9xJ9qJ3hOlsvRl3eWTLFP82Ni/lV9LdMSlFopg8HZ5zb+tnfU4oVmw+7jwEtPli
eddr/Ma3BQgOARl+agl5KRKIeyW7T1jHMznXHDskY9DjiQ8bwzdKIQfxFzttwgq8
Z5kV20KJsh6eXv55+DixIBHryiIRgnTnn7T0dPTHcOhoNVvAEj8LhtCS+nTBizo5
iHOgb73Gtd4XBzLodA2Msctpzlf07RymFFj54j6+tTIXPQGMAkxG8zV6iznaOBYg
ffGzAsnVViVP++LltQGpSqKun/3hbMUnwqEdAgSNnqsiroJ64KMRX9sGC0IyieTa
XsXt7IRS
=itkV
-----END PGP SIGNATURE-----

--biJj7Y4VWbRg0I93--

