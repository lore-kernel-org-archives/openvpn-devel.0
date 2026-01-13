From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 11:54:16 +0000
In-Reply-To: <gerrit.1768304582000.I0141945469dd11340bfb42ec37a3c5f90ed0ff52@...2715...>
References: <gerrit.1768304582000.I0141945469dd11340bfb42ec37a3c5f90ed0ff52@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <3e872e95fa262c4511a28f1033a238a791c1b340-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1ns57BDCGFg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Remove old
 "dynamic remote" feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1ns57BDCGFg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1468?usp=3Demail )

Change subject: socket: Remove old "dynamic remote" feature
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/1468/comment/fb901cf9_6dc32792?usp=3D=
email :
PS1, Line 923:             if (ai && !addrlist_match(&remote_verify, ai))
Doesn't this also break the part without dynamic reresolving remote? I woul=
d expect also a change to options.c to disallow --remote with tcp-server.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1468?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0141945469dd11340bfb42ec37a3c5f90ed0ff52
Gerrit-Change-Number: 1468
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 13 Jan 2026 11:54:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--1ns57BDCGFg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1468?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1468/comment/fb901cf9_6dc32792?usp=3Demail">Patch Set #1, =
Line 923:</a> <code style=3D"font-family:monospace,monospace">            i=
f (ai &amp;&amp; !addrlist_match(&amp;remote_verify, ai))</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Doesn&=
#39;t this also break the part without dynamic reresolving remote? I would =
expect also a change to options.c to disallow --remote with tcp-server.</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1468?usp=3Demail">change 1468</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1468?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0141945469dd11340bfb42ec37a=
3c5f90ed0ff52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1468 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 13 Jan 2026 11:54:16=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--1ns57BDCGFg=--

