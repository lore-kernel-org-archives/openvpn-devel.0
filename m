MIME-Version: 1.0
In-Reply-To: <f102cd48-d5d4-ef1c-2ad4-a9313f5488d9@...515...>
References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
	<CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
	<20160629090025.GV78279@...1296...>
	<51c19384-4814-c63e-f515-ea0f3ce8791e@...515...>
	<CAFHpkQFMs3OsBoV8LP1BZnZpomMFwp6pvw_bx58UrLK20dyF0Q@...278...>
	<224018c8-c3a7-6a7e-0d46-2f44d87b2990@...515...>
	<CAFHpkQEsEj70wZxdXs9fd8W8j3QfuyWBjJAHXvzUGVTPt50_CQ@...278...>
	<1920c5bf-c449-3a79-5331-c8df691705d8@...515...>
	<20160629102122.GW78279@...1296...>
	<f102cd48-d5d4-ef1c-2ad4-a9313f5488d9@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 5 Jul 2016 00:24:16 -0400
Message-ID: <CAKuzo_hX8EKmX9mF63NhhoH0Wyb7d1cKKu+exvTmKX6wf2OyLA@...278...>
Content-Type: multipart/alternative; boundary=001a1141279492ca7f0536dbd498
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
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

--001a1141279492ca7f0536dbd498
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 4, 2016 at 7:33 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:

> Here is an installer that includes all the necessary bits to make
> openvpnserv2/interactive service things work nicely:
>
> <
> http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_git-I905=
-x86_64.exe
> >
>

Tested this installer on windows 7. Works as expected with two minor issues:

(i) If service installation checkbox is unselected, interactive service
remain selected and obviously fails in the end as no service binaries get
installed

(ii) If GUI is running, the installer offers to stop it but in that case it
also offers to restart it at the end of installation. That's not good as it
gets started as admin (as installer runs as admin) which is not ideal -- at
least not what I wanted. I would say just do not offer to start the GUI at
all even if it was stopped by the installer -- let the user restart it
after installation.

Selva

--001a1141279492ca7f0536dbd498
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Mon, Jul 4, 2016 at 7:33 AM, Sam=
uli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..."=
 target=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div id=3D":7z7" class=3D"a3s aXjCH m155b5b1a4ffa9b74">Her=
e is an installer that includes all the necessary bits to make<br>
openvpnserv2/interactive service things work nicely:<br>
<br>
&lt;<a href=3D"http://build.openvpn.net/downloads/snapshots/openvpn-install=
-2.3_git-I905-x86_64.exe" rel=3D"noreferrer" target=3D"_blank">http://build=
.openvpn.net/downloads/snapshots/openvpn-install-2.3_git-I905-x86_64.exe</a=
>&gt;</div></blockquote></div><br></div><div class=3D"gmail_extra">Tested t=
his installer on windows 7. Works as expected with two minor issues:<br><br=
></div><div class=3D"gmail_extra">(i) If service installation checkbox is u=
nselected, interactive service remain selected and obviously fails in the e=
nd as no service binaries get installed<br><br></div><div class=3D"gmail_ex=
tra">(ii) If GUI is running, the installer offers to stop it but in that ca=
se it also offers to restart it at the end of installation. That&#39;s not =
good as it gets started as admin (as installer runs as admin) which is not =
ideal -- at least not what I wanted. I would say just do not offer to start=
 the GUI at all even if it was stopped by the installer -- let the user res=
tart it after installation.<br><br></div><div class=3D"gmail_extra">Selva<b=
r></div></div>

--001a1141279492ca7f0536dbd498--

