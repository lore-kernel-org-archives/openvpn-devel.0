From: lstipakov@...277...
Mime-Version: 1.0 (1.0)
Date: Fri, 19 Nov 2021 22:04:50 +0200
Message-Id: <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
References: <YZf4ch72IZYhz5Tb@...1296...>
In-Reply-To: <YZf4ch72IZYhz5Tb@...1296...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
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
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Ok, my idea was to fix only config loading dir. Apparently this is not enou=
gh, so I=E2=80=99ll look into ENGINESDIR too.=20

L=C3=A4hetetty iPhonesta

> Gert Doering <gert@...1296...> kirjoitti 19.11.2021 kello 21.18:
>=20
> =EF=BB=BFHi,
>=20
>> On Fri, Nov 19, 2021 at 06:15:50PM +0200, Lev Stipakov wrote:
>> OPENSSLDIR: "C:\Program Files\OpenVPN\ssl"
>> ENGINESDIR: "C:\Users\lev\Projects\vcpkg\packages\openssl_x64-windows-ov=
pn\lib\engines-1_1"
>> Seeding source: os-specific
>>=20
>> ENGINESDIR looks good, no? Is it something we use?
>=20
> no, not good.
>=20
> Should I ever want to use an engine, I'd need to create a "c:\users\lev\.=
.."
> on my client machine...
>=20
> gert
>=20
> --=20
> "If was one thing all people took for granted, was conviction that if you=
=20
> feed honest figures into a computer, honest figures come out. Never doubt=
ed=20
> it myself till I met a computer with a sense of humor."
>                             Robert A. Heinlein, The Moon is a Harsh Mistr=
ess
>=20
> Gert Doering - Munich, Germany                             gert@...1296...

