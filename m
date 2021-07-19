Date: Mon, 19 Jul 2021 18:11:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YPWkQPghWzdWbst+@greenie.muc.de>
References: <20210714162533.10098-1-david@...2627...>
 <7b1e2246-8375-0369-1d27-6100cc03b872@...2181...>
 <20210715091009.GA976@...1296...>
 <3eb6ce10-9e98-bd9a-4b52-33cebf7735c9@...2627...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Rjq4tjUwk8wDBJAO"
Content-Disposition: inline
In-Reply-To: <3eb6ce10-9e98-bd9a-4b52-33cebf7735c9@...2627...>
Subject: Re: [Openvpn-devel] [PATCH] Fix leaks in route.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: david korczynski <david@...2627...>
Cc: openvpn-devel@lists.sourceforge.net

--Rjq4tjUwk8wDBJAO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 19, 2021 at 04:29:32PM +0100, david korczynski wrote:
> Gert and Antonio, I am not sure if you would want me to change the
> commit message or not. Let me know if you want me to change it and then
> I will do that.

Nah, I'll adjust the commit message when commiting.

(Our rule is: code is never changed compared to what is on the list,
whitespace/comments in code can be adjusted if it makes sense and the
author is OK, and commit messages can be adjusted if the commit itself
is good but there is grammar errors, a link to trac missing, ...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Rjq4tjUwk8wDBJAO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg9aQ/AAoJEB2Cnv7KVigSNgIL/2VdxrQ3bMS6sQKJKA9XUaW9
G4VOV9jUWOndEH+bW/JNyhgiO4+vqOKmbztySDP4ffqLy7D161RgTU95VZo8Ti3A
8THrvvb8ktT/tl+Zrf9SEdm2JF1JObBiKIF4eC6iLhGYj/y4QwWSWCqotDjqsN1j
ETkrlv7G9vrK4IESzRAHrMoWksCZt6mv5EEcSuqAR0MZluQdCXmjg55magA/v9Ni
gPevcFax8MBRQA2ouAqfOFUdIRVA7aIeIZ8RlWWNm6z5NF+I0gi4ZCbRmsNXj3/E
TBA60LHpoimXi/iruJ05DdqeUF+oG+xh5SVgofvf8jEApji7Ia/qt9TF79toUoNU
gbp5mGiLY+G3IlYZPveL7RGb60mKPyw1yUovYhc0u7dmudsYiQDNkzCcExbz7rjf
rLTPysBORIbab3lyZWUFcrVINvgc6XWHj6P3Ra7HLPq0pIyxA55U/Ei8JezucMQT
fPhjKE5bUJP81JSoc9MfSLY26cGAcREddG90MeH/dQ==
=P8B2
-----END PGP SIGNATURE-----

--Rjq4tjUwk8wDBJAO--

