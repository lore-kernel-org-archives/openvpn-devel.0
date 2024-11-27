From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 27 Nov 2024 10:52:59 +0000
In-Reply-To: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
References: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., alex@...2837...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d9b4cef8129fc3fe8cc3c14631ca4bd2f33528ba-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ogVtRkagJPY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Haiku: Add calls to
 manage routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kallisti5 <alex@...2837...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ogVtRkagJPY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, kallisti5, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/688?usp=3Demail )

Change subject: Haiku: Add calls to manage routing table
......................................................................


Patch Set 8: Code-Review-1

(10 comments)

Patchset:

PS8:
The code should work, technically, but since we're in a review cycle, I've =
found more things that should be changed to confirm to our style guide (or =
to just not copy existing ugliness).

We do have an uncrustify config in the source tree to get the whitespace au=
to-fixed (dev-tools/uncrustify.conf), but you need a slightly older uncrust=
ify version (0.72) to actually produce correct output.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/688/comment/2d7989ed_31075357 :
PS8, Line 1858:     {
please remove this indentation level, it looks unnecessary.

(We used to need this before we went for C99 compatibility, and declaring l=
ocal variables did not work unless we had a local {} block - but nowadays, =
this is no longer needed - it's just that nobody else fixed the other code =
blocks yet)


http://gerrit.openvpn.net/c/openvpn/+/688/comment/a5af820d_fdaa953c :
PS8, Line 2350:     {
same here


http://gerrit.openvpn.net/c/openvpn/+/688/comment/631992d6_e721d0c9 :
PS8, Line 2543:     {
same here.

Also: I see route *deletion* for IPv6 routes, but no route *addition*, and =
also no ifconfig for IPv6 (other patch).  So maybe IPv6 route deletion shou=
ld go to a followup patch "add IPv6 support for Haiku" which has ifconfig +=
 route add + route delete


http://gerrit.openvpn.net/c/openvpn/+/688/comment/3f9c168e_262eae5a :
PS8, Line 3940:     if (sockfd < 0) {
this is a style guide violation - normally, for first time submitters, I'd =
fix that on the fly but since we're here anyway...  we require the opening =
brace to be on its own line

```
if (thing)
{
    /* do something */
}
```

always, no exceptions.


http://gerrit.openvpn.net/c/openvpn/+/688/comment/509a08d9_9b43b7cf :
PS8, Line 3947:     if (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct i=
fconf)) < 0) {
this


http://gerrit.openvpn.net/c/openvpn/+/688/comment/2af50a79_267b9f62 :
PS8, Line 3954:         return;
we require to always have braces, even if it's a single statement

```
if (size =3D=3D 0)
{
    return;
}
```


http://gerrit.openvpn.net/c/openvpn/+/688/comment/2f4ff9d8_38d0a4d4 :
PS8, Line 3961:     if (ioctl(sockfd, SIOCGRTTABLE, &config, sizeof(struct =
ifconf)) < 0) {
bracket


http://gerrit.openvpn.net/c/openvpn/+/688/comment/54c49fc8_a46d3299 :
PS8, Line 3969:     while (interface < end) {
bracket


http://gerrit.openvpn.net/c/openvpn/+/688/comment/ce646a6b_df5cd804 :
PS8, Line 3978:         if (route.destination !=3D NULL)
these need braces...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd
Gerrit-Change-Number: 688
Gerrit-PatchSet: 8
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: kallisti5 <alex@...2837...>
Gerrit-Comment-Date: Wed, 27 Nov 2024 10:52:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--ogVtRkagJPY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, kallisti5, plaistho=
s. </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail">Vi=
ew Change</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/688?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">The code should work, technically, but since=
 we&#39;re in a review cycle, I&#39;ve found more things that should be cha=
nged to confirm to our style guide (or to just not copy existing ugliness).=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">We do have a=
n uncrustify config in the source tree to get the whitespace auto-fixed (de=
v-tools/uncrustify.conf), but you need a slightly older uncrustify version =
(0.72) to actually produce correct output.</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/688/comment/2d7989ed_31075357">Patch Set #8, Line 1858:</a> <code style=
=3D"font-family:monospace,monospace">    {</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">please remove this indentation level, =
it looks unnecessary.</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">(We used to need this before we went for C99 compatibility, and de=
claring local variables did not work unless we had a local {} block - but n=
owadays, this is no longer needed - it&#39;s just that nobody else fixed th=
e other code blocks yet)</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/688/comment/a5af820d_fdaa953c">Patch Set #8, Line 2350:</a> <cod=
e style=3D"font-family:monospace,monospace">    {</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">same here</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/631992d6_e721d0c9">Pa=
tch Set #8, Line 2543:</a> <code style=3D"font-family:monospace,monospace">=
    {</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
same here.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Al=
so: I see route *deletion* for IPv6 routes, but no route *addition*, and al=
so no ifconfig for IPv6 (other patch).  So maybe IPv6 route deletion should=
 go to a followup patch &quot;add IPv6 support for Haiku&quot; which has if=
config + route add + route delete</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/688/comment/3f9c168e_262eae5a">Patch Set #8, Line 3940:=
</a> <code style=3D"font-family:monospace,monospace">    if (sockfd &lt; 0)=
 {</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">thi=
s is a style guide violation - normally, for first time submitters, I&#39;d=
 fix that on the fly but since we&#39;re here anyway...  we require the ope=
ning brace to be on its own line</p><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">```<br>if (thing)<br>{<br>    /* do someth=
ing */<br>}<br>```</pre><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">always, no exceptions.</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/688/comment/509a08d9_9b43b7cf">Patch Set #8, Line 3947:</a=
> <code style=3D"font-family:monospace,monospace">    if (ioctl(sockfd, SIO=
CGRTSIZE, &amp;config, sizeof(struct ifconf)) &lt; 0) {</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">this</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/2af50a79_267b9f62">=
Patch Set #8, Line 3954:</a> <code style=3D"font-family:monospace,monospace=
">        return;</code></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">we require to always have braces, even if it&#39;s a single sta=
tement</p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">```<br>if (size =3D=3D 0)<br>{<br>    return;<br>}<br>```</pre></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/2f4ff9d8_3=
8d0a4d4">Patch Set #8, Line 3961:</a> <code style=3D"font-family:monospace,=
monospace">    if (ioctl(sockfd, SIOCGRTTABLE, &amp;config, sizeof(struct i=
fconf)) &lt; 0) {</code></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">bracket</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/688/comment/54c49fc8_a46d3299">Patch Set #8, Line 3969:</a> <code sty=
le=3D"font-family:monospace,monospace">    while (interface &lt; end) {</co=
de></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">bracket</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/ce6=
46a6b_df5cd804">Patch Set #8, Line 3978:</a> <code style=3D"font-family:mon=
ospace,monospace">        if (route.destination !=3D NULL)</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">these need braces...</=
p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/688?usp=3Demail">change 688</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/688=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f=
44087d7c2b6fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 688 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
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
<div style=3D"display:none"> Gerrit-Attention: kallisti5 &lt;alex@...2839...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 27 Nov 2024 10:52:59=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ogVtRkagJPY=--

