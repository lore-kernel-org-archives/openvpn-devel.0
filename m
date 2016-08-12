MIME-Version: 1.0
In-Reply-To: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Aug 2016 21:14:43 -0400
Message-ID: <CAKuzo_jXCPDbsn24i4LcsqovVXGNaQuc-PtwwucnVDvwpMQgYg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0a879ab735310539d59c92
Subject: Re: [Openvpn-devel] autoconf/automake warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0a879ab735310539d59c92
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 11, 2016 at 2:50 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Hi,
>
> I noticed a few errors today when building OpenVPN on Fedora 23.  The
> attached patch resolves this.  But it breaks 'make' when it reaches
> ./src/openvpnserv:
>

The patch is obviously useless as it breaks configuring.


>
> Makefile:505: ../../src/openvpn/.deps/openvpnserv-block_dns.Po: No
> such file or directory
>

It is indeed caused by a bug in automake (bug#13928) because of which
variables in foo_SOURCES do not get expanded when subdir-objects is
specfied. Thus $(top_srcdir) in  $(top_srcdir)/src/openvpn/block_dns.c, for
example,  causes a folder literally named $(top_srcdir) created inside
src/openvpnserv/. But make wont find any files there and leads to the
missing file issues.

This has been fixed in automake 1.15a master tree in this commit :
http://git.savannah.gnu.org/cgit/automake.git/commit/?id=
6a675ef17edf7109da189f5ae70e2dc6b7665896

(I tested it works)

But that may not get into any distributions for a while and anyway  we'll
have to continue supporting various 1.x versions of automake for a long
time.

We have two options:

(i) just ignore the subdir-objects warning until it really cannot be
ignored (i.e when they make it the default).
OR
(ii) do not use any variables that need expansion in packagename_SOURCES
lines in Makefile.am  This is an easy fix that should just work.

Selva

--94eb2c0a879ab735310539d59c92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Aug 11, 2016 at 2:50 PM, David Sommerseth <span dir=3D"ltr">&lt=
;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2142...=
<wbr>topphemmelig.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
<br>
Hi,<br>
<br>
I noticed a few errors today when building OpenVPN on Fedora 23.=C2=A0 The<=
br>
attached patch resolves this.=C2=A0 But it breaks &#39;make&#39; when it re=
aches<br>
./src/openvpnserv:<br></blockquote><div><br></div><div>The patch is obvious=
ly useless as it breaks configuring.<br>=C2=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Makefile:505: ../../src/openvpn/.deps/openvp<wbr>nserv-block_dns.Po: No<br>
such file or directory<br></blockquote><div><br></div><div>It is indeed cau=
sed by a bug in automake (bug#13928) because of which variables in foo_SOUR=
CES do not get expanded when subdir-objects is specfied. Thus $(top_srcdir)=
 in=C2=A0 $(top_srcdir)/src/openvpn/<wbr>block_dns.c, for example,=C2=A0 ca=
uses a folder literally named $(top_srcdir) created inside src/openvpnserv/=
. But make wont find any files there and leads to the missing file issues.<=
br><br></div><div>This has been fixed in automake 1.15a master tree in this=
 commit :<br><a href=3D"http://git.savannah.gnu.org/cgit/automake.git/commi=
t/?id=3D6a675ef17edf7109da189f5ae70e2dc6b7665896" target=3D"_blank">http://=
git.savannah.gnu.org/<wbr>cgit/automake.git/commit/?id=3D<wbr>6a675ef17edf7=
109da189f5ae70e2d<wbr>c6b7665896</a></div><div><br>(I tested it works)<br><=
br></div><div>But that may not get into any distributions for a while and a=
nyway=C2=A0 we&#39;ll have to continue supporting various 1.x versions of a=
utomake for a long time.<br><br></div><div>We have two options: <br><br>(i)=
 just ignore the subdir-objects warning until it really cannot be ignored (=
i.e when they make it the default).<br></div><div>OR<br></div><div>(ii) do =
not use any variables that need expansion in packagename_SOURCES lines in M=
akefile.am=C2=A0 This is an easy fix that should just work.<br></div><div><=
br></div><div>Selva</div></div><br></div></div>

--94eb2c0a879ab735310539d59c92--

