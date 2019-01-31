MIME-Version: 1.0
References: <20190131164010.GG962@...1296...>
In-Reply-To: <20190131164010.GG962@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 31 Jan 2019 12:05:33 -0500
Message-ID: <CAKuzo_jJ90W2M7W2kLCx=JbJ=2DaC_mbesdrzWBZm04NMLyYOw@...278...>
Content-Type: multipart/alternative; boundary="000000000000de86a30580c4091a"
Subject: Re: [Openvpn-devel] OpenVPN 2.4: crypto api patches for OpenSSL
 1.1.1? cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000de86a30580c4091a
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Jan 31, 2019 at 11:40 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> I have changed the Subject: and started a new thread, so that this
> isn't lost in the discussion specific to commit ce1c1beef1eb.
>
> On Thu, Jan 31, 2019 at 11:28:52AM -0500, Selva Nair wrote:
> > So now the question -- do we want to support Windows builds with OpenSSL
> > 1.1.1 in 2.4?
>
> Basically, we already do.
>
> Could you summarize what is current not working right in 2.4 + 1.1.1,
> and which patches we need to make it work?
>
> I admit I have lost track (many many patches related to TLS 1.3... some
> bring new features, some bugfixes) and could imagine everyone else being
> in the same boat.  Maybe except Arne ;-)
>

OpenSSL 1.1.1 prefers pss padding even for TLS 1.2 so when both client and
server are linked against 1.1.1 and cryptoapicert is in use we need the
last two commits:

1. commit 0cab3475a83e9bad35b0eeb39b9ca886e6afaf1e
Move OpenSSL vs CNG signature digest type mapping to a function

2. commit ce1c1beef1eb9ea776e00861117f72c4a1a6f1f8
Handle PSS padding in cryptoapicert

It may take a little more work than cherry-pick + conflict resolve for
these as cryptoapi.c in master has diverged from 2.4 due to EC key support
in the former.

Apart from that, management-external-[cert|key] requires a way to signal
pss or "none" padding  -- Arne's patch on that is pending review or
revision, I forget. But that's not specific to Windows.

Selva

--000000000000de86a30580c4091a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 31, 2019 at 11:40 AM Ge=
rt Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1186...=
.1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi,<br>
<br>
I have changed the Subject: and started a new thread, so that this<br>
isn&#39;t lost in the discussion specific to commit ce1c1beef1eb.<br>
<br>
On Thu, Jan 31, 2019 at 11:28:52AM -0500, Selva Nair wrote:<br>
&gt; So now the question -- do we want to support Windows builds with OpenS=
SL<br>
&gt; 1.1.1 in 2.4?<br>
<br>
Basically, we already do.<br>
<br>
Could you summarize what is current not working right in 2.4 + 1.1.1, <br>
and which patches we need to make it work?<br>
<br>
I admit I have lost track (many many patches related to TLS 1.3... some<br>
bring new features, some bugfixes) and could imagine everyone else being<br>
in the same boat.=C2=A0 Maybe except Arne ;-)<br></blockquote><br></div><di=
v class=3D"gmail_quote">OpenSSL 1.1.1 prefers pss padding even for TLS 1.2 =
so when both client and server are linked against 1.1.1 and cryptoapicert i=
s in use we need the last two commits:<br><br>1. commit 0cab3475a83e9bad35b=
0eeb39b9ca886e6afaf1e<br>Move OpenSSL vs CNG signature digest type mapping =
to a function<br><br>2. commit ce1c1beef1eb9ea776e00861117f72c4a1a6f1f8<br>=
Handle PSS padding in cryptoapicert<br><br></div><div class=3D"gmail_quote"=
>It may take a little more work than cherry-pick + conflict resolve for the=
se as cryptoapi.c in master has diverged from 2.4 due to EC key support in =
the former.<br><br></div><div class=3D"gmail_quote">Apart from that, manage=
ment-external-[cert|key] requires a way to signal pss or &quot;none&quot; p=
adding=C2=A0 -- Arne&#39;s patch on that is pending review or revision, I f=
orget. But that&#39;s not specific to Windows.<br><br></div><div class=3D"g=
mail_quote">Selva<br></div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote"><br><br><br></div></div>

--000000000000de86a30580c4091a--

