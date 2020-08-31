MIME-Version: 1.0
References: <f10b3cfd-d020-5598-ec84-95fc8cd0e8e9@...515...>
 <CAKuzo_gsxSLbVaS7gi-reDWds9LS2KiL_z1Z1ABBdb9BDS3r=Q@...278...>
In-Reply-To: <CAKuzo_gsxSLbVaS7gi-reDWds9LS2KiL_z1Z1ABBdb9BDS3r=Q@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 31 Aug 2020 16:30:05 +0300
Message-ID: <CAGyAFMU2CKQFPCvSL3gB2MuU97V3FPm9+GxZ3HJsq=z8p5mFKw@...278...>
Subject: Re: [Openvpn-devel] Help testing OpenVPN 2.5-beta2 driver
 installation?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> This may be because the file version of openvpn.exe is not changed (2.5.0=
.0) -- we may have to add a build number ( the 4th last digit) and incremen=
t it each time. That would make the final 2.5.0 release something like 2.5.=
0.xx for the file versions though the product version can be 2.5.0, hopeful=
ly.

Yep, that's what we will do (update version.m4).

> (2) At the end of install the GUI is launched as admin, not user.

I couldn't reproduce that on my Windows 10 laptop:

 - installed 2.5 beta2 as unprivileged user "guest1"
 - checked in task manager that openvpn-gui is launched under "guest1" user
 - rebooted and checked again that openvpn-gui is launched under the
same "guest1" user.

> Although not prompted for reboot, I did reboot and checked again that the=
 binaries are still the old one's. F

Should be fixed in beta3.

--=20
-Lev

