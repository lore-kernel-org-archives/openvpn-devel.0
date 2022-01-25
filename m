MIME-Version: 1.0
References: <20220121185752.14138-1-selva.nair@...277...>
 <61752087-04ba-c571-9ee6-b366adb54c68@...2181...>
 <52435b2a-a5b0-198f-284c-c229ceb1512e@...1227...>
 <8ee7b45d-9229-b107-0bfd-8b5b77e95537@...2181...>
In-Reply-To: <8ee7b45d-9229-b107-0bfd-8b5b77e95537@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 Jan 2022 12:01:58 -0500
Message-ID: <CAKuzo_hoSDMFbs3eFgmM7W5dDXsvmLYeJQgn0tChk6ZkmfGA5w@...278...>
Content-Type: multipart/alternative; boundary="000000000000fb9c0605d66b0b28"
Subject: Re: [Openvpn-devel] [PATCH] Do not error when md_kt_size() is
 called with mdname="none"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000fb9c0605d66b0b28
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Jan 25, 2022 at 11:35 AM Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 25/01/2022 17:30, Arne Schwabe wrote:
> > Am 25.01.22 um 17:27 schrieb Antonio Quartulli:
> >> Hi,
> >>
> >> On 21/01/2022 19:57, selva.nair@...277... wrote:
> >>> diff --git a/src/openvpn/crypto_openssl.c
> b/src/openvpn/crypto_openssl.c
> >>> index 35fb0052..b93c680a 100644
> >>> --- a/src/openvpn/crypto_openssl.c
> >>> +++ b/src/openvpn/crypto_openssl.c
> >>> @@ -1073,6 +1073,10 @@ md_kt_name(const char *mdname)
> >>>   unsigned char
> >>>   md_kt_size(const char *mdname)
> >>>   {
> >>> +    if (!strcmp("none", mdname))
> >>
> >> Since we have it implemented, can we use streq() here?
> >>
> >> Cheers,
> >>
> >
> > streq is mainly used in option.c only, almost all other codes uses
> > strcmp insteads, so not really that strong of an argument.
>
> I thought options.c was part of this project too :-D
> To be honest, I think streq() is not really useful, but then we should
> either use it consistently or just drop it.
>
> I am in favour of dropping it because including options.h in other .c
> files can be quite a nightmare and you don't want that just to use streq().
>
> So I guess we can live with this patch, but should we put on the agenda
> wiping streq() for good?
>

"live with" ? When did strcmp() become a pariah?

Though strcmp()'s naming and return value are arguably not intuitive, we
are all used to it. That said, we have 472 uses of streq(), so let it be.
Just do not require that one should be preferred over the other.

Consistency is a good goal, but let's not be pedantic about it.

Selva

--000000000000fb9c0605d66b0b28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Jan 25, 2022 at 11:35 AM Antonio Quartulli=
 &lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 25/01/2022 17:30, Arne Schwabe wrote:<br>
&gt; Am 25.01.22 um 17:27 schrieb Antonio Quartulli:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On 21/01/2022 19:57, <a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt;&gt;&gt; diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto=
_openssl.c<br>
&gt;&gt;&gt; index 35fb0052..b93c680a 100644<br>
&gt;&gt;&gt; --- a/src/openvpn/crypto_openssl.c<br>
&gt;&gt;&gt; +++ b/src/openvpn/crypto_openssl.c<br>
&gt;&gt;&gt; @@ -1073,6 +1073,10 @@ md_kt_name(const char *mdname)<br>
&gt;&gt;&gt; =C2=A0 unsigned char<br>
&gt;&gt;&gt; =C2=A0 md_kt_size(const char *mdname)<br>
&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!strcmp(&quot;none&quot;, mdname))<br>
&gt;&gt;<br>
&gt;&gt; Since we have it implemented, can we use streq() here?<br>
&gt;&gt;<br>
&gt;&gt; Cheers,<br>
&gt;&gt;<br>
&gt; <br>
&gt; streq is mainly used in option.c only, almost all other codes uses <br>
&gt; strcmp insteads, so not really that strong of an argument.<br>
<br>
I thought options.c was part of this project too :-D<br>
To be honest, I think streq() is not really useful, but then we should <br>
either use it consistently or just drop it.<br>
<br>
I am in favour of dropping it because including options.h in other .c <br>
files can be quite a nightmare and you don&#39;t want that just to use stre=
q().<br>
<br>
So I guess we can live with this patch, but should we put on the agenda <br>
wiping streq() for good?<br></blockquote><div><br></div><div>&quot;live wit=
h&quot; ? When did strcmp() become a pariah?=C2=A0</div><div><br></div><div=
>Though strcmp()&#39;s naming and return value are arguably not intuitive, =
we are all used to it. That said, we have 472 uses of streq(), so let it be=
. Just do not require that one should be preferred over the other.</div><di=
v><br></div><div>Consistency is a good=C2=A0goal, but let&#39;s not be peda=
ntic about it.</div><div><br></div><div>Selva</div></div></div>

--000000000000fb9c0605d66b0b28--

