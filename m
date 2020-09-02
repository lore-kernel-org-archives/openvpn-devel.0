MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Wed, 2 Sep 2020 19:30:09 -0400
Message-ID: <CAKuzo_gnC6zdR7c-M44M2RQ=xnCcRPMOGaU+AmCJvprOJCnZsw@...278...>
Content-Type: multipart/alternative; boundary="0000000000002fdda105ae5d0567"
Subject: [Openvpn-devel] On tap-windows6 adapter installation by tapctl.exe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002fdda105ae5d0567
Content-Type: text/plain; charset="UTF-8"

Hi,

tldr: a fix for Trac 1321

Currently tapctl.exe does the following to create an adapter and install
the driver on it.

1. Create a device info structure
2. Set the hardware id on it
3. Search the driver store for the latest matching driver
4. Select the driver, set it in the device info and then call
SetupDiCallClassInstaller() with
  (a) DIF_REGISTERDEVICE
  (b) DIF_REGISTER_COINSTALLERS
  (c) DIF_INSTALL_INTERFACES
  (d) DIF_INSTALLDEVICE

As per setupapi.dev.log, it appears that step 4 (d) is failing with some
access error to the driver store unless elevated to SYSTEM (see Trac 1321).
This leaves the adapter not fully configured. Hard to say exactly what
fails as none of the function calls return any error.

I propose to replace 4(d) with a call to DiInstallDevice() instead. My
tests show this completes without error.

This also has an advantage that we could call it with driver_info = NULL
which will force the system to use the latest matching driver. That would
also eliminate step 3 which is right now very inefficient, though not
required to fix the problem at hand.

If this sounds sane, I'll submit a patch.

Selva

--0000000000002fdda105ae5d0567
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>tldr: a fix for Trac 1321</div><div=
><br></div><div><div>Currently=C2=A0tapctl.exe does the following=C2=A0to c=
reate an adapter and install the driver on it.</div></div><div><br></div><d=
iv>1. Create a device info structure</div><div>2. Set the hardware id on it=
</div><div>3. Search the driver store for the latest matching driver</div><=
div>4. Select the driver, set it in the device info and then call SetupDiCa=
llClassInstaller() with</div><div>=C2=A0 (a) DIF_REGISTERDEVICE</div><div>=
=C2=A0 (b) DIF_REGISTER_COINSTALLERS=C2=A0<br>=C2=A0 (c) DIF_INSTALL_INTERF=
ACES</div><div>=C2=A0 (d) DIF_INSTALLDEVICE=C2=A0</div><div><br></div><div>=
As per setupapi.dev.log, it appears that step 4 (d) is failing with some ac=
cess error to the driver store unless elevated to SYSTEM (see Trac 1321). T=
his leaves the adapter not fully configured. Hard to say exactly what fails=
 as none of the function calls return any error.</div><div><br></div><div>I=
 propose to replace 4(d) with a call to DiInstallDevice() instead. My tests=
 show this completes without error.</div><div><br></div><div>This also has =
an advantage that we could call it with driver_info =3D NULL which will for=
ce the system to use the latest matching driver. That would also eliminate =
step 3 which is right now very inefficient, though not required to fix the =
problem at hand.<br></div><div><br></div><div>If this sounds sane, I&#39;ll=
 submit a patch.</div><div><br></div><div>Selva</div></div>

--0000000000002fdda105ae5d0567--

