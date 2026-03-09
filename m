From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 9 Mar 2026 12:52:28 +0000
In-Reply-To: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
References: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ed289ec27bc30ca510ca97b84dfe34504f31fc26-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZsRClrz0/FA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Try to emphasise the
 transition from old ovpn-dco to new ovpn module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZsRClrz0/FA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1550?usp=3Demail )

Change subject: Try to emphasise the transition from old ovpn-dco to new ov=
pn module
......................................................................


Patch Set 2:

(2 comments)

File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1550/comment/d69c5c22_e41422ac?usp=3D=
email :
PS2, Line 381:             msg(msglevel, "Interface %s exists and its not u=
sing "
> "its not using" -> "it's not using the" or "it doesn't use the"
Done


File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/1550/comment/f1eb5789_7fb2d671?usp=3D=
email :
PS2, Line 1244:                       "ovpn-backports to enable data channe=
l offload.");
> Replace redundant "data channel offload" with "enable it"?
enable it feels a bit too short here. I feel a bit better with repeating it=
 here to make it a more clear. But I rewrote the sentence to make it a less=
 annoying.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072d7bf90133d328
Gerrit-Change-Number: 1550
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 09 Mar 2026 12:52:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--ZsRClrz0/FA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1550/comment/d69c5c22_e41422ac?usp=3Demail">Patch Set #2, Li=
ne 381:</a> <code style=3D"font-family:monospace,monospace">            msg=
(msglevel, &quot;Interface %s exists and its not using &quot;</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">&quot;its not using&quot; -&gt; &quot;it&#39;s not using the&quot;=
 or &quot;it doesn&#39;t use the&quot;</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1550/comment/f1eb5789_7fb2d671?usp=3Demail">Patch S=
et #2, Line 1244:</a> <code style=3D"font-family:monospace,monospace">     =
                 &quot;ovpn-backports to enable data channel offload.&quot;=
);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">Replace redundant &quot;data channel offload&quot;=
 with &quot;enable it&quot;?</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">enable it feels a bit too sho=
rt here. I feel a bit better with repeating it here to make it a more clear=
. But I rewrote the sentence to make it a less annoying.</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/155=
0?usp=3Demail">change 1550</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072=
d7bf90133d328 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Mar 2026 12:52:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--ZsRClrz0/FA=--

