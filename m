From: "mandree (Code Review)" <gerrit@...515...>
Date: Fri, 10 Apr 2026 13:41:04 +0000
In-Reply-To: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
References: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
Reply-To: matthias.andree@...68..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <cc86a45efc6e46e383c8a31ad2e1650b3a3bed9c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kPFvldnGhug="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kPFvldnGhug=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mandree has posted comments on this change by plaisthos. ( http://gerrit.op=
envpn.net/c/openvpn/+/1550?usp=3Demail )

Change subject: Try to emphasise the transition from old ovpn-dco to new ov=
pn module
......................................................................


Patch Set 5: Code-Review-2

(4 comments)

Patchset:

PS5:
Let's improve language before merging.


File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/1550/comment/e7879042_626b9a72?usp=3D=
email :
PS5, Line 57:     The OpenVPN DCO module has been merged into the Linux ker=
nel in 6.16.
```suggestion
    The OpenVPN DCO module has been merged into the Linux kernel as of 6.16.
```


http://gerrit.openvpn.net/c/openvpn/+/1550/comment/5f918724_336ce375?usp=3D=
email :
PS5, Line 58:     This required some API changes and OpenVPN 2.7 will only =
supports the
```suggestion
    This required some API changes and OpenVPN 2.7 will only support the
```


File doc/man-sections/advanced-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1550/comment/77ea989c_398c5871?usp=3D=
email :
PS5, Line 105:   ovpn module. The ovpn module is integrated into the Linux =
kernel
```suggestion
  ovpn module. The ovpn module has been integrated into the Linux kernel
```

(assuming it is still available)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072d7bf90133d328
Gerrit-Change-Number: 1550
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 10 Apr 2026 13:41:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--kPFvldnGhug=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1550?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Let&#39;s =
improve language before merging.</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File Changes.rst:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550/comment/e78=
79042_626b9a72?usp=3Demail">Patch Set #5, Line 57:</a> <code style=3D"font-=
family:monospace,monospace">    The OpenVPN DCO module has been merged into=
 the Linux kernel in 6.16.</code></p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">```suggestion<br>    The=
 OpenVPN DCO module has been merged into the Linux kernel as of 6.16.<br>``=
`</pre></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550/comme=
nt/5f918724_336ce375?usp=3Demail">Patch Set #5, Line 58:</a> <code style=3D=
"font-family:monospace,monospace">    This required some API changes and Op=
enVPN 2.7 will only supports the</code></p><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">```suggestion<br> =
   This required some API changes and OpenVPN 2.7 will only support the<br>=
```</pre></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/ma=
n-sections/advanced-options.rst:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550/comment/77ea=
989c_398c5871?usp=3Demail">Patch Set #5, Line 105:</a> <code style=3D"font-=
family:monospace,monospace">  ovpn module. The ovpn module is integrated in=
to the Linux kernel</code></p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">```suggestion<br>  ovpn module.=
 The ovpn module has been integrated into the Linux kernel<br>```</pre><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">(as=
suming it is still available)</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail">change 1550<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072=
d7bf90133d328 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mandree &lt;matthias.andree@...220...=
..68...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Apr 2026 13:41:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--kPFvldnGhug=--

