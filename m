MIME-Version: 1.0
In-Reply-To: <20160917132024.12570-1-gert@...1296...>
References: <20160917132024.12570-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 17 Sep 2016 19:11:56 -0400
Message-ID: <CAKuzo_jqgMNCqcbCHBLO7hHoa9aLDTj3Ed7UmJ446b2J++8BCw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c12299cc211d9053cbc35cd
Subject: Re: [Openvpn-devel] [PATCH] Fix win32 building with C99 mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c12299cc211d9053cbc35cd
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Sep 17, 2016 at 9:20 AM, Gert Doering <gert@...1296...> wrote:

> In -std=c99 mode, WIN32 is not defined to be "1" anymore, but just
> "#define WIN32" - so the "#if WIN32" breaks, needs to be "#ifdef WIN32"
>

Indeed...

To depend on the compiler or system headers to define WIN32 was not a great
idea anyway. Using  _WIN32 or __WIN32 is probably more reliable. Or we
should define WIN32 in config.h. With std=c99, it seems WIN32 gets defined
by chance through some header pulled-in by syshead.h -- not something one
can rely on.

Compiler-defined macros with std=c99:
$ x86_64-w64-mingw32-gcc -std=c99 -E -dM - </dev/null | grep WIN32
#define _WIN32 1
#define __WIN32 1
#define __WIN32__ 1

As for a quick fix, the patch takes care of misc.c, but  there is an issue
with block_dns.c as well. It does not include the required config.h and
syshead.h at the top before #ifdef WIN32, so now the whole file gets
skipped -- mea culpa, mea culpa...

I think we can just remove #ifdef WIN32 from block_dns.c (its compiled only
on Windows), and add config.h and syshead.h headers at the top. Then we
also need -I$(top_srcdir)/src/compat in src/openvpnsev/Makefile.am as
compat.h is included by syshead.h.

Thanks,

Selva

--94eb2c12299cc211d9053cbc35cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sat, Sep 17, 2016 at 9:20 AM, Ge=
rt Doering <span dir=3D"ltr">&lt;<a target=3D"_blank" href=3D"mailto:gert@...220...=
..1296...">gert@...1296...</a>&gt;</span> wrote:<br><blockquote style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex" class=3D"gmail_quote">In -std=3Dc99 mode, WIN32 is not defined to be &=
quot;1&quot; anymore, but just<br>
&quot;#define WIN32&quot; - so the &quot;#if WIN32&quot; breaks, needs to b=
e &quot;#ifdef WIN32&quot;<span><font color=3D"#888888"><br></font></span><=
/blockquote><div><br></div><div>Indeed...<br><br>To depend on the compiler =
or system headers to define WIN32 was not a great idea anyway. Using=C2=A0 =
_WIN32 or __WIN32 is probably more reliable. Or we should define WIN32 in c=
onfig.h. With std=3Dc99, it seems WIN32 gets defined by chance through some=
 header pulled-in by syshead.h -- not something one can rely on.<br><br>Com=
piler-defined macros with std=3Dc99:<br>$ x86_64-w64-mingw32-gcc -std=3Dc99=
 -E -dM - &lt;/dev/null | grep WIN32<br>#define _WIN32 1<br>#define __WIN32=
 1<br>#define __WIN32__ 1<br><br>As for a quick fix, the patch takes care o=
f misc.c, but=C2=A0 there is an issue with block_dns.c as well. It does not=
 include the required config.h and syshead.h at the top before #ifdef WIN32=
, so now the whole file gets skipped -- mea culpa, mea culpa... <br><br>I t=
hink we can just remove #ifdef WIN32 from block_dns.c (its compiled only on=
 Windows), and add config.h and syshead.h headers at the top. Then we=C2=A0=
 also need -I$(top_srcdir)/src/compat in src/openvpnsev/Makefile.am as comp=
at.h is included by syshead.h.<br><br></div><div>Thanks,<br><br></div><div>=
Selva<br></div></div></div></div>

--94eb2c12299cc211d9053cbc35cd--

