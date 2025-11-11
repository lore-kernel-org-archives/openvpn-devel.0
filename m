From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 11:10:25 +0000
In-Reply-To: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
References: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7f5025e4cee0251f13cadc383bebadfc678b44a2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wb7lcOxRyxg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Fix conversion
 warning in tls_prepend_opcode_v1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wb7lcOxRyxg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1298?usp=3Demail )

Change subject: ssl: Fix conversion warning in tls_prepend_opcode_v1
......................................................................


Patch Set 3: Code-Review-1

(2 comments)

Patchset:

PS3:
I think the assert is wrong.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1298/comment/84eda4a7_8aea915f?usp=3D=
email :
PS3, Line 3985:     ASSERT(ks->key_id <=3D 1 << P_OPCODE_SHIFT);
Can we add brackets here? I find this a bit hard to read since the order of=
 <=3D and << is not so super obvious. Brackets would make this a bit nicer =
to read.

I think we should probably add a define to indicate the highest key ID, som=
ething like this:

/* packet opcode (high 5 bits) and key-id (low 3 bits) are combined in one =
byte */
#define P_KEY_ID_MASK  0x07
#define P_OPCODE_SHIFT 3
/* We use 3 bits for the key id which makes 7 the highest key id */
#define MAXIMUM_KEY_ID 7

I think this assert is also wrong since (1 << 3) =3D 8 and 8 is not an allo=
wed key id.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d
Gerrit-Change-Number: 1298
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 11 Nov 2025 11:10:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--wb7lcOxRyxg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1298?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think th=
e assert is wrong.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1298/comment/84eda4a7_8a=
ea915f?usp=3Demail">Patch Set #3, Line 3985:</a> <code style=3D"font-family=
:monospace,monospace">    ASSERT(ks-&gt;key_id &lt;=3D 1 &lt;&lt; P_OPCODE_=
SHIFT);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Can we add brackets here? I find this a bit hard to read=
 since the order of &lt;=3D and &lt;&lt; is not so super obvious. Brackets =
would make this a bit nicer to read.</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">I think we should probably add a d=
efine to indicate the highest key ID, something like this:</p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">/* packet op=
code (high 5 bits) and key-id (low 3 bits) are combined in one byte */<br>#=
define P_KEY_ID_MASK  0x07<br>#define P_OPCODE_SHIFT 3<br>/* We use 3 bits =
for the key id which makes 7 the highest key id */<br>#define MAXIMUM_KEY_I=
D 7</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">I think this assert is also wrong since (1 &lt;&lt; 3) =3D 8 and 8 =
is not an allowed key id.</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail">change 1298</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb438=
0ac91b09c1c8d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1298 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 11 Nov 2025 11:10:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--wb7lcOxRyxg=--

