MIME-Version: 1.0
In-Reply-To: <5659C357.8030206@...2070...>
References: <20151125082651.GT24952@...1296...>
	<1448477731-21421-1-git-send-email-iam@...2070...>
	<56560812.4050008@...2070...>
	<CAKuzo_j+asj4qBeZEPMcOH5coqy2PmXpLzBQQ5Vd6j8jJ2njbQ@...278...>
	<5659C357.8030206@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 28 Nov 2015 12:25:41 -0500
Message-ID: <CAKuzo_ie5x9Ov_kTwXCtnD2F6QA9p-n710SDntuVovgA59gERg@...278...>
Content-Type: multipart/alternative; boundary=001a114b2a521d928605259d1a95
Subject: Re: [Openvpn-devel] [PATCH v5-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b2a521d928605259d1a95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 28, 2015 at 10:08 AM, ValdikSS <iam@...2070...> wrote:

> Hi!
>
> You have the point, note is confusing on XP. Changed it to "=E2=80=A6on W=
indows
> Vista or later".
>

That doesn't make it any less confusing. If I run a generic 2.3 (i.e no
wfp) build on on windows 7. I'll get that warning even though I am on
"vista or later". So it has to be something like "..not supported in this
build" or whatever... We can't anticipate on what version of windows a
build without wfp compiled-in may be run..


>
> Non-fatal note message is intended to have one config file on various
> platforms without any modifications.
>

There is already a way to handle that. So why break it for someone who
doesn't want to ignore unknown options? In my view a better way is to let
the existing code in options.c handle it appropriately (as fatal or warn
depending on other options, whether its being pushed or read from config
etc..)

Having said that there are other options such as --user and --group which
just generate a warning on windows. It may be its just me being pedantic.
Anyone else?

Selva

--001a114b2a521d928605259d1a95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sat, Nov 28, 2015 at 10:08 AM, V=
aldikSS <span dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_=
blank">iam@...2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><div bgcolor=3D"#FFFFFF" text=3D"#000000">Hi!<br>
    <br>
    You have the point, note is confusing on XP. Changed it to &quot;=E2=80=
=A6on
    Windows Vista or later&quot;.<br></div></blockquote><div><br></div><div=
>That doesn&#39;t make it any less confusing. If I run a generic 2.3 (i.e n=
o wfp) build on on windows 7. I&#39;ll get that warning even though I am on=
 &quot;vista or later&quot;. So it has to be something like &quot;..not sup=
ported in this build&quot; or whatever... We can&#39;t anticipate on what v=
ersion of windows a build without wfp compiled-in may be run..<br>=C2=A0<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div bgcolor=3D"#FFFFFF" text=3D"#000=
000">
    <br>
    Non-fatal note message is intended to have one config file on
    various platforms without any modifications. </div></blockquote><div><b=
r></div><div>There is already a way to handle that. So why break it for som=
eone who doesn&#39;t want to ignore unknown options? In my view a better wa=
y is to let the existing code in options.c handle it appropriately (as fata=
l or warn depending on other options, whether its being pushed or read from=
 config etc..)<br></div><div>=C2=A0<br></div><div>Having said that there ar=
e other options such as --user and --group which just generate a warning on=
 windows. It may be its just me being pedantic.=C2=A0 Anyone else?</div></d=
iv><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--001a114b2a521d928605259d1a95--

