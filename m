Date: Tue, 11 Aug 2020 11:19:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200811091901.GC75094@...1296...>
References: <20200810143707.5834-1-arne@...1227...>
 <20200810143707.5834-16-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zfSPj0+0wxNpTjLN"
Content-Disposition: inline
In-Reply-To: <20200810143707.5834-16-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 15/17] Refactor
 key_state_export_keying_material functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--zfSPj0+0wxNpTjLN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 10, 2020 at 04:37:05PM +0200, Arne Schwabe wrote:
> This refactors the common code between mbed SSL and OpenSSL into
> export_user_keying_material and also prepares the backend functions
> to export more than one key.

I'd like to postpone this one for "after 2.5 branching" (so it would
go to master early in the "new master" tree).

We had the discussion on IRC yet on "when is the right time for=20
refactoring?" - and there's two sorts of refactoring patches, one=20
is for code that is very likely to see attention in it or close by=20
(context) due to bugfixes or other work - this sort of refactoring
I like to put in "before a release", so we can have bugfixes and
related work touch identical code in "master" and "release/2.5"

Then there is stuff like this one, which is complex and fairly
isolated - and I have the feeling that "more changes to this code
will come in master-to-2.6", so that one wouldn't benefit from
"also have it in 2.5", while the risk for "destabilize 2.5" is=20
slightly higher...  scales tipping the other way.

(Also: I have no test case for EKM yet, so let's not rush this)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zfSPj0+0wxNpTjLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfMmKEAAoJEB2Cnv7KVigSttsL/2J71Em9zT/GU9PiV2cwvtdy
ksagbb+UwaqpBXN6wcSlCA+srsHXGwqfp/13MyZ/tJSt12FjuwETzcR3tC/ZXMGM
RxMxjnVFQI4yBeLhoWHdr78Be0xkFRqynDDGTQX4n9YsARRJ2NHx56zx93HyP60o
2zMEFEOmBGlKGIv9gInV3iNOH8r7Dz6O5kJ1jj772yNOw//yexCtvlLkDylX5Jbl
S2mhslSDjpUOCeSbVeqX6D3YGBmWA1gQHcZ6X0/pybqu7ISG4BVNGDATBs2aIR8Y
zGJmRv68Ak5dpeRkz5hmGFejXgGLIJibPnpFA3PiE43JOjHQVWU+aS9AbcjHQu30
OfwhjtCHCoIceGUGy+NNOMZt+Y6W4QW3aocRqOp7Hqused+i/0iORC/EuM8kVlqo
A9f3alMNjMzdo0h08tZEEgY+oEzyNSTLWRXl9aOhf+yGtCSg8Tk8cgHJxqO0IhTY
ihUMNsGH6LDnbi4aWhIYMh8r7J3T74qBVggmuyGWdA==
=AHLT
-----END PGP SIGNATURE-----

--zfSPj0+0wxNpTjLN--

