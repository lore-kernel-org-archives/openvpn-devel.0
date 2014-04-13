Date: Sun, 13 Apr 2014 17:26:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413152613.GT16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zuly/YyMp1HNQw/u"
Content-Disposition: inline
Subject: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--zuly/YyMp1HNQw/u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

OpenVPN does not currently report the version of the SSL library it is
using - which I'm not sure whether it's by design or just because nobody
ever added it.  Anyway, right now I think we need it, to help future
cases.

There are a few questions that go along with that, which I want to discuss
here :-)

- shall we report compile-time versions as well, or only run-time version?

  Like:

	OpenSSL compile version=3D'OpenSSL 1.0.1f 6 Jan 2014'
		library version=3D'OpenSSL 1.0.1g 7 Apr 2014'

  (this is on one of my test systems where I discovered an old OpenSSL
  installation, and upgraded *after* I built the OpenVPN binary)

  While I always like seeing numbers, I think the compile-time version is
  not actually that useful - if the ABI is not compatible, it will break,
  and if it is, the library version is what is relevant.

- how do I get the library version for PolarSSL?

- shall we report the library version to the server, e.g. in the form of

   IV_SSL=3DOpenSSL 1.0.1f
   IV_SSL=3DPolarSSL 1.2.8

  as a sysadmin on the server side, I'd welcome this ("show me what my
  users are running").  From a security geek side, I'm not sure whether
  there is potential for abuse, so "please give me your input"

- if we report it, do we want to report it always (as IV_VER) or only
  if --push-peer-info is set?

feedback, please! :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zuly/YyMp1HNQw/u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0qslakuBuNlUUl1AQKAZAQAuGQuKV+gCFPJEe4C56MLchZoVtUCzwga
Ooytp/eUUOjaJqKL+ys1JVFWbuYQw6uvVLCG6j/nP5ImAjeVz/VrwaGOC5UcXfRS
JbdEj8/65/NWiyJL8Gz/Oa0fiLzN+p8owwqVmuIzKflHeKM0d5TuEEp9Ur7EylO0
Dko9r/1Btlk=
=MzJd
-----END PGP SIGNATURE-----

--zuly/YyMp1HNQw/u--

