From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 21 Jul 2025 18:25:37 +0000
In-Reply-To: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
References: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <7f8bf5994ef167a8e7cd30790096e07fff66a3c4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X1WAXBx0lGY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Added
 remove_option() and do_update().
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X1WAXBx0lGY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/809?usp=3Demail )

Change subject: PUSH_UPDATE: Added remove_option() and do_update().
......................................................................


Patch Set 21: Code-Review-1

(4 comments)

Patchset:

PS21:=20
As discussed on IRC, I do have some things I'd like to see changed before m=
erging.

I am taking note of the +2's already given, it's just polishing, comments, =
readability...


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/809/comment/20d8d7ae_599aaf68 :
PS21, Line 2833:         if (!is_update && !check_pull_client_ncp(c, found))
does it make sense to suppress this check?  It should never fail, and never=
 modify anything (as we passed on the first run).

As it is, this code is a bit confusing, so we'd need a comment

```
    /* on PUSH_UPDATE, do not run the NCP checks, because they take 5 minut=
es
     * to complete and we are in a hurry
     */
```

(put the real reasoning there, of course ;-) )

Mmmh, I think I see the reason, OPT_P_NCP is not set on PUSH_UPDATE, so the=
 code assumes "we have no cipher" and does fallback things... so the commen=
t would need to be something like

```
    /* on PUSH_UPDATE, NCP related flags are never updated, and so the code
     * would assume "no cipher pushed =3D NCP failed" - so, don't call it on
     * updates */
```


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/809/comment/758d81ff_703882a6 :
PS21, Line 5502: options_server_import(struct options *o,
please do not move them (as for 808).  thanks :-)


http://gerrit.openvpn.net/c/openvpn/+/809/comment/dbc0b2a7_f3d837dd :
PS21, Line 3134:     }
with the extra code, the comment before the function is no longer appropria=
te.

Also, it's unclear to me why this is needed?  I'm not guessing the reasonin=
g but claiming "this does not look reasonable" - if `redirect-gateway def1`=
 was pushed or updated, we should not remove it again just because it's not=
 METHOD_SERVICE?

If we need it, we definitely need a comment to explain why.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I507180d7397b6959844a30908010132bc3411067
Gerrit-Change-Number: 809
Gerrit-PatchSet: 21
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Mon, 21 Jul 2025 18:25:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--X1WAXBx0lGY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>Patch set 21:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/809?tab=3Dcomments">Patch Set #21:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">As discussed on IRC, I do have some things =
I&#39;d like to see changed before merging.</p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">I am taking note of the +2&#39;s already giv=
en, it&#39;s just polishing, comments, readability...</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/809/comment/20d8d7ae_599aaf68">Patch Set #21, Line 2833:</a> <=
code style=3D"font-family:monospace,monospace">        if (!is_update &amp;=
&amp; !check_pull_client_ncp(c, found))</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">does it make sense to suppress this check=
?  It should never fail, and never modify anything (as we passed on the fir=
st run).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">As i=
t is, this code is a bit confusing, so we&#39;d need a comment</p><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br>    /=
* on PUSH_UPDATE, do not run the NCP checks, because they take 5 minutes<br=
>     * to complete and we are in a hurry<br>     */<br>```</pre><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">(put the real reasoning =
there, of course ;-) )</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Mmmh, I think I see the reason, OPT_P_NCP is not set on PUSH_UPDA=
TE, so the code assumes &quot;we have no cipher&quot; and does fallback thi=
ngs... so the comment would need to be something like</p><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">```<br>    /* on PUSH=
_UPDATE, NCP related flags are never updated, and so the code<br>     * wou=
ld assume &quot;no cipher pushed =3D NCP failed&quot; - so, don&#39;t call =
it on<br>     * updates */<br>```</pre></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
09/comment/758d81ff_703882a6">Patch Set #21, Line 5502:</a> <code style=3D"=
font-family:monospace,monospace">options_server_import(struct options *o,</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">please =
do not move them (as for 808).  thanks :-)</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/809/comment/dbc0b2a7_f3d837dd">Patch Set #21, =
Line 3134:</a> <code style=3D"font-family:monospace,monospace">    }</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">with the ext=
ra code, the comment before the function is no longer appropriate.</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Also, it&#39;s unclea=
r to me why this is needed?  I&#39;m not guessing the reasoning but claimin=
g &quot;this does not look reasonable&quot; - if `redirect-gateway def1` wa=
s pushed or updated, we should not remove it again just because it&#39;s no=
t METHOD_SERVICE?</p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">If we need it, we definitely need a comment to explain why.</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/809?usp=3Demail">change 809</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I507180d7397b6959844a3090801=
0132bc3411067 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 809 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Jul 2025 18:25:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--X1WAXBx0lGY=--

