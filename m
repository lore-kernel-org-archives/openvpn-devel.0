From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 21 Nov 2024 17:20:21 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <db0b83b931f8d40ab168ccaddda827dad622478c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9F+3pU1RQrA="; charset=UTF-8
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
To: mattock <samuli@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9F+3pU1RQrA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/811?usp=3Demail )

Change subject: Add lwip support to t_server_null
......................................................................


Patch Set 2: Code-Review-1

(6 comments)

File tests/lwip_client_up.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/1843a1b0_52ead016 :
PS2, Line 20: 	echo "Waiting for fping to exit ($count/$maxcount)"
mixed indent over the next three lines


File tests/t_server_null_client.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/c505db89_06e4ea15 :
PS2, Line 6:     if echo "$test_name"|grep _lwip > /dev/null 2>&1; then
is "grep -q" portable? That would be nicer here.


http://gerrit.openvpn.net/c/openvpn/+/811/comment/81b73860_900e7d09 :
PS2, Line 8: 	    return 1
tab indent


http://gerrit.openvpn.net/c/openvpn/+/811/comment/2d16907b_24ca5a14 :
PS2, Line 41: 	return 0
tab indent


http://gerrit.openvpn.net/c/openvpn/+/811/comment/ae1b215d_2f625303 :
PS2, Line 162: if test -r ./lwipovpn; then
Would be nice to be able to override this with something like `$LWIPOVPN`. =
Definitely do not want to copy that executable around all the time.


http://gerrit.openvpn.net/c/openvpn/+/811/comment/b99be658_67323adc :
PS2, Line 189:     if echo "$test_name"|grep _lwip > /dev/null; then
another case for grep -q



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Gerrit-Change-Number: 811
Gerrit-PatchSet: 2
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Thu, 21 Nov 2024 17:20:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--9F+3pU1RQrA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/lwip_client_up.sh:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/811/comment/1843a1b0_52ead016">Patch Set #2, Line 2=
0:</a> <code style=3D"font-family:monospace,monospace">	echo &quot;Waiting =
for fping to exit ($count/$maxcount)&quot;</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">mixed indent over the next three lines=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/t_ser=
ver_null_client.sh:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/811/comment/c505db89_06e4ea15"=
>Patch Set #2, Line 6:</a> <code style=3D"font-family:monospace,monospace">=
    if echo &quot;$test_name&quot;|grep _lwip &gt; /dev/null 2&gt;&amp;1; t=
hen</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">is=
 &quot;grep -q&quot; portable? That would be nicer here.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/811/comment/81b73860_900e7d09">=
Patch Set #2, Line 8:</a> <code style=3D"font-family:monospace,monospace">	=
    return 1</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">tab indent</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/811/comment/2d16907b_24ca5a14">Patch Set #2, Line 41:</a> <code style=
=3D"font-family:monospace,monospace">	return 0</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">tab indent</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/811/comment/ae1b215d_2f625303">Patch =
Set #2, Line 162:</a> <code style=3D"font-family:monospace,monospace">if te=
st -r ./lwipovpn; then</code></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Would be nice to be able to override this with something l=
ike `$LWIPOVPN`. Definitely do not want to copy that executable around all =
the time.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811/=
comment/b99be658_67323adc">Patch Set #2, Line 189:</a> <code style=3D"font-=
family:monospace,monospace">    if echo &quot;$test_name&quot;|grep _lwip &=
gt; /dev/null; then</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">another case for grep -q</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">chan=
ge 811</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca=
6b8c029f0d250 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 811 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 21 Nov 2024 17:20:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--9F+3pU1RQrA=--

