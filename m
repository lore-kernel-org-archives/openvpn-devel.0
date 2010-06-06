Message-ID: <20100606231601.2474.qmail@...1287...>
Date: Mon, 7 Jun 2010 01:16:01 +0200
From: Peter Stuge <peter@...1287...>
References: <20100604224938.GA19956@...1375...>
	<201006052336.37559.dave_br@...1278...>
	<915E9EDC-6AC1-4CAE-963C-0CBBFA3315F5@...1348...>
	<201006060058.21798.dave_br@...1278...>
	<20100606224242.GA13584@...33...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20100606224242.GA13584@...33...>
Subject: Re: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Matthias Andree wrote:
> I'm not sure currently if Solaris /bin/sh likes $(...) notation or
> insists on `...`

`` is the only portable way.


//Peter

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFMDCwxhR3Q0dhIfEgRAiNYAKCwHExZDNqS+XSTdNeXBZhp7LCzngCgkBBj
hXN43KQmHGlgWD8fdfcZ0rw=
=EvPD
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

