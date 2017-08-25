References: <9D542DA272786745B160AD8534D3D3F66CA88A57@...2140...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4ec94910-f8d0-e4ec-f88c-77f18ce3baca@...1227...>
Date: Fri, 25 Aug 2017 14:44:43 +0200
MIME-Version: 1.0
In-Reply-To: <9D542DA272786745B160AD8534D3D3F66CA88A57@...2140...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] State of OpenVPN3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Kuhr Stefan <S.Kuhr@...2139...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 25.08.17 um 14:01 schrieb Kuhr Stefan:
> Hello everyone,
>=20
> =A0
>=20
> we are currently using the Windows openvpn client version 2.3.11 with
> our product. Our product uses the TAP adapter functionality and relies
> on the interoperation between openvpn.exe and the windows certificate
> store, as we use Smartcards for client authentication.
>=20
> =A0
>=20
> I just discovered the OpenVPN3 project on GitHub and it looks like an
> ideal solution to me that allows better integration of openvpn in the
> collateral software stack that we ship as part of our product than the
> out-of-process approach we currently use with openvpn.exe.
>=20
> =A0
>=20
> So what is the state of openvpn3, does it work with TAP adapters or is
> it TUN-only?

Not sure, people are moving from TAP away but the code should support TAP.

> Does it have integration with the windows certificate
> store? Is it on-par with the 2.x development branch and under active
> development?=20

That is offloaded to the UI, like in openvpn 2.x with
management-external-key which is the cleaner approach.

> It wouldn=92t make sense for us to use OpenVPN3 if it lags
> behind the 2.x versions with respect to security fixes for instance.
> There still doesn=92t seem to be a stable/release branch for the OpenVPN3
> project on GitHub, so is OpenVPN3 ready for prime-time with respect to
> client functionality or is this some sort of alpha or beta status softwar=
e?

Completely different code base. And  a library instead of being a
standalone client.It is used in OpenVPN Incs own clients but not much
apart from that.

Arne

