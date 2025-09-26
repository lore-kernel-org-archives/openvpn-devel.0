From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 16:16:40 +0000
In-Reply-To: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
References: <gerrit.1758627240000.Ie6b4c41d13544d5ba71d441cc794c7abd12408f3@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fd188dcc70f926fdab4a7bc8275d451788f2c178-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="djiN+7j78q4="; charset=UTF-8
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

--djiN+7j78q4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/1206?usp=3Demail )

Change subject: platform: Do not assume uid_t/gid_t are signed
......................................................................


Patch Set 2: Code-Review+2

(2 comments)

File src/openvpn/platform.c:

http://gerrit.openvpn.net/c/openvpn/+/1206/comment/cfa9da6d_0cb4d448 :
PS2, Line 87:         if (!pw)
            :         {
            :             msg(M_ERR, "failed to find UID for user %s", user=
name);
            :         }
> Note the CLEAR() at the top of the function
Oops, you're right!


http://gerrit.openvpn.net/c/openvpn/+/1206/comment/65848078_10dc0c02 :
PS2, Line 131:         if (!gr)
             :         {
             :             msg(M_ERR, "failed to find GID for group %s", gr=
oupname);
             :         }
> Note the CLEAR() at the top of the function
Done



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
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 26 Sep 2025 16:16:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--djiN+7j78q4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1206?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/platform.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1206/comment/cfa9da6d_0cb4d448">Patch Set #2, Line =
87:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">        if (!pw)<br>        {<br>            msg(M_ERR=
, &quot;failed to find UID for user %s&quot;, username);<br>        }<br></=
pre></blockquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Note the CLEAR() at the top of the functio=
n</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Oops, you&#39;re right!</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1206/comment/65848078_10dc0c02">Patch Set #2, Line 131:</a> </p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;"><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">        if (!gr)<br>        {<br>            msg(M_ERR, &quot;fai=
led to find GID for group %s&quot;, groupname);<br>        }<br></pre></blo=
ckquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">Note the CLEAR() at the top of the function</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1206?usp=3Demail">change 1206</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
06?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie6b4c41d13544d5ba71d441cc79=
4c7abd12408f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1206 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 26 Sep 2025 16:16:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--djiN+7j78q4=--

