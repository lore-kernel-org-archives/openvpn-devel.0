References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
 <108f5ba4-240b-5496-f37b-51ff2a6fb2fe@...2080...>
 <CAKuzo_he9FoT-iC-FZAW7qQH2vepY+XmOfsiL6uSH=7hW8ZvVQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5bb0e3e1-e5ea-6385-a7e5-0a5dd23626d8@...1227...>
Date: Sun, 17 Nov 2019 20:08:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_he9FoT-iC-FZAW7qQH2vepY+XmOfsiL6uSH=7hW8ZvVQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g0r0FTbW4kq2X4GimhBuhid3xZRNli2Gv"
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g0r0FTbW4kq2X4GimhBuhid3xZRNli2Gv
Content-Type: multipart/mixed; boundary="4Yug9fg8EmVQ9jNc8kGPWAzO0pKEFT5ZG"

--4Yug9fg8EmVQ9jNc8kGPWAzO0pKEFT5ZG
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.11.19 um 22:58 schrieb Selva Nair:
> Hi David
>=20
> Thanks for the comments
>=20
>     My idea was just to add -Werror right in the line above, and not
>     extend the
>     ACL_CHECK_ADD_COMPILE_FLAGS macro with another argument.
>=20
>=20
> I'm fine with that approach as well. Let me know if you want a v2.
>=20
>=20
>     I think you said it pretty well in your mail:
>=20
>     > Darn compilers and darn -Werror
>=20
>=20
>     So your change does improve Clang ... I dunno what we will do with GC=
C.
>=20
>=20
> It doesn't affect gcc as gcc does error (or ignore -- see below)
> unsupported options with or without -Werror. So I think we are okay.
> travis build on my fork confirms that:
> https://travis-ci.org/selvanair/openvpn/builds/612019849
>=20
> However, gcc does have quirky behaviour when it comes to options like
> -Wno-xx-yy. It just accepts them silently[*] with or without -Werror.
> That works fine for us, but it does generate an error about that
> unsupported option if any other error is encountered during the build.=C2=
=A0
> As other errors are anyway a show-stopper, I think we can live with that.
>=20
> Selva
>=20
> [*] I think their reasoning is that -Wno-xx-yy can be thus used to
> suppress warnings added to newer versions without breaking builds with
> older ones. But clang doesn't share that view.

I agree with Selva here. If we cannot get rid of the warnings themselves
this seems to be the only sane way. So I am not totally with this stuff
but it is better than the altneratives at the moment. And I really
annoyed by all these new warnings of Clang

Acked-By: Arne Schwabe <arne@...1227...>

Arne


--4Yug9fg8EmVQ9jNc8kGPWAzO0pKEFT5ZG--

--g0r0FTbW4kq2X4GimhBuhid3xZRNli2Gv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3RmpoACgkQFRhsZwKx
RFQr1A//YMOe82GIqI3ORu5CoIgs2FOnvpkYpuJjOpuCvklSvHnsk+5fPgKJ+cdS
JXqXjpnEUbrzAvtJZ1ZVNyaNK9+Dz6OswB7pP71gOx9e1IeQBP7fdknQ6y7vi71y
NqKf664tU9LwOvAAbIQDMUUrZ7GOYCYdB8stV4XpfkWFXQvVyW4JdU241/rCgdjZ
Rmc7AsilrVjC/Gz8sXzqxiR6rw6T9mHxQC8XvZBAZZZsPJayDoakIksVkplP2AIp
581TGHk0DXbDaRVQjTX7VC3PWMmyGJfhH+l4KJClm9dJIG3cHFNkX5hMetWioGkv
C5pzZRvTGQo2HesDM1eIiJrxDImpnD9clxw3cNm0So+/FvrzYsa8zMpFP6fe9jVC
ZiURO52+n+zyRMFTNhFbubqpbd7Q34ww7Z2SgeRFuErLz8cDlATvKno7UsY4fOff
iFofy9MziFkV8SDZiI2MaIUCEAq/wffzoqkBu0OQRDbXgKQGea1EX/Mjwn2bshJ0
tqAV+1wDK+difY4uATNaHepwxxCNHQgQ22ZlnoKUHqz7JJ0+Q4CZIINnGWnBRETR
92Bu6GvwHPhvnu9RMBDL021qqMaVdTHxj9uOkFXpAs8AgFmBUkAyx7witkcOM/wc
xLoSFrJd92QtH+NH7zMlVCVQdPd/vPYfyJxAZbT06w2VqoKSBMM=
=SCeB
-----END PGP SIGNATURE-----

--g0r0FTbW4kq2X4GimhBuhid3xZRNli2Gv--

