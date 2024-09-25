From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 11:47:12 +0000
In-Reply-To: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
References: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <de043b22da5f57f4aad279cc9685dc1493e874be-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0+YPC8IVU1o="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0+YPC8IVU1o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/757?usp=3Demail )

Change subject: event/multi: add event_arg object to make event handling mo=
re generic
......................................................................


Patch Set 1:

(5 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/757/comment/aa46d7bd_e7e189df :
PS1, Line 11: distinguish which of these sockets have been pocked by an inc=
oming
> poked?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/757/comment/adc64174_bd2c6985 :
PS1, Line 15: event handler argument, from a "partly integer evaluated vari=
able"
> "integer-evaluated" would be easier to parse I think.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/757/comment/7946288e_fc23bcb7 :
PS1, Line 22: use only one socket to handle all clients i/o.
> Sounds clunky, "I/O of all clients" maybe? Or just "all clients. [=E2=80=
=A6]
'all clients' sounds good


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/757/comment/a9e5c953_3086edb7 :
PS1, Line 105:     struct event_arg ev_arg;
> Please add documentation [=E2=80=A6]
With the current approach we pass &mi as data to the event engine, because =
if data is an address we know for sure that it must be a mi.
Now we want to put ourselves in the position to pass either a multi_instanc=
e or a link_socket object.
For this reason we can't simply pass their address as we would not have a w=
ay to understand what object that is.
Therefore the idea is to use a new struct (ev_arg) which internally will gi=
ve me the pointer of the mi or ls, depending on the event type.
Since we need this new struct to live somewhere, it was easier to locate it=
 within the same struct that it points to (hence link_socket and multi_inst=
ance).

To some extends, you may take it as a "event base class", which is then int=
erpreted as mi or ls.

Does it help understanding what is going on?


File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/757/comment/b8214964_f33cc340 :
PS1, Line 169:     struct event_arg ev_arg;
> Please add documentation
explained in previous reply.



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 25 Sep 2024 11:47:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--0+YPC8IVU1o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/757/comment/aa46d7bd_e7e189df">Patch Set #1, Line 11:</a> <code style=
=3D"font-family:monospace,monospace">distinguish which of these sockets hav=
e been pocked by an incoming</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">poked?</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757/comment/adc641=
74_bd2c6985">Patch Set #1, Line 15:</a> <code style=3D"font-family:monospac=
e,monospace">event handler argument, from a &quot;partly integer evaluated =
variable&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">&quot;integer-evaluated&quot; would be=
 easier to parse I think.</blockquote></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/757/comment/7946288e_fc23bcb7">Patch Set #1, Line =
22:</a> <code style=3D"font-family:monospace,monospace">use only one socket=
 to handle all clients i/o.</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sounds clunky, &quot;I/O =
of all clients&quot; maybe? Or just &quot;all clients. [=E2=80=A6]</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&#39;all=
 clients&#39; sounds good</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/multi.h:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757/comment/a9e=
5c953_3086edb7">Patch Set #1, Line 105:</a> <code style=3D"font-family:mono=
space,monospace">    struct event_arg ev_arg;</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Please =
add documentation [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">With the current approach we pass &amp;mi as =
data to the event engine, because if data is an address we know for sure th=
at it must be a mi.<br>Now we want to put ourselves in the position to pass=
 either a multi_instance or a link_socket object.<br>For this reason we can=
&#39;t simply pass their address as we would not have a way to understand w=
hat object that is.<br>Therefore the idea is to use a new struct (ev_arg) w=
hich internally will give me the pointer of the mi or ls, depending on the =
event type.<br>Since we need this new struct to live somewhere, it was easi=
er to locate it within the same struct that it points to (hence link_socket=
 and multi_instance).</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">To some extends, you may take it as a &quot;event base class&quot;=
, which is then interpreted as mi or ls.</p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Does it help understanding what is going on?</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/so=
cket.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/757/comment/b8214964_f33cc340">Patch Set #=
1, Line 169:</a> <code style=3D"font-family:monospace,monospace">    struct=
 event_arg ev_arg;</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Please add documentation</blockquo=
te></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">explained=
 in previous reply.</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail">change 757</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/757?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Sep 2024 11:47:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0+YPC8IVU1o=--

