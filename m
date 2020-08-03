References: <56d6f733-9f00-f76f-f7c7-9ac280020f50@...1879...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <fc329812-98ec-d838-bee2-9271db84e7e4@...515...>
Date: Mon, 3 Aug 2020 13:26:12 +0300
MIME-Version: 1.0
In-Reply-To: <56d6f733-9f00-f76f-f7c7-9ac280020f50@...1879...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] MSI Installer: Add .ovpn file
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
To: =?UTF-8?Q?Robert_Gr=c3=a4tz?= <graetzrx@...1879...>, openvpn-devel@lists.sourceforge.net

Hi,

I have not developed the MSI installer and know only the basics about
MSI. Simon Rozman (rozmansi) is the right person to ask about this.

That said, I think using a "Merge Module" might be the way forward. The
tap-windows6 "installer" is implemented as such (MSM).

Samuli

Il 30/07/20 11:21, Robert Gr=E4tz ha scritto:
> Hello,
>=20
> I am very happy that 2.5 will be hopefully soon released.
>=20
> I want to integrate my config file inside the msi installer. I think
> that romansi mentioned that there will be a proper solution for this
> issue. Are there any news or documentation yet? I tried something with
> Microsoft Orca [1], but it doesn't work yet.
>=20
> Best regards
>=20
> Robert
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


