From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 13:12:04 +0000
In-Reply-To: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
References: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <33625af17667f4664d3191437f7b003eb61683e9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t7aafw2Fk/0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Handle
 libnl-genl and libcap-ng consistent with other libs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--t7aafw2Fk/0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/724?usp=3Demail )

Change subject: configure: Handle libnl-genl and libcap-ng consistent with =
other libs
......................................................................


Patch Set 3: Code-Review-1

(3 comments)

Patchset:

PS3:
Feature-ACK, but it does not work for me.

I applied this against 14d2db6cd41fb6 on Ubuntu 20.04, did `autoreconf -vif=
` then `configure`, `make`, and it fails for me with

```
gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include -I../../sr=
c/compat    -I/usr/include/lzo    -DPLUGIN_LIBDIR=3D\"/usr/local/lib/openvp=
n/plugins\"  -Wall -Wno-stringop-truncation -g -O2 -std=3Dc11 -MT options.o=
 -MD -MP -MF $depbase.Tpo -c -o options.o options.c &&\
mv -f $depbase.Tpo $depbase.Po
In file included from dco_internal.h:31,
                 from dco.h:31,
                 from tun.h:43,
                 from socket.h:37,
                 from ssl.h:38,
                 from options.c:45:
dco_linux.h:31:10: fatal error: netlink/socket.h: No such file or directory
   31 | #include <netlink/socket.h>
      |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
```
because the LIBNL_GENL_CFLAGS do not show up on the gcc command line...


File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/724/comment/546e2b93_7afac6b6 :
PS3, Line 1495: AC_SUBST([OPTIONAL_LIBNL_GENL_LIBS])
so what are these needed for?  I see that the generated `src/openvpn/Makefi=
le` has both

```
LIBNL_GENL_CFLAGS =3D -I/usr/include/libnl3
LIBNL_GENL_LIBS =3D -lnl-genl-3 -lnl-3
```
and
```
OPTIONAL_LIBNL_GENL_CFLAGS =3D -I/usr/include/libnl3
OPTIONAL_LIBNL_GENL_LIBS =3D -lnl-genl-3 -lnl-3
```
so this seems slightly redundant...


http://gerrit.openvpn.net/c/openvpn/+/724/comment/97ee1a30_d7a7fbe2 :
PS3, Line 1545: TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CM=
OCKA_CFLAGS}"
This is `TEST_*` only, but shouldn't we have these for `AM_CFLAGS` and `ope=
nvpn_LDADD` as well?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe
Gerrit-Change-Number: 724
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 17 Sep 2024 13:12:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--t7aafw2Fk/0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/724?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Feature-ACK, but it does not work for me.</p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">I applied this a=
gainst 14d2db6cd41fb6 on Ubuntu 20.04, did `autoreconf -vif` then `configur=
e`, `make`, and it fails for me with</p><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">```<br>gcc -DHAVE_CONFIG_H -I. -I../..=
 -I../../include  -I../../include -I../../src/compat    -I/usr/include/lzo =
   -DPLUGIN_LIBDIR=3D\&quot;/usr/local/lib/openvpn/plugins\&quot;  -Wall -W=
no-stringop-truncation -g -O2 -std=3Dc11 -MT options.o -MD -MP -MF $depbase=
.Tpo -c -o options.o options.c &amp;&amp;\<br>mv -f $depbase.Tpo $depbase.P=
o<br>In file included from dco_internal.h:31,<br>                 from dco.=
h:31,<br>                 from tun.h:43,<br>                 from socket.h:=
37,<br>                 from ssl.h:38,<br>                 from options.c:4=
5:<br>dco_linux.h:31:10: fatal error: netlink/socket.h: No such file or dir=
ectory<br>   31 | #include &lt;netlink/socket.h&gt;<br>      |          ^~~=
~~~~~~~~~~~~~~~<br>compilation terminated.<br>```<br>because the LIBNL_GENL=
_CFLAGS do not show up on the gcc command line...</pre></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File configure.ac:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/724/comment/546e2b93_7afac6b6">Patch Set #3, Line 1495:</a> <code style=
=3D"font-family:monospace,monospace">AC_SUBST([OPTIONAL_LIBNL_GENL_LIBS])</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">so what=
 are these needed for?  I see that the generated `src/openvpn/Makefile` has=
 both</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>=
LIBNL_GENL_CFLAGS =3D -I/usr/include/libnl3<br>LIBNL_GENL_LIBS =3D -lnl-gen=
l-3 -lnl-3<br>```<br>and<br>```<br>OPTIONAL_LIBNL_GENL_CFLAGS =3D -I/usr/in=
clude/libnl3<br>OPTIONAL_LIBNL_GENL_LIBS =3D -lnl-genl-3 -lnl-3<br>```<br>s=
o this seems slightly redundant...</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/724/comment/97ee1a30_d7a7fbe2">Patch Set #3, Line 1545=
:</a> <code style=3D"font-family:monospace,monospace">TEST_CFLAGS=3D&quot;$=
{TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}&quot;</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">This is `TEST_*` on=
ly, but shouldn&#39;t we have these for `AM_CFLAGS` and `openvpn_LDADD` as =
well?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/724?usp=3Demail">change 724</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/724?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39a6f58b11b922f5dbd3e55a5bc=
8574eda8a83fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 724 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Sep 2024 13:12:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--t7aafw2Fk/0=--

