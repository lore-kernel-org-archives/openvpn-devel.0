MIME-Version: 1.0
References: <f10b3cfd-d020-5598-ec84-95fc8cd0e8e9@...515...>
In-Reply-To: <f10b3cfd-d020-5598-ec84-95fc8cd0e8e9@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 29 Aug 2020 11:36:53 -0400
Message-ID: <CAKuzo_gsxSLbVaS7gi-reDWds9LS2KiL_z1Z1ABBdb9BDS3r=Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000066df0f05ae05f1cc"
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000066df0f05ae05f1cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 28, 2020 at 9:10 AM Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:

> Hi,
>
> It would be great if somebody would find time to test the following
> installer:
>
>
> https://build.openvpn.net/downloads/releases/OpenVPN-2.5-beta2-I601-amd64=
.msi
>
> In particular I'd like to know if anyone else has problems installing
> Wintun or Tap-windows6. My exact issue is described here:
>
> https://github.com/OpenVPN/openvpn-build/issues/187
>
> At the moment two people have successfully ran that installer and one
> (me) have failed.
>

For me the installer (with beta1 installed) without errors and tap driver
does get updated, but some issues are noticed (Windows 10 home 64 bit):

(1) Only openvpn-gui.exe gets updated. openvpn.exe and openvpnserv.exe stay
at the old beta1 (binaries dated Aug 14th, version 2.5_beta1 etc..).

This may be because the file version of openvpn.exe is not changed
(2.5.0.0) -- we may have to add a build number ( the 4th last digit) and
increment it each time. That would make the final 2.5.0 release something
like 2.5.0.xx for the file versions though the product version can be
2.5.0, hopefully.

LZO dll gets updated, but other dlls (crypto and pkcs11) are not  (based on
date). The latter may be okay if their versions have not changed.

(2) At the end of install the GUI is launched as admin, not user.

Although not prompted for reboot, I did reboot and checked again that the
binaries are still the old one's. Fresh install of beta2 brings in all
binaries dated Aug 27.

Selva

--00000000000066df0f05ae05f1cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Aug 28, 2020 at 9:10 AM Samuli Sepp=C3=A4ne=
n &lt;<a href=3D"mailto:samuli@...515...">samuli@...515...</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
It would be great if somebody would find time to test the following<br>
installer:<br>
<br>
<a href=3D"https://build.openvpn.net/downloads/releases/OpenVPN-2.5-beta2-I=
601-amd64.msi" rel=3D"noreferrer" target=3D"_blank">https://build.openvpn.n=
et/downloads/releases/OpenVPN-2.5-beta2-I601-amd64.msi</a><br>
<br>
In particular I&#39;d like to know if anyone else has problems installing<b=
r>
Wintun or Tap-windows6. My exact issue is described here:<br>
<br>
<a href=3D"https://github.com/OpenVPN/openvpn-build/issues/187" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn-build/issues/1=
87</a><br>
<br>
At the moment two people have successfully ran that installer and one<br>
(me) have failed.<br></blockquote><div><br></div><div>For me the installer =
(with beta1 installed) without errors and tap driver does get updated, but =
some issues are noticed (Windows 10 home 64 bit):</div><div><br></div><div>=
(1) Only openvpn-gui.exe gets updated. openvpn.exe and openvpnserv.exe stay=
 at the old beta1 (binaries dated Aug 14th, version 2.5_beta1 etc..).=C2=A0=
</div><div><br></div><div>This may be because the file version of openvpn.e=
xe is not changed (2.5.0.0) -- we may have to add a build number ( the 4th =
last digit) and increment it each time. That would make the final 2.5.0 rel=
ease something like 2.5.0.xx for the file versions though the product versi=
on can be 2.5.0, hopefully.</div><div><br></div><div>LZO dll gets updated, =
but other dlls (crypto and pkcs11) are not=C2=A0 (based on date). The latte=
r may be okay if their versions have not changed.</div><div><br></div><div>=
(2) At the end of install the GUI is launched as admin, not user.</div><div=
><br></div><div>Although not prompted for reboot, I did reboot and checked =
again that the binaries are still the old one&#39;s. Fresh install of beta2=
 brings in all binaries dated Aug 27.</div><div><br></div><div>Selva</div><=
/div></div>

--00000000000066df0f05ae05f1cc--

