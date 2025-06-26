From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 26 Jun 2025 11:01:11 +0000
In-Reply-To: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
References: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <98d4cc7810f7b8eab67666f9efd3b85e79fc9301-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NlC7o2hSIfs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: create NRPT
 registry key if it doesn't exist
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NlC7o2hSIfs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1069?usp=3Demail )

Change subject: dns: create NRPT registry key if it doesn't exist
......................................................................


Patch Set 2: Code-Review-2

(1 comment)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/1069/comment/4e9b30f4_a9c94189 :
PS2, Line 2665:         err =3D RegCreateKeyExA(HKEY_LOCAL_MACHINE, sys_key=
, 0, NULL, 0, 0, NULL, &nrpt, NULL);
Doesn't work for me - the DnsPolicyConfig is created but no subkeys are pre=
sent. Also in Event Log there is:

openvpnserv error:
   DeleteNrptRules: could not open NRPT base key (5)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I46132ebaf3bf3b16798b6f2416f7bf7272f5646b
Gerrit-Change-Number: 1069
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Thu, 26 Jun 2025 11:01:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--NlC7o2hSIfs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactiv=
e.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1069/comment/4e9b30f4_a9c94189">Patch Set #2,=
 Line 2665:</a> <code style=3D"font-family:monospace,monospace">        err=
 =3D RegCreateKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, NULL, 0, 0, NULL, &amp=
;nrpt, NULL);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Doesn&#39;t work for me - the DnsPolicyConfig is created but no sub=
keys are present. Also in Event Log there is:</p><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">openvpnserv error:  <br>   De=
leteNrptRules: could not open NRPT base key (5)</pre></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1069?usp=
=3Demail">change 1069</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1069?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46132ebaf3bf3b16798b6f2416f=
7bf7272f5646b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Jun 2025 11:01:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--NlC7o2hSIfs=--

