From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 1 Oct 2025 15:10:50 +0000
In-Reply-To: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
References: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2b48590de5bc7668f6a0006572d5e22aae110e25-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VQynN2P4dyc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: PUSH_UPDATE:
 disabling PUSH_UPDATE server if DCO is enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VQynN2P4dyc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mrbff, plaisthos.

flichtenheld has posted comments on this change by mrbff. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1245?usp=3Demail )

Change subject: PUSH_UPDATE: disabling PUSH_UPDATE server if DCO is enabled
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1245/comment/901153d2_c4cc2b99?usp=3D=
email :
PS1, Line 304:                     " To send a PUSH_UPDATE message, be sure=
 to use the `--disable-dco` option.");
```suggestion
                    " To send a PUSH_UPDATE message, be sure to use the --d=
isable-dco option.");
```

Remove the quotes, we do not use them in other error messages.


http://gerrit.openvpn.net/c/openvpn/+/1245/comment/ff703365_a978f0ce?usp=3D=
email :
PS1, Line 320:                     " To send a PUSH_UPDATE message, be sure=
 to use the `--disable-dco` option.");
```suggestion
                    " To send a PUSH_UPDATE message, be sure to use the --d=
isable-dco option.");
```

Remove the quotes, we do not use them in other error messages.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibe78949435bb2f26ad68301e2710321bf37c9486
Gerrit-Change-Number: 1245
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Wed, 01 Oct 2025 15:10:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--VQynN2P4dyc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: mrbff, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_util.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1245/comment/901153d2_c4cc2b99?usp=3Demail">Patch =
Set #1, Line 304:</a> <code style=3D"font-family:monospace,monospace">     =
               &quot; To send a PUSH_UPDATE message, be sure to use the `--=
disable-dco` option.&quot;);</code></p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">```suggestion<br>     =
               &quot; To send a PUSH_UPDATE message, be sure to use the --d=
isable-dco option.&quot;);<br>```</pre><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Remove the quotes, we do not use th=
em in other error messages.</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1245/comment/ff703365_a978f0ce?usp=3Demail">Patch Set #1, Lin=
e 320:</a> <code style=3D"font-family:monospace,monospace">                =
    &quot; To send a PUSH_UPDATE message, be sure to use the `--disable-dco=
` option.&quot;);</code></p><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">```suggestion<br>                =
    &quot; To send a PUSH_UPDATE message, be sure to use the --disable-dco =
option.&quot;);<br>```</pre><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Remove the quotes, we do not use them in other=
 error messages.</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1245?usp=3Demail">change 1245</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1245?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe78949435bb2f26ad68301e271=
0321bf37c9486 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1245 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Oct 2025 15:10:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--VQynN2P4dyc=--

