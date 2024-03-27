From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 27 Mar 2024 10:48:48 +0000
In-Reply-To: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
References: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b926fc73dded566d0ca6a2cc1db0843feff402b3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7aBq0RbZFWk="; charset=UTF-8
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

--7aBq0RbZFWk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/547?usp=3Demail )

Change subject: Remove openvpn_snprintf and similar functions
......................................................................


Patch Set 2:

(5 comments)

Patchset:

PS2:
some nit picks below..


File src/openvpn/proxy.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/d2c89116_22dbc48e :
PS2, Line 962:                 if (sret >=3D sizeof(buf))
if this can truly happen, does it mean that the buffer is undersized compar=
ed to the size of all variables we are putting together?

Therefore, wouldn't it make more sense to extend the size of the buffer to =
ensure that no matter what we save in those variables, we will always be ab=
le to create the HTTP header?

Or there is a limit with the HTTP header that we have to deal with?

My concern is that we are not preventing people from filling those variable=
s as they please, but we will then fail to put them together for no good re=
ason.

does it make sense?


File src/openvpn/socks.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/8bdf0e3c_8356c931 :
PS2, Line 114:                         (int) strlen(creds.username), creds.=
username,
normally we don't put a paceb etween the cast and the variable name.
This comments applies to all other casts below


http://gerrit.openvpn.net/c/openvpn/+/547/comment/b417986e_a5f333df :
PS2, Line 116:     ASSERT(sret <=3D sizeof(to_send));
why ASSERT here while in other cases we just go to error or cleanup?


File tests/unit_tests/openvpn/test_buffer.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/f8c8a505_dbfb9729 :
PS2, Line 369:      * for this unit test. We know that are doing this that =
are truncated
I think there is some typ0 here.
Maybe something like: "We know that results will be truncated and we actual=
ly want to test that".



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
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 27 Mar 2024 10:48:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--7aBq0RbZFWk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
547?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">some nit picks below..</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/proxy.c:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/547/comment/d2c89116_22dbc48e">Patch Set #2, Line 962:</a> <code st=
yle=3D"font-family:monospace,monospace">                if (sret &gt;=3D si=
zeof(buf))</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">if this can truly happen, does it mean that the buffer is undersized c=
ompared to the size of all variables we are putting together?</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Therefore, wouldn&#39;t =
it make more sense to extend the size of the buffer to ensure that no matte=
r what we save in those variables, we will always be able to create the HTT=
P header?</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Or =
there is a limit with the HTTP header that we have to deal with?</p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">My concern is that we a=
re not preventing people from filling those variables as they please, but w=
e will then fail to put them together for no good reason.</p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">does it make sense?</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socks.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/547/comment/8bdf0e3c_8356c931">Patch Set #2, Line 1=
14:</a> <code style=3D"font-family:monospace,monospace">                   =
     (int) strlen(creds.username), creds.username,</code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">normally we don&#39;t put a pa=
ceb etween the cast and the variable name.<br>This comments applies to all =
other casts below</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/547/comment/b417986e_a5f333df">Patch Set #2, Line 116:</a> <code style=
=3D"font-family:monospace,monospace">    ASSERT(sret &lt;=3D sizeof(to_send=
));</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">wh=
y ASSERT here while in other cases we just go to error or cleanup?</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/ope=
nvpn/test_buffer.c:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/547/comment/f8c8a505_dbfb9729"=
>Patch Set #2, Line 369:</a> <code style=3D"font-family:monospace,monospace=
">     * for this unit test. We know that are doing this that are truncated=
</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I thi=
nk there is some typ0 here.<br>Maybe something like: &quot;We know that res=
ults will be truncated and we actually want to test that&quot;.</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/547?usp=3Demail">change 547</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07096977e3b562bcb5d2c6f1167=
3a4175b8e12ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 27 Mar 2024 10:48:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--7aBq0RbZFWk=--

