Date: Sun, 19 Feb 2017 18:49:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170219174934.GK93896@...1296...>
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LXx4g46d83wF7unj"
Content-Disposition: inline
In-Reply-To: <3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--LXx4g46d83wF7unj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 19, 2017 at 01:03:45PM +0100, Steffan Karger wrote:
> Thank you very much.  You approach looks good to me, and quite closely
> matches what I had in mind for when I would find the time to tackle
> this.  (Which might have taken me a while, so really happy to see these
> patches!)
[..]
> Also very good that this is split up into small and independently
> reviewable patches.  I'll start review soon.

While Steffan is our resident expert on nasty crypto libraries, I just
want to echo the sentiment - having these "chunks" tackle one API function
at a time, they are easily testable, and in case something explodes, it's
much easier to bisect to find the problematic one.

Now back to being a commit slave for Steffan's ACKs :-)  (I do not know
the APIs well enough to properly comment on the changes, I can only run
tests...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LXx4g46d83wF7unj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYqdqtAAoJEB2Cnv7KVigSvV8MAJEapwinvW09JRGEd8KYNo8s
g5Ftj5xFMJEzG7x0+h1zQTHc/UDFDQ668DJvbOG4aknqGq7AnZjNh9rA8m7uG0Tr
TV7T1mZK+2bvhjJyS71KxhJXOImZkmxKiUJm34FMHKsmyoEQ+eKSYoavYkhQD0My
ue/dZt+msClzc8vZ6MqacSDUqgSFhZhGphzkwl3VJNLyBUQ/j1yR9D2N17zsJn4b
AZIogTr9gLFEZpp4IgwnVJf6Htm09jX6qPiLjD5cX0wqKtFQk6FnDp5DFNsDm0Hi
zzsPXsNuVQ1MWou8+hW8pjNKQKG9aqa3fvXSWmEEhgK0UNmP35KiQ/Yqes4Mr8QL
/u0QJREHk7q69CP8IbWVO/c9w57a3+wZxCLA3lGzQWA+s0iis/bRADJQgpKVVKjW
wShacXc5yP2u7/5/9L7EdPkLptKQjBzxzb16QeyHnarBGlCWaD26D7yJCQpU4j6U
k+XYCaZ3n3IhLGD7g7G8zI2uXVWOH/lA7Tm+BzLkSQ==
=Vllk
-----END PGP SIGNATURE-----

--LXx4g46d83wF7unj--

