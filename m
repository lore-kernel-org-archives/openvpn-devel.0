Date: Sun, 21 Jun 2020 13:14:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200621111403.GP1431@...1296...>
References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cf7TutYJHw72Sphq"
Content-Disposition: inline
In-Reply-To: <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--cf7TutYJHw72Sphq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

going through OpenVPN threads that went stale - I think this is=20
actually a nice addition (read: other people have already asked=20
me if this can be done).

On Thu, Mar 05, 2020 at 01:53:12PM +0100, Jan Just Keijser wrote:
> So, for what it's worth, I've dusted off the patch again and rebased it=20
> to the current openvpn master tree. See attached. Note that I did only=20
> rudimentary testing, as I don't use Windows 10 a lot and I was testing=20
> using a mingw cross-compile only. In wireshark I *do* see that the=20
> correct DHCP offer is sent to the tap-win adapter.
>=20
> Also note that I implemented multiple search domains by separating them=20
> using semi-colons, e.g.
>=20
>  =A0=A0 --dhcp-option SEARCH example.com;example.org;example.nl;example.de
>=20
> etc as that was easier to implement

The patch looks okay-ish on quick reading.

> Also note that I did not fully implement the RFC3397 encoding of the=20
> search list, as that requires one to merge domain names that occur more=20
> than once - that would have made the code far more complicated.

Indeed.  I haven't looked at what other DHCP implementations do, but
"correct" encoding definitly sounds like quite a bit of extra code just
to save a few bytes on the wire - might come handy if you have many
subdomains of a long internal DNS domain, though, but this can be=20
added "if needed".


More interesting is the question "which option to use" - it should
be synchronized between openvpn platform handlers.  So if systemd-networkd
uses "SEARCH-DOMAIN" it would make sense to use that for windows
as well.

Is there an option in Tunnelblick to set MacOS DNS and search list?  If
yes, what option do they use?

Does anyone know about commercial VPN providers basing their clients
on OpenVPN?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cf7TutYJHw72Sphq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe70D6AAoJEB2Cnv7KVigSHtIL/AoJ9FSOfxVxACZI3fJBsVJ7
shDd9AB2iQMqnW4/U6Y0GqAMJhY7yqab9IPFkSSMxMT9E60BXfJUv4uTdqIeYGX6
CcuXk+cDuNuKUJlaxhA9+9uXQwmvpipgGTgguIKffPzF691VSOb+gZR4MnwPcSWN
9wp6zAxnloB7qNLWmVC66q3mVtqMf5W7oEFHh1aK2ndMcUnLBllNRmvxXPyoloLN
tT52fmNi9CY6FNbHfdW3yGjFEOGb4L1PakK1USB2QSyMqqqvjV22n/F62xSDG6KF
VFzLzYNAur5/OjPaCbTLsVucdek9JwOQ3DKefHnISvTEwf1PGy0D/s2ZriAycs4w
gaqci0QEXt9rrSepLmNbmpIlaMFsd16Rd6dYdWvu9x958KmcUljZUKxgu1Xqymd6
CCURx3rQ3WTTDsCfx6vTEH4tczACzAVaMLStrv79l7pNSGZvB7YPRf5Kw/Ma1WQN
+xne9rFXHM3uQ9mJ9B/ufHg+TxGXpa8ypI6xL+tF2w==
=7x5+
-----END PGP SIGNATURE-----

--cf7TutYJHw72Sphq--

