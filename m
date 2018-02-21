Date: Wed, 21 Feb 2018 14:45:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180221134504.GV69387@...1296...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <1511026858-23281-2-git-send-email-selva.nair@...277...>
 <20180220161429.GB69696@...1296...>
 <CAKuzo_iDwg6YJX4GaXPOU8tGhRoKL3-025N9=a+jNwDaZWSy2A@...278...>
 <20180220195920.GQ69387@...1296...>
 <CAKuzo_iiv+3GJXuAV1rD+ZH9ijUybqVVNBW1iaV5KzNTDZgyfQ@...278...>
 <20180221074259.GT69387@...1296...>
 <CAKuzo_iu-PeP6qHtMbQi69=3RSN1U9JNTFwso32s_H96KM3uNA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wyHyZdqeYW2KHjoc"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iu-PeP6qHtMbQi69=3RSN1U9JNTFwso32s_H96KM3uNA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Make most registry values optional
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

--wyHyZdqeYW2KHjoc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 21, 2018 at 08:20:34AM -0500, Selva Nair wrote:
> > Thanks for investigating and finding the root cause.  "This is not what
> > the documentation says...!" -> I need to actually *run* these things, n=
ot
> > just test compile.
>=20
> When I say painful builds, I mean edit build[*], copy to Windows, run
> in a few configurations, look through the event viewer, rinse rather
> repeat. And finally when it seems to start working connect to a my
> work VPN,  remove the registry keys and try to break it etc..

Indeed, that takes quite a bit of time.

> FYI, I don't just "test compile", and leave it at that.

I did not want to imply that you did - sorry if it came across that way.=20=
=20

*I* only test compiled, and was then happy merging your patch ("I'm sure=20
Selva tested this, it is according to documentation and the code looks=20
good, and compiles fine") - but as I learned, there are more caveats on
Windows.  So, when we do more basic changes (new API, etc), I need to
do actual test installations on my windows zoo, like, win7/32, win7/64,
win10/64...  I usually do this already today if I suspect breakage, but
in this case, it came as a surprise.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--wyHyZdqeYW2KHjoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajXffAAoJEB2Cnv7KVigSe+sMAKpyeqAACl9Ym1LNrSrQd3SB
ecblWJZj/rJE3W4qs6zNfqshBxKB8/DPCvWcsQiDdKsVwXWf+YViEhYOen7+GHZO
0B/nKDqRBA9bOUTF4pW2im8khWjFHtq1cYk4zoPCgEf+FWSsRGxxGz64w/L8HmE6
/SLf9MJ3Tx7gH+DlIMV80SOLMadZ6XsIpyzvh3itG+3LMTqEq9F5+c232Hx5Q8Sl
Giv8ZU7PiQmWQb4DpRwfgOO9K+cMe3cvXf5iMUiGDhKAANHBcV640pllsSN1WxUt
zjxk+akjOiDGZBz/D1z3L3qqVHduSODj2ZJIlKlzDKeG4V79hW2lSZ8w1E+gAZs1
EZULQEQsyQLaPOI9i0ldcLOsb9iXs7Bp01HyyTR1/0cL+UB8I8wXnMNrgU1rXsKc
FHMiyfgJuxW5tL4cLk69gH9iZXT6ibYNRPmsv2Veav/uvrnlSQMl0lRV2XXednR9
ElgYdjL5P6DvoDN+YAwfRQCshpD5N9kSTXV2cNCP8A==
=CXCG
-----END PGP SIGNATURE-----

--wyHyZdqeYW2KHjoc--

