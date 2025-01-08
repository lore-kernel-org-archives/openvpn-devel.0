From: "mattock (Code Review)" <gerrit@...515...>
Date: Wed, 8 Jan 2025 13:05:44 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9ab18961c27a31ef26993e806de96c3e25281b61-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dxKRM0GvtjM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add lwip support to
 t_server_null
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dxKRM0GvtjM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mattock has posted comments on this change. ( http://gerrit.openvpn.net/c/o=
penvpn/+/811?usp=3Demail )

Change subject: Add lwip support to t_server_null
......................................................................


Patch Set 4:

(7 comments)

Patchset:

PS4:
All issues resolved.


File tests/lwip_client_up.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/e5dfa19e_fca0a793 :
PS2, Line 20: 	echo "Waiting for fping to exit ($count/$maxcount)"
> mixed indent over the next three lines
Done


File tests/t_server_null_client.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/1acb5cc3_d3a479e7 :
PS2, Line 6:     if echo "$test_name"|grep _lwip > /dev/null 2>&1; then
> is "grep -q" portable? That would be nicer here.
Done


http://gerrit.openvpn.net/c/openvpn/+/811/comment/c6345891_2ea42088 :
PS2, Line 8: 	    return 1
> tab indent
Done


http://gerrit.openvpn.net/c/openvpn/+/811/comment/7d51432a_fcba8233 :
PS2, Line 41: 	return 0
> tab indent
Done


http://gerrit.openvpn.net/c/openvpn/+/811/comment/55e97910_8cd840bb :
PS2, Line 162: if test -r ./lwipovpn; then
> Would be nice to be able to override this with something like `$LWIPOVPN`=
. [=E2=80=A6]
It is now possible to do

    LWIPOVPN_PATH=3D/some/path/to/lwipovpn make check

To use a custom location.

It would have been nicer to be able to override it it t_server_null.rc, but=
 that file gets loaded too late for it to have any practical effect on the =
actual client command-lines.


http://gerrit.openvpn.net/c/openvpn/+/811/comment/1078467a_e03e2968 :
PS2, Line 189:     if echo "$test_name"|grep _lwip > /dev/null; then
> another case for grep -q
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Gerrit-Change-Number: 811
Gerrit-PatchSet: 4
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 08 Jan 2025 13:05:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--dxKRM0GvtjM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">View C=
hange</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
811?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">All issues resolved.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/lwip_client_up.sh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/811/comment/e5dfa19e_fca0a793">Patch Set #2, Line 20:</a> <cod=
e style=3D"font-family:monospace,monospace">	echo &quot;Waiting for fping t=
o exit ($count/$maxcount)&quot;</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">mixed indent over the=
 next three lines</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File tests/t_server_null_client.sh:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811/comm=
ent/1acb5cc3_d3a479e7">Patch Set #2, Line 6:</a> <code style=3D"font-family=
:monospace,monospace">    if echo &quot;$test_name&quot;|grep _lwip &gt; /d=
ev/null 2&gt;&amp;1; then</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">is &quot;grep -q&quot; port=
able? That would be nicer here.</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/811/comment/c6345891_2ea42088">Patch Set #2, Line 8:=
</a> <code style=3D"font-family:monospace,monospace">	    return 1</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">tab indent</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/811/comment/7d51432a_fcba8233">Patch Set #2, Line 41:</a> <=
code style=3D"font-family:monospace,monospace">	return 0</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">tab indent</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/811/comment/55e97910_8cd840bb">Patch Set #2, Line 162:</a> <code styl=
e=3D"font-family:monospace,monospace">if test -r ./lwipovpn; then</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Would be nice to be able to override this with something like =
`$LWIPOVPN`. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">It is now possible to do</p><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">    LWIPOVPN_PATH=3D/some=
/path/to/lwipovpn make check<br>    <br>To use a custom location.</pre><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">It would have been n=
icer to be able to override it it t_server_null.rc, but that file gets load=
ed too late for it to have any practical effect on the actual client comman=
d-lines.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811/c=
omment/1078467a_e03e2968">Patch Set #2, Line 189:</a> <code style=3D"font-f=
amily:monospace,monospace">    if echo &quot;$test_name&quot;|grep _lwip &g=
t; /dev/null; then</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">another case for grep -q</blockquo=
te></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/811?usp=3Demail">change 811</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca=
6b8c029f0d250 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 811 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Jan 2025 13:05:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--dxKRM0GvtjM=--

