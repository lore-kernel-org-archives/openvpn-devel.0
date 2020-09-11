Date: Fri, 11 Sep 2020 23:39:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200911213947.GI75094@...1296...>
References: <20200717190801.17780-1-gert@...1296...>
 <20200811104401.31075-1-gert@...1296...>
 <15bba1d3-81e9-e37b-9d30-ad99b2425767@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YZlgiSU82KsurN9l"
Content-Disposition: inline
In-Reply-To: <15bba1d3-81e9-e37b-9d30-ad99b2425767@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

--YZlgiSU82KsurN9l
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

thanks for the review.

On Fri, Sep 11, 2020 at 09:03:43PM +0200, David Sommerseth wrote:
> On 11/08/2020 12:44, Gert Doering wrote:
> > This is a new "samples" plugin which does not do many useful things,
> > besides
[..]
> > +sample-client-connect.o: sample-client-connect.c
> > +
> > +# This directory is where we will look for openvpn-plugin.h
> > +CPPFLAGS=3D-I../../../include
> > +
> > +CC=3Dgcc
>=20
> If you don't set this; CC will normally be 'cc', which is normally linked=
 to
> gcc on Linux systems.
>=20
> > +CFLAGS=3D-O2 -Wall -Wno-unused-variable -g
>=20
> I would probably skip the -Wno-unused-variable and rather not declare unu=
sed
> variables.

Yeah, not sure how that one slipped in.  I *did* try to make it warning-fre=
e,
so, next version is coming :-)

> > +    rl->name =3D strdup("config");
>=20
> I'm getting a lot of "warning: implicit declaration of function ???strdup=
???;" and
>  "warning: assignment to ???char *??? from ???int??? makes pointer from i=
nteger
> without a cast" compiler warning on all of these strdup() calls.
>=20
> We do use strdup() in the main openvpn code, but that code includes confi=
g.h,
> which contains #define _GNU_SOURCE 1.  This removes this compiler warning.
>=20
> This is on RHEL-7 with both gcc-4.8 and gcc-9.3.

Not sure what you are hitting there.  According to "man strdup()",=20
inclusion of <string.h> should be fully sufficient, without any extra
declarations.  But maybe it's a -std=3D... thing to tell GCC what
C language level is desired?

I developed and tested this on a gentoo linux, with gcc-9.2.0, and it's=20
*not* throwing strdup() warnings.

> Otherwise, the code looks reasonable and it works.  The log file does not
> include the pushed echo statement (can be enabled in options.c:5286).  The
> management interface shows the pushed echo message.

Yeah, the "echo" directive is sort of weird.  It's blanked out of PUSH
messages as well...  I do wonder what James had in mind here, or what=20
AS/Connect are using it for :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YZlgiSU82KsurN9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfW+6iAAoJEB2Cnv7KVigS05wMAK/Pm2PbmNvN3u8ROrv9Oc1c
hmTcbhG6BAlT4SYGrwyElna3lLEj+wTtiIH4E8Ou3KWuvy06hJDJcqcJ1NgHmfRE
tA70QsVkqOAV8n074hwXfelSvEAItKQmJYfbr552hBUn0xExNOXEgL+QY7aAZJrh
dEdA5FHeIfdZvW0AhmewMdLC79/+n+3DdW0/Tpx6KKy0C/u37OXRjsss9yz4H9E4
0QsunQJ82NYXduSbUgqxP8NswELR42RWY3L/0qs2QICUKEAztaWbv0PnQAGhKXth
Gl6CTKONhPDpYsR9u5RTsw54cXS4xlfFQwa0i305HuoUA/u5KwKr1kFcgI6jxIPb
nSKTsVy5B3g+2tuFjlXQD6+socjjzwUz6F1oBJPDriBhPDZG+UScaXKTCNJrcFZ4
S/iVKu26RlVxaz59KLedMs+hsQizHeqMJ1up+STtWAPBCkd1TlY58z3DLubh0jxO
UjlGrpfmKCD8Xlgzzp4SoCqL1nPC8B63l26dCSl9vw==
=l3Yb
-----END PGP SIGNATURE-----

--YZlgiSU82KsurN9l--

