MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
References: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
From: Selva <selva.nair@...277...>
Date: Mon, 30 Oct 2017 11:05:46 -0400
Message-ID: <CAKuzo_her_KFBMA3Xt6zKGmHGLnc89qXkb=n_LnvxcSzsvdV+A@...278...>
Content-Type: multipart/alternative; boundary="001a113e91645b20af055cc4fa29"
Subject: Re: [Openvpn-devel] OpenVPN Interactive Service Branding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>, "eduvpn@...321..." <eduvpn@...321...>

--001a113e91645b20af055cc4fa29
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Oct 30, 2017 at 4:41 AM, Simon Rozman <simon@...2293...> wrote:

> Hi Selva,
>
> We are considering distributing a local copy of OpenVPN with eduVPN Client:
> - To provide better app isolation;
> - To allow eduVPN to manage and update own OpenVPN copy.


This is fine, but I would like to see eduVPN usable as a GUI for the
official distribution as well (see below):


>
> The problem is one cannot run two openvpnserv.exe services at the same
> time, because the service control named pipe is hard-coded to
> "\\.\pipe\openvpn\service".
>
> While reviewing the openvpnserv.exe source code, I noticed on the other
> hand, that registry key is configurable as "HKEY_LOCAL_MACHINE\SOFTWARE\<PACKAGE_NAME>".
> Analogous to that, I have created a patch https://github.com/Amebis/
> openvpn/commit/103f07e54f8c672e1fa220ef197d26692c5d1300 to support
> "<PACKAGE_NAME>" configuration of named pipes as well.
>

Instead of a pipe name set at compile-time, I think its better to make this
customizable by the installer. That is,
we could take service name from an optional registry entry so that it may
be renamed by the installation package.

That way eduVPN's GUI will remain compatible with official service if a
user wishes to use it as a replacement for OpenVPN-GUI


> Along with https://github.com/Amebis/openvpn/commit/
> 082e0c0de2d79ac61cae33128d8b35b392fba664 and


The hard coded admin group name is only a default to fall back on, when no
entry is found in the registry. Just set the desired name in registry while
installing the package.

https://github.com/Amebis/openvpn/commit/9084c4822b83ed77b7bedf938acb3d
> 0dd8c3b382 patches to make OpenVPN Administrators group and OpenVPN
> firewall rule names configurable as well.


The firewall rules are always added to the same sublayer by all instances
of openvpn. And this has to remain so to avoid conflicts between rules
added by multiple instances. A name change will only affect error messages.
If that is the aim, why pick only the firewall code?

Selva

--001a113e91645b20af055cc4fa29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Mon, Oct 30, 2017 at 4:41 AM, Si=
mon <span class=3D"" id=3D":bkf.1" tabindex=3D"-1">Rozman</span> <span dir=
=3D"ltr">&lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank"><span cl=
ass=3D"" id=3D":bkf.2" tabindex=3D"-1">simon</span>@<span class=3D"" id=3D"=
:bkf.3" tabindex=3D"-1">rozman</span>.<span class=3D"" id=3D":bkf.4" tabind=
ex=3D"-1">si</span></a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Hi Selva,<br>
<br>
We are considering distributing a local copy of OpenVPN with eduVPN Client:=
<br>
- To provide better app isolation;<br>
- To allow eduVPN to manage and update own OpenVPN copy.</blockquote><div><=
br></div><div>This is fine, but I would like to see <span class=3D"" id=3D"=
:bkf.5" tabindex=3D"-1">eduVPN</span> usable as a GUI for the official dist=
ribution as well (see below):</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
The problem is one cannot run two openvpnserv.exe services at the same time=
, because the service control named pipe is hard-coded to &quot;\\.\pipe\op=
envpn\service&quot;.<br>
<br>
While reviewing the openvpnserv.exe source code, I noticed on the other han=
d, that registry key is configurable as &quot;HKEY_LOCAL_MACHINE\SOFTWARE\&=
lt;<wbr>PACKAGE_NAME&gt;&quot;. Analogous to that, I have created a patch <=
a href=3D"https://github.com/Amebis/openvpn/commit/103f07e54f8c672e1fa220ef=
197d26692c5d1300" rel=3D"noreferrer" target=3D"_blank">https://github.com/A=
mebis/<wbr>openvpn/commit/<wbr>103f07e54f8c672e1fa220ef197d26<wbr>692c5d130=
0</a> to support &quot;&lt;PACKAGE_NAME&gt;&quot; configuration of named pi=
pes as well.<br></blockquote><div><br></div><div>Instead of a pipe name set=
 at compile-time, I think its better to make this <span class=3D"" id=3D":b=
kf.6" tabindex=3D"-1">customizable</span> by the installer. That is,</div><=
div>we could take service name from an optional registry entry so that it m=
ay be renamed by the installation package.</div><div><br></div><div>That wa=
y <span class=3D"" id=3D":bkf.7" tabindex=3D"-1">eduVPN&#39;s</span> GUI wi=
ll remain compatible with official service if a user wishes to use it as a =
replacement for <span class=3D"" id=3D":bkf.8" tabindex=3D"-1">OpenVPN</spa=
n>-GUI</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Along with <a href=3D"https://github.com/Amebis/openvpn/commit/082e0c0de2d7=
9ac61cae33128d8b35b392fba664" rel=3D"noreferrer" target=3D"_blank">https://=
github.com/Amebis/<wbr>openvpn/commit/<wbr>082e0c0de2d79ac61cae33128d8b35<w=
br>b392fba664</a> and</blockquote><div><br></div><div>The hard coded admin =
group name is only a default to fall back on, when no entry is found in the=
 registry. Just set the desired name in registry while installing the packa=
ge.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"> <a href=3D"https://=
github.com/Amebis/openvpn/commit/9084c4822b83ed77b7bedf938acb3d0dd8c3b382" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/Amebis/<wbr>openvpn=
/commit/<wbr>9084c4822b83ed77b7bedf938acb3d<wbr>0dd8c3b382</a> patches to m=
ake OpenVPN Administrators group and OpenVPN firewall rule names configurab=
le as well.</blockquote><div><br></div><div>The firewall rules are always a=
dded to the same sublayer by all instances of <span class=3D"" id=3D":bkf.9=
" tabindex=3D"-1">openvpn</span>. And this has to remain so to avoid confli=
cts between rules added by multiple instances. A name change will only affe=
ct error messages. If that is the aim, why pick only the firewall code?<br>=
</div><div>=C2=A0</div><div><span class=3D"" id=3D":bkf.10" tabindex=3D"-1"=
>Selva</span></div></div></div></div>

--001a113e91645b20af055cc4fa29--

