From: "selvanair (Code Review)" <gerrit@...515...>
Date: Sat, 28 Mar 2026 15:49:29 +0000
In-Reply-To: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
References: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <b6f0f471986a357f2c248ec87588ae9f69936359-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oTHq/E1gJAk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: management: add
 password-base64 multi-line input for passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Bluca <luca.boccassi@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oTHq/E1gJAk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, plaisthos.

selvanair has posted comments on this change by Bluca. ( http://gerrit.open=
vpn.net/c/openvpn/+/1593?usp=3Demail )

Change subject: management: add password-base64 multi-line input for passwo=
rds
......................................................................


Patch Set 1:

(5 comments)

File doc/management-notes.txt:

http://gerrit.openvpn.net/c/openvpn/+/1593/comment/ec11ebed_489629cf?usp=3D=
email :
PS1, Line 329:   commands.
Update MANAGEMENT_VERSION to 6 and document that multi-line password suppor=
t requires daemon version >=3D 6.


File src/openvpn/manage.c:

http://gerrit.openvpn.net/c/openvpn/+/1593/comment/0fc3a710_af3796ab?usp=3D=
email :
PS1, Line 1029:  * @param type          The type of password being entered =
(e.g. "Auth", "TLS-Auth", etc)
Nitpick: "TLS-Auth" is not a valid type -- "Private Key" ?


http://gerrit.openvpn.net/c/openvpn/+/1593/comment/ce75309c_cca007a8?usp=3D=
email :
PS1, Line 1102:                     msg(M_CLIENT, "ERROR: could not base64-=
decode password");
This could lead to an unhelpful decode error or silent truncation which is =
hard to debug.

Instead, use a larger length like OPENVPN_BASE64_LENGTH(USER_PASS_LEN) + 10=
24 that will capture some of the excess data (if any), and then check OPENV=
PN_BASE64_DECODE_LENGTH(BLEN(buf)) < USER_PASS_LEN. On failure, return an E=
RROR message showing password is too long.


http://gerrit.openvpn.net/c/openvpn/+/1593/comment/13426238_dff01d9f?usp=3D=
email :
PS1, Line 1110:             secure_memzero(decoded, sizeof(decoded));
Also needs a buf_clear() somewhere as buf contains sensitive data.


http://gerrit.openvpn.net/c/openvpn/+/1593/comment/1de6799c_71c005a6?usp=3D=
email :
PS1, Line 1664:     else if (streq(p[0], "password-base64"))
As Gert suggested, we could use "password 'Type'" with no argument and inte=
rpret it differently based on the management-client-version (say MCV_MULTIL=
INE_PASSWORD). Better than introducing a different keyword?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233
Gerrit-Change-Number: 1593
Gerrit-PatchSet: 1
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Comment-Date: Sat, 28 Mar 2026 15:49:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--oTHq/E1gJAk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Bluca, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail">View =
Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes.txt:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1593/comment/ec11ebed_489629cf?usp=3Demail">Patch Set=
 #1, Line 329:</a> <code style=3D"font-family:monospace,monospace">  comman=
ds.</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Update MANAGEMENT_VERSION to 6 and document that multi-line =
password support requires daemon version &gt;=3D 6.</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1593/comment/0fc3a710_af3796ab?usp=3Demail">Patch Set #1, Line=
 1029:</a> <code style=3D"font-family:monospace,monospace"> * @param type  =
        The type of password being entered (e.g. &quot;Auth&quot;, &quot;TL=
S-Auth&quot;, etc)</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Nitpick: &quot;TLS-Auth&quot; is not a valid =
type -- &quot;Private Key&quot; ?</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1593/comment/ce75309c_cca007a8?usp=3Demail">Patch Set #=
1, Line 1102:</a> <code style=3D"font-family:monospace,monospace">         =
           msg(M_CLIENT, &quot;ERROR: could not base64-decode password&quot=
;);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">This could lead to an unhelpful decode error or silent trunc=
ation which is hard to debug.</p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Instead, use a larger length like OPENVPN=
_BASE64_LENGTH(USER_PASS_LEN) + 1024 that will capture some of the excess d=
ata (if any), and then check OPENVPN_BASE64_DECODE_LENGTH(BLEN(buf)) &lt; U=
SER_PASS_LEN. On failure, return an ERROR message showing password is too l=
ong.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593/comm=
ent/13426238_dff01d9f?usp=3Demail">Patch Set #1, Line 1110:</a> <code style=
=3D"font-family:monospace,monospace">            secure_memzero(decoded, si=
zeof(decoded));</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Also needs a buf_clear() somewhere as buf contai=
ns sensitive data.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1593/comment/1de6799c_71c005a6?usp=3Demail">Patch Set #1, Line 1664:</=
a> <code style=3D"font-family:monospace,monospace">    else if (streq(p[0],=
 &quot;password-base64&quot;))</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">As Gert suggested, we could use &=
quot;password &#39;Type&#39;&quot; with no argument and interpret it differ=
ently based on the management-client-version (say MCV_MULTILINE_PASSWORD). =
Better than introducing a different keyword?</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demai=
l">change 1593</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8e=
be21ac958f233 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1593 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Bluca &lt;luca.boccassi@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 28 Mar 2026 15:49:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--oTHq/E1gJAk=--

