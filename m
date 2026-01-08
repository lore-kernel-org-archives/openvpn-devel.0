From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 8 Jan 2026 17:27:48 +0000
In-Reply-To: <gerrit.1767808679000.I864cd4a718886f437b72e93d0286f90fcb73592b@...2715...>
References: <gerrit.1767808679000.I864cd4a718886f437b72e93d0286f90fcb73592b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ed0699a34d0cb737ffc9fb779986f796f024a63c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KIfmOoqUyB4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: Fix
 conversion warnings in interactive.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KIfmOoqUyB4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by flichtenheld. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1457?usp=3Demail )

Change subject: openvpnserv: Fix conversion warnings in interactive.c
......................................................................


Patch Set 3: Code-Review-1

(3 comments)

Patchset:

PS3:
Two comments, and I really think Heiko should have a look at these changes.


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/1457/comment/55b31c70_6a63bb5f?usp=3D=
email :
PS3, Line 1391: RegWStringLength(PCWSTR string)
I'd suggest to name that `RegWStringSize()` - d12fk has tried to make every=
thing that is a "number of bytes in memory" named "xxxsize", and everything=
 that is "length of glyphs in a whatever-string" a "xxxlength".  So this wo=
uld be a "size" function.

(Also for `length` inside the function, as soon as `wcslen()` is multiplied=
 it's not longer a "length" in that terminology)


http://gerrit.openvpn.net/c/openvpn/+/1457/comment/6dd9276d_710aa1d2?usp=3D=
email :
PS3, Line 1744: static LSTATUS
why is that change?  We have a `DWORD err` and return that?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1457?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I864cd4a718886f437b72e93d0286f90fcb73592b
Gerrit-Change-Number: 1457
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 08 Jan 2026 17:27:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--KIfmOoqUyB4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1457?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1457?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Two commen=
ts, and I really think Heiko should have a look at these changes.</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/inter=
active.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1457/comment/55b31c70_6a63bb5f?usp=3Dema=
il">Patch Set #3, Line 1391:</a> <code style=3D"font-family:monospace,monos=
pace">RegWStringLength(PCWSTR string)</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;d suggest to name =
that `RegWStringSize()` - d12fk has tried to make everything that is a &quo=
t;number of bytes in memory&quot; named &quot;xxxsize&quot;, and everything=
 that is &quot;length of glyphs in a whatever-string&quot; a &quot;xxxlengt=
h&quot;.  So this would be a &quot;size&quot; function.</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">(Also for `leng=
th` inside the function, as soon as `wcslen()` is multiplied it&#39;s not l=
onger a &quot;length&quot; in that terminology)</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1457/comment/6dd9276d_710aa1d2?usp=3Demai=
l">Patch Set #3, Line 1744:</a> <code style=3D"font-family:monospace,monosp=
ace">static LSTATUS</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">why is that change?  We have a `DWORD err` a=
nd return that?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1457?usp=3Demail">change 1457</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1457?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I864cd4a718886f437b72e93d028=
6f90fcb73592b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1457 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 08 Jan 2026 17:27:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--KIfmOoqUyB4=--

