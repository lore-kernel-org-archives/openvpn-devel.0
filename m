From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 25 Nov 2015 17:41:42 +0100
Message-ID: <1584543.znVl45ZabU@...1526...>
In-Reply-To: <SN1PR08MB1391C6F144144362BB6BA1B9B9050@...2065...>
References: <564AFAF5.4030004@...515...>
	<CAKuzo_ga8AhYyRHDTktndfXFeP9Yzfw-SBGx4J6ZkBcEGg9tcw@...278...>
	<SN1PR08MB1391C6F144144362BB6BA1B9B9050@...2065...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN-GUI now on GitHub + other Windows team
	things
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

You seem to have gotten the path to the cross compiled openssl wrong.

On Wednesday 25 November 2015 16:07:12 Morris, Russell wrote:
> FYI, no joy =E2=80=A6 =E2=98=B9. Configure below gives the following erro=
r,
> configure: error: Cannot find OpenSSL library
>
> So still looking for OpenSSL.
>
> Thanks!
>
> =E2=80=A6 Russell
>
>
> From: Selva Nair [mailto:selva.nair@...277...]
> Sent: Sunday, November 22, 2015 1:22 PM
> To: Morris, Russell <rmorris@...1315...>
> Cc: Samuli Sepp=C3=A4nen <samuli@...515...>;
> openvpn-devel@lists.sourceforge.net
 Subject: Re: [Openvpn-devel]
> OpenVPN-GUI now on GitHub + other Windows team things
>
> On Sun, Nov 22, 2015 at 12:33 PM, Morris, Russell
> <rmorris@...1315...<mailto:rmorris@...1315...>> wrote:
 Hi,
>
> Went to get started on this, and I admit =E2=80=93 a lot of different and=
 confusing
> information about the libraries and include files (and a lot of it
> contradicts it seems). Do you have a good source for the =E2=80=9Cright=
=E2=80=9D files to
> grab?

> Thanks!
>
> To start with try without openssl.
> (each command below is on one line -- gmail may break the lines)
> $ git clone https://github.com/OpenVPN/openvpn-gui.git
> $ cd openvpn-gui
> $ autoreconf -i -v
> $ ./configure --prefix=3D/ --host=3Dx86_64-w64-mingw32
> --build=3Dx86_64-pc-linux-gnu --program-prefix=3D''
> CFLAGS=3D-DDISABLE_CHANGE_PASSWORD OPENSSL_CRYPTO_LIBS=3D"-L./"
 $ make
>
> That will build will get openvpn-gui.exe. Copy it to windows as run as
> administrator.

> All this assumes you have a setup with git, mingw-w64, automake, libtool
> installed.

> Selva

Heiko Hund

Development Manager, R&D
tel +49-721-25516-237
SOPHOS Security made simple
--
Sophos Technology GmbH, Commercial Register: Mannheim HRB 712658
Headquarter Location: Amalienbadstr. 41/Bau 52 | 76227 Karlsruhe | Germany
Executive Board: Nicholas Bray, Pino von Kienlin, Joachim Frost


Sophos Technology GmbH, Amalienbadstra=E1=BA=9Ee 41/Bau 52, D-76227 Karlsru=
he, Deutschland
Tel +49 (0)721 25516 0 Fax +49 (0)721 25516 200 E-Mail info@...2075... www.=
sophos.de
Sitz der Gesellschaft: Karlsruhe, Amtsgericht Mannheim HRB 712658
Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Pino von Kienlin, Wolfgang Hilper=
t, Jennifer Onslow.
Sophos GmbH, Gustav-Stresemann-Ring 1, 65189 Wiesbaden, Deutschland
Tel +49 (0) 611 5858-0 Fax +49 (0) 611 5858-1042 E-Mail info@...2075... www=
.sophos.de
Sitz der Gesellschaft: Wiesbaden, Amtsgericht Wiesbaden HRB 25915 Gesch=C3=
=A4ftsf=C3=BChrer: Nicholas Bray, Wolfgang Hilpert, Pino von Kienlin, Jenni=
fer Onslow

