From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 14 Jan 2026 16:01:00 +0000
In-Reply-To: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
References: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <91f36730ba98e6875a23faf60dc0917f225e71db-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UIVUGDRr16g="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Silence compiler
 truncation warning by checking snprintf return value
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

--UIVUGDRr16g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1272?usp=3Demail )

Change subject: Silence compiler truncation warning by checking snprintf re=
turn value
......................................................................


Patch Set 3: Code-Review-1

(3 comments)

Patchset:

PS3:
Hi. Had ignored this for a while mostly because mingw 13.0.0 isn't present =
in our buildbot fleet, yet. But tested it now and it indeed resolves the is=
sue. But see comments about error handling.


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/1272/comment/8ce84b65_d5cb1a44?usp=3D=
email :
PS3, Line 3565: M_FATAL
I think M_FATAL is too drastic here. A continue would also be okay, like we=
 do for errors on RegOpenKeyEx a few lines below.


http://gerrit.openvpn.net/c/openvpn/+/1272/comment/3f5b513f_6359ba5c?usp=3D=
email :
PS3, Line 3680:             msg(M_FATAL, "Error constructing connection str=
ing for %s", enum_name);
I think M_FATAL is too drastic here. A continue would also be okay, like we=
 do for errors on RegOpenKeyEx a few lines below.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852
Gerrit-Change-Number: 1272
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 14 Jan 2026 16:01:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--UIVUGDRr16g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1272?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Hi. Had ig=
nored this for a while mostly because mingw 13.0.0 isn&#39;t present in our=
 buildbot fleet, yet. But tested it now and it indeed resolves the issue. B=
ut see comments about error handling.</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1272/=
comment/8ce84b65_d5cb1a44?usp=3Demail">Patch Set #3, Line 3565:</a> <code s=
tyle=3D"font-family:monospace,monospace">M_FATAL</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think M_FATAL=
 is too drastic here. A continue would also be okay, like we do for errors =
on RegOpenKeyEx a few lines below.</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1272/comment/3f5b513f_6359ba5c?usp=3Demail">Patch Set =
#3, Line 3680:</a> <code style=3D"font-family:monospace,monospace">        =
    msg(M_FATAL, &quot;Error constructing connection string for %s&quot;, e=
num_name);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I think M_FATAL is too drastic here. A continue would=
 also be okay, like we do for errors on RegOpenKeyEx a few lines below.</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1272?usp=3Demail">change 1272</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1272?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1=
e8678b24bd852 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1272 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 14 Jan 2026 16:01:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--UIVUGDRr16g=--

