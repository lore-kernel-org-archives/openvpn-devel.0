From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 9 Dec 2024 12:28:28 +0000
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <84adf82e3b89f867d24ca1a6e1a47520cebbfd01-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bNgdrcpxl5s="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bNgdrcpxl5s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/824?usp=3Demail )

Change subject: dns: support multiple domains without DHCP
......................................................................


Patch Set 2:

(3 comments)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/21f75f54_201cbbb0 :
PS2, Line 1302:     CloseServiceHandle(dnssvc);
SAL:

Warning	C6387	'dnssvc' could be '0'.	openvpn	C:\Users\lev\Projects\openvpn-=
build\src\openvpn\src\openvpnserv\interactive.c	1302

same on the following line. Add a NULL check?


http://gerrit.openvpn.net/c/openvpn/+/824/comment/d64294ff_24966968 :
PS2, Line 1584:     size =3D (wcslen(list) + 1) * sizeof(list[0]);
I got a SAL warning:

Warning	C6053	The prior call to 'wcsncpy' might not zero-terminate string '=
list'.	openvpn	C:\Users\lev\Projects\openvpn-build\src\openvpn\src\openvpns=
erv\interactive.c	1584

I think on line 1581 we have +1 to copy NULL terminator from domains, so th=
is is not an issue? Should we also initialize list with {0} to make SAL hap=
py?


http://gerrit.openvpn.net/c/openvpn/+/824/comment/e58e3f80_84b5ad3c :
PS2, Line 1648: RemoveDnsSearchDomains(HKEY key, PCWSTR domains)
SAL warning:

Warning	C6262	Function uses '16432' bytes of stack.  Consider moving some d=
ata to heap.	openvpn	C:\Users\lev\Projects\openvpn-build\src\openvpn\src\op=
envpnserv\interactive.c	1648

Is 4096 a random "large enough" value? Can we make it, say, 2048 to make SA=
L happy?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Gerrit-Change-Number: 824
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Mon, 09 Dec 2024 12:28:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--bNgdrcpxl5s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/824/comment/21f75f54_201cbbb0">Patch Set #2, Line=
 1302:</a> <code style=3D"font-family:monospace,monospace">    CloseService=
Handle(dnssvc);</code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">SAL: </p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Warning	C6387	&#39;dnssvc&#39; could be &#39;0&#39;.	openvpn	C:\Users\le=
v\Projects\openvpn-build\src\openvpn\src\openvpnserv\interactive.c	1302	</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">same on the fol=
lowing line. Add a NULL check?</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/824/comment/d64294ff_24966968">Patch Set #2, Line 1584:</a=
> <code style=3D"font-family:monospace,monospace">    size =3D (wcslen(list=
) + 1) * sizeof(list[0]);</code></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">I got a SAL warning:</p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Warning	C6053	The prior call to &#39;wcsncpy&#3=
9; might not zero-terminate string &#39;list&#39;.	openvpn	C:\Users\lev\Pro=
jects\openvpn-build\src\openvpn\src\openvpnserv\interactive.c	1584	</p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">I think on line 1581=
 we have +1 to copy NULL terminator from domains, so this is not an issue? =
Should we also initialize list with {0} to make SAL happy?</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/e58e3f80_84b5ad3c"=
>Patch Set #2, Line 1648:</a> <code style=3D"font-family:monospace,monospac=
e">RemoveDnsSearchDomains(HKEY key, PCWSTR domains)</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">SAL warning:</p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Warning	C6262	Function uses &=
#39;16432&#39; bytes of stack.  Consider moving some data to heap.	openvpn	=
C:\Users\lev\Projects\openvpn-build\src\openvpn\src\openvpnserv\interactive=
.c	1648	</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Is 4=
096 a random &quot;large enough&quot; value? Can we make it, say, 2048 to m=
ake SAL happy?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/824?usp=3Demail">change 824</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/824?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Dec 2024 12:28:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--bNgdrcpxl5s=--

