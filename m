From: "ordex (Code Review)" <gerrit@...515...>
Date: Sat, 26 Jul 2025 00:01:20 +0000
References: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b6d7184cdb352cee6fd0a5eed009d5bd42ded04d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C8Y9Ndn/T4E="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: drop client
 prefix after DCO PEER_FLOAT notification
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--C8Y9Ndn/T4E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail

to review the following change.


Change subject: dco: drop client prefix after DCO PEER_FLOAT notification
......................................................................

dco: drop client prefix after DCO PEER_FLOAT notification

multi_process_float() will possibly float a client and
also generate and set its new prefix.

However, after processing the PEER_FLOAT_NTF message, we
were not clearing the prefix, thus effectivly making
the generated prefix permanent until the next set_prefix()
call.

Clear the prefix right after calling multi_process_float()
to avoid printing messages with the wrong prefix.

Github: closes OpenVPN/openvpn#799
Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/multi.c
1 file changed, 4 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1116/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d23aee7..32331d7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3417,6 +3417,10 @@
                                         &m->top.c2.from.dest,
                                         (struct sockaddr *)&dco->dco_float=
_peer_ss);
             multi_process_float(m, mi, mi->context.c2.link_sockets[0]);
+            /* multi_process_float() generated and set a new peer prefix, =
but we
+             * don't to keep it at this point.
+             */
+            clear_prefix();
             CLEAR(dco->dco_float_peer_ss);
         }
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24
Gerrit-Change-Number: 1116
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--C8Y9Ndn/T4E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco: drop client prefix after DCO PEER_FLOAT notification<br=
><br>multi_process_float() will possibly float a client and<br>also generat=
e and set its new prefix.<br><br>However, after processing the PEER_FLOAT_N=
TF message, we<br>were not clearing the prefix, thus effectivly making<br>t=
he generated prefix permanent until the next set_prefix()<br>call.<br><br>C=
lear the prefix right after calling multi_process_float()<br>to avoid print=
ing messages with the wrong prefix.<br><br>Github: closes OpenVPN/openvpn#7=
99<br>Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24<br>Signed-off-by=
: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/mult=
i.c<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br></pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1116/1</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index d23a=
ee7..32331d7 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><sp=
an>+++ b/src/openvpn/multi.c</span><br><span>@@ -3417,6 +3417,10 @@</span><=
br><span>                                         &amp;m-&gt;top.c2.from.de=
st,</span><br><span>                                         (struct sockad=
dr *)&amp;dco-&gt;dco_float_peer_ss);</span><br><span>             multi_pr=
ocess_float(m, mi, mi-&gt;context.c2.link_sockets[0]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /* multi_process_float() gen=
erated and set a new peer prefix, but we</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * don&#39;t to keep it at this point.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+             */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            clear_prefix();=
</span><br><span>             CLEAR(dco-&gt;dco_float_peer_ss);</span><br><=
span>         }</span><br><span> #endif /* if defined(TARGET_LINUX) || defi=
ned(TARGET_WIN32) */</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail">change 1116=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ad5df0f6785ffe9becd9f83329=
a9335d1a36f24 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1116 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--C8Y9Ndn/T4E=--

