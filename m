From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 10:39:06 +0000
In-Reply-To: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
References: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <00cac86cbc4ce4f09bc74f0ab54f2e2e564a5882-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fQhe9nHhSyQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE server:
 added new unit tests and improved documentation
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

--fQhe9nHhSyQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mrbff, plaisthos.

flichtenheld has posted comments on this change by mrbff. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1316?usp=3Demail )

Change subject: PUSH_UPDATE server: added new unit tests and improved docum=
entation
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File tests/unit_tests/openvpn/test_push_update_msg.c:

http://gerrit.openvpn.net/c/openvpn/+/1316/comment/c3c8a28a_a6ce6843?usp=3D=
email :
PS1, Line 147:                 printf("\n\nexpected_size: %lu\n  actual_siz=
e: %lu", res_len, str_len);
```suggestion
                printf("\n\nexpected_size: %zu\n  actual_size: %zu", res_le=
n, str_len);
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9
Gerrit-Change-Number: 1316
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Tue, 28 Oct 2025 10:39:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--fQhe9nHhSyQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: mrbff, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/t=
est_push_update_msg.c:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1316/comment/c3c8a28a_a6ce6=
843?usp=3Demail">Patch Set #1, Line 147:</a> <code style=3D"font-family:mon=
ospace,monospace">                printf(&quot;\n\nexpected_size: %lu\n  ac=
tual_size: %lu&quot;, res_len, str_len);</code></p><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">```suggest=
ion<br>                printf(&quot;\n\nexpected_size: %zu\n  actual_size: =
%zu&quot;, res_len, str_len);<br>```</pre></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail">cha=
nge 1316</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idba419681fe3ccc4e6e2f6ce759=
2332dcff62cd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1316 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Oct 2025 10:39:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--fQhe9nHhSyQ=--

