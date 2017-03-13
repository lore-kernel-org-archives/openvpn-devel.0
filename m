References: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
	<a766bfda-08dd-0984-c310-e9fc502326b0@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <ff77c70f-4ae2-8b53-3c81-747b7abab662@...515...>
Date: Mon, 13 Mar 2017 17:30:22 +0200
MIME-Version: 1.0
In-Reply-To: <a766bfda-08dd-0984-c310-e9fc502326b0@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T8g8WagmrnJQlojT7Mk1KPcHN84h5uBkw"
Subject: Re: [Openvpn-devel] could be gitlab-ci an alternative to buildbot
 cloud?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T8g8WagmrnJQlojT7Mk1KPcHN84h5uBkw
Content-Type: multipart/mixed; boundary="------------133A6E5FA7F0F6F7809F3ACD"

This is a multi-part message in MIME format.
--------------133A6E5FA7F0F6F7809F3ACD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On 08/03/2017 21:58, Samuli Sepp=C3=A4nen wrote:
> Hi,
>=20
> On 05/03/2017 16:25, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> Hello,
>>
>> there was some buzz related to improvement of testing system, like
>> patchwork.
>> we tried gitlab-ci on our internal project, it looks very promising.
>>
>> since openvpn is already hosted on gitlab.com <http://gitlab.com>,
>> there's a possibility of
>>
>> 1) users can add their own gitlab-ci agents to the repo
>> 2) it might be even windows agents
>> 3) build results are publicly available (not easy to get from buildbot)
>=20
> Buildbot is behind VPN because of security reasons. We can easily grant
> more access to its WebUI if we need to. So far there has not been a
> pressing need to do that.
>=20
> Afaik it would be possible to run a Windows buildslaves. The problem is
> that OpenVPN Windows building tends to suck. Hence we have the custom
> hacked together cross-compile "buildslave" that makes use of openvpn-buil=
d.
>=20
>> it looks like a big step, and it is hard to predict its result. but, I
>> think we can try and have a look at it.
>> thoughts?
>=20
> Personally I'm not too keen to migrate away from Buildbot unless there
> are very significant benefits. Not having to configure any
> agents/buildslaves would be such a benefit imho.
>=20
> That said, I will have a look at gitlab-ci to see what it can do.
>=20

Hi,

I went through GitLab CI documentation and it seems we probably _could_
use it as an alternative to Buildbot. That said, the switch would not be
trivial, and would not add much value to the current Buildbot setup
imho. Plus I have a feeling getting t_client.sh to work would be a lot
of work.

The good thing about Buildbot is that the buildmaster configuration is
pure Python, so it is easily adaptable to our needs with minimal code
changes. Plus buildbot is not limited to a particular web service
(GitLab/GitHub), but still provides the hooks to integrate with almost
anything[*]. We're thus not limited by the tool itself.

Buildbot build failure messages are available in the openvpn-builds
mailing list archive:

<https://sourceforge.net/p/openvpn/mailman/openvpn-builds/>

For a "normal" developer the buildbot webui is not of much interest. One
exception is manually triggering builds against other Git repos or
branches (e.g. one with a proposed fix).

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*] <http://docs.buildbot.net/latest/manual/cfg-changesources.html>

--------------133A6E5FA7F0F6F7809F3ACD
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------133A6E5FA7F0F6F7809F3ACD--

--T8g8WagmrnJQlojT7Mk1KPcHN84h5uBkw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYxrsOAAoJEClYTZ9AhkV44SIH/1j5sCT9zJ7yndl13oIeGdlM
JX0cVTvaClK/0DsHOAo/WULP2WqdqP8LuAtygegTsjODcNoQlwkdpf0OxQULXVMd
F35Aa9giXRQXn6Oo6uhY6NEqDAx1RRhduAyR0yvDFwyHRXYEn74kXZfAZ7vqFELu
jUGv958OpTr1M3F5PctVUhptKRtwzPgn5P053xm4lSCl2bSFlHxYhQD0slZmYwkl
BQD+Pu1TXaZpLTiBvBqOWuPxCXNmxu1ydhdrrVw+9vdG5LW2S1t/98aLCVNkJlOe
lfmJ9FFSx4/sIFmaGf6CVvhh9c/AXmk/dwMOQIGIodZhMV4lB9wNJeIb5Pj6wHI=
=z6fs
-----END PGP SIGNATURE-----

--T8g8WagmrnJQlojT7Mk1KPcHN84h5uBkw--

