From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 20 Feb 2025 07:23:04 +0000
In-Reply-To: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
References: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <d8d9513d1220178c2ab609c1f405f17524e91bc0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oUbIq5nKIpw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: kernel
 notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oUbIq5nKIpw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/816?usp=3Demail )

Change subject: dco-win: kernel notifications
......................................................................


Patch Set 20: Code-Review+1

(4 comments)

Patchset:

PS20:
the code looks good and the tests confirm "it works".  I have a few minor n=
its, though.


File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/816/comment/5d25f041_1b79d04b :
PS20, Line 644: dco_handle_overlapped_success(dco_context_t *dco, bool queu=
ed)
can you add a comment what this function does?  As a non-windows programmer=
 I find `Overlapped` a foreign concept


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/816/comment/d7e9b590_0c316b58 :
PS20, Line 409: #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || define=
d(TARGET_FREEBSD) || defined(TARGET_WIN32))
this is a minor nitpick, but I find this line very long and hard to read no=
w - can you wrap it?

```
#if defined(ENABLE_DCO) \
    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_=
WIN32))
```


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/816/comment/3e9bcdb0_2f4ec1a0 :
PS20, Line 3231: #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defin=
ed(TARGET_FREEBSD) || defined(TARGET_WIN32))
same thing



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iedc10616225f6769c66d3c29d4a462b622ebbc6e
Gerrit-Change-Number: 816
Gerrit-PatchSet: 20
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 20 Feb 2025 07:23:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--oUbIq5nKIpw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>Patch set 20:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/816?tab=3Dcomments">Patch Set #20:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">the code looks good and the tests confirm &=
quot;it works&quot;.  I have a few minor nits, though.</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_win.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/816/comment/5d25f041_1b79d04b">Patch Set #20, Line 644:</a>=
 <code style=3D"font-family:monospace,monospace">dco_handle_overlapped_succ=
ess(dco_context_t *dco, bool queued)</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">can you add a comment what this function doe=
s?  As a non-windows programmer I find `Overlapped` a foreign concept</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/816/comment/d7e9b590_0c316b58">Patch Set #20, L=
ine 409:</a> <code style=3D"font-family:monospace,monospace">#if defined(EN=
ABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || d=
efined(TARGET_WIN32))</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">this is a minor nitpick, but I find this line very long and=
 hard to read now - can you wrap it?</p><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">```<br>#if defined(ENABLE_DCO) \<br>  =
  &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(T=
ARGET_WIN32))<br>```</pre></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/multi.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/816/comment/3e9bcd=
b0_2f4ec1a0">Patch Set #20, Line 3231:</a> <code style=3D"font-family:monos=
pace,monospace">#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) |=
| defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">same thing</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/816=
?usp=3Demail">change 816</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iedc10616225f6769c66d3c29d4a=
462b622ebbc6e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 816 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 20 Feb 2025 07:23:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--oUbIq5nKIpw=--

