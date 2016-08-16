MIME-Version: 1.0
In-Reply-To: <073f348b-77a8-3967-2874-77f2c973dbf4@...2070...>
References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
	<073f348b-77a8-3967-2874-77f2c973dbf4@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 Aug 2016 13:42:19 -0400
Message-ID: <CAKuzo_goKiVr4k7+eQbLK93fzQ99ZH+pkk1uVw0k2_OGb0mH4A@...278...>
Content-Type: multipart/alternative; boundary=001a113bc7ca0df783053a33e099
Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a113bc7ca0df783053a33e099
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Aug 16, 2016 at 12:41 PM, ValdikSS <iam@...2070...> wrote:

> This is known issue (for me), and it was superficially discussed on IRC at
> some point. It wasn't considered significant to implement block-outside-dns
> for multiple connections.
>
> Is there ahy reason to use block-outside-dns on multiple connections? Just
> asked supergregg (bug reporter), he probably has a reason if he created the
> bug.
>

I have no strong reason except that if an end user gets two configs with
block-outside-dns enabled it should just work without having to edit the
configs. Support for dns traffic through each tunnel may not be required,
but at least one of them working even if block-outside-dns is specified in
multiple configs looks like a nice thing to do.  Not all users can be
expected to edit configs.

Selva

--001a113bc7ca0df783053a33e099
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Aug 16, 2016 at 12:41 PM, Valdi=
kSS <span dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_blan=
k">iam@...2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div text=3D"#000000" bgcolor=3D"#FFFFFF">This is known issue (for me), and =
it was superficially discussed on
    IRC at some point. It wasn&#39;t considered significant to implement
    block-outside-dns for multiple connections.<br>
    <br>
    Is there ahy reason to use block-outside-dns on multiple
    connections? Just asked supergregg (bug reporter), he probably has a
    reason if he created the bug.</div></blockquote></div><br>I have no str=
ong reason except that if an end user gets two configs with block-outside-d=
ns enabled it should just work without having to edit the configs. Support =
for dns traffic through each tunnel may not be required, but at least one o=
f them working even if block-outside-dns is specified in multiple configs l=
ooks like a nice thing to do.=C2=A0 Not all users can be expected to edit c=
onfigs.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">Selva</div></div>

--001a113bc7ca0df783053a33e099--

