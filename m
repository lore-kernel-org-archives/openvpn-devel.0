From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 May 2025 09:54:45 +0000
In-Reply-To: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
References: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...,
 gert@...1296...
Message-ID: <84229678ef8ca7dd8c42558da105529b6c410592-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="snb4Tc2NWDo="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--snb4Tc2NWDo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/791?usp=3Demail )

Change subject: Reformat the whole project with clang-format
......................................................................


Patch Set 18:

(3 comments)

File src/openvpn/buffer.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/6892fcb6_41f2daaf :
PS18, Line 850:     } while (c);
> it should not do that
Why?


http://gerrit.openvpn.net/c/openvpn/+/791/comment/18dc39e2_b722d6bf :
PS18, Line 915:             && c !=3D 127)) /* allow ascii non-control and =
UTF-8, consider DEL to be a control */
> this is ugly, but I guess the best way to fix it is to manually move the =
comment before the if() lin [=E2=80=A6]
Yes.


File src/openvpn/console_builtin.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/e785d1b2_41139a46 :
PS18, Line 74:         msg(M_WARN | M_ERRNO, "get_console_input_win32(): un=
expected error");
> the extra spaces around `foo|bar` are not really to my liking ("this belo=
ngs together" vibes)
Interestingly one of the things we can't configure in clang-format. The spa=
ce around binary operators is not optional.



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Mon, 26 May 2025 09:54:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--snb4Tc2NWDo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/791/comment/6892fcb6_41f2daaf">Patch Set #18, Line 850:</a=
> <code style=3D"font-family:monospace,monospace">    } while (c);</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">it should not do that</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Why?</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/791/comment/18dc39e2_b722d6bf">Patch Set #18, Li=
ne 915:</a> <code style=3D"font-family:monospace,monospace">            &am=
p;&amp; c !=3D 127)) /* allow ascii non-control and UTF-8, consider DEL to =
be a control */</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">this is ugly, but I guess the best wa=
y to fix it is to manually move the comment before the if() lin [=E2=80=A6]=
</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Yes.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/console_builtin.c:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/e785d1b2_4113=
9a46">Patch Set #18, Line 74:</a> <code style=3D"font-family:monospace,mono=
space">        msg(M_WARN | M_ERRNO, &quot;get_console_input_win32(): unexp=
ected error&quot;);</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">the extra spaces around `foo|bar`=
 are not really to my liking (&quot;this belongs together&quot; vibes)</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Inte=
restingly one of the things we can&#39;t configure in clang-format. The spa=
ce around binary operators is not optional.</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail"=
>change 791</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 26 May 2025 09:54:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--snb4Tc2NWDo=--

