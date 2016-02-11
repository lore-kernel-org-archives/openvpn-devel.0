MIME-Version: 1.0
In-Reply-To: <56BCB9ED.7050802@...515...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Feb 2016 15:23:13 -0500
Message-ID: <CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
Content-Type: multipart/alternative; boundary=001a11c2b4640f2e37052b845361
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
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

--001a11c2b4640f2e37052b845361
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 11, 2016 at 11:42 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
wrote:

> 2) OpenVPN-GUI points OpenVPN config directory to a system-wide location
>
> While OpenVPN-GUI now saves the registry keys under "HKCU" (=3Dcurrent
> user) instead of "HKLM" (=3Dlocal-machine), the default value for OpenVPN
> configs is still C:\Program Files\OpenVPN\config (or equivalent). At
> least on my test system the OpenVPN configuration files under that
> directory could not be read by a normal user, even though listing the
> files was permitted. This caused OpenVPN-GUI to see the config file, but
> upon loading it just hanged.
>

Changing this default may break most setups as that is where the GUI looked
for configs for so long.. I was under the impression that C:\Program FIles\
and directories & files under it are readable by all users. And that
matches with a few machines I checked  (win 7, win10, server2012).
openvpn.nsis does not show any permission settings on these folders either.
May be there are some "hardened" systems where such locations are not
readable?

I'm don't write GUI, so anything beyond a warning popup is too hard for me.
Yet, it would be nice to have an initial configuration dialog (shown at
first run by each user) to set config_dir and possibly a few other
parameters.

Selva

--001a11c2b4640f2e37052b845361
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Feb 11, 2016 at 11:42 AM, Samul=
i Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." t=
arget=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
><div style=3D"overflow:hidden">2) OpenVPN-GUI points OpenVPN config direct=
ory to a system-wide location<br>
<br>
While OpenVPN-GUI now saves the registry keys under &quot;HKCU&quot; (=3Dcu=
rrent<br>
user) instead of &quot;HKLM&quot; (=3Dlocal-machine), the default value for=
 OpenVPN<br>
configs is still C:\Program Files\OpenVPN\config (or equivalent). At<br>
least on my test system the OpenVPN configuration files under that<br>
directory could not be read by a normal user, even though listing the<br>
files was permitted. This caused OpenVPN-GUI to see the config file, but<br>
upon loading it just hanged.</div></blockquote></div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Changing this default may break m=
ost setups as that is where the GUI looked for configs for so long.. I was =
under the impression that C:\Program FIles\ and directories &amp; files und=
er it are readable by all users. And that matches with a few machines I che=
cked =C2=A0(win 7, win10, server2012). openvpn.nsis does not show any permi=
ssion settings on these folders either. May be there are some &quot;hardene=
d&quot; systems where such locations are not readable?=C2=A0</div></div><di=
v class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I&#39;m don&#3=
9;t write GUI, so anything beyond a warning popup is too hard for me. Yet, =
it would be nice to have an initial configuration dialog (shown at first ru=
n by each user) to set config_dir and possibly a few other parameters.<br><=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=C2=A0=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra"><br></div></div>

--001a11c2b4640f2e37052b845361--

