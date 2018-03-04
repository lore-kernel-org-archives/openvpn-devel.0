From: Jeremie Courreges-Anglas <jca@...2272...>
References: <20180228231123.27782-1-steffan@...1856...>
 <20180304090817.GL69387@...1296...>
 <1999112e-8de3-5ac2-e9a2-0f499e69b123@...1856...>
Date: Sun, 04 Mar 2018 17:22:00 +0100
Message-ID: <87muznkdzr.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Add a warning that we do not officially
 support LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 04 2018, Steffan Karger <steffan@...1856...> wrote:
> Hi,
>
> On 04-03-18 10:08, Gert Doering wrote:
>> On Thu, Mar 01, 2018 at 12:11:23AM +0100, Steffan Karger wrote:
>>> As discussed in the community meeting of 13-12-2017, we should warn our
>>> users that LibreSSL is not officially supported.  We expect that it
>>> currently works, but it might suddenly break or we might decide to no
>>> longer build against LibreSSL in the future.
>>=20
>> Generally speaking, I agree.
>>=20
>> Should we also add a warning (+ sleep 60 to be extra-annoying?) to
>> configure if LibreSSL is detected?
>
> I considered that (modulo the sleep 60) and wrote the code to do the
> configure check, but then thought that a not-suppressible warning in the
> logs would be sufficient.  I still think it is, but don't mind re-adding
> it to configure.ac if you prefer that.

As an OpenBSD developer and the maintainer of our OpenVPN port,
I certainly care about building and using OpenVPN with LibreSSL.
I have already provided patches in the past, and yesterday I pushed
compat glue in LibreSSL so that openvpn-2.4.5 can build on OpenBSD
(-current).

So I'm wondering what would be needed to consider LibreSSL "supported".

I hear that there are concerns over LibreSSL not being API-compatible
with OpenSSL.  As you may have noticed, LibreSSL recently introduced
lots of OpenSSL-1.1+ interfaces.  While there is no plan to support the
full OpenSSL-1.1 API (tons of functions were added, not all of them seem
useful...), the intent is to provide what the ecosystem actually needs.
I can probably serve as a bridge between the two projects here.

If you see other points where I - or anyone else - can help, please
share. :)

--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlqcHSgACgkQDfp0rhUk
5+4f3xAAkkr5N6BkpTFCJfTwxIEtRdyiSAc04QHbov342WGDu8fcuf/hTOQH/SH4
KCu0oFYaQ7bkejDSFi/gyp/rDPMNpZMvdnbvYU1K4qHuuNqE35Rby4UOsKHEbPA9
MBjNquLejRPptS8tHDUy91r9aByHr5dLrE6OAowdC90SBOzc1le3i4oaXfqRxTv/
ZXIU5z/wvM++uqR3sn8P9hrxBxAgoxRT2eLOOZ4JiK9Nz12VmjlhRUH2fHFXISmY
QyRIiEv07EZ4636tu0EKH0BCRUfWwCiuI7zA1VpuobLvPyY/N2BUkz5JfYSi81x2
NqxbO03qCFXsVUKaS6CT896imPZS+t/aHOV2kkpo+oq3SshEkkMhrmC0vwLxrf46
QnFTs0HHln1FBnu1+96n9924Sb4g2Ryab2kO3jKubPLEdfXrgCaXKoDr38yO8y52
kqaSAVrUK92MGXW0k23dHALRgWN6bzPvEL/T4aJqJ6fC2mjVXx8bUGwPUgUaPyvX
ES4ZBsPFMnqRSfj7xTgtEK8yZLh4zGHkfxZ2dlybiorLRHpYeJabP3jcAXeUeSfL
zyCVW2cgoDWRUI/CbWPxTVu+6IAEsolqfjdt09GQlj7DD0NMlTKvQtVjGYjsTLoQ
xkCna6gGofdUAhuECr6NNZQ207H91x+/ZUobTBldX8hSfumhFD0=
=40TB
-----END PGP SIGNATURE-----
--=-=-=--

