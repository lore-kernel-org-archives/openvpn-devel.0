From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 13:28:02 +0000
In-Reply-To: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
References: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <9c1a0ee92af64f208626e1beb2c648f62fcadc08-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sk1zuwJIUYg="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sk1zuwJIUYg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/724?usp=3Demail )

Change subject: configure: Handle libnl-genl and libcap-ng consistent with =
other libs
......................................................................


Patch Set 3:

(3 comments)

Patchset:

PS3:
> Feature-ACK, but it does not work for me. [=E2=80=A6]
hmm, works for me.


File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/724/comment/a0cd9504_a65fc9b8 :
PS3, Line 1495: AC_SUBST([OPTIONAL_LIBNL_GENL_LIBS])
> so what are these needed for?  I see that the generated `src/openvpn/Make=
file` has both [=E2=80=A6]
Yeah, I assume this is related to that LIBNL_GENL_CFLAGS is automatically g=
enerated by PKG_CHECK_MODULES. The OPTIONAL_ makes sure we have a consisten=
t place to put the arguments that we completely control. But in this case I=
 just made the code consistent.


http://gerrit.openvpn.net/c/openvpn/+/724/comment/3aa88266_2f45c1c9 :
PS3, Line 1545: TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CM=
OCKA_CFLAGS}"
> This is `TEST_*` only, but shouldn't we have these for `AM_CFLAGS` and `o=
penvpn_LDADD` as well?
This is handled by the patch in Makefile.am



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Tue, 17 Sep 2024 13:28:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--sk1zuwJIUYg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
724?tab=3Dcomments">Patch Set #3:</a> </p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Feature-ACK, but it d=
oes not work for me. [=E2=80=A6]</blockquote></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">hmm, works for me.</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File configure.ac:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/724/comment/a0cd9504_a65fc9b8">Patch Set #3, Line 1495:</a> <code style=
=3D"font-family:monospace,monospace">AC_SUBST([OPTIONAL_LIBNL_GENL_LIBS])</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">so what are these needed for?  I see that the generate=
d `src/openvpn/Makefile` has both [=E2=80=A6]</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Yeah, I assume this is relate=
d to that LIBNL_GENL_CFLAGS is automatically generated by PKG_CHECK_MODULES=
. The OPTIONAL_ makes sure we have a consistent place to put the arguments =
that we completely control. But in this case I just made the code consisten=
t.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/724/comment=
/3aa88266_2f45c1c9">Patch Set #3, Line 1545:</a> <code style=3D"font-family=
:monospace,monospace">TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/i=
nclude ${CMOCKA_CFLAGS}&quot;</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is `TEST_*` only, =
but shouldn&#39;t we have these for `AM_CFLAGS` and `openvpn_LDADD` as well=
?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">This is handled by the patch in Makefile.am</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demai=
l">change 724</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Sep 2024 13:28:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--sk1zuwJIUYg=--

