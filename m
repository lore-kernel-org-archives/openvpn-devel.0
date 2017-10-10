Date: Tue, 10 Oct 2017 16:27:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20171010142717.GH958@...1296...>
References: <99D61A626FDA8A4B90A270669121BE10857D3DCD@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857D3DCD@...2294...>
Subject: Re: [Openvpn-devel] openvpnserv building under MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 10, 2017 at 12:22:22PM +0000, Simon Rozman wrote:
> Unfortunately, maintaining a mingw build environment for our own OpenVPN=
=20
> binaries is an overkill. Therefore, in the first stage, I have updated th=
e=20
> Microsoft Visual Studio C++ project files to be able to compile=20
> openvpnserv.exe again:
> - Project files were updated to Microsoft Visual Studio C++ 2017 Communit=
y=20
> Edition.
> - Some minor updates were made to .h/.c files to compile using MSVC again.
> - Support for x64 platform was added.
> - All MSVC warnings were addressed and fixed.
>=20
> Can I deliver the patches for above?

This sounds good.  Please send patches (preferably with git-send-email,
in reasonable chunks) to the list so we can review and merge.  Please
rebase on top of master.

"Reasonable chunks" is a very subjective thing, of course :-) - in this
case I'd group the MSVC specific things into one patch (like, project
files and such), and the rest into one or more patches depending on the=20
number of changes.

MSVC-only things are easier to review as there won't be any impact to
other platforms or build systems, while generic "fix warning" patches
have the tendency to introduce warnings elsewhere (like, printf()=20
format specifiers vs. "what is a time_t" being a prime example).

Anyway, thanks for dusting off these corners :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ3NjFAAoJEB2Cnv7KVigSVv0L/0626s/TsZ7qv8A1kw2pT4Pq
vcdnLzHcIVR508PFzdGqoET0zbXl7UI83FFEbwFx9kbxmNHIS4ADuWmqOC+0Wzyu
ShEGAXSjYG9sq3BZ3TRysFeXj+eyhqCOrwb0gv4QzXuhprZQWXiD4nF8gUz9c5We
6wvmP+6z7v75qcCbQBZD5EKuvQNLHbcca3IlzWWqBZYC03xYvz/0pi/7gGB8FFhS
xuXTkmr8SEQq+vpShslGrUcyRMRfqHSc4y7G/RYI+t/isGjCgg7DPjzNKwSnkFFD
EXRtGeBNl+zKHjXoqZN5vit+yrpHhLYA10BkaHsqz0/dUHHvUFuP88vdGYIzDUQw
K6o0zcwtWDu6k5IQmftWYRSkx241zw8z1wTh9054AnaVbT12NFwikhggkNgHDIVH
hybtEacLu3Z9RV97BHLcAdrGIzhvDBShP55GE1gZdmgaZbmBkbNW9dXjjBzrbqeP
Fpwmyi8OoBAxniwBYyX3b3Y2qXTvKTyFilRXS6SxEQ==
=pTs7
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

