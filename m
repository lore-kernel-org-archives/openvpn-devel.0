MIME-Version: 1.0
References: <20220824165718.102002-1-arne@...1227...>
 <YwfdRXTtp91VfJYd@...1296...>
In-Reply-To: <YwfdRXTtp91VfJYd@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Aug 2022 17:46:18 -0400
Message-ID: <CAKuzo_hjiR13j-eZ1g_05vCGe+iYAdfYkrTGGpjV6AmhschtvA@...278...>
Content-Type: multipart/alternative; boundary="00000000000046bca205e717c136"
Subject: Re: [Openvpn-devel] [PATCH] Fix delcarion of pubkeys in
 test_provider.c in MSVC builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--00000000000046bca205e717c136
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 25, 2022 at 4:37 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Aug 24, 2022 at 06:57:18PM +0200, Arne Schwabe wrote:
> >   Error: test_provider.c(74): error C2099: initializer is not a constant
> >
> > Fix this issue by making the const char* to const char[]. This is
> probably
> > of one the weird array decay corner cases
>
> Out of curiosity - does the error go away if you just remove all these
> "const" from the declaration?  Making this just a "static char *"?
>

The  const after * in the original was to make the pointer a compile-time
constant and usable as an initializer. Else even gcc and clang will error
out. The const before * indicating the value is a constant could be
removed, but the value is in fact a constant string literal, so why do
so....

Anyway, for some reason MSVC doesn't seem to accept any form other than
what Arne proposed. Unless we define pubkeys[] using the three string
literals directly and eliminate those intermediate vars (pubkey1, 2, 3).
.
Selva

--00000000000046bca205e717c136
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 25, 2022 at 4:37 PM Gert =
Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1711...=
96...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Hi,<br>
<br>
On Wed, Aug 24, 2022 at 06:57:18PM +0200, Arne Schwabe wrote:<br>
&gt;=C2=A0 =C2=A0Error: test_provider.c(74): error C2099: initializer is no=
t a constant<br>
&gt; <br>
&gt; Fix this issue by making the const char* to const char[]. This is prob=
ably<br>
&gt; of one the weird array decay corner cases<br>
<br>
Out of curiosity - does the error go away if you just remove all these<br>
&quot;const&quot; from the declaration?=C2=A0 Making this just a &quot;stat=
ic char *&quot;?<br></blockquote><div><br></div><div>The=C2=A0 const after =
* in the original was to make the pointer a compile-time constant and usabl=
e as an initializer. Else even gcc and clang will error out. The const befo=
re * indicating the value is a constant could be removed, but the value is =
in fact a constant string literal, so why do so....=C2=A0</div><div><br></d=
iv><div>Anyway, for some reason MSVC doesn&#39;t seem to accept any form ot=
her than what Arne proposed. Unless we define pubkeys[] using the three str=
ing literals directly and eliminate those intermediate vars (pubkey1, 2, 3)=
.</div><div>.</div><div>Selva</div></div></div>

--00000000000046bca205e717c136--

