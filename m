From: "mattock (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 11:51:11 +0000
In-Reply-To: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
References: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <909b4eeeddb290505ac9fbd3771ca68d12b36ff9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YE4PvFodzbM="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YE4PvFodzbM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mattock has posted comments on this change. ( http://gerrit.openvpn.net/c/o=
penvpn/+/1024?usp=3Demail )

Change subject: t_server_null: print error when server startup fails
......................................................................


Patch Set 1:

(1 comment)

File tests/t_server_null_server.sh:

http://gerrit.openvpn.net/c/openvpn/+/1024/comment/864a35bd_87c44e01 :
PS1, Line 27:     # we run OpenVPN without --daemon and --log to catch the =
underlying error.
> This doesn't explain why we can't use the log file from the failed startu=
p? Please elaborate.
I can't remember the impact of --log, so I need to test again. I vaguely re=
call nothing ever going to the logs if the startup fails.



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
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 20 May 2025 11:51:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--YE4PvFodzbM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_server.sh:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1024/comment/864a35bd_87c44e01">Patch Set #1, Lin=
e 27:</a> <code style=3D"font-family:monospace,monospace">    # we run Open=
VPN without --daemon and --log to catch the underlying error.</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">This doesn&#39;t explain why we can&#39;t use the log file from th=
e failed startup? Please elaborate.</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">I can&#39;t remember the impact of --lo=
g, so I need to test again. I vaguely recall nothing ever going to the logs=
 if the startup fails.</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail">change 1024</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1024?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 20 May 2025 11:51:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--YE4PvFodzbM=--

