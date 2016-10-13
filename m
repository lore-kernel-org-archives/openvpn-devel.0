MIME-Version: 1.0
In-Reply-To: <1476269227-13290-1-git-send-email-arne@...1227...>
References: <CAKuzo_h+1YqaAYSXtUXiNvcewg74aBS+rTwHBU_QXhVFvZW0Vg@...278...>
	<1476269227-13290-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 12 Oct 2016 22:46:02 -0400
Message-ID: <CAKuzo_ifQNjmv+c0snx=kgca84bAoZswOwmPQzH8VXji9ckemg@...278...>
Content-Type: multipart/alternative; boundary=001a113c03727813ef053eb61dcc
Subject: Re: [Openvpn-devel] [PATCH v2] Change the hold command to
 communicate the time that OpenVPN would wait to the UI.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113c03727813ef053eb61dcc
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Oct 12, 2016 at 6:47 AM, Arne Schwabe <arne@...1227...> wrote:

> Before the connect-retry change to do exponential backup this was not
> necessary
> since the time was fixed. With the exponential backoff the UI needs either
> to
> implement its own exponential backoff mechansim or needs a way of knowing
> the
> value of OpenVPN internal mechansim.
>
> Patch V2: Fixed typos noticed by Selva(
> ---
>  doc/management-notes.txt |  7 +++++--
>  src/openvpn/init.c       | 15 +++++++++------
>  src/openvpn/manage.c     |  8 ++++++--
>  src/openvpn/manage.h     |  2 +-
>  4 files changed, 21 insertions(+), 11 deletions(-)


Looks good and works as expected. Tested on Linux.

-  >HOLD:Waiting for hold release
> +  >HOLD:Waiting for hold release:10


OpenVPN GUI does not parse the "Waiting for hold release" string, so this
doesn't affect it.

ACK from me.

Suggest to correct mechansim->mechanism (x2) in commit message during
merge.

Selva

--001a113c03727813ef053eb61dcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Oct 12, 2016 at 6:47 AM, Arne S=
chwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=3D"_=
blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span>Befo=
re the connect-retry change to do exponential backup this was not necessary=
<br>
since the time was fixed. With the exponential backoff the UI needs either =
to<br>
implement its own exponential backoff mechansim or needs a way of knowing t=
he<br>
value of OpenVPN internal mechansim.<br>
<br>
</span>Patch V2: Fixed typos noticed by Selva(<br>
---<br>
=C2=A0doc/management-notes.txt |=C2=A0 7 +++++--<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 +++++++++------<br>
<span>=C2=A0src/openvpn/manage.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++++--<br>
=C2=A0src/openvpn/manage.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
</span>=C2=A04 files changed, 21 insertions(+), 11 deletions(-)</blockquote=
></div><br>Looks good and works as expected. Tested on Linux.</div><div cla=
ss=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
- =C2=A0&gt;HOLD:Waiting for hold release<br>+ =C2=A0&gt;HOLD:Waiting for h=
old release:10</blockquote></div><div class=3D"gmail_extra"><br></div><div =
class=3D"gmail_extra">OpenVPN GUI does not parse the &quot;Waiting for hold=
 release&quot; string, so this doesn&#39;t affect it.<br></div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">ACK from me.</div><di=
v class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Suggest to cor=
rect mechansim-&gt;mechanism (x2) in commit message during merge.=C2=A0</di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</di=
v></div>

--001a113c03727813ef053eb61dcc--

