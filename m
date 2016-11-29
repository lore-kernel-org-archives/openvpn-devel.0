Date: Tue, 29 Nov 2016 11:18:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161129101812.GE1013@...1296...>
References: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
	<1480371252-3880-1-git-send-email-steffan@...1856...>
	<CA+0EDdBLaPxX3u07yfg=S-xnVEnFRP7oD=2BnpONtjw7EEkPeQ@...278...>
	<331bcfe6-0373-1542-cdfc-50f360b7ceaa@...1435...>
	<2ebb29c2-6cbf-e770-2f31-5e08fa2f0e9f@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <2ebb29c2-6cbf-e770-2f31-5e08fa2f0e9f@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce and use secure_memzero()
 to erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 29, 2016 at 11:07:12AM +0100, Arne Schwabe wrote:
> I think we should prefer memset_s if available since it is a C11 standard.

Since we're currently compiling against C99, we can't rely on it being
there (in my OS Zoo, only MacOS seems to have it, at least "have a manpage
for it" - not even FreeBSD 11 or "gentoo current") - but then, configure=20
could check that for us...

Shall we merge the current patch anyway, as the memory barrier does the
job on all current compilers, and add a memset_s() variant "whenever=20
one of us finds time to add and test this"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYPVXjAAoJEB2Cnv7KVigSK6QL/2dPd0cU/L2YCzxoGWNmkMOl
er1KlsZ/GvnL+Ij1W9eJMo/6qASJrKrCtRVizM387XkKa4NjfdPGYZQwdQ/Ar3S8
1IzOMUA0RqiLj4aECPyk28rItaW4pwW0fq+rUNHtrKrMsPH0vjoBancS4tj7hxtT
E0nwU8Hb4SYbu6ZGzMv0VRRANG1w8qYyNI8oX5V9XECOoyAAmp//ZT0FY0z7XDxh
aiKi0vHcSzphWwvd600PfNOXV/XNLyvtbDsakTIcY8/QmLmaDLyBY5t2EcWvToIO
AsJUCudgHBL7lx9RN2YhWnYmLeDBwI9uRdReo5aKPzQTkZjbokf6sdgrieyHHCrs
4hcl+FJ6qbYFXitSxoiAOUEim/Uv1TPJmtag0YPGjr7qKKbFmpGSQ9IxSdPKsV7m
q1E2aAiuyxajL/kh+J/BpXArRV8yK2SfcSL8H9DFFz6XpWCDkTZ9/x2aeX9QUY4p
JO/fHUO0qcUNSH7pnrC6fIf/l97J6M/ImsYIBrThnA==
=UBry
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--

