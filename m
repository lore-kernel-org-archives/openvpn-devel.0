From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 9 Feb 2024 14:59:38 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <602a3af91576b711eb74eefadd5711c7ed22b65d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8FjjQgRgaRE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement support
 for AEAD tag at the end
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8FjjQgRgaRE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/506?usp=3Demail )

Change subject: Implement support for AEAD tag at the end
......................................................................


Patch Set 3:

(5 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/008126a3_c9aca210 :
PS2, Line 8:
> Maybe some motivation?
Done


http://gerrit.openvpn.net/c/openvpn/+/506/comment/529bb2f4_83e37dd3 :
PS2, Line 9: Change-Id: I00821d75342daf3f813b829812d648fe298bea81
> Missing sign-off
Done


File src/openvpn/ssl.h:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/42ec6996_93fc2b0d :
PS2, Line 110: /** Suport for the AEAD tag at the end a larger peer id and =
IV */
> "a" -> "and"
Done


http://gerrit.openvpn.net/c/openvpn/+/506/comment/c4efc0b2_472126be :
PS2, Line 111: #define IV_PROTO_DATA_V3        (1<<10)
> This define seems unused in the current patch?
Done


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/cd150f1a_9bbdf41a :
PS2, Line 269: /* This adds a few more methods that strictly necessary but =
this allows
> "that" -> "than"?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Gerrit-Change-Number: 506
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 09 Feb 2024 14:59:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--8FjjQgRgaRE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/506/comment/008126a3_c9aca210">Patch Set #2, Line 8:</a> <code style=
=3D"font-family:monospace,monospace"></code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Maybe some moti=
vation?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
06/comment/529bb2f4_83e37dd3">Patch Set #2, Line 9:</a> <code style=3D"font=
-family:monospace,monospace">Change-Id: I00821d75342daf3f813b829812d648fe29=
8bea81</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Missing sign-off</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.h:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/506/comment/42ec6996_93fc2b0d">Patch Set #2, Line 110:</a> <code st=
yle=3D"font-family:monospace,monospace">/** Suport for the AEAD tag at the =
end a larger peer id and IV */</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;a&quot; -&gt; &q=
uot;and&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/506/comment/c4efc0b2_472126be">Patch Set #2, Line 111:</a> <code style=
=3D"font-family:monospace,monospace">#define IV_PROTO_DATA_V3        (1&lt;=
&lt;10)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">This define seems unused in the current patch=
?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests=
/unit_tests/openvpn/test_ssl.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506/comment/cd150f=
1a_9bbdf41a">Patch Set #2, Line 269:</a> <code style=3D"font-family:monospa=
ce,monospace">/* This adds a few more methods that strictly necessary but t=
his allows</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">&quot;that&quot; -&gt; &quot;than&quot;?</=
blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">D=
one</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/506?usp=3Demail">change 506</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/506?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 09 Feb 2024 14:59:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--8FjjQgRgaRE=--

