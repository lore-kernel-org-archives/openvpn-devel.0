From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 07:51:19 +0000
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <66c96102e89c72569e02411d17be98fe4d25f509-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yGCe11oVSsI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support
 multiple domains without DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yGCe11oVSsI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/824?usp=3Demail )

Change subject: dns: support multiple domains without DHCP
......................................................................


Patch Set 3:

(3 comments)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/df2d8e6a_fc1974ba :
PS2, Line 1302:     CloseServiceHandle(dnssvc);
> SAL:  [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/824/comment/848dd16c_3cd12015 :
PS2, Line 1584:     size =3D (wcslen(list) + 1) * sizeof(list[0]);
> I got a SAL warning: [=E2=80=A6]
The actual check is in line 1572 where we make sure there is enough room in=
 the buffer to append the domains including the NUL at the end (+2, one for=
 the comma, the other one for \0)

wcsncpy() pads the source string wit 0 if count is greater than the len of =
the source string, so domlen + 1 will do the trick.

I think it is indeed a false positive and wonder what triggers it. Let's tr=
y to init list with zeros and if that defeats the diagnostic, good enough, =
but it is not necessary.


http://gerrit.openvpn.net/c/openvpn/+/824/comment/ffa63cf0_730a2c02 :
PS2, Line 1648: RemoveDnsSearchDomains(HKEY key, PCWSTR domains)
> SAL warning: [=E2=80=A6]
Yeah, let's go with 2k and see where we land. Usually this should not be an=
 issue I think as there are normally not so many search domains set. There =
_is_ no correct value here, unless you re(allocate) from the heap to make s=
ure the local maximum is handled.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Gerrit-Change-Number: 824
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 12 Dec 2024 07:51:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--yGCe11oVSsI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/824/comment/df2d8e6a_fc1974ba">Patch Set #2, Line=
 1302:</a> <code style=3D"font-family:monospace,monospace">    CloseService=
Handle(dnssvc);</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">SAL:  [=E2=80=A6]</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/848dd16c_3cd1201=
5">Patch Set #2, Line 1584:</a> <code style=3D"font-family:monospace,monosp=
ace">    size =3D (wcslen(list) + 1) * sizeof(list[0]);</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">I got a SAL warning: [=E2=80=A6]</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">The actual check is in line 1572 where =
we make sure there is enough room in the buffer to append the domains inclu=
ding the NUL at the end (+2, one for the comma, the other one for \0)</p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">wcsncpy() pads the=
 source string wit 0 if count is greater than the len of the source string,=
 so domlen + 1 will do the trick.</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">I think it is indeed a false positive and wonder what =
triggers it. Let&#39;s try to init list with zeros and if that defeats the =
diagnostic, good enough, but it is not necessary.</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/824/comment/ffa63cf0_730a2c02">Patch Se=
t #2, Line 1648:</a> <code style=3D"font-family:monospace,monospace">Remove=
DnsSearchDomains(HKEY key, PCWSTR domains)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">SAL warn=
ing: [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Yeah, let&#39;s go with 2k and see where we land. Usually =
this should not be an issue I think as there are normally not so many searc=
h domains set. There _is_ no correct value here, unless you re(allocate) fr=
om the heap to make sure the local maximum is handled.</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?u=
sp=3Demail">change 824</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Dec 2024 07:51:19=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--yGCe11oVSsI=--

