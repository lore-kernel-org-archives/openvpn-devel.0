Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170907012225.21661-1-davids@...515...>
 <20170907061200.GB70062@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <73fb2899-edfb-1399-39de-e84d9c3e87fe@...2080...>
Date: Thu, 7 Sep 2017 16:06:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170907061200.GB70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DeRaInGpxIEWLEhTovNOWLoNpApLXQkIU"
Subject: Re: [Openvpn-devel] [PATCH] lz4: Changing how LZ4 library handling
 is done
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DeRaInGpxIEWLEhTovNOWLoNpApLXQkIU
Content-Type: multipart/mixed; boundary="Spa8bNDtw1dgBdTu5oQHGtHv9bR0cTTt9";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <73fb2899-edfb-1399-39de-e84d9c3e87fe@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] lz4: Changing how LZ4 library handling is
 done
References: <20170907012225.21661-1-davids@...515...>
 <20170907061200.GB70062@...1296...>
In-Reply-To: <20170907061200.GB70062@...1296...>

--Spa8bNDtw1dgBdTu5oQHGtHv9bR0cTTt9
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 08:12, Gert Doering wrote:
> Hi,
>=20
> On Thu, Sep 07, 2017 at 03:22:25AM +0200, David Sommerseth wrote:
>> This change will expect the system to have LZ4 libraries and headers
>> installed by default.  We still carry a bundled LZ4 library, which
>> must now be explicitly enabled through providing --enable-bundled-lz4
>> to ./configure.  Otherwise, as before, --disable-lz4 will completely
>> remove any LZ4 support.
>=20
> I'm totally missing the *reason* why you want to change this

Bundled libraries are considered to be bad, as it requires active
maintenance.  Just look at which version we ship in OpenVPN (1.6.0) and
we've had two rebase patches on the -devel ML which have been ignored,
first updating to v1.7.4.2 [0] and then v1.7.5 [1].  I have not bothered
yet to send a new rebase request to the latest v1.8.0 [2].  That is an
awfully bad track record.

[0] Dec 15, 2016
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13575.=
html>
[1] Feb 21, 2017
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14137.=
html>
[2] Aug 17, 2017 <https://github.com/lz4/lz4/releases/tag/v1.8.0>

If we even manage to miss that there are CVE fixes in the LZ4 library,
then we've in even bigger trouble.  Especially if we're so bad at
updating just the maintenance releases.

Yes, I can already hear you say that updates caused by CVEs will be
handled more promptly.  But from my point of view, that's just words.
We do not have any processes for handling bundled libraries nor response
times nor who and how updates in bundled libraries are tracked.


> We don't have --enable-bundled-compat flags for the rest of the things
> in compat/ either, don't we?

Somehow I expected that argument from you, Gert.  But that is truly
comparing apples and oranges.

LZ4 is a large library compared to the compat functions we do provide:

  1605  compat-basename.c
  2208  compat-inet_ntop.c
  2261  compat-inet_pton.c
  2353  compat-daemon.c
  3210  compat-gettimeofday.c
  4057  compat-dirname.c
 49760  compat-lz4.c

The code complexity of compat-dirname.c (which is the second largest
compat code) is negligible compared to compat-lz4.c  So the risk of a
security issue should be considerably lower in these other functions we add.

Secondly, we only use our compat-*.c functions if the underlying system
does not carry those features - most commonly, these are libc related
functions.  So if a systems libc does not carry a function we need, we
need to have a wrapper for a specific function.  And strictly speaking,
LZ4 is not a requirement for OpenVPN to function as an application.

> Also, I can't see consensus that "remove the bundled lz4" is the way to=20
> go - this was on the plate for the hackathon to discuss.  You and Antonio
> are convinced that this is a good way forward, applying a very specific=20
> Linux-distro-based mindset to it ("missing libraries are a problem of the
> package builder, why should we care?") - please listen to my arguments: t=
here
> are people out there that build OpenVPN from source (tarball or git), and
> they are looking at library dependencies with a slightly different view.

Hence the --enable-bundled-lz4.  If you do not have or want to build LZ4
yourself first, then you can use our bundled LZ4 - with the risks that
implies.  But this is done explicitly, so a developer or package
maintainer is forced to take a decision here first.

But equally important, if anyone is going to build OpenVPN from source,
what is the chances that they will not be able to build LZ4 from source
before building OpenVPN?

And we already have several other external libraries we depend on which
we do not carry a compat-* version for ... LZO being the most obvious
one, as it is a 1:1 comparison to LZ4.  Then there is openssl/mbedtls.
But we do have feature specific dependencies  pkcs11-helper, p11kit,
which is available on all our supported platforms.  Then there is libpam
(for *nix).  And Linux can add libselinux and libsystemd into the mix as
well.

This patch actually aligns LZ4 to be treated more equally to LZO, with
the distinction that we do have --enable-bundled-lz4 - at least for some
time forward.


And some more arguments why bundled libraries are bad, here even from a
FreeBSD perspective:
<https://www.freebsd.org/doc/en/books/porters-handbook/bundled-libs.html>

A couple of other with more generic perspectives:
<http://www.professionalsecurity.co.uk/products/computer-systems-and-it-sec=
urity-news/library-bundles-a-game-of-chance/>
<https://blog.flameeyes.eu/2009/03/bundling-libraries-the-curse-of-the-anci=
ents/>

And the perspective from a few Linux distros:
<https://wiki.gentoo.org/wiki/Why_not_bundle_dependencies>
<https://fedoraproject.org/wiki/Bundled_Libraries?rd=3DPackaging:Bundled_Li=
braries>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--Spa8bNDtw1dgBdTu5oQHGtHv9bR0cTTt9--

--DeRaInGpxIEWLEhTovNOWLoNpApLXQkIU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsVJrAAoJEIbPlEyWcf3yJ9YP/2ET9loBxI8sRD7/7kf03xD3
DpUugmsNh1LcyXamIz35+3Z3sOC5TRnxqIklAJArtOkdnHPDOTCCiVtqq0EYpILP
xzKfnLsCdJf4hXiFGQOnB3q8H6Dx1OnnGMhkibeWCX21A3GfKV1D7IJqEqye857F
QnSiG1x0QVox1spc71DPa9Posp6o7bzlHg0toIEMw3SzIp03VqpdOhUCJMGXJWXZ
IVE/IIqUH3XNuEGIKK+9lSkV0ZVkf0m5NZRaFF9FXAt6B0zWPzAwINRwOtW4rQu6
xgawwNCBBiBx/ceSgDQBZcVXSXrIE3iF3VP0GS5ekLTYr/efNM7xdVR99so07NKw
mbTcdxAaTYNCKviJoE6uTw/reFYvEmv3hu3lNhWT49IBsj9Dc6fgF91of6+rpEdQ
jEToFzSrE6bAGomLNQ4TQs8rkdHrTqamze8UmQj81eK/RxiAIa+eg8fCi8ZAXCNj
ZS4K8Ow6CEKJQ93c06XGJuC5BfHB7e/xxOrYfxh4SVIouM4b1EiQB1DLtaFBHwTQ
leezZCtvi9k1tvAa7g98nRnbUhQnOK9PdfIHCPZ11cCd5ypwzckmjn1OaOK0JNu2
t/W4uGogyYXuH95cMMjFFfqejjtV6toiqYfGo2Ehtnuzi2z4zq81Fx/9TnYKemKF
TjzaXlmgIwjzH2H3QOJC
=3P2L
-----END PGP SIGNATURE-----

--DeRaInGpxIEWLEhTovNOWLoNpApLXQkIU--

