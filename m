Date: Tue, 9 Dec 2014 20:09:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141209190918.GA17158@...1296...>
References: <54833CC6.8010507@...1490...> <5486B561.8080104@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FMJTF8LVhUQkvsEb"
Content-Disposition: inline
In-Reply-To: <5486B561.8080104@...515...>
Subject: Re: [Openvpn-devel] feature request: get openvpn to use closest
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--FMJTF8LVhUQkvsEb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 09, 2014 at 10:40:01AM +0200, Samuli Sepp=E4nen wrote:
> > I also think it should be done with some "openvpn-ping" instead of icmp
> > ping because it confirms the server is available on the protocol/port
> > combination, whereas icmp doesn't
> In what kind of scenario would an OpenVPN server not be available, if
> the server itself still responds to pings?

"The server process crashed".

Not that OpenVPN would ever ASSERT() on invalid packets, or crash upon
bugs, no.  :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FMJTF8LVhUQkvsEb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVIdI3qkuBuNlUUl1AQJ8xgP+MVlCOMiMm0fen8squGkQ7I2Bbw29aTaa
EtjAB1avBfN/d7RYiXGgluLUJzucGQquP8mwVyodRc/svA/a1amKJvwzp5qYNLGM
tkqkAzJNGO3zX3BhxL+YOWN4HpbZ6QeG06hcZIb2jWCo6qFTwQuhOdmEEYqSr1n+
QVMOpAOZXxw=
=TTeF
-----END PGP SIGNATURE-----

--FMJTF8LVhUQkvsEb--

