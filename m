From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 19:28:08 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <91df5372ae900766974506a52aca986208e4adb0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HZCcVbVEm/c="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Bind to multiple
 ipv4/ipv6 addresses
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

--HZCcVbVEm/c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/764?usp=3Demail )

Change subject: Bind to multiple ipv4/ipv6 addresses
......................................................................


Patch Set 10:

(4 comments)

Patchset:

PS10:
some initial comments


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/4b14a43b_444e9460 :
PS10, Line 331:  * Return the io_wait() flags appropriate for
any particular reason why this is moved up?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/daecd6cc_2a7c62a8 :
PS10, Line 1000:     for (int j =3D 0; j < e->local_list->len; j++)
not sure how useful that change is - we basically set the same environment =
variable `len` times, every time overwriting the previous one.


http://gerrit.openvpn.net/c/openvpn/+/764/comment/62ecf583_fdc89a37 :
PS10, Line 3833:     if (!has_udp_in_local_list(o))
That's not really the right check - or the function is named badly.  The ch=
eck needs to be `if (has_tcp_...)` or `if (!has_only_udp_...)`, no?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 10
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Mon, 30 Dec 2024 19:28:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--HZCcVbVEm/c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
764?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">some initial comments</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/764/comment/4b14a43b_444e9460">Patch Set #10, Line 331:</a> <code st=
yle=3D"font-family:monospace,monospace"> * Return the io_wait() flags appro=
priate for</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">any particular reason why this is moved up?</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/764/comment/daecd6cc_2a7c62a8">Patch Set #10, Line 1000:</a> <cod=
e style=3D"font-family:monospace,monospace">    for (int j =3D 0; j &lt; e-=
&gt;local_list-&gt;len; j++)</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">not sure how useful that change is - we basically se=
t the same environment variable `len` times, every time overwriting the pre=
vious one.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
64/comment/62ecf583_fdc89a37">Patch Set #10, Line 3833:</a> <code style=3D"=
font-family:monospace,monospace">    if (!has_udp_in_local_list(o))</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">That&#39;s no=
t really the right check - or the function is named badly.  The check needs=
 to be `if (has_tcp_...)` or `if (!has_only_udp_...)`, no?</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
64?usp=3Demail">change 764</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 30 Dec 2024 19:28:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--HZCcVbVEm/c=--

