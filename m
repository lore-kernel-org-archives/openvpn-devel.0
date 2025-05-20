From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 20:43:49 +0000
In-Reply-To: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
References: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., sasepp@...2783...
Message-ID: <1f1b159de7471b4cb7e92f1f5bcad7fdd0909c30-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2qwQMtGpfFg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null: print
 error when server startup fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <sasepp@...2783...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2qwQMtGpfFg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1024?usp=3Demail )

Change subject: t_server_null: print error when server startup fails
......................................................................


Patch Set 1:

(1 comment)

File tests/t_server_null_server.sh:

http://gerrit.openvpn.net/c/openvpn/+/1024/comment/10e6f7d1_701a039c :
PS1, Line 27:     # we run OpenVPN without --daemon and --log to catch the =
underlying error.
> I can't remember the impact of --log, so I need to test again. [=E2=80=A6]
This is correct, if cli parsing fails before logging is changed, you'll onl=
y see stdout/stderr

Which is why t_client.sh uses

```
    $RUN_SUDO "${openvpn}" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39dc6b08952a06dae7901e468f9487c8541d83c3
Gerrit-Change-Number: 1024
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <sasepp@...2783...>
Gerrit-Comment-Date: Tue, 20 May 2025 20:43:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: mattock <sasepp@...2783...>
Gerrit-MessageType: comment

--2qwQMtGpfFg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_server.sh:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1024/comment/10e6f7d1_701a039c">Patch Set #1, Lin=
e 27:</a> <code style=3D"font-family:monospace,monospace">    # we run Open=
VPN without --daemon and --log to catch the underlying error.</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">I can&#39;t remember the impact of --log, so I need to test again.=
 [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">This is correct, if cli parsing fails before logging is change=
d, you&#39;ll only see stdout/stderr</p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Which is why t_client.sh uses</p><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">```<br>    $RUN_SUDO =
&quot;${openvpn}&quot; $openvpn_conf &gt;&gt;$LOGDIR/$SUF:openvpn.log &amp;=
<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1024?usp=3Demail">change 1024</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1024?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39dc6b08952a06dae7901e468f9=
487c8541d83c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1024 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;sasepp@...2783...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;sasepp@...2867...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 20 May 2025 20:43:49=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: mattock &lt;sasepp@...2283...=
3...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--2qwQMtGpfFg=--

