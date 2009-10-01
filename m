MIME-Version: 1.0
In-Reply-To: <200910011141.52317.mailinglists@...1145...>
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...> 
	<7bb795fd0909302333x42aa4869gaf70cf7dc07d611d@...278...> 
	<7bb795fd0910010022i14565834vaa0d29b7fa48eb44@...278...> 
	<200910011141.52317.mailinglists@...1145...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Thu, 1 Oct 2009 12:14:14 +0200
Message-ID: <7bb795fd0910010314m5db10bedx448cf3b3a502fe82@...278...>
Content-Type: multipart/alternative; boundary=001485f77870fc184d0474dce9a5
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-1?Q?Marcel_Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

--001485f77870fc184d0474dce9a5
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Thu, Oct 1, 2009 at 11:41 AM, Marcel Pennewi=DF
<mailinglists@...1145...>wrote:

> On Thursday 01 October 2009 09:22:31 JuanJo Ciarlante wrote:
> > Compiled from
> >
> >
> http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn-2.1_rc19c-ipv6=
-0
> >.4.7.tar.gz , it went find for both, as the symbol(s) are ok at the
> objects:
> >
> > $ nm -p multi.o ssl.o | egrep 'o:|tls_auth'
> > multi.o:
> >                  U tls_authenticate_key
> >                  U tls_authentication_status
> > ssl.o:
> > 0000000000000080 T tls_authenticate_key
> > 0000000000000ba0 T tls_auth_standalone_init
> > 0000000000000d80 T tls_auth_standalone_finalize
> > 0000000000000ff0 T tls_authentication_status
> >
> > , ie: tls_authenticate_key symbol present as code ("T "ext) in ssl.o
> > , could be there something fishy/unclean in your building env?
>
> i don't know but build log seems not to show any problems. after the build
> error my multi.o and ssl.o are are different from yours:
>
> larissa openvpn-2.1_rc19 # nm -p multi.o ssl.o | egrep 'o:|tls_auth'
> multi.o:
>                 U tls_authenticate_key
>                 U tls_authentication_status
> ssl.o:
> 0000000000000080 T tls_authentication_status
> 0000000000000be0 T tls_auth_standalone_init
> 0000000000000da0 T tls_auth_standalone_finalize
>

This is even more weird, cool ...


> the problem only exists when i add your patch. without your patch
> everything
> runs fine. i'm using openvpn-source from
> http://ftp.tu-ilmenau.de/mirror/gentoo/distfiles/openvpn-2.1_rc19.tar.gz
> which is the official source from gentoo-portage and apply your patch.
>
> i'll try your sources asap.
>

They must^Wshould output the very same source, as the
patch is created from a "diff -ur ..." between stock and
my src tree.

Could you please show a diff between config.h from stock
and patched build?

Cheers,


> Regards,
> Marcel
>
>
>
>
> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#3=
3;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

--001485f77870fc184d0474dce9a5
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,<br><br><div class=3D"gmail_quote">On Thu, Oct 1, 2009 at 11:41 A=
M, Marcel Pennewi=DF <span dir=3D"ltr">&lt;<a href=3D"mailto:mailinglists@...220...=
..1145...">mailinglists@...1145...</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex;">

<div class=3D"im">On Thursday 01 October 2009 09:22:31 JuanJo Ciarlante wro=
te:<br>
&gt; Compiled from<br>
&gt;<br>
&gt; <a href=3D"http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn-=
2.1_rc19c-ipv6-0" target=3D"_blank">http://cloud.github.com/downloads/jjo/o=
penvpn-ipv6/openvpn-2.1_rc19c-ipv6-0</a><br>
&gt;.4.7.tar.gz , it went find for both, as the symbol(s) are ok at the obj=
ects:<br>
&gt;<br>
&gt; $ nm -p multi.o ssl.o | egrep &#39;o:|tls_auth&#39;<br>
&gt; multi.o:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0U tls_authenticate_key<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0U tls_authentication_status<br>
&gt; ssl.o:<br>
&gt; 0000000000000080 T tls_authenticate_key<br>
&gt; 0000000000000ba0 T tls_auth_standalone_init<br>
&gt; 0000000000000d80 T tls_auth_standalone_finalize<br>
&gt; 0000000000000ff0 T tls_authentication_status<br>
&gt;<br>
&gt; , ie: tls_authenticate_key symbol present as code (&quot;T &quot;ext) =
in ssl.o<br>
&gt; , could be there something fishy/unclean in your building env?<br>
<br>
</div>i don&#39;t know but build log seems not to show any problems. after =
the build<br>
error my multi.o and ssl.o are are different from yours:<br>
<br>
larissa openvpn-2.1_rc19 # nm -p multi.o ssl.o | egrep &#39;o:|tls_auth&#39=
;<br>
<div class=3D"im">multi.o:<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 U tls_authenticate_key<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 U tls_authentication_status<br>
ssl.o:<br>
</div>0000000000000080 T tls_authentication_status<br>
0000000000000be0 T tls_auth_standalone_init<br>
0000000000000da0 T tls_auth_standalone_finalize<br></blockquote><div><br></=
div><div>This is even more weird, cool ...</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex;">


<br>
the problem only exists when i add your patch. without your patch everythin=
g<br>
runs fine. i&#39;m using openvpn-source from<br>
<a href=3D"http://ftp.tu-ilmenau.de/mirror/gentoo/distfiles/openvpn-2.1_rc1=
9.tar.gz" target=3D"_blank">http://ftp.tu-ilmenau.de/mirror/gentoo/distfile=
s/openvpn-2.1_rc19.tar.gz</a><br>
which is the official source from gentoo-portage and apply your patch.<br>
<br>
i&#39;ll try your sources asap.<br></blockquote><div><br></div><div>They mu=
st^Wshould output the very same source, as the</div><div>patch is created f=
rom a &quot;diff -ur ...&quot; between stock and</div><div>my src tree.</di=
v>

<div><br></div><div>Could you please show a diff between config.h from stoc=
k</div><div>and patched build?</div><div><br></div><div>Cheers,</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex;">


<div><div></div><div class=3D"h5"><br>
Regards,<br>
Marcel<br>
<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Come build with us! The BlackBerry&amp;reg; Developer Conference in SF, CA<=
br>
is the only developer event you need to attend this year. Jumpstart your<br>
developing skills, take BlackBerry mobile applications to market and stay<b=
r>
ahead of the curve. Join us from November 9&amp;#45;12, 2009. Register now&=
amp;#33;<br>
<a href=3D"http://p.sf.net/sfu/devconf" target=3D"_blank">http://p.sf.net/s=
fu/devconf</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>--JuanJo ; =
echo jAjo@...1263... | sed &#39;s/[SPAM]//g&#39;<br>

--001485f77870fc184d0474dce9a5--

