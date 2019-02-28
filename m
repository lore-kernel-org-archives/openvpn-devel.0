Date: Thu, 28 Feb 2019 19:25:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190228182507.GR962@...1296...>
References: <1550709982-19319-1-git-send-email-selva.nair@...277...>
 <201902281725.x1SHPXJq043376@...2054...>
 <CAKuzo_jso35sxhAk4OUAiSXqX6g6OciS1vseyRgZBGVGRbOWUA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XiVeImctRR2en/bC"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jso35sxhAk4OUAiSXqX6g6OciS1vseyRgZBGVGRbOWUA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Better error message when
 script fails due to script-security setting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XiVeImctRR2en/bC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 28, 2019 at 12:33:46PM -0500, Selva Nair wrote:
> On Thu, Feb 28, 2019 at 12:25 PM Gert Doering <gert@...1296...> wrote:
>=20
> > Your patch has been applied to the master branch - it won't apply to
> > 2.4 as we have no "run_command.*" there yet.  Shall we cherrypick
> > bf97c00f7dba4 and 253f015558 to get there?  Or do you want to do a
> > 2.4 version of the patch?
>=20
> Would require more cherry-picks than that, or some manual edits, isn't it?

Yes, as we also have uncrustify patches that affect neighboring code.

> I can send a patch for 2.4 -- would you prefer the same as this --
> i.e with switch(stat) in misc.c and and preprocessor macros in misc.h
> or a simpler, return code =3D -2 and error message as in version 1?

I think we should have the same code (so, with the switch()), just in
misc.c - when we come here next time, at least it will be the same code,
not "something completely different".

thanks,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XiVeImctRR2en/bC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJceCeBAAoJEB2Cnv7KVigSyPAMAJvzuxIqYjfUmvhbAZD5tJXJ
gPA9j92BnaZzG7Ww65Rl0hNaYLLqDVwRT51/cwSPt1r5fPP92IhLL54NTuvKRe2m
nXZodoZAfW4k3m3ma60GnJXM3UDHcpupDKex3XHfmRTVyWMnWatJl7NP+W06hvHP
SBoDdiyH/Dnpk3chNWZ8ihF7tloYe81MJ/Sh3rKAofBzN/+6eUoGoIFoblt0lPuH
r6iSj2BL+0n7UUWTQGya7F/6Oaqgk2OT5UZqrLGdLw01LeIZoI1JWp5o/JHaL6jP
SzmlG51sE7XPaWl/g5LgTmBJ8V5dCakUInzlU4beAjaKftHmN6yzx7BwNQusyic6
SeU26Udb7+neucodkAhSoxwXh1ziS1Rp7slvItgkS3EPwxzwQEBdP3EnTKzeMpsl
6kxa3wkPCM1T4hLj6AWeqR7qmgI+IfEe/ggD7tfGc3kte2ESzEplD9PbVMPIQ3eR
sbhVu9hmDmp5M0iLHTn+vD5pO6j7bIp2hpvuJstQOw==
=DMpr
-----END PGP SIGNATURE-----

--XiVeImctRR2en/bC--

