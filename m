MIME-Version: 1.0
Date: Fri, 9 Mar 2012 18:51:41 +0200
Message-ID: <CABT9mj_+3KRELoLQBGK5B14Q=Y_HGGjS48E6bEWnDPuCwBXgtw@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/mixed; boundary=0015174c382cff76db04bad234eb
Subject: [Openvpn-devel] mingw32-built openvpn-2.3-alpha1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0015174c382cff76db04bad234eb
Content-Type: multipart/alternative; boundary=0015174c382cff76ca04bad234e9

--0015174c382cff76ca04bad234e9
Content-Type: text/plain; charset=ISO-8859-1

Hi everyone,

First of all, let me say that I am delighted to see 2.3 approaching final
release. This is truly great.

Just wanted to let you know that there may be some rough edges when trying
to use the source tarball to compile openvpn using mingw32. I suppose
nobody uses mingw anymore, so this not too important, but anyway:

1.To get pass the ./configure phase in makeopenvpn, I had to insert a
CFLAGS=' -I /c/mingw/include/ddk' before the ./configure invocation. The
following check:

dnl ipv6 support
AC_CHECKING([for struct sockaddr_in6 for IPv6 support])
AC_CHECK_TYPE(
      [struct sockaddr_in6],
      [],
      [AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6
transport support.])],
      [#include "syshead.h"])

in configure.ac could not find the ntddndis.h (located among other places
in /c/mingw/include/ddk) which is included in syshead.h:357. Maybe the
configure.ac needs a little change but I'm not sure what change exactly.
Note, my installation used to be able to compile everything up to 2.2.1
without tinkering. Since these headers are a seemingly new requirement,
maybe a new command line option is needed in the configure script?

2.There is also a small error in makeopenvpn, in line 59, instead of
GENOUT, it says GENOOUT. Which, of course, leads to breakage :) Easily
fixed, that one.
3.Also, compiling OpenSSL from the source package leads to lib/ and bin/
directories under the openssl target path, so the relevant openvpn script
(getopenssl) needs adjustment. Attaching my version for your reference.
This is not strictly an error, just letting everyone know.

Best Regards,
-- 
Athanasios Douitsis

--0015174c382cff76ca04bad234e9
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everyone,<br><br>First of all, let me say that I am delighted to see 2.3=
 approaching final release. This is truly great. <br><br>Just wanted to let=
 you know that there may be some rough edges when trying to use the source =
tarball to compile openvpn using mingw32. I suppose nobody uses mingw anymo=
re, so this not too important, but anyway:<br>
<br>1.To get pass the ./configure phase in makeopenvpn, I had to insert a C=
FLAGS=3D&#39; -I /c/mingw/include/ddk&#39; before the ./configure invocatio=
n. The following check:<br><br>dnl ipv6 support<br>AC_CHECKING([for struct =
sockaddr_in6 for IPv6 support])<br>
AC_CHECK_TYPE(<br>=A0=A0=A0=A0=A0 [struct sockaddr_in6],<br>=A0=A0=A0=A0=A0=
 [],<br>=A0=A0=A0=A0=A0 [AC_MSG_ERROR([struct sockaddr_in6 not found, neede=
d for ipv6 transport support.])],<br>=A0=A0=A0=A0=A0 [#include &quot;syshea=
d.h&quot;])<br><br>in <a href=3D"http://configure.ac">configure.ac</a> coul=
d not find the ntddndis.h (located among other places in /c/mingw/include/d=
dk) which is included in syshead.h:357. Maybe the <a href=3D"http://configu=
re.ac">configure.ac</a> needs a little change but I&#39;m not sure what cha=
nge exactly. Note, my installation used to be able to compile everything up=
 to 2.2.1 without tinkering. Since these headers are a seemingly new requir=
ement, maybe a new command line option is needed in the configure script? <=
br>
<br>2.There is also a small error in makeopenvpn, in line 59, instead of GE=
NOUT, it says GENOOUT. Which, of course, leads to breakage :) Easily fixed,=
 that one. <br>3.Also, compiling OpenSSL from the source package leads to l=
ib/ and bin/ directories under the openssl target path, so the relevant ope=
nvpn script (getopenssl) needs adjustment. Attaching my version for your re=
ference. This is not strictly an error, just letting everyone know. <br>
<br>Best Regards,<br>-- <br>Athanasios Douitsis<br><br><br><br>

--0015174c382cff76ca04bad234e9--

--0015174c382cff76db04bad234eb
Content-Type: application/octet-stream; name=getopenssl
Content-Disposition: attachment; filename=getopenssl
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gzlgkwt30

IyEvYmluL3NoCgojIGdldCB2ZXJzaW9uLm5zaSBkZWZpbml0aW9ucwouIGF1dG9kZWZzL2RlZnMu
c2gKCiMgR2V0IE9wZW5TU0wgYmluYXJpZXMKaWYgWyAtZCAiJE9QRU5TU0xfRElSIiBdIDsgdGhl
bgogICAgbWtkaXIgLXAgJEdFTk9VVC9saWIgJj4vZGV2L251bGwgICAgCiAgICBta2RpciAtcCAk
R0VOT1VUL2JpbiAmPi9kZXYvbnVsbCAgICAKICAgIGZvciBmIGluIGJpbi9saWJlYXkzMi5kbGwg
YmluL3NzbGVheTMyLmRsbCBiaW4vb3BlbnNzbC5leGUgOyBkbwoJY3AgJE9QRU5TU0xfRElSLyRm
ICRHRU5PVVQvbGliCiAgICAgICAgaWYgWyAteiAiJE5PX1NUUklQIiBdOyB0aGVuCgkgICAgc3Ry
aXAgJEdFTk9VVC9saWIvYGJhc2VuYW1lICRmYAoJZmkKICAgIGRvbmUKICAgIG12ICRHRU5PVVQv
bGliL29wZW5zc2wuZXhlICRHRU5PVVQvYmluCmVsc2UKICAgIGVjaG8gT3BlblNTTCBESVIgJE9Q
RU5TU0xfRElSIE5PVCBGT1VORApmaQo=
--0015174c382cff76db04bad234eb--

