From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Apr 2024 08:22:27 +0000
In-Reply-To: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
References: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <030e46e8d57edd744de5187cf6b22e6e636b0e96-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q+zpxFVjUhM="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove
 openvpn_snprintf and similar functions
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

--Q+zpxFVjUhM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/547?usp=3Demail )

Change subject: Remove openvpn_snprintf and similar functions
......................................................................


Patch Set 2: Code-Review-1

(3 comments)

Patchset:

PS2:
Unfortunately, this fails -Werror msbuild builds now, see comment in intera=
ctive.c


File src/openvpn/proxy.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/b37effa6_d450b13a :
PS2, Line 962:                 if (sret >=3D sizeof(buf))
> if this can truly happen, does it mean that the buffer is undersized comp=
ared to the size of all var [=E2=80=A6]
this code is not part of the actual patchset, but a gerrit artefact due to =
rebasing.  *This* patchset only replaces openvpn_snprintf() with snprintf().


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/918c9772_0150ba41 :
PS2, Line 2007:              sud.options, svc_pipe);
This makes GHA msbuild build fails now, with

```
 D:\a\openvpn\openvpn\src\openvpnserv\interactive.c(2006,37): warning C4477=
: 'swprintf' : format string '%llu' requires an argument of type 'unsigned =
__int64', but variadic argument 2 has type 'HANDLE' [D:\a\openvpn\openvpn\o=
ut\build\win-amd64-release\src\openvpnserv\openvpnserv.vcxproj]
 ```

 so it seems the cast to something-int (`DWORD`?) is needed.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07096977e3b562bcb5d2c6f11673a4175b8e12ac
Gerrit-Change-Number: 547
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 08 Apr 2024 08:22:27 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--Q+zpxFVjUhM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/547?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Unfortunately, this fails -Werror msbuild bui=
lds now, see comment in interactive.c</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/proxy.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
47/comment/b37effa6_d450b13a">Patch Set #2, Line 962:</a> <code style=3D"fo=
nt-family:monospace,monospace">                if (sret &gt;=3D sizeof(buf)=
)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">if this can truly happen, does it mean that the buf=
fer is undersized compared to the size of all var [=E2=80=A6]</blockquote><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this code is =
not part of the actual patchset, but a gerrit artefact due to rebasing.  *T=
his* patchset only replaces openvpn_snprintf() with snprintf().</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interac=
tive.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/547/comment/918c9772_0150ba41">Patch Set #=
2, Line 2007:</a> <code style=3D"font-family:monospace,monospace">         =
    sud.options, svc_pipe);</code></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">This makes GHA msbuild build fails now, with</p><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br> =
D:\a\openvpn\openvpn\src\openvpnserv\interactive.c(2006,37): warning C4477:=
 &#39;swprintf&#39; : format string &#39;%llu&#39; requires an argument of =
type &#39;unsigned __int64&#39;, but variadic argument 2 has type &#39;HAND=
LE&#39; [D:\a\openvpn\openvpn\out\build\win-amd64-release\src\openvpnserv\o=
penvpnserv.vcxproj]<br> ```<br> <br> so it seems the cast to something-int =
(`DWORD`?) is needed.</pre></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">change 547</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/547?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07096977e3b562bcb5d2c6f1167=
3a4175b8e12ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Apr 2024 08:22:27=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Q+zpxFVjUhM=--

