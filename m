References: <CACtGRr8ZoT9xi_MFsqOrRnGEAZqM9yVwZCCy1H1zWDpc0PGo3Q@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <8d258197-8137-aa00-043f-132d5e06faa6@...515...>
Date: Fri, 27 Oct 2017 10:31:57 +0300
MIME-Version: 1.0
In-Reply-To: <CACtGRr8ZoT9xi_MFsqOrRnGEAZqM9yVwZCCy1H1zWDpc0PGo3Q@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Windows build 2.4.4 fails signature verification
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
To: Lefty <leftygamer@...277...>, openvpn-devel@lists.sourceforge.net

On 27/10/2017 08:20, Lefty wrote:
> Hi all,
>=20
> I recently downloaded the openvpn-install-2.4.4-I601.exe Windows
> installer, along with the openvpn-install-2.4.4-I601.exe.asc signature fi=
le.
>=20
> I imported Samuli's new key ( fingerprint 6D04 F8F1 B017 3111 F499 795E
> 2958 4D9F 4086 4578).
> When I run PGP I get the following output:
>=20
> gpg: armor header: Version: GnuPG v1
> gpg: assuming signed data in 'openvpn-install-2.4.4-I601.exe'
> gpg: Signature made 09/26/17 06:19:55 Pacific Daylight Time
> gpg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 using RSA key D72AF3448CC2B034
> gpg: Can't check signature: No public key
>=20
> It appears the installer has been signed with the "Security Mailing List
> GPG Key" instead of the key described on the sig page.
>=20
> Am I doing the verification wrong?
> Any suggestions much appreciated!
>=20
> -Lefty
>=20

Hi,

There's a link to the Security Mailing List key on the GnuPG public key
page:

<https://openvpn.net/index.php/open-source/documentation/sig.html>

As mentioned on that page the Security Mailing List key has been used to
sign releases from 2.3.16 and 2.4.3 onwards.

I hope we don't have to shuffle the keys anymore in the near future.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

