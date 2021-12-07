Date: Tue, 7 Dec 2021 19:53:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Ya+tvSnooB80V/dI@...1296...>
References: <20211207170211.3275837-2-arne@...1227...>
 <202112071850.1B7IoXox074190@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yyh0Y5IYtjYifahf"
Content-Disposition: inline
In-Reply-To: <202112071850.1B7IoXox074190@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove max_size from
 buffer_list_new
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--yyh0Y5IYtjYifahf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 07, 2021 at 07:50:33PM +0100, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> That was one of the easy ones :-) - verified that indeed, this option
> is never used in OpenVPN code.
>=20
> I have client-side tested this ("make check"), just to be sure.
>=20
> "void" has been added to prototype and function declaration...
>=20
> Your patch has been applied to the master branch.
>=20
> commit 5962f6267fcdf33f83f8de725751b5ef41e94f7c
> Author: Arne Schwabe
> Date:   Tue Dec 7 18:01:51 2021 +0100
>=20
>      Remove max_size from buffer_list_new
>=20
>      Signed-off-by: Arne Schwabe <arne@...1227...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20211207170211.3275837-2-arne@...1227...>
>      URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20211207170211.=
3275837-2-arne@...1227...

*sigh* one day I'll learn... mail-archive search engine takes a few
hours before message IDs can be found.  So usually when a patch is
very fresh, I check the "URL:" that the script puts into the commit
message, and adjust from the web archive.

Forgot for this one, but noticed before pushing - so, fixing the commit
message with

  URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
23329.html

which of course creates a new commit ID.

Thus:

commit 61d2f918d53c932acd1061b8523c54c18ebb8176 (HEAD -> master)
Author: Arne Schwabe <arne@...1227...>
Date:   Tue Dec 7 18:01:51 2021 +0100

    Remove max_size from buffer_list_new

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <20211207170211.3275837-2-arne@...1227...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg23329.html
    Signed-off-by: Gert Doering <gert@...1296...>


Stupid toolchain...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yyh0Y5IYtjYifahf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhr629AAoJEB2Cnv7KVigSVEAL/j8WyvWHQLu7AORRvcdekoN9
pZnjVpAziAwu9/UNCPTMXGnJstv24u8vcB+4StWQOlWtzT8sA1lQPBMXPQZuPjql
cCHZ1lPM+O6i4Rjc9hGD/oM7QqWLhA1dnS3/tLKDQiDFzfnfXi7Sc3E5YdbKgHgz
w4wNjq2B/RlVmo1y3MFqWbwhlyGsph2QAKo0d+0EVQwMvqUXaacbpLh7apn8oO/M
JeDsorki0QPztcCLNynyzpdRmqj3jw9EYTxTBz4VGlsdSAglOpZYmL2G3HvqiqR4
jlAyAGwmDybNgQVJutEgjze9ji+mTLsA+7ew05xCas+ETp/4FeLhnHZKkd185J4M
zC2XgL6rqP+y0+JySEen2W7fBw9JUHdLSiL/ZT8LI35diZsx+sJEpho4anxvmbch
nXNPEGF5ezNkBYJjEIhM18ArKN00Q+HjIAb1MvzK89D1C2uIYa7pOwB6cHAx4XKY
xJepIHTqDxvoUDmDMqq1ZwPb2aZu8edeuy8TpfRDuA==
=USVV
-----END PGP SIGNATURE-----

--yyh0Y5IYtjYifahf--

