From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 12:03:01 +0000
In-Reply-To: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
References: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d8c05c3eb0bdb4c146f8072c555a21718132d615-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XiL0iC6cp30="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: PUSH_UPDATE server:
 check IV_PROTO before sending the message to the ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XiL0iC6cp30=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

ordex has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1255?usp=3Demail )

Change subject: PUSH_UPDATE server: check IV_PROTO before sending the messa=
ge to the client
......................................................................


Patch Set 1: Code-Review-2

(3 comments)

File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1255/comment/af9bdc8d_7673d872?usp=3D=
email :
PS1, Line 204:         msg(M_CLIENT, "ERROR: Peer ID: %u does not support p=
ush-update",
I'd remove the "ERROR:" label - this is just an information that we have un=
supported clients connected and they won't receive the message.

maybe something: "PUSH_UPDATE: not sending message to unsupported peer with=
 ID %u"?


http://gerrit.openvpn.net/c/openvpn/+/1255/comment/352256e9_45e6f7bc?usp=3D=
email :
PS1, Line 205:             mi->context.c2.tls_multi ? mi->context.c2.tls_mu=
lti->peer_id : UINT32_MAX);
you just dereferenced "tls_multi" a few lines above, therefore it must be n=
on-NULL at this point.
If you believe it can be NULL, this check should happen earlier on. But can=
 it really happen? I am not sure.


http://gerrit.openvpn.net/c/openvpn/+/1255/comment/ac206d3c_e8cbc84e?usp=3D=
email :
PS1, Line 252:             gc_free(&gc);
am I wrong or this is totally unrelated?
It still seems a valid fix, but please submit it in its own patch.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec
Gerrit-Change-Number: 1255
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Wed, 08 Oct 2025 12:03:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--XiL0iC6cp30=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_util.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1255/comment/af9bdc8d_7673d872?usp=3Demail">Patch =
Set #1, Line 204:</a> <code style=3D"font-family:monospace,monospace">     =
   msg(M_CLIENT, &quot;ERROR: Peer ID: %u does not support push-update&quot=
;,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">I&#39;d remove the &quot;ERROR:&quot; label - this is just an=
 information that we have unsupported clients connected and they won&#39;t =
receive the message.</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">maybe something: &quot;PUSH_UPDATE: not sending me=
ssage to unsupported peer with ID %u&quot;?</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1255/comment/352256e9_45e6f7bc?usp=3Demail">P=
atch Set #1, Line 205:</a> <code style=3D"font-family:monospace,monospace">=
            mi-&gt;context.c2.tls_multi ? mi-&gt;context.c2.tls_multi-&gt;p=
eer_id : UINT32_MAX);</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">you just dereferenced &quot;tls_multi&quot=
; a few lines above, therefore it must be non-NULL at this point.<br>If you=
 believe it can be NULL, this check should happen earlier on. But can it re=
ally happen? I am not sure.</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1255/comment/ac206d3c_e8cbc84e?usp=3Demail">Patch Set #1, Lin=
e 252:</a> <code style=3D"font-family:monospace,monospace">            gc_f=
ree(&amp;gc);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">am I wrong or this is totally unrelated?<br>It sti=
ll seems a valid fix, but please submit it in its own patch.</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1255?usp=3Demail">change 1255</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
55?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc=
65f2959227bec </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1255 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Oct 2025 12:03:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--XiL0iC6cp30=--

