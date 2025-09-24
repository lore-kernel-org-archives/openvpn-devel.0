From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 16:33:31 +0000
In-Reply-To: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
References: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6bf6c44f76ae12d2c9397c98b71b1f0e5ecfa16f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1aaFTfSlPss="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: platform: Do not
 assume uid_t/gid_t are signed
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

--1aaFTfSlPss=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/1206?usp=3Demail )

Change subject: platform: Do not assume uid_t/gid_t are signed
......................................................................


Patch Set 2:

(2 comments)

File src/openvpn/platform.c:

http://gerrit.openvpn.net/c/openvpn/+/1206/comment/933bb202_973498c6 :
PS2, Line 87:         if (!pw)
            :         {
            :             msg(M_ERR, "failed to find UID for user %s", user=
name);
            :         }
Shouldn't we set user_valid to false here? Or do we assume that the struct =
is initialized with 0?


http://gerrit.openvpn.net/c/openvpn/+/1206/comment/a4d30325_3994e017 :
PS2, Line 131:         if (!gr)
             :         {
             :             msg(M_ERR, "failed to find GID for group %s", gr=
oupname);
             :         }
Shouldn't we set group_valid to false here?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie6b4c41d13544d5ba71d441cc794c7abd12408f3
Gerrit-Change-Number: 1206
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 24 Sep 2025 16:33:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--1aaFTfSlPss=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/platform.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1206/comment/933bb202_973498c6">Patch Set #2, Line 87:<=
/a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">        if (!pw)<br>        {<br>            msg(M_ERR, &q=
uot;failed to find UID for user %s&quot;, username);<br>        }<br></pre>=
</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Shouldn&#39;t we set user_valid to false here? Or do we assume that the st=
ruct is initialized with 0?</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1206/comment/a4d30325_3994e017">Patch Set #2, Line 131:</a> <=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;"><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">        if (!gr)<br>        {<br>            msg(M_ERR, &quot;f=
ailed to find GID for group %s&quot;, groupname);<br>        }<br></pre></b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Sh=
ouldn&#39;t we set group_valid to false here?</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Dema=
il">change 1206</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie6b4c41d13544d5ba71d441cc79=
4c7abd12408f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1206 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 24 Sep 2025 16:33:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--1aaFTfSlPss=--

