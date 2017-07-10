Date: Mon, 10 Jul 2017 08:30:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170710063017.GE97029@...1296...>
References: <20170221192737.24166-1-davids@...515...>
	<20170221192737.24166-4-davids@...515...>
	<24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wGpptzwidXSj3oLh"
Content-Disposition: inline
In-Reply-To: <24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Replace deprecated LZ4 function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>

--wGpptzwidXSj3oLh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 10, 2017 at 12:31:31PM +0800, Antonio Quartulli wrote:
> Instead of cluttering the code with these ifdefs directly in the main
> codebase, how about doing it in compat.h, like this (it's a copy/paste -
> code might be wrapper by the mail client):

Better, but I wonder if we shouldn't fix this in configure.ac - "if the
system lz4 is older than what we bundle(*), use our compat-lz4.c instead"

(*) ... or older than what we need, functionality-wise

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wGpptzwidXSj3oLh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZYx74AAoJEB2Cnv7KVigSZkAMAIGZ5tZp4dw0wNCkEmNgobfA
mtAkb2+N2p3i5aHtTQgqokwrXpMwBOl/sDkVk4+px2MdMG5LFOeQl4SG9cIN74/T
ig4JV+gPldKD8n8rBld2hMGJ1838WvI3nqONISeQ4dxTPu26eiXQVZb19lKCqGQt
qglQHYJa60vEAol+m6rbMAzUj3jUwplW+F+4zd5XkuFnDYn8GEKlHW0dBd5GVLRi
dSP8G9+Wa5t8UYKREDNm/um7aDO6XKrGeRFF/nirSoRM6l1qNWld2cfuYKYg0s2M
yxxH26MF7ZDI5ANZKwxa2vnGqQq8CWWZlTKj28Ru+PK1Ynas/rAEyF/wTcc9QxPZ
eiuc/5HrJzjtzaO2QU7Hl0gKyko56DZHzA80Giaau+HJ9+hP8oRiWAueDEBzSOlY
mwcNGPLxqSIKfxMc74p0xScoMGZPjzzggyqT8zj8MaItJa/X91k2p9Q16HxH0SoR
pVO+ryh24M1CyZ9ER3s1x/dqs1+7ytPzEAeopQ8Jkg==
=1ANM
-----END PGP SIGNATURE-----

--wGpptzwidXSj3oLh--

