From: "Csillag =?ISO-8859-1?Q?Krist=F3f?=" <csillag@...385...>
Message-Id: <1114964603.5478.46.camel@...387...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_nervhq-7989-1114964560-0001-2"
Subject: [Openvpn-devel] one-time pad encryption?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun May  1 09:23:19 2005
To: openvpn-devel@lists.sourceforge.net

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_nervhq-7989-1114964560-0001-2
Content-Type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi there!

I would like to ask if is anybody working on implementing OTP (One-Time
Pad) encryption for OpenVPN?

I have heard the usual arguments against OTP (too big keys, need too
much random input, must never reuse, etc.) many times, still, I think
this could be useful in a number of situations.

(Imagine that you are running an organisation that operates at several
different locations, and you need real-time, encrypted communication,
and you can afford to periodically send over a deputy, with a few DVDs,
full of white noise.)

Obviously, the handling of keys (like generating, importing, exporting,
choosing, finding, erasing the right parts of the right keys at the
right time) would need some extra care, maybe a separate daemon should
do it.

Does something like this already exist? Or is somebody working on it?
Or is somebody interested in this?

	Kristof Csillag


--=20
Csillag Krist=F3f

http://www.mit.bme.hu/~csillag
csillag@...386...

--=_nervhq-7989-1114964560-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCdQJ7UhjTfEopf5URArAHAJ0R7lZBKKVu/6ELd+UTu1x7Bq1+dACdFQ3m
CR4e0RQK+5DYEUm6r9mmEfk=
=Q2N/
-----END PGP SIGNATURE-----

--=_nervhq-7989-1114964560-0001-2--

