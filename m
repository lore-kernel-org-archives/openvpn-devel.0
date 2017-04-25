MIME-Version: 1.0
In-Reply-To: <16ad3121-4498-7a47-c481-f6e0c2b19084@...277...>
References: <d0cc2a54-cd65-9ebd-1e6f-8d2b75bfb223@...277...>
	<CAKuzo_iam5RwR=grdc9cT8OL6AWdEp_bEh9jo1dhiyVf9T21sQ@...278...>
	<67275b0c-0491-b8e0-23d8-7ed548a6f3e3@...277...>
	<16ad3121-4498-7a47-c481-f6e0c2b19084@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 Apr 2017 18:03:24 -0400
Message-ID: <CAKuzo_gBGVPeVo+Wo6rpW856_A1p3=qws0f2MTQxGEcbh4=ONw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c190372c7a38c054e04e57f
Subject: Re: [Openvpn-devel] Windows 10 Creators Update broke
	--block-outside-dns
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--94eb2c190372c7a38c054e04e57f
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 25, 2017 at 4:40 PM, ValdikSS <valdikss@...277...> wrote:

> Please check updated version
> https://github.com/ValdikSS/openvpn-with-patches/commit/
> 80345eac823326299c5428a8db45dc06a8d10f7b
>
> set_interface_metric() needs to be called from interactive service but the
> service doesn't include win32.h/c so I had to copy/paste code into it. How
> could this be improved?
>

Code shared between to openvpn core and the service could go into
block_dns.c and block_dns.h. Do not make the service code dependent on
win32.h as that will pull-in a lot of unwanted dependencies with it.

Selva

--94eb2c190372c7a38c054e04e57f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Apr 25, 2017 at 4:40 PM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D"=
mailto:valdikss@...277..." target=3D"_blank">valdikss@...277...</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div text=3D"#000000" bgcolor=
=3D"#FFFFFF">Please check updated version<br>
<a class=3D"m_3029888029251379535moz-txt-link-freetext" href=3D"https://git=
hub.com/ValdikSS/openvpn-with-patches/commit/80345eac823326299c5428a8db45dc=
06a8d10f7b" target=3D"_blank">https://github.com/ValdikSS/<wbr>openvpn-with=
-patches/commit/<wbr>80345eac823326299c5428a8db45dc<wbr>06a8d10f7b</a><br>
    <br>
    <span class=3D"m_3029888029251379535blob-code-inner"><span class=3D"m_3=
029888029251379535pl-en">set_interface_metric()
        needs to be called from interactive service but the service
        doesn&#39;t include win32.h/c so I had to copy/paste code into it.
        How could this be improved?</span></span><div class=3D"yj6qo ajU"><=
div id=3D":8e3" class=3D"ajR" tabindex=3D"0"></div></div></div></blockquote=
></div><div class=3D"gmail_extra"><br></div>Code shared between to openvpn =
core and the service could go into block_dns.c and block_dns.h. Do not make=
 the service code dependent on win32.h as that will pull-in a lot of unwant=
ed dependencies with it.</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">Selva=C2=A0</div></div>

--94eb2c190372c7a38c054e04e57f--

