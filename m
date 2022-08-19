Date: Fri, 19 Aug 2022 12:18:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv9jXk9r5Zc9ut5c@...1296...>
References: <20220818201505.656149-1-frank@...2641...>
 <20220818201505.656149-2-frank@...2641...>
 <6e140f92-f71f-35e8-cd3b-914949ef24b5@...2181...>
 <52da546c-3890-c073-aea7-a620db92520d@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="31R/3dkhd58VM5Ey"
Content-Disposition: inline
In-Reply-To: <52da546c-3890-c073-aea7-a620db92520d@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] uncrustify: remove newlines after
 return type of function prototype
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Antonio Quartulli <a@...2181...>, Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

--31R/3dkhd58VM5Ey
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 19, 2022 at 11:50:04AM +0200, Arne Schwabe wrote:
> Am 18.08.22 um 22:43 schrieb Antonio Quartulli:
> > yes! This is what we need!
> >=20
> > Acked-by: Antonio Quartulli <a@...2181...>
>=20
> I am out of the loop here. Could you two explain why we need this? I.e.=20
> what is wrong with the current style is and what the plan is to change?
>=20
> If often struggle to properly format function with the soft limit of 80=20
> without being allowed to put the return type on a separate line. So I am=
=20
> not sure what the improvement of this change is.

This is the conclusion that I arrived to as well, when reviewing the
changes in 1/2.  Forcing the prototype on the return type while at
the same time permitting enums, structs, etc., will cause cases like

enum some_special_type special_function_with_descriptive_name(int arg1,
                                                              char * arg2);

which is definitely less readable than=20

enum some_special_type=20
special_function_with_descriptive_name(int arg1, char * arg2);

or maybe

enum some_special_type=20
  special_function_with_descriptive_name(int arg1, char * arg2);


Now, for other cases,

int
somefunc(void);

I find the other style

int somefunc(void);

much easier to grok ("have a single look and see what this is about").


... so, my suggestion is that we permit both styles for function prototypes,
based on overall type + function name + parameter length.

It would be cool if uncrustify had a magic flag for that, like "if=20
return type + function name is < 40 characters, put on a single line,
and if over, split" :-)

Am I making sense?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--31R/3dkhd58VM5Ey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/2NeAAoJEB2Cnv7KVigSVKcL/1GsW1QoMKRV80sSCPikqZ0A
o8UsafHIkgfAZ1sTOgMZo2F4Ugvd65HoEZ6c3yx5cRIWyahKf8y4UCdQg6YxNV+a
Xoit0LdyWJcfyxzvbOyapwmtsJm74O22msU/ewJqSYLx8cPlBG7MeWtaOONsvkqZ
K1+XlCPB4Wo4Yvyen3vnB5rw7FAuHMgvw25WW4OQve7iRmZMjJ6PQHc3WVS2PO+e
jlw+o2RhxrA6FVrxcqj5ArBfcnBQHNVa8mWi1deLyubG5n5XqVt3olpn4R06ghNK
UiXiTgKVsJs6tdX1+r3oRhhKUCK4k2jJJn2OTMg7Gq+2jxo/WmfHgmV91jjv0lJT
xP/vMAWlLulwR3p3UJdxIDQk5Cgp73fK8TCZdmx2k+j7Ir20e8BNJ8vQfTnFFlzV
DFboA0ODUuWtoH0TtOvb/eyWJejlYska7vKXBDH6L+UQXIZXy0ALaA1rWTdii3Ku
t2IWY3tKy4KBYkVg8AQ3NKXYUNbbKTydjPFZHFpCow==
=7mHu
-----END PGP SIGNATURE-----

--31R/3dkhd58VM5Ey--

