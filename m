References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <1500293278.28621.32.camel@...1866...>
 <CAFHpkQGMFD0JX5NHsxy_QCrzFMJ-Tcj5HS9xnkzvsQ6Vk3aQGw@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <acee346a-aa66-2b3f-6f59-b15a03b19839@...515...>
Date: Wed, 18 Oct 2017 14:52:22 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGMFD0JX5NHsxy_QCrzFMJ-Tcj5HS9xnkzvsQ6Vk3aQGw@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, David Woodhouse <dwmw2@...1866...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 18/10/2017 10:43, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-07-17 17:07 GMT+05:00 David Woodhouse <dwmw2@...1866...
> <mailto:dwmw2@...1866...>>:
>=20
>     On Fri, 2017-07-14 at 17:07 +0300, Samuli Sepp=C3=A4nen wrote:
>     > Hi all,
>     >
>     > Those of you who use pkcs11 on Windows: could you please test this =
new
>     > Windows installer:
>     >
>     >
>     >
>     > The previous installer(s) had pkcs11-helper 1.11. This one has 1.22=
, so
>     > some regression testing would be good to have.
>=20
>     Please include the pkcs11-helper patch from
>     https://github.com/OpenSC/pkcs11-helper/pull/4
>     <https://github.com/OpenSC/pkcs11-helper/pull/4>=C2=A0to make it supp=
ort
>     using
>     RFC7512 PKCS#11 URIs to specify certificates/keys instead of its own
>     non-standard identifiers.
>=20
>=20
>=20
> David, can you have a look, please ?
>=20
> https://github.com/OpenVPN/openvpn-build/pull/110
I added this as a topic for today's meeting, with links to earlier
discussion. It seems we agreed that patching the 2.4 Windows installers
would be fine.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

