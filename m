Date: Wed, 9 Apr 2014 10:45:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140409084530.GQ16637@...1296...>
References: <1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
	<5343E392.1010803@...1800...>
	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>
	<5343FF41.3080406@...1879...>
	<5344111D.3080408@...515...> <5344145F.3010702@...515...>
	<53442B8A.2030105@...515...>
	<CAFHpkQE-6kqi+RT4oF_F+4YULRd=NtJ3rCNK-YR+JrGM47s-sw@...278...>
	<53450525.4010704@...1227...>
	<CAFHpkQEuf35w0CuEDvYrRARZR2-vmcZQAh6eA=8q=XkdertD-w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgSDeLpY4hRAQrsA"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEuf35w0CuEDvYrRARZR2-vmcZQAh6eA=8q=XkdertD-w@...278...>
Subject: Re: [Openvpn-devel] Heartbleed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???? ??????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--OgSDeLpY4hRAQrsA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 09, 2014 at 02:32:42PM +0600, ???? ??????? wrote:
> I used to think that client without "nobind" option binds to 1194/udp
> (we encountered that issue with multiple openvpn connection on the
> same machine), so, "nobind" tells openvpn instance not to bind to
> udp/1194, and so, only openvpn server can exploit heartbleed
> vulnerability, but not any attacker.

Well, not "any" attacker, but "any attacker who can see your packets",
either by sitting in the path, or by DNS attacks, misdirecting your
communication attempts to a malicious server.

This is not trivial to set up, and might not be worth for every client
out there - but if you're truly concerned about your data, upgrade the
client, revoke the old key+certificate, reissue new keys.

(If you use an extra username+password authentication with one-time-passwor=
ds,
this should be "good enough", provided your openssl is fixed)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OgSDeLpY4hRAQrsA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0UIqqkuBuNlUUl1AQJLGwQAlRuW19SyOh0/W/fhU+LQ9dXjvDUjkVKf
q77hflgYxw4hH6QWoBuV/2inY76kLJVwX+SNv+id9AsRv45gZoZTZZrHNF28DaA/
x8qgaBVAKfJur+7fjU9bXlPqgrcoxHE0Shy9ajPiooAXlvPf9rjq9gVxTCtn2Srl
YlxWyXTmFcQ=
=1Dpf
-----END PGP SIGNATURE-----

--OgSDeLpY4hRAQrsA--

