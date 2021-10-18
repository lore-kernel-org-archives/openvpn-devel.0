MIME-Version: 1.0
References: <20211015175330.15760-1-selva.nair@...277...>
 <20211015184733.16988-1-selva.nair@...277...>
 <CAGyAFMWXUCG0iEw2S2L1O8R3_hjkae3hVEoKASZCH3A_EjvL1g@...278...>
In-Reply-To: <CAGyAFMWXUCG0iEw2S2L1O8R3_hjkae3hVEoKASZCH3A_EjvL1g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 18 Oct 2021 07:25:02 -0400
Message-ID: <CAKuzo_iRmy4XhgYVXu0=Rij4SGqA_oQ7_va2gGfwPOU4gESthQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000c7538005ce9eccd2"
Subject: Re: [Openvpn-devel] [PATCH for 2.5] Fix some more wrong defines in
 config-msvc.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c7538005ce9eccd2
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Oct 18, 2021 at 3:56 AM Lev Stipakov <lstipakov@...277...> wrote:

> Looks good (I commented already in 2.5 version) apart from
>
> > -#define ENABLE_DEBUG 1
> > +#define ENABLE_DEBUG 0
>
> which doesn't undef it.
>

Right, we check it using #ifdef, not #if.

Gert: do you need a v2 or can you remove the line please?

Selva

--000000000000c7538005ce9eccd2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Oct 18, 2021 at 3:56 AM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Looks good (I comme=
nted already in 2.5 version) apart from<br>
<br>
&gt; -#define ENABLE_DEBUG 1<br>
&gt; +#define ENABLE_DEBUG 0<br>
<br>
which doesn&#39;t undef it.<br></blockquote><div><br></div><div>Right, we c=
heck it using #ifdef, not #if.=C2=A0</div><div><br></div><div>Gert: do you =
need a v2 or can you remove the line please?</div><div><br></div><div>Selva=
</div></div></div>

--000000000000c7538005ce9eccd2--

