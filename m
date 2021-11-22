MIME-Version: 1.0
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
In-Reply-To: <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Nov 2021 12:55:57 -0500
Message-ID: <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000002cc84505d16457f2"
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002cc84505d16457f2
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Nov 22, 2021 at 12:20 PM Lev Stipakov <lstipakov@...277...> wrote:

> I added a commit to vcpkg/openssl PR
> (https://github.com/microsoft/vcpkg/pull/21540) which gives an option
> to customize ENGINESDIR. Unfortunately openssl doesn't make it easy -
> ENGINESDIR is built based on --prefix, which is set to vcpkg build
> dir. The prefix cannot be set to something like C:\SSL, because in
> this case vcpkg build would require an elevated prompt. So I had to
> patch the makefile template. Let's see if there are less hacky ways to
> do it.
>

A common practice for locally installing to a private path for development
would be to do a "prefix relocation" using DESTDIR:

make DESTDIR=/home/selva/openssl-pkg/ install

which will preserve the search paths compiled into the library. This will
work for cross-compile on linux even with drive letters in prefix, though
awkward.  But such an approach cannot work on Windows as "C:" cannot be
embedded in Windows paths.

A hack could be to use paths without a drive letter: like prefix =
"/Program Files/OpenVPN/" etc. and then use DESTDIR to relocate for the
development installation. That relies on the Windows behaviour that paths
starting with "/" resolve to "C:/"  and depends on the value of "current
drive" which is probably reliable.

Otherwise patching as you propose may be the only way..

That said, how safe is this use of "C:/Program files/foo-bar" itself? Could
it be vulnerable in localized Windows -- e.g., "C:/Program Files/" may not
exist in some language versions and any user could then create one. If so,
we may have to set "C:/Windows/System32/" or some such path as OPENSSLDIR,
ENGINESDIR and MODULESDIR. It's unfortunate that OpenSSL folks decided to
use hard-coded values in the library for config location and dll search
paths.

Given these difficulties, shall we (also) set env vars in OpenVPN.exe on
startup so that OpenSSL config file and search paths will point to safe
locations determined at run time (only if not already set by user) --
needed only for Windows as we do not distribute OpenSSL for other
platforms. OpenSSL docs say what env vars are used to override built-in
paths, I'll do some tests to be sure.

Selva

--0000000000002cc84505d16457f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Nov 22, 2021 at 12:20 PM Lev Stipakov &lt;=
<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">I added a commit =
to vcpkg/openssl PR<br>
(<a href=3D"https://github.com/microsoft/vcpkg/pull/21540" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/microsoft/vcpkg/pull/21540</a>) whi=
ch gives an option<br>
to customize ENGINESDIR. Unfortunately openssl doesn&#39;t make it easy -<b=
r>
ENGINESDIR is built based on --prefix, which is set to vcpkg build<br>
dir. The prefix cannot be set to something like C:\SSL, because in<br>
this case vcpkg build would require an elevated prompt. So I had to<br>
patch the makefile template. Let&#39;s see if there are less hacky ways to<=
br>
do it.<br></blockquote><div><br></div><div>A common practice for locally in=
stalling to a private path for development would be to do a &quot;prefix re=
location&quot; using DESTDIR:</div><div><br></div><div>make DESTDIR=3D/home=
/selva/openssl-pkg/ install</div><div><br></div><div>which will preserve th=
e search paths compiled into the library. This will work for cross-compile =
on linux even with drive letters in prefix, though awkward.=C2=A0 But such =
an approach cannot work on Windows as &quot;C:&quot; cannot be embedded in =
Windows paths.</div><div><br></div><div>A hack could be to use paths withou=
t a drive letter: like prefix =3D &quot;/Program Files/OpenVPN/&quot; etc. =
and then use DESTDIR to relocate for the development installation. That rel=
ies on the Windows behaviour that paths starting with &quot;/&quot; resolve=
 to &quot;C:/&quot;=C2=A0 and depends on the value of &quot;current drive&q=
uot; which is probably reliable.</div><div><br></div><div>Otherwise patchin=
g as you propose may be the only way..</div><div><br></div><div>That said, =
how safe is this use of &quot;C:/Program files/foo-bar&quot; itself? Could =
it be vulnerable in localized Windows -- e.g., &quot;C:/Program Files/&quot=
; may not exist in some language versions and any user could then create on=
e. If so, we may have to set &quot;C:/Windows/System32/&quot; or some such =
path as OPENSSLDIR, ENGINESDIR and MODULESDIR. It&#39;s unfortunate that Op=
enSSL folks decided to use hard-coded values in the library=C2=A0for config=
 location and dll search paths.</div><div><br></div><div>Given these diffic=
ulties, shall we (also) set env vars in OpenVPN.exe on startup so that Open=
SSL config file and search paths will point to safe locations determined at=
 run time (only if not already set by user) -- needed only for Windows as w=
e do not distribute OpenSSL for other platforms. OpenSSL docs say what env =
vars are used to override built-in paths, I&#39;ll do some tests to be sure=
.</div><div><br></div><div>Selva</div></div></div>

--0000000000002cc84505d16457f2--

