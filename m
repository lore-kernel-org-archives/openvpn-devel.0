MIME-Version: 1.0
In-Reply-To: <8000a47e-979c-3afc-1a7a-5f8afab85634@...1856...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<8000a47e-979c-3afc-1a7a-5f8afab85634@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 8 Dec 2016 17:04:53 -0500
Message-ID: <CAKuzo_ga48WDGd-g8Xp=L1NbXf0Naez1ZRN3FhcyL247bK72Rg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05b50aec251505432cd4f4
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05b50aec251505432cd4f4
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 8, 2016 at 4:50 PM, Steffan Karger <steffan@...1856...> wrote:

> .
>
> > This proposal allows for the "open bracing" question, which allows
> > '} else {'  and '} else if () {'.
> >
> > So now the bike shed debate opens up ... Is this something we can get
> > consensus around?
>
> Even though I asked for this on the CodeStyle page, I have to agree with
> Gert's argument on IRC:  we settled for Allman in Munich, so we should
> not re-open the bikeshed (even more ;) ).  So, even though it's not my
> personal preference, I argue we should not allow this.  Apologies for
> the noise...
>

I forgot to mention that, which was the only real comemnt I had:

if (xxxx)
{
   ...
}
followed by
else if (xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx) {
 ....
}

looks inconsitent and not pretty. Why not just stick to:

if (carefree())
{
   follow_me();
}
else if (cautious())
{
   as_you_wish();
}
else
{
   abort();
}

Looks easier to read.

Selva

--94eb2c05b50aec251505432cd4f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 8, 2016 at 4:50 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">.<br>
<span class=3D""><br>
&gt; This proposal allows for the &quot;open bracing&quot; question, which =
allows<br>
&gt; &#39;} else {&#39;=C2=A0 and &#39;} else if () {&#39;.<br>
&gt;<br>
&gt; So now the bike shed debate opens up ... Is this something we can get<=
br>
&gt; consensus around?<br>
<br>
</span>Even though I asked for this on the CodeStyle page, I have to agree =
with<br>
Gert&#39;s argument on IRC:=C2=A0 we settled for Allman in Munich, so we sh=
ould<br>
not re-open the bikeshed (even more ;) ).=C2=A0 So, even though it&#39;s no=
t my<br>
personal preference, I argue we should not allow this.=C2=A0 Apologies for<=
br>
the noise...<br></blockquote><div><br></div><div>I forgot to mention that, =
which was the only real comemnt I had:<br><br></div><div>if (xxxx)<br>{<br>=
=C2=A0=C2=A0 ...<br>}<br></div><div>followed by<br></div><div>else if (xxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxx) {<br>=C2=A0....<br>}<br><br></div><div>looks i=
nconsitent and not pretty. Why not just stick to:<br><br></div><div>if (car=
efree())<br>{<br></div><div>=C2=A0=C2=A0 follow_me();<br></div><div>}<br></=
div><div>else if (cautious())<br>{<br></div><div>=C2=A0=C2=A0 as_you_wish()=
;<br></div><div>}<br></div><div>else<br>{<br></div><div>=C2=A0=C2=A0 abort(=
);<br>}<br><br></div><div>Looks easier to read.<br></div></div><br></div><d=
iv class=3D"gmail_extra">Selva<br></div></div>

--94eb2c05b50aec251505432cd4f4--

