From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 May 2025 10:40:42 +0000
In-Reply-To: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
References: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...,
 gert@...1296...
Message-ID: <039123843a4f42e1864f4313b2b64ffb3c27a86a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iUHS09Tj6OI="; charset=UTF-8
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

--iUHS09Tj6OI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/791?usp=3Demail )

Change subject: Reformat the whole project with clang-format
......................................................................


Patch Set 19:

(4 comments)

File src/openvpn/buffer.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/5fa573c3_de511cf1 :
PS18, Line 850:     } while (c);
> Why?
As discussed on IRC this is actually correct for our current formatting.


http://gerrit.openvpn.net/c/openvpn/+/791/comment/5173a895_ec42235c :
PS18, Line 915:             && c !=3D 127)) /* allow ascii non-control and =
UTF-8, consider DEL to be a control */
> Yes.
Done in separate commit.


File src/openvpn/comp.h:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/ca6252bf_a8b50dfe :
PS18, Line 93: bool check_compression_settings_valid(struct compress_option=
s *info, int msglevel);
> this is one of the changes I'm not sure we want - having the return type =
on the line before gives us [=E2=80=A6]
As discussed in IRC this is consistent with what we have. Switched the .cla=
ng-format to use "AllDefinitions" instead which doesn't change anything but=
 better matches our policy.


File src/openvpn/console_builtin.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/9b83c0b1_41c7cd5f :
PS18, Line 74:         msg(M_WARN | M_ERRNO, "get_console_input_win32(): un=
expected error");
> Interestingly one of the things we can't configure in clang-format. [=E2=
=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b8973463404e3e
Gerrit-Change-Number: 791
Gerrit-PatchSet: 19
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Mon, 26 May 2025 10:40:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--iUHS09Tj6OI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/791/comment/5fa573c3_de511cf1">Patch Set #18, Line 850:</a=
> <code style=3D"font-family:monospace,monospace">    } while (c);</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">Why?</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">As discussed on IRC this is actually correct for our cur=
rent formatting.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/791/comment/5173a895_ec42235c">Patch Set #18, Line 915:</a> <code style=
=3D"font-family:monospace,monospace">            &amp;&amp; c !=3D 127)) /*=
 allow ascii non-control and UTF-8, consider DEL to be a control */</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Yes.</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done in separate commit.</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/comp.h:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/791/comment/ca6252bf_a8b50dfe">Patch Set #18, Line 93:</a> <code style=
=3D"font-family:monospace,monospace">bool check_compression_settings_valid(=
struct compress_options *info, int msglevel);</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this is=
 one of the changes I&#39;m not sure we want - having the return type on th=
e line before gives us [=E2=80=A6]</blockquote></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">As discussed in IRC this is consistent w=
ith what we have. Switched the .clang-format to use &quot;AllDefinitions&qu=
ot; instead which doesn&#39;t change anything but better matches our policy=
.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/console_builtin.c:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/9b83c0b1_41c7cd5f=
">Patch Set #18, Line 74:</a> <code style=3D"font-family:monospace,monospac=
e">        msg(M_WARN | M_ERRNO, &quot;get_console_input_win32(): unexpecte=
d error&quot;);</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">Interestingly one of the things we ca=
n&#39;t configure in clang-format. [=E2=80=A6]</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=
=3Demail">change 791</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b=
8973463404e3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 791 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 26 May 2025 10:40:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--iUHS09Tj6OI=--

