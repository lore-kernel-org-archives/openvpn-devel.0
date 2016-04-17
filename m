MIME-Version: 1.0
In-Reply-To: <5710B96E.6070603@...515...>
References: <5710B96E.6070603@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 17 Apr 2016 18:03:57 -0400
Message-ID: <CAKuzo_gObagUmAuwRzh8vRPiP0Z0YG5GtOamtyKQX3W4q6xNfA@...278...>
Content-Type: multipart/alternative; boundary=001a113de7dcdcdc4d0530b56c77
Subject: Re: [Openvpn-devel] New EV-signed tap-windows6 driver ready for
	testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113de7dcdcdc4d0530b56c77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 15, 2016 at 5:50 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> After a longish struggle I managed to produce a tap-windows6 driver that
> has SHA2 EV signature, and which installs correctly on one particular
> instance of Windows 7. An earlier driver signed with the same EV
> certificate loaded correctly on Windows 10.
>
> Now we'd need to verify that this particular driver installs and works
> correctly on other Windows versions, such as
>
> - Windows 10 (untested)
> - Windows 8.1 (untested)
> - Windows 7 (more testing is always good)
> - Windows Server 2012r2 (untested)
> - Windows Vista (untested, _might_ fail)
>

- Windows 10 (64 bit): success

Installs without error and works fine.

- Windows 7 (64 bit): success, but see below

Installs without error and works fine.
However, the driver details says that its _not_ digitally signed, but the
driver properties window shows "Digitally signed by OpenVPN Technologies
Inc."
Installing KB3123479 (update to support SHA2 signatures) makes no
difference.

- Windows server 2008r2 (64bit) : installs ok, but adapter fails

Installs without error, driver properties and driver details display same
as Windows 7 (i.e one says signed, other says not signed).
Cannot enable the tap adapter -- fails with the following error

"The TAP-Windows Adapter V9 service failed to start due to the following
error:
Windows cannot verify the digital signature for this file. A recent
hardware or software change might have installed a file that is signed
incorrectly or damaged, or that might be malicious software from an unknown
source."

On installing KB3123479, the error changes to
"The driver \Driver\tap0901 failed to load for the device ROOT\NET\0004."
and TAP adapters do no show up in the list of network adapters

- Windows vista (32 bit): installs after ignoring security warning, works
fine

Installation: Pops up a warning that says no valid signature, publisher not
verified etc. On choosing to install anyway, completes without error.
Tap adapter works fine

I thought driver signature is not enforced on 32 bit vista, but this is the
only platform (among those I tried) that complained loudly at installation
time.

Note: none of the above systems are up-to-date with windows updates.

Selva

--001a113de7dcdcdc4d0530b56c77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Fri, Apr 15, 2016 at 5:50 AM, Samuli=
 Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." ta=
rget=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div>After a longish struggle I managed to=
 produce a tap-windows6 driver that<br>
has SHA2 EV signature, and which installs correctly on one particular<br>
instance of Windows 7. An earlier driver signed with the same EV<br>
certificate loaded correctly on Windows 10.<br>
<br>
Now we&#39;d need to verify that this particular driver installs and works<=
br>
correctly on other Windows versions, such as<br>
<br>
- Windows 10 (untested)<br>
- Windows 8.1 (untested)<br>
- Windows 7 (more testing is always good)<br>
- Windows Server 2012r2 (untested)<br>
- Windows Vista (untested, _might_ fail)</div></blockquote></div><div class=
=3D"gmail_extra"><br>- Windows 10 (64 bit): success<br></div><br>Installs w=
ithout error and works fine. <br><br>- Windows 7 (64 bit): success, but see=
 below<br><br>Installs without error and works fine.=C2=A0 <br>However, the=
 driver details says that its _not_ digitally signed, but the driver proper=
ties window shows &quot;Digitally signed by OpenVPN Technologies Inc.&quot;=
 </div><div class=3D"gmail_extra">Installing KB3123479 (update to support S=
HA2 signatures) makes no difference.<br><br></div><div class=3D"gmail_extra=
">- Windows server 2008r2 (64bit) : installs ok, but adapter fails<br><br><=
/div><div class=3D"gmail_extra">Installs without error, driver properties a=
nd driver details display same as Windows 7 (i.e one says signed, other say=
s not signed).<br>Cannot enable the tap adapter -- fails with the following=
 error<br><br></div>&quot;The TAP-Windows Adapter V9 service failed to star=
t due to the following error: <br><div class=3D"gmail_extra">Windows cannot=
 verify the digital signature for this file. A recent hardware or software =
change might have installed a file that is signed incorrectly or damaged, o=
r that might be malicious software from an unknown source.&quot;<br><br></d=
iv><div class=3D"gmail_extra">On installing KB3123479, the error changes to=
<br>&quot;The driver \Driver\tap0901 failed to load for the device ROOT\NET=
\0004.&quot;<br></div><div class=3D"gmail_extra">and TAP adapters do no sho=
w up in the list of network adapters<br><br></div><div class=3D"gmail_extra=
">- Windows vista (32 bit): installs after ignoring security warning, works=
 fine<br><br></div><div class=3D"gmail_extra">Installation: Pops up a warni=
ng that says no valid signature, publisher not verified etc. On choosing to=
 install anyway, completes without error.<br></div><div class=3D"gmail_extr=
a">Tap adapter works fine<br><br></div><div class=3D"gmail_extra">I thought=
 driver signature is not enforced on 32 bit vista, but this is the only pla=
tform (among those I tried) that complained loudly at installation time.<br=
><br></div><div class=3D"gmail_extra">Note: none of the above systems are u=
p-to-date with windows updates.<br><br></div><div class=3D"gmail_extra">Sel=
va<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"=
><br></div></div>

--001a113de7dcdcdc4d0530b56c77--

