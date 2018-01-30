References: <CAKuzo_jVbyE3kQkgT1aYgMSK-YGm2Ho=Evbsrck5Y4mNwAsKmQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6beb138f-831e-edd7-d4dd-28beeadc5310@...515...>
Date: Tue, 30 Jan 2018 11:33:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jVbyE3kQkgT1aYgMSK-YGm2Ho=Evbsrck5Y4mNwAsKmQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [Openvpn-users] test latest binary on vista
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Hi,

Il 29/01/2018 20:09, Selva Nair ha scritto:
> (Cross posting to users and devel)
>=20
> Hi,
>=20
> 2.4.x needs to support, Vista, isn't it?

Good question and we have discussed in the past. Windows Vista is no
longer supported by Microsoft:

<https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-shee=
t>

But then again, we do provide installers which work on Windows XP, which
is similarly EOL. So I guess we do support Windows Vista for the time being.

>=20
> Can anyone please latest 2.4 release branch on Windows Vista using an
> RSA certificate in Windows cert store (using --cryptoapicert option) ?
>=20
> Need to be built with openssl 1.1. Not sure the snapshots are built that =
way..
> https://build.openvpn.net/downloads/snapshots/

Not yet. I will switch snapshot builds to OpenSSL 1.1 once
openvpn-build's openvpn.nsi stops failing on OpenSSL 1.1 libraries
(names have changed). A PR is pending but it still needs one minor fix.

> The recent changes to cryptoapi uses CNG api which is supposedly
> supported on Vista but some testing would be useful. I no longer have
> access to a Vista machine.
>=20
> Thanks,
>=20
> Selva
>=20



--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

