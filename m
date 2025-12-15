From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 10:09:47 +0000
In-Reply-To: <gerrit.1765381324000.I21251a42f94fa1d9de083d2acd95b887658c5760@...2715...>
References: <gerrit.1765381324000.I21251a42f94fa1d9de083d2acd95b887658c5760@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <706bf30d7019359706b1d6f618f985044622322a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q0PcZv+dX64="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change ssl_ctx in
 struct tls_options to be a pointer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q0PcZv+dX64=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

MaxF has posted comments on this change by plaisthos. ( http://gerrit.openv=
pn.net/c/openvpn/+/1431?usp=3Demail )

Change subject: Change ssl_ctx in struct tls_options to be a pointer
......................................................................


Patch Set 4:

(1 comment)

File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1431/comment/c2acf41e_4c956f57?usp=3D=
email :
PS4, Line 878: all instances sharing the same context
I'm a bit confused here. The point of this change is to make all instances =
share the same context, right? But "all instances sharing the same context"=
 makes me wonder if I misunderstand something, because isn't that just the =
same as "all instances"?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I21251a42f94fa1d9de083d2acd95b887658c5760
Gerrit-Change-Number: 1431
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 15 Dec 2025 10:09:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Q0PcZv+dX64=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1431/comment/c2acf41e_4c956f57?usp=3Demail">Patch Set #4, Lin=
e 878:</a> <code style=3D"font-family:monospace,monospace">all instances sh=
aring the same context</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I&#39;m a bit confused here. The point of=
 this change is to make all instances share the same context, right? But &q=
uot;all instances sharing the same context&quot; makes me wonder if I misun=
derstand something, because isn&#39;t that just the same as &quot;all insta=
nces&quot;?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1431?usp=3Demail">change 1431</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1431?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I21251a42f94fa1d9de083d2acd9=
5b887658c5760 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1431 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 15 Dec 2025 10:09:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--Q0PcZv+dX64=--

