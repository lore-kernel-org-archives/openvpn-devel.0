Date: Sat, 6 Jun 2020 20:16:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200606181657.GB1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
 <1591374528.4728.53.camel@...2316...>
 <1591377595.4728.67.camel@...2316...>
 <47ddb948-d12f-6372-1ca9-34b70dee3f25@...1227...>
 <20200606084110.GY1431@...1296...>
 <fe88bc2f-948d-d0c1-8969-b81ccfe1dba2@...1227...>
 <20200606112817.GZ1431@...1296...>
 <1591456971.3589.12.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3hchEEfOsSuDeH1J"
Content-Disposition: inline
In-Reply-To: <1591456971.3589.12.camel@...2316...>
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--3hchEEfOsSuDeH1J
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 06, 2020 at 08:22:51AM -0700, James Bottomley wrote:
> The only remaining problem is the lack of environment variable support
> in MAC openssl which I'll fix by using the absolute path.  If it works
> I think below is the replacement patch.

That patch seems to go the "complicated" route, not the "easy" one...?

> +eval shrext=3D$shrext_cmds
> +AC_SUBST([shrext])

... I hoped we can get rid of this again...

And maybe then we can just have "libtestengine.so" target in Makefile?

> +[testengine_section]
> +dynamic_path	=3D ABSBUILDDIR/.libs/libtestengineSHREXT

And no more SHREXT here either...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3hchEEfOsSuDeH1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe292ZAAoJEB2Cnv7KVigSzZoL/iivZrmYaJHNuupIdia99iIP
6Q7RHFmArDoiHMend39osBodEBl+EeZHIoG3Qo5391PQiKgJYjTPda2u/QsbTkia
qhyxU4CH3PpYt0yDC6Le1ivDuSaq4B+WKo0Ju8Nv4i0gn95XKex+bl2jRK0LCg0A
+ibpmcyW45TPd8ynJEEexMhbEY16tG32lzFeTwPhE8hLiC8L00PFQ1ov2PpcphW/
NtUI0fiN7lPyY6R0tLFeHD/8k1gNv9sUBaEql22spPwz7vPckdCP5wN0b90G7gTn
K6VvAnethPT4cskLdiJYVn29Q1wCiLnQrimrkiYlX3ziAOy6+2eSAx6vD1Snt4cJ
ps5ttkzuFHJqlk/oQfL84aRbajlS0to0ubT7HHIgX4Z8anw1opnfuH+/RjoizreZ
aLGdvnUeOB2DCD3HX9KOBJOusTXvlNufBk9SWss+CPhKOfbxG5Edv/iCiBWFvONe
DdrFM+xg/JmKDEd+9wsScwVDcLFLZ+MUTGNEoJ9glg==
=rhtc
-----END PGP SIGNATURE-----

--3hchEEfOsSuDeH1J--

