Date: Mon, 5 Apr 2021 10:34:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210405083413.GN976@...1296...>
References: <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
 <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
 <20210403095640.GW976@...1296...>
 <5f61a142d6c8fc91223af9b89cf2772b.squirrel@...2556...>
 <768c58ba-e87b-4e96-0403-61fece8297d0@...2181...>
 <704cc498609f9451a1af5010669452b4.squirrel@...2556...>
 <20210403165313.GY976@...1296...>
 <d4daa5b7f65017700e60369dc5ff1778.squirrel@...2556...>
 <f63feda0-a22b-4e01-ea3b-a2c6bcb0eaaf@...2181...>
 <63c5054ebcf20fceb7dba025f065b180.squirrel@...2556...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2KnalKfNM3PQ1Bre"
Content-Disposition: inline
In-Reply-To: <63c5054ebcf20fceb7dba025f065b180.squirrel@...2556...>
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--2KnalKfNM3PQ1Bre
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 05, 2021 at 10:16:07AM +0200, Simon Matter wrote:
> Then I misunderstood what is written here?
>=20
> https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Option:--com=
press
>=20
> "Compression is not recommended and is a feature users should avoid using.
> To signal this clearly, --comp-lzo and --compress are discouraged and
> considered deprecated features. Beginning with 2.5, these options will no
> longer enable compression, just enable the compression framing to be able
> to receive compressed packets."
>=20
> That made me feel compression support in 2.5 is only on a compatibility
> level.

This is half-correct, and half-incomplete.  Look at=20

  --allow-compression yes

(new in 2.5).

Yes, 2.5 will no longer send compressed packets unless explicitly permitted
by "allow-compression yes" - but the infrastructure is still there, and
still tested, but moved from "this is something everybody will want" to
"if you know what you are doing and why, you can still have it".

Regarding your other mail where you doubted that "there will be a discussio=
n"
- well, I can assure you that there are discussions about every feature we
take out of OpenVPN (and usually, mails to openvpn-devel and openvpn-users
to figure out who might still be using it).  Many of these discussions do
not happen on the list but on the #openvpn-devel and #openvpn-meeting
IRC channels - but Samuli is sending the meeting minutes to the -devel
list (and they are on the trac web page), so we try to make transparent=20
what we discuss and why.


As always, code is a balance between features, maintenance effort, bugs,
and security...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2KnalKfNM3PQ1Bre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgasuFAAoJEB2Cnv7KVigSK54L/0lBoD5isqZSK51TaYX6xSAJ
q/b0HXjrzDv/fPHwPX0gbAUO8lScyg07ptmQR6g/waXOssUrt14yK428U4Kjkd8U
LvpZ1RUcaRueeDkFgVObu3vvY7mmlEATSS7IFR0p6TJPbq3/+4gN+hoIM3F593Cf
PzRLr4IcPfwZ6h1UgUyMsIFd4oGruzRqfMnTfNs7CGYkBVt34jkJ7kuYULvxmNvo
jyzh7NKC/QE42PS0XZN1xY5HmdNpQgznrsJo4/mNo84SKGQo0fT8PyXQpc8pzClB
jSwXszKD+WVGSx9/cidixvj6s1XgOi2bYyCM0tQzZ0T5fRwfas9olv+sXVz4g9Wn
UIluORy/5lUwt/RsIdhjUT/U6g1vsjvp1YNbdl5WKPbPmDYZdWDy1fIBlCN24Vyb
+cXUvx5UBpI+uwhzTHyRhdTMsxbALi5mlaWT42t8qPis1D/x+BIQfBy8fITlEMqD
AfS5nVS7xpiBR8m6WJ9L5t57XxAtYn4hHg4kmb0p+w==
=hdPs
-----END PGP SIGNATURE-----

--2KnalKfNM3PQ1Bre--

