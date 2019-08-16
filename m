Date: Fri, 16 Aug 2019 19:51:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190816175120.GN1349@...1296...>
References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
 <43f87c71-6da5-b777-0def-e3a0893398b0@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <43f87c71-6da5-b777-0def-e3a0893398b0@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net, Todd Ouska <todd@...2525...>, Sean Parkinson <sean@...2525...>

--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 16, 2019 at 05:22:27PM +0200, Antonio Quartulli wrote:
> The reason why I ask is that adding a new crypto backend drastically
> increases the maintenance cost for us.=20

... and since we're already struggling with providing proper maintenance
and getting new stuff integrated in a timely fashion, every new burden
due to extra testing, extra backends to consider when adding crypto-
related patches, etc., is a fairly big no-go today.

Now, if we had 30 contributors that are all sitting idle waiting for
patches to review, test and ACK, I might view this slightly differently...

> Therefore, reducing the change
> required in OpenVPN would be extremely beneficial.

This.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdVu0YAAoJEB2Cnv7KVigSggEL/23Z22GwOPM1Je/254B2zHHm
3QfaS2Ali8XOB1NP35Eq9a6PEzIXpsZxHcTClRZ0mpTh/m+80CGBV2w2JMENVyp3
8TQ0MqYqDWcycSogvL4+YgL1gbppQqYDYcTUxSqGvyW6T/plfZK83qAJHpU6DMop
DyUmSxLk2JjNKS3/ewQDB/2sYOa49FF+dC3hYY2oVHqZGdPqyN5CyNJ9RnZD8mq8
8wnLrW/lyHIKFtWD0G5N3P5LKgfFf9rTiuqaEi1Ot5q28XZP8GCxRiyUiJIjW9OA
4Vg71ADAMv4aIb7sD0fjSbd3Bb2Ev2KO5LpdHmAR+TK8Sf95nSTjBUNhwOAAvkNa
KLSd/3QytVPxFDHzgJHE5cu2VK2kLTGApKs9hLjn9MzZ+yqEyUZy8tOy2q4m55vx
5ENzjP4Ioi5hSTPIXE9t0No/oCkQkRbt0JRGYDzhI3972pYolILSqSiN7Mg2Dg6n
Wrp1gbJoLqcBWNgpjeFkhXf8N95Mo6j/OFzeP8mUTA==
=43mf
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--

