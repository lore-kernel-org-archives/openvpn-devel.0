From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 09:51:33 +0000
In-Reply-To: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
References: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net, a@...2181...
Message-ID: <7d48d9da573d0b55ef0b3a530ac676da2b35fa6d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0qZIqOXFK08="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: event/multi: add
 event_arg object to make event handling more generic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0qZIqOXFK08=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/757?usp=3Demail )

Change subject: event/multi: add event_arg object to make event handling mo=
re generic
......................................................................


Patch Set 1: Code-Review-1

(6 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/757/comment/d285fad6_adb4db9c :
PS1, Line 11: distinguish which of these sockets have been pocked by an inc=
oming
poked?


http://gerrit.openvpn.net/c/openvpn/+/757/comment/8fd531fb_1f14a455 :
PS1, Line 15: event handler argument, from a "partly integer evaluated vari=
able"
"integer-evaluated" would be easier to parse I think.


http://gerrit.openvpn.net/c/openvpn/+/757/comment/e6c649bc_aca2f81f :
PS1, Line 22: use only one socket to handle all clients i/o.
Sounds clunky, "I/O of all clients" maybe? Or just "all clients."


Patchset:

PS1:
Documentation review.
Please also note the "Uncrustify" failure.


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/757/comment/f0c63fc8_4797f681 :
PS1, Line 105:     struct event_arg ev_arg;
Please add documentation

What is the advantage of storing this in the mi itself? Memory handling?


File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/757/comment/91cb60e0_7934e9e5 :
PS1, Line 169:     struct event_arg ev_arg;
Please add documentation



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e
Gerrit-Change-Number: 757
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 25 Sep 2024 09:51:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--0qZIqOXFK08=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/757/comment/d285fad6_adb4db9c">Patch Set #1, Line 11:</a> <code s=
tyle=3D"font-family:monospace,monospace">distinguish which of these sockets=
 have been pocked by an incoming</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">poked?</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/757/comment/8fd531fb_1f14a455">Patch Set #1, Line 15:</=
a> <code style=3D"font-family:monospace,monospace">event handler argument, =
from a &quot;partly integer evaluated variable&quot;</code></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">&quot;integer-evaluated&quot=
; would be easier to parse I think.</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/757/comment/e6c649bc_aca2f81f">Patch Set #1, Line 22:=
</a> <code style=3D"font-family:monospace,monospace">use only one socket to=
 handle all clients i/o.</code></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Sounds clunky, &quot;I/O of all clients&quot; maybe? Or =
just &quot;all clients.&quot;</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?tab=3Dcomments">Patch S=
et #1:</a> </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">D=
ocumentation review.<br>Please also note the &quot;Uncrustify&quot; failure=
.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/multi.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/757/comment/f0c63fc8_4797f681">Patch Se=
t #1, Line 105:</a> <code style=3D"font-family:monospace,monospace">    str=
uct event_arg ev_arg;</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Please add documentation</p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">What is the advantage of storing this in the mi=
 itself? Memory handling?</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/socket.h:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757/comment/91=
cb60e0_7934e9e5">Patch Set #1, Line 169:</a> <code style=3D"font-family:mon=
ospace,monospace">    struct event_arg ev_arg;</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Please add documentation</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/757?usp=3Demail">change 757</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd7f6a2ad350cdc2312b3e80fa0=
dbdd7e4311d2e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 757 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Sep 2024 09:51:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0qZIqOXFK08=--

