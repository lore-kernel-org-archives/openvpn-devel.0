From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 09:40:47 +0000
In-Reply-To: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
References: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <df1edeceb6210fdbd411e67b55727bf434608bbf-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C7sDLQEgOV8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mroute/management:
 fix uninitialized variable (UNINIT)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--C7sDLQEgOV8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/880?usp=3Demail )

Change subject: mroute/management: fix uninitialized variable (UNINIT)
......................................................................


Patch Set 2: Code-Review-1

(3 comments)

Patchset:

PS2:
close :-)


File doc/management-notes.txt:

http://gerrit.openvpn.net/c/openvpn/+/880/comment/5aaed102_183dab88 :
PS2, Line 211:
Thanks for this.  I overlooked this in v1, though - I think we should have =
protocol at the start `tcp:1.2.3.4:4000`, as this is really the "most commo=
n way", and since we *print* the addresses that way now this would be more =
logical.

Sorry for not spotting this earlier.

Also, we might mention "this isn't working for IPv6-connected clients (yet)=
, kill by CN or CID instead".


File src/openvpn/manage.c:

http://gerrit.openvpn.net/c/openvpn/+/880/comment/898e15ca_959b2a49 :
PS2, Line 564:
As discussed in the management-notes.txt comment, I am convinced that it's =
more logical to do protocol first, so p1 -> protocol, p2 -> IP, p3 -> port =
then.  Sorry again.

We do the msg() in that format already ;-)

Besides this, the new version & error handling look acceptable (we discusse=
d getting rid of ascii2proto() and just checking for "udp" or "tcp" here, b=
ut it does not make much of a difference).



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1
Gerrit-Change-Number: 880
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 29 Jan 2025 09:40:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--C7sDLQEgOV8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/880?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">close :-)</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File doc/management-notes.txt:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/880/comment/5aaed102_183dab88">Patch Set #2, Line 211:</a> <code style=
=3D"font-family:monospace,monospace"></code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Thanks for this.  I overlooked this in v1, =
though - I think we should have protocol at the start `tcp:1.2.3.4:4000`, a=
s this is really the &quot;most common way&quot;, and since we *print* the =
addresses that way now this would be more logical.</p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Sorry for not spotting this earlier.<=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Also, we migh=
t mention &quot;this isn&#39;t working for IPv6-connected clients (yet), ki=
ll by CN or CID instead&quot;.</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/manage.c:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880/comme=
nt/898e15ca_959b2a49">Patch Set #2, Line 564:</a> <code style=3D"font-famil=
y:monospace,monospace"></code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">As discussed in the management-notes.txt comment, I am co=
nvinced that it&#39;s more logical to do protocol first, so p1 -&gt; protoc=
ol, p2 -&gt; IP, p3 -&gt; port then.  Sorry again.</p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">We do the msg() in that format alread=
y ;-)</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Besides=
 this, the new version &amp; error handling look acceptable (we discussed g=
etting rid of ascii2proto() and just checking for &quot;udp&quot; or &quot;=
tcp&quot; here, but it does not make much of a difference).</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
880?usp=3Demail">change 880</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd31=
78eee1f60fff1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 880 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Jan 2025 09:40:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--C7sDLQEgOV8=--

