MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 16 Jul 2012 12:24:22 -0400
Message-ID: <CAEsd45Rh9zu=FC_Qdt4KiUfGayMqRzshF4OpxsHcszVH+8vBHw@...278...>
Content-Type: multipart/alternative; boundary=e89a8fb205cc396c8404c4f4df3a
Subject: [Openvpn-devel] New build system questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--e89a8fb205cc396c8404c4f4df3a
Content-Type: text/plain; charset=UTF-8

I'm in the process of trying to build 2.3_alpha2 into Tunnelblick. It's
slow going because of my unfamiliarity with make/automake, etc. I have
several questions:

(1) Is there a way to disable building "openvpnserv" and the "auth-pam"
plugin? (Other than modifying src/Makefile.am and src/plugins/Makefile.am,
of course.) I'm thinking of something along the lines of
"ENABLE_OPENVPNSERV=no" or "DISABLE-AUTH-PAM".


(2) Should I be concerned about the following warnings?

checking lzo/lzoutil.h presence... no
configure: WARNING: lzo/lzoutil.h: accepted by the compiler, rejected by
the preprocessor!
configure: WARNING: lzo/lzoutil.h: proceeding with the compiler's result
checking for lzo/lzoutil.h... yes
checking lzo/lzo1x.h usability... yes
checking lzo/lzo1x.h presence... no
configure: WARNING: lzo/lzo1x.h: accepted by the compiler, rejected by the
preprocessor!
configure: WARNING: lzo/lzo1x.h: proceeding with the compiler's result




(3) I want to build "compat" as a static library. How can I do that?

I've tried adding the following arguments after "./configure":

--enable-static --disable-shared


And I've tried prefixing ./configure with the following:

COMPAT_CFLAGS=-static  LIBCOMPAT_CFLAGS=-static
 LIBCOMPAT_LA_CFLAGS=-static compat_CFLAGS=-static
 libcompat_CFLAGS=-static  libcompat_la_CFLAGS=-static
COMPAT_LDFLAGS=-static  LIBCOMPAT_LDFLAGS=-static
 LIBCOMPAT_LA_LDFLAGS=-static compat_LDFLAGS=-static
 libcompat_LDFLAGS=-static  libcompat_la_LDFLAGS=-static
 COMPAT_LIBTOOLFLAGS=-static  LIBCOMPAT_LIBTOOLFLAGS=-static
 LIBCOMPAT_LA_LIBTOOLFLAGS=-static compat_LIBTOOLFLAGS=-static
 libcompat_LIBTOOLFLAGS=-static libcompat_la_LIBTOOLFLAGS=-static


But it still seems to be building a "shared" library for compat -- I get
the following warning:

*** Warning: Linking the shared library libcompat.la against the

*** static library [path to] libcrypto.a is not portable!

along with the same warning about libssl.a, liblzo2.a, and
libpkcs11-helper.a.

Any help would be greatly appreciated.

--e89a8fb205cc396c8404c4f4df3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>I&#39;m in the process of trying to build 2.3_alpha2 into Tunnelblick.=
=C2=A0It&#39;s slow going because of my unfamiliarity with make/automake, e=
tc. I have several questions:</div><div><br></div>
<div>(1) Is there a way to disable building &quot;openvpnserv&quot; and the=
 &quot;auth-pam&quot; plugin? (Other than modifying src/Makefile.am and src=
/plugins/Makefile.am, of course.) I&#39;m thinking of something along the l=
ines of &quot;ENABLE_OPENVPNSERV=3Dno&quot; or &quot;DISABLE-AUTH-PAM&quot;=
.</div>

<div><br></div><div><br></div><div>(2) Should I be concerned about the foll=
owing warnings?=C2=A0</div><div><br></div><blockquote style=3D"margin:0px 0=
px 0px 40px;border:none;padding:0px"><div>checking lzo/lzoutil.h presence..=
. no</div>

<div>configure: WARNING: lzo/lzoutil.h: accepted by the compiler, rejected =
by the preprocessor!</div><div>configure: WARNING: lzo/lzoutil.h: proceedin=
g with the compiler&#39;s result</div><div>checking for lzo/lzoutil.h... ye=
s</div>

<div>checking lzo/lzo1x.h usability... yes</div><div>checking lzo/lzo1x.h p=
resence... no</div><div>configure: WARNING: lzo/lzo1x.h: accepted by the co=
mpiler, rejected by the preprocessor!</div><div>configure: WARNING: lzo/lzo=
1x.h: proceeding with the compiler&#39;s result</div>

</blockquote><div><br></div><div><br></div><br class=3D"Apple-interchange-n=
ewline"><div>(3) I want to build &quot;compat&quot; as a static library. Ho=
w can I do that?</div><div><br></div><blockquote style=3D"margin:0 0 0 40px=
;border:none;padding:0px">

<div>I&#39;ve tried adding the following arguments after &quot;./configure&=
quot;:</div>
<blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div>-=
-enable-static --disable-shared</div></div></blockquote><div><br></div><div=
>And I&#39;ve tried prefixing ./configure with the following:</div><div>

<br>
</div><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div>=
<div>COMPAT_CFLAGS=3D-static =C2=A0LIBCOMPAT_CFLAGS=3D-static =C2=A0LIBCOMP=
AT_LA_CFLAGS=3D-static compat_CFLAGS=3D-static =C2=A0libcompat_CFLAGS=3D-st=
atic =C2=A0libcompat_la_CFLAGS=3D-static COMPAT_LDFLAGS=3D-static =C2=A0LIB=
COMPAT_LDFLAGS=3D-static =C2=A0LIBCOMPAT_LA_LDFLAGS=3D-static compat_LDFLAG=
S=3D-static =C2=A0libcompat_LDFLAGS=3D-static =C2=A0libcompat_la_LDFLAGS=3D=
-static =C2=A0COMPAT_LIBTOOLFLAGS=3D-static =C2=A0LIBCOMPAT_LIBTOOLFLAGS=3D=
-static =C2=A0LIBCOMPAT_LA_LIBTOOLFLAGS=3D-static compat_LIBTOOLFLAGS=3D-st=
atic =C2=A0libcompat_LIBTOOLFLAGS=3D-static libcompat_la_LIBTOOLFLAGS=3D-st=
atic</div>


</div></blockquote><div><br></div><div>But it still seems to be building a =
&quot;shared&quot; library for compat -- I get the following warning:</div>=
</blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px=
">

<blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div>*=
** Warning: Linking the shared library <a href=3D"http://libcompat.la">libc=
ompat.la</a> against the</div></div></blockquote><blockquote style=3D"margi=
n:0 0 0 40px;border:none;padding:0px">

<div><div>*** static library [path to] libcrypto.a is not portable!</div></=
div></blockquote>along with the same warning about libssl.a, liblzo2.a, and=
 libpkcs11-helper.a.<br><br></blockquote>Any help would be greatly apprecia=
ted.

--e89a8fb205cc396c8404c4f4df3a--

