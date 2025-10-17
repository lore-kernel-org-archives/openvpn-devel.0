From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 11:28:04 +0000
References: <gerrit.1760700482000.I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1c61546a06d48e6373709055a7e20c40f175f0ca-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+PWvktxOcyY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: route: Add
 #endif comment for uncrustify compliance
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+PWvktxOcyY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1284?usp=3Demail

to review the following change.


Change subject: route: Add #endif comment for uncrustify compliance
......................................................................

route: Add #endif comment for uncrustify compliance

Cherry-pick dca6b03098ab0f3ef808c891673305651dc6704a
broke uncrustify compliance. Apparently this one added
line pushed it over the limit to require the #endif
comment.

Change-Id: I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1284/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3ff9717..75e94c2 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2368,7 +2368,7 @@
     {
         gateway_needed =3D true;
     }
-#endif
+#endif /* ifndef _WIN32 */

     struct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1284?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4
Gerrit-Change-Number: 1284
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--+PWvktxOcyY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1284?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">route: Add #endif comment for uncrustify co=
mpliance<br><br>Cherry-pick dca6b03098ab0f3ef808c891673305651dc6704a<br>bro=
ke uncrustify compliance. Apparently this one added<br>line pushed it over =
the limit to require the #endif<br>comment.<br><br>Change-Id: I46d0e4be82a5=
cc7e466d6e8f658e5b131b5401c4<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed, 1 inserti=
on(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/84/1284/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/route.c b/src/openvpn/route.c</span><br><span>index 3ff9717..75e94c2 1006=
44</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/open=
vpn/route.c</span><br><span>@@ -2368,7 +2368,7 @@</span><br><span>     {</s=
pan><br><span>         gateway_needed =3D true;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef _WIN32 */</span><br><s=
pan> </span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     struct argv argv =3D argv_new();</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1284?usp=3D=
email">change 1284</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1284?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46d0e4be82a5cc7e466d6e8f658=
e5b131b5401c4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1284 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--+PWvktxOcyY=--

