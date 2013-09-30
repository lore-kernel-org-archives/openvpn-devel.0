From: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
References: <52491AFC.2000105@...1420...>
In-Reply-To: <52491AFC.2000105@...1420...>
Date: Mon, 30 Sep 2013 13:31:42 +0300
Message-Id: <1380537102.1734.3.camel@...1503...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN Windows uninstallation does	not
	remove TAP driver
Reply-To: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
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
Content-ID: <1380537101.1734.2.camel@...1503...>
To: Christian Rank <christian.rank@...1420...>, openvpn-devel@lists.sourceforge.net

Hi Christian,

Thanks for the patch! I'll test it and apply it to openvpn-build if it all =
checks out.

Samuli

----- Messaggio originale -----
> Author: Christian Rank <christian.rank@...1420...>
>=20
> 32-bit Windows version of OpenVPN installed on a 64-bit Windows does not
> remove TAP driver on uninstallation.
>=20
> If you install OpenVPN on a 64-bit Windows using the 32-bit installer
> from
> > http://swupdate.openvpn.org/community/releases/openvpn-install-2.3.2-I0=
03-i686.exe
> the TAP driver gets installed by default (if not deselected during
> installation).
>=20
> However, uninstalling the OpenVPN software leaves the TAP driver
> installed.
>=20
> Here is patch for the NSIS configuration file which corrects this
> installer issue.
>=20
> Signed-off-by: Christian Rank <christian.rank@...1420...>
>=20
> --=20
> Dr. Christian Rank
> Rechenzentrum Universit=C3=A4t Passau
> Bereich Netzwerk und Telekommunikation
> IT-Sicherheitsbeauftragter der Universit=C3=A4t
> Innstr. 33
> D-94032 Passau
> GERMANY
> Tel.: 0851/509-1838
> Fax:=C2=A0  0851/509-1802
>=20
<Allegato>=C2=A0  openvpn.nsi.patch
<Allegato>=C2=A0  smime.p7s
<Allegato>=C2=A0  ATT00001.txt
<Allegato>=C2=A0  ATT00002.txt


