From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 1 May 2025 09:05:45 +0000
In-Reply-To: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <24e3a980f0c65cabd28a0dcaef0401ef4de7457f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IviM7//guRk="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: deal with
 --dhcp-options when --dns is active
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IviM7//guRk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/904?usp=3Demail )

Change subject: dns: deal with --dhcp-options when --dns is active
......................................................................


Patch Set 15: Code-Review+1

(2 comments)

Patchset:

PS15:
Stared at the code and slightly tested on Windows, both --dhcp-option dns a=
nd --dns work, in various combinations. I haven't checked env variables and=
 non-Windows parts.

While not the fault of this patch, I noticed that inside run_up_down_servic=
e() we do not log success of setting DNS via service, like we normally do w=
hen we talk to the service:

  2025-05-01 11:49:09 us=3D187000 INET address service: add 10.8.0.2/24
  2025-05-01 11:49:09 us=3D203000 IPv4 MTU set to 1500 on interface 20 usin=
g service

Let's do that for DNS, too, in a separate patch.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/904/comment/dbd3e34f_fbb036f8 :
PS15, Line 4299:         tuntap_options_postprocess_dns(o);
Why WIN32 and Android require special treatment? I see that it was not adde=
d in this patch, but still a comment "why" could be in place, since we touc=
h this fragment.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Gerrit-Change-Number: 904
Gerrit-PatchSet: 15
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Thu, 01 May 2025 09:05:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--IviM7//guRk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>Patch set 15:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/904?tab=3Dcomments">Patch Set #15:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Stared at the code and slightly tested on W=
indows, both --dhcp-option dns and --dns work, in various combinations. I h=
aven&#39;t checked env variables and non-Windows parts.</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">While not the fault of this patc=
h, I noticed that inside run_up_down_service() we do not log success of set=
ting DNS via service, like we normally do when we talk to the service:</p><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">  20=
25-05-01 11:49:09 us=3D187000 INET address service: add 10.8.0.2/24<br>  20=
25-05-01 11:49:09 us=3D203000 IPv4 MTU set to 1500 on interface 20 using se=
rvice<br>  <br>Let&#39;s do that for DNS, too, in a separate patch.</pre></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/optio=
ns.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/904/comment/dbd3e34f_fbb036f8">Patch Set #15=
, Line 4299:</a> <code style=3D"font-family:monospace,monospace">        tu=
ntap_options_postprocess_dns(o);</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Why WIN32 and Android require special treatment?=
 I see that it was not added in this patch, but still a comment &quot;why&q=
uot; could be in place, since we touch this fragment.</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?us=
p=3Demail">change 904</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb=
2e9cb2570cd6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 01 May 2025 09:05:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--IviM7//guRk=--

