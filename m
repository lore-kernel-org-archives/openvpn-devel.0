From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 20 Oct 2025 14:57:01 +0000
In-Reply-To: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
References: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5b50a3b2dc711c7b36022e9387e109db3d945fbc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qP7QLSE6ykk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Warn if push is used
 without --mode server/--server/--server-bridge
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

--qP7QLSE6ykk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1288?usp=3Demail )

Change subject: Warn if push is used without --mode server/--server/--serve=
r-bridge
......................................................................


Patch Set 1: Code-Review-1

(4 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1288/comment/f7cedb8d_5f290a51?usp=3D=
email :
PS1, Line 14: Also remove an used macro.
"unused" I assume


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1288/comment/d6b588cf_299e97fa?usp=3D=
email :
PS1, Line 3337:
whitespace


http://gerrit.openvpn.net/c/openvpn/+/1288/comment/bf2317ec_7c3577ee?usp=3D=
email :
PS1, Line 3338:     if (o->push_list.head && o->mode !=3D MODE_SERVER)
We have a lot of warnings and errors that we potentially throw if not in --=
mode server, see code around line 2650. Maybe this new check would be bette=
r put there?


http://gerrit.openvpn.net/c/openvpn/+/1288/comment/1d984d7c_11af20d7?usp=3D=
email :
PS1, Line 3340:         msg(M_WARN, "Note: Using --push without --mode serv=
er is an unsupported"
We probably also should add a note under --push in the documentation.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82c7c61be07593ecd5bf2f854767dda74ab5170c
Gerrit-Change-Number: 1288
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 20 Oct 2025 14:57:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--qP7QLSE6ykk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1288/comment/f7cedb8d_5f290a51?usp=3Demail">Patch Set #1, Line=
 14:</a> <code style=3D"font-family:monospace,monospace">Also remove an use=
d macro.</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">&quot;unused&quot; I assume</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1288/comment/d6b588cf_299e97fa?usp=3Demail">Patch Set #1, Line 333=
7:</a> <code style=3D"font-family:monospace,monospace">    </code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">whit=
espace</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288/co=
mment/bf2317ec_7c3577ee?usp=3Demail">Patch Set #1, Line 3338:</a> <code sty=
le=3D"font-family:monospace,monospace">    if (o-&gt;push_list.head &amp;&a=
mp; o-&gt;mode !=3D MODE_SERVER)</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">We have a lot of warnings and e=
rrors that we potentially throw if not in --mode server, see code around li=
ne 2650. Maybe this new check would be better put there?</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1288/comment/1d984d7c_11af20d7?=
usp=3Demail">Patch Set #1, Line 3340:</a> <code style=3D"font-family:monosp=
ace,monospace">        msg(M_WARN, &quot;Note: Using --push without --mode =
server is an unsupported&quot;</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">We probably also should add a not=
e under --push in the documentation.</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail">chang=
e 1288</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82c7c61be07593ecd5bf2f85476=
7dda74ab5170c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1288 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Oct 2025 14:57:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--qP7QLSE6ykk=--

