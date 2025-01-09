From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 9 Jan 2025 13:52:47 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <656e2ba15e4570ed0532f5ec494d26dbd092f0d4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8UBYa8pgvGE="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8UBYa8pgvGE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/764?usp=3Demail )

Change subject: Bind to multiple ipv4/ipv6 addresses
......................................................................


Patch Set 11:

(3 comments)

File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/28aa0c26_868ac69b :
PS10, Line 331:  * Return the io_wait() flags appropriate for
> any particular reason why this is moved up?
just a leftover.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/764/comment/3d99bd65_c221426a :
PS10, Line 1000:     for (int j =3D 0; j < e->local_list->len; j++)
> not sure how useful that change is - we basically set the same environmen=
t variable `len` times, eve [=E2=80=A6]
made another function to do this specifically for every local_entry, let me=
 know if this is legal.


http://gerrit.openvpn.net/c/openvpn/+/764/comment/9afa3ab7_df013376 :
PS10, Line 3833:     if (!has_udp_in_local_list(o))
> That's not really the right check - or the function is named badly. [=E2=
=80=A6]
made another function has_tcp_in_local_list(), might be useful in some case=
s, also I moved this check little bit down to when we have at least one loc=
al_entry, again, let me know if this is legal



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 11
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Thu, 09 Jan 2025 13:52:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--8UBYa8pgvGE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/764/comment/28aa0c26_868ac69b">Patch Set #10, Line 331:</a> =
<code style=3D"font-family:monospace,monospace"> * Return the io_wait() fla=
gs appropriate for</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">any particular reason why this is =
moved up?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">just a leftover.</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764/comment/=
3d99bd65_c221426a">Patch Set #10, Line 1000:</a> <code style=3D"font-family=
:monospace,monospace">    for (int j =3D 0; j &lt; e-&gt;local_list-&gt;len=
; j++)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">not sure how useful that change is - we basica=
lly set the same environment variable `len` times, eve [=E2=80=A6]</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">made ano=
ther function to do this specifically for every local_entry, let me know if=
 this is legal.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/764/comment/9afa3ab7_df013376">Patch Set #10, Line 3833:</a> <code style=
=3D"font-family:monospace,monospace">    if (!has_udp_in_local_list(o))</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">That&#39;s not really the right check - or the function =
is named badly. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">made another function has_tcp_in_local_list(), =
might be useful in some cases, also I moved this check little bit down to w=
hen we have at least one local_entry, again, let me know if this is legal</=
p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/764?usp=3Demail">change 764</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/764=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Jan 2025 13:52:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--8UBYa8pgvGE=--

