Date: Thu, 13 Dec 2018 08:09:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181213070916.GX962@...1296...>
References: <20181130135641.11533-1-gert@...1296...>
 <20181130135641.11533-3-gert@...1296...>
 <5e07f322-7d84-7758-8f46-f579579bd45d@...2181...>
 <ebd4c068-6046-81d5-9763-ec5dec8cdddb@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="q74XNxSV1vRgrnoy"
Content-Disposition: inline
In-Reply-To: <ebd4c068-6046-81d5-9763-ec5dec8cdddb@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] uncrustify openvpn/ sources
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--q74XNxSV1vRgrnoy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 12, 2018 at 11:50:20PM +0100, David Sommerseth wrote:
> I do see my uncrustify run have some weird disagreements in
> src/openvpn/push.c, where it wants to indent all the switch case parts one
> more level.  Not sure why this didn't hit Gerts run though, this change d=
oes
> seem appropriate to our CodeStyle wiki page.=20=20

This is Arne's forget-auth-token patch which added a level of brackets
but did not re-indent the switch/case part (e61b401ac5).  I commented
on this in the "merge and pushed" mail, but decided to merge it nonetheless
as this is another one that had been going in circles for too many moons...

[..]
> But I think we just need to accept that we can only push uncrustify to so=
me
> degree towards our desired coding style and then to accept the minor gaps=
 to
> our view of full perfection.=20=20

I am fine with this.  Yes, some of the changes look funky, and I wouldn't
personally do other stuff, but I can live with the result - and it's way
better than having to argue style questions all the time, instead of
focusing on code and "possible logic flaws in the code".

> Telling contributors to "run your changes
> through uncrustify before sending patches" will definitely help.

Indeed.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--q74XNxSV1vRgrnoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcEgWcAAoJEB2Cnv7KVigSpNQL/3/lomFDEe17zfmv6YqH5r3V
h/tFxI2wunKk5gj9FaLQ/ZSgUNpDULX0RUrHSjsgTt2iCinFZUuglv/8c96zHeS3
bgjLGwKEKBjpJaEY97dvF7y2AyzNmGQesbr7LRel4veEgucsz73PkmlWFYelzh8U
8AF4Sjfw1XWtz5MryuHcTvhj19Ehn6ptviSIBfyC9HRuqmOX36E0E9a9PL7XZYPj
4g4XnQ9hyzLOtnYIfndWs0G1h/NTUihCZgPIVe+W6XwZe5dEOyMevHoYx2WZXiWu
usXfT/iVN/mvmVCEDOfIvQqmogpgTsNgmtCYAxj/lIWIl7/C0l5wR2OBnEt5u43+
+mdky7eCGbTaW/TSWnB+TKFP1+LfOOGgCvzMjBWCydC0eVAs4QzLck77PpKPPS4z
RzhXxaPLCxhL+a9/eu7H5rioHoXCDZDFeTJ2gh5lrp8FfJNcfB/qLRETP3Re6o8I
aU7W9+H6cIiuvuZb6aaeGgmVfHr5S8rRjb4P9sQ1/g==
=LkuA
-----END PGP SIGNATURE-----

--q74XNxSV1vRgrnoy--

