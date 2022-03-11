MIME-Version: 1.0
References: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...>
 <CAKuzo_ioneE7-WX68GNgVE_dSK1LqoxtEOZwyoafEb7596-s+g@...278...>
 <YipsQB6QHjkjC4/I@...1296...>
In-Reply-To: <YipsQB6QHjkjC4/I@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Mar 2022 21:59:47 -0500
Message-ID: <CAKuzo_g3x6PDMeiDvxM303XdVLpF68xfw6AcEWgBKk6sw1ighQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000dce09005d9e88678"
Subject: Re: [Openvpn-devel] OpenVPN Client 2FA problem with Backslash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Jakob Curdes <jc@...2663...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000dce09005d9e88678
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Mar 10, 2022 at 4:23 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Mar 10, 2022 at 12:51:51PM -0500, Selva Nair wrote:
> > I missed this follow up on the devel list. Please see my reply to
> > openvpn-users. If @ doesnt work there is no easy fix short of patching
> the
> > GUI.
>
> We're planning a 2.5.x release "some time next week" (partly prompted
> due to the OpenSSL release on

tuesday).  So now's a good time for GUI
> fixes :-)
>
>
See PR 483 <https://github.com/OpenVPN/openvpn-gui/pull/483>

@Jakob Curdes <jc@...2663...>  This could be tested using the CI
executable here:
https://github.com/OpenVPN/openvpn-gui/suites/5617977743/artifacts/182849130
(for 64 bit Windows). No need to install --- just unzip into a temp folder
and double click on the included openvpn-gui.exe.

Selva

--000000000000dce09005d9e88678
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 10, 2022 at 4:23 PM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1826...=
6...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi,<br>
<br>
On Thu, Mar 10, 2022 at 12:51:51PM -0500, Selva Nair wrote:<br>
&gt; I missed this follow up on the devel list. Please see my reply to<br>
&gt; openvpn-users. If @ doesnt work there is no easy fix short of patching=
 the<br>
&gt; GUI.<br>
<br>
We&#39;re planning a 2.5.x release &quot;some time next week&quot; (partly =
prompted<br>
due to the OpenSSL release on=C2=A0</blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"> tuesday).=C2=A0 So now&#39;s a good time for GUI<br>
fixes :-)<br>
<br></blockquote><div><br></div><div>See PR <a href=3D"https://github.com/O=
penVPN/openvpn-gui/pull/483">483</a></div><div><br></div><div><a class=3D"g=
mail_plusreply" id=3D"m_-5532055924127106883plusReplyChip-0" href=3D"mailto=
:jc@...2663..." target=3D"_blank">@Jakob Curdes</a>=C2=A0 This could be tes=
ted using the CI executable here:=C2=A0</div><div><a href=3D"https://github=
.com/OpenVPN/openvpn-gui/suites/5617977743/artifacts/182849130" target=3D"_=
blank">https://github.com/OpenVPN/openvpn-gui/suites/5617977743/artifacts/1=
82849130</a></div><div>(for 64 bit Windows). No need to install --- just un=
zip into a temp folder and double click on the included openvpn-gui.exe.</d=
iv><div><br></div><div>Selva</div></div></div>

--000000000000dce09005d9e88678--

