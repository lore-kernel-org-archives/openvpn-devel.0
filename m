Date: Sat, 30 Sep 2017 18:19:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170930161910.GX70062@...1296...>
References: <1506735276.3927298.1123095944.62A302FF@...2307...>
 <20170930074629.GT70062@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qdXEecL5KnboUGfM"
Content-Disposition: inline
In-Reply-To: <20170930074629.GT70062@...1296...>
Subject: Re: [Openvpn-devel] Unreferenced function in 2.4.4 Linux build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: logcabin@...2306...
Cc: openvpn-devel@lists.sourceforge.net

--qdXEecL5KnboUGfM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(copying back in the list)

On Sat, Sep 30, 2017 at 09:46:29AM +0200, Gert Doering wrote:
> Which linux distribution is this, in which version?  Can you upload
> config.log and your system's "lz4.h" somewhere so we can see what it=20
> tried to do, and why it is failing?

I received the files in the meantime, and I'm not fully understanding
the issue yet.=20=20

lz4.h says it's 1.8.0, so is passing the "newer than 1.7.1" check just=20
fine.  The lz4.h also has a prototype for LZ4_compress_default(), so it
really should work fine...


What I noticed in config.log is that we test for "is it working?" by
checking LZ4_compress()

    # if LZ4_LIBS is set, we assume it will work, otherwise test
    if test -z "${LZ4_LIBS}"; then
        AC_CHECK_LIB([lz4],
                     [LZ4_compress],
                     [LZ4_LIBS=3D"-llz4"],
                     [have_lz4=3D"no"])
    fi

... which we might want to change to LZ4_compress_default().

But it should still work.


@logcabin: can you show me the failing compiler call as well?  Like,
the last 30 lines from a failing "make" run?

You said you found a workaround for it - what did you do to fix it?

Could it be that there are multiple liblz4.a or liblz4.so.* on your
system?  What does "locate liblz4." print out?

(So maybe there's a lz4.h for 1.8.0, but the liblz4.* that the linker
picks up is from an older version that did not have LZ4_compress_default()
yet...)


Slightly puzzling :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qdXEecL5KnboUGfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZz8P9AAoJEB2Cnv7KVigSA8gL/2aSuQsQxkryJdDlws7s6q2H
LCbvk2jrhAzfH5VTlzyU/qSGgtVfUB836tJcXcTJxxQpsUncD1+Gs/kkXYfmoa43
AV/GffGTZMi3hoQLYmIc8YvSMDIGWx8xwz6ntautgSV6KTFHd13+Er8ugh2OvwRT
PtO+iDM+ho11Uq6hkob+4E0vujYm7WkN/lHBMv+z8VuGy2bHHhZb7RwiQ8J0KncL
IVm+YNxYGpr+A2FB/+iGDF6IHnWdxsGaKtT96rr/jcW6dL6zcOX76OktqeTI3nvW
ux6uep8L5gy4xoGOHTuzBQKcS1M6O5KgQKEnP4gxQUGMLQeSgcvQ5YTmdgE1aOGO
pY8QYxgXn/678K5LEbuv2FgubirTq5htNLc5kneVk1E3wjCJUn4j01DzSxxioYFU
mRlU/7ztFxhSdlmhYJQBcSQBMXkbtgrkRMunhBm4j78mYWDJoyA6F5VJwNyjxeDD
jk5sCEHr+7RqxnksV3N4xNivzfzMdZ3X9gkyQZNr4Q==
=y/A2
-----END PGP SIGNATURE-----

--qdXEecL5KnboUGfM--

