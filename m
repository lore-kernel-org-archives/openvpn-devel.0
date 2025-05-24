From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 24 May 2025 14:14:08 +0000
In-Reply-To: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
References: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <0046e185200475ca98671ff12a9639846b2ed5d0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dpcVpZsrIZA="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Reformat the whole
 project with clang-format
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

--dpcVpZsrIZA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/791?usp=3Demail )

Change subject: Reformat the whole project with clang-format
......................................................................


Patch Set 18:

(5 comments)

Patchset:

PS18:
Overall this is impressively good.  Some changes (struct opening bracket) s=
hould have been done all along :-) - others just make sense.  I have a few =
that I do not like and I think one actual bug in the ruleset (`do...while()=
` in buffer.c).


File src/openvpn/buffer.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/e228108e_a877cddf :
PS18, Line 850:     } while (c);
it should not do that


http://gerrit.openvpn.net/c/openvpn/+/791/comment/450ac52e_57fa1b4a :
PS18, Line 915:             && c !=3D 127)) /* allow ascii non-control and =
UTF-8, consider DEL to be a control */
this is ugly, but I guess the best way to fix it is to manually move the co=
mment before the if() line


File src/openvpn/comp.h:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/07c11cf5_a35c47d6 :
PS18, Line 93: bool check_compression_settings_valid(struct compress_option=
s *info, int msglevel);
this is one of the changes I'm not sure we want - having the return type on=
 the line before gives us more line length for the actual prototype, and al=
so it eases "grep ^function" to find prototype + function implementation (m=
y use case, which I could certainly solve differently)


File src/openvpn/console_builtin.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/ecc1640a_115b4d7b :
PS18, Line 74:         msg(M_WARN | M_ERRNO, "get_console_input_win32(): un=
expected error");
the extra spaces around `foo|bar` are not really to my liking ("this belong=
s together" vibes)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b8973463404e3e
Gerrit-Change-Number: 791
Gerrit-PatchSet: 18
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Sat, 24 May 2025 14:14:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--dpcVpZsrIZA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
791?tab=3Dcomments">Patch Set #18:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Overall this is impressively good.  Some changes=
 (struct opening bracket) should have been done all along :-) - others just=
 make sense.  I have a few that I do not like and I think one actual bug in=
 the ruleset (`do...while()` in buffer.c).</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/buffer.c:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/791/comment/e228108e_a877cddf">Patch Set #18, Line 850:</a> <code style=
=3D"font-family:monospace,monospace">    } while (c);</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">it should not do that</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/450ac52=
e_57fa1b4a">Patch Set #18, Line 915:</a> <code style=3D"font-family:monospa=
ce,monospace">            &amp;&amp; c !=3D 127)) /* allow ascii non-contro=
l and UTF-8, consider DEL to be a control */</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">this is ugly, but I guess the best w=
ay to fix it is to manually move the comment before the if() line</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/comp.h:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/791/comment/07c11cf5_a35c47d6">Patch Set #18, Line =
93:</a> <code style=3D"font-family:monospace,monospace">bool check_compress=
ion_settings_valid(struct compress_options *info, int msglevel);</code></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">this is one of t=
he changes I&#39;m not sure we want - having the return type on the line be=
fore gives us more line length for the actual prototype, and also it eases =
&quot;grep ^function&quot; to find prototype + function implementation (my =
use case, which I could certainly solve differently)</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/console_builtin.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/791/comment/ecc1640a_115b4d7b">Patch Set #18, Line 74=
:</a> <code style=3D"font-family:monospace,monospace">        msg(M_WARN | =
M_ERRNO, &quot;get_console_input_win32(): unexpected error&quot;);</code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">the extra spac=
es around `foo|bar` are not really to my liking (&quot;this belongs togethe=
r&quot; vibes)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/791?usp=3Demail">change 791</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/791?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b=
8973463404e3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 791 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 24 May 2025 14:14:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--dpcVpZsrIZA=--

