Date: Sat, 20 Jan 2018 19:00:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180120180042.GO69387@...1296...>
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ft0o2zvssPbUStej"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ft0o2zvssPbUStej
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 20, 2018 at 12:22:52PM -0500, Selva Nair wrote:
> Does openvpn-vagrant include any VM provisioning with openssl-0.9.8?

"Not that I'm aware of"...

> Until recently I had access to a few old debian boxes but now all
> updated and 0.9.8 testing is getting harder.

... but it should be fairly easy to find a suitable base OS "box", and
add our provisioning to it...   which debian versions would be suitable?

My buildbots, unfortunately, all have 1.0.1+ or 1.1 even today given
that master won't build otherwise (0.9.8 is still there on some of the
older FreeBSDs, but hidden behind symlinks pointing to newer versions...)

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--Ft0o2zvssPbUStej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaY4PKAAoJEB2Cnv7KVigSSNQMAIk2XWPeYgCjxjm0tkCzOEKw
J1+SJuhKd/IL0Gfy89mNGk3KUFdGkUJiHoCpGLg3L8OlVVTYbFCVIxQyFJYggNsw
otncJmrEYe9Nhoa6KjEhcM39mXPlpeY3dY3x4awYKZS20s/xbtHpTLWac5v1ex3p
+DwmV5+Hwi9YxwmqTnzDgYuimTlOB/rZ5O6nSzpYQNQFf+3U5+GE1II0AwakdaTD
MuQkToVu2UswGQi1RRD5QdiUGMmBGLmRzq35SYpPel8hkJEK+xCEPLLDwuSMpGnj
+unlCESigXkMs9ziuOuuNSep/R94Z0kY776RuLuv44thpWyo1c+WSbfiDwwz0jJl
20lN3DI4bvTOnJCeNUtpUiDHzIpFIabCLZuROlr3TjtfFHDgvxy5nsZ2LwpdYzs1
xXq0HNEEzVquAvbQdZuXka0sI+39RDoEQ10G++1gQu6J3InshleYgV13UerYkOlI
lZwr+KPe87PTeiRTNPstKmBNwt35lh1Cs5Phs+4VBw==
=lf89
-----END PGP SIGNATURE-----

--Ft0o2zvssPbUStej--

