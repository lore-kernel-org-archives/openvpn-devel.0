From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 27 Nov 2024 11:41:18 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <62f8b2728ecea167f111bccf587c85bc1a78de86-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GvwA5PxjdTI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Allow
 OpenVPN in client mode to receive and handle PUSH ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GvwA5PxjdTI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/808?usp=3Demail )

Change subject: PUSH_UPDATE: Allow OpenVPN in client mode to receive and ha=
ndle PUSH UPDATE control messages to allow options updating at runtime.
......................................................................


Patch Set 4:

(7 comments)

File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/6208a664_8a387af8 :
PS4, Line 812:
nit: whitespace


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/4862d3bd_9b57ad9f :
PS4, Line 2033:             int status =3D do_route(&c->options, c->c1.rout=
e_list, c->c1.route_ipv6_list,
nice catch!


File src/openvpn/options_util.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/93ec136c_da93606f :
PS4, Line 124: check_push_update_option_flags(char **line, unsigned int *fl=
ags)
Add doxygen what does this function do.


http://gerrit.openvpn.net/c/openvpn/+/808/comment/cacb7fd2_2e6844f7 :
PS4, Line 138:         if (str[1])
below 8 lines are duplicated 3 times. Maybe define a macro and reuse it, an=
d later undefine? Like

#define ADVANCE_OR_FAIL(ptr) \
    do {                     \
        if (!(ptr)[1])       \
            return false;    \
        c =3D *(++(ptr));      \
    } while (0)


http://gerrit.openvpn.net/c/openvpn/+/808/comment/fc0ee113_1823490a :
PS4, Line 160:     if (c =3D=3D '-' && !(*flags & PUSH_OPT_TO_REMOVE))
you could remove the "c =3D=3D '-'" check here and move this whole block un=
der the "if" condition above


http://gerrit.openvpn.net/c/openvpn/+/808/comment/76877514_402d6e34 :
PS4, Line 221: apply_pull_filter(const struct options *o, char *line, bool =
is_update, unsigned int *push_update_option_flags)
Let's move doxygen to the header.


File src/openvpn/push.h:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/811984a2_89dbae3b :
PS4, Line 47: int process_incoming_push_update(struct context *c,
Doxygen



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Gerrit-Change-Number: 808
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Wed, 27 Nov 2024 11:41:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--GvwA5PxjdTI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">View C=
hange</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/808/comment/6208a664_8a387af8">Patch Set #4, Line 812:</a> <co=
de style=3D"font-family:monospace,monospace">    </code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">nit: whitespace</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/808/comment/4862d3bd_9b57ad9f">Patch Set #4, Line 2033:</=
a> <code style=3D"font-family:monospace,monospace">            int status =
=3D do_route(&amp;c-&gt;options, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_l=
ist,</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">n=
ice catch!</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/options_util.c:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/93ec136c_da=
93606f">Patch Set #4, Line 124:</a> <code style=3D"font-family:monospace,mo=
nospace">check_push_update_option_flags(char **line, unsigned int *flags)</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Add dox=
ygen what does this function do.</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/808/comment/cacb7fd2_2e6844f7">Patch Set #4, Line 138:</=
a> <code style=3D"font-family:monospace,monospace">        if (str[1])</cod=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">below 8 li=
nes are duplicated 3 times. Maybe define a macro and reuse it, and later un=
define? Like</p><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">#define ADVANCE_OR_FAIL(ptr) \<br>    do {                    =
 \<br>        if (!(ptr)[1])       \<br>            return false;    \<br> =
       c =3D *(++(ptr));      \<br>    } while (0)</pre></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/808/comment/fc0ee113_1823490a">Patch=
 Set #4, Line 160:</a> <code style=3D"font-family:monospace,monospace">    =
if (c =3D=3D &#39;-&#39; &amp;&amp; !(*flags &amp; PUSH_OPT_TO_REMOVE))</co=
de></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">you could=
 remove the &quot;c =3D=3D &#39;-&#39;&quot; check here and move this whole=
 block under the &quot;if&quot; condition above</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/808/comment/76877514_402d6e34">Patch Set =
#4, Line 221:</a> <code style=3D"font-family:monospace,monospace">apply_pul=
l_filter(const struct options *o, char *line, bool is_update, unsigned int =
*push_update_option_flags)</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Let&#39;s move doxygen to the header.</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push.h:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/808/comment/811984a2_89dbae3b">Patch Set #4, Line 47:</a> =
<code style=3D"font-family:monospace,monospace">int process_incoming_push_u=
pdate(struct context *c,</code></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Doxygen</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">change 808</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/808?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 27 Nov 2024 11:41:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--GvwA5PxjdTI=--

