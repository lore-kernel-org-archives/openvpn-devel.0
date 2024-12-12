From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 15:49:22 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., steffan@...1856..., max@...2606...,
 gert@...1296...
Message-ID: <c1212fe01ba31fca5580feda0d30f59492302ef3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2D0CL752Izc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Trigger
 renegotiation of data key if getting close to the AEAD usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: syzzer <steffan@...1856...>, MaxF <max@...2606...>, flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2D0CL752Izc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, flichtenheld, syzzer.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 13:

(5 comments)

File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/c237d8e4_41a211f7 :
PS10, Line 134: static int64_t
              : tls_get_limit_aead(const char *ciphername)
              : {
              :     int64_t limit =3D cipher_get_aead_limits(ciphername);
              :
              :     if (limit =3D=3D 0)
              :     {
              :         return 0;
              :     }
              :
              :     /* set limit to 7/8 of the limit so the renogiation can=
 succeed before
              :      * we go over the limit */
              :     limit =3D limit * 7/8;
              :
              :     msg(D_SHOW_KEYS, "Note: AEAD cipher %s will be limited =
to a sum of %"
              :         PRIi64 " for block and packets before renegotiation=
",
              :         ciphername, limit);
              :     return limit;
              : }
> This function could return uint
Done


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/9c45c755_8086e09c :
PS12, Line 144:     /* set limit to 7/8 of the limit so the renogiation can=
 succeed before
> renegotiation
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/ee3d97c9_67c4d1c6 :
PS12, Line 146:     limit =3D limit * 7/8;
> Consider adding overflow checks. [=E2=80=A6]
I changed the order to /8 * 7 which does not have the overflow problem and =
I think if we now off by a few packets because of the lower precision that =
is not doing much in the grand scheme.


http://gerrit.openvpn.net/c/openvpn/+/796/comment/2ddba798_2401cb2d :
PS12, Line 149:         PRIi64 " for block and packets before renegotiation=
",
> This suggests a hard limit, but it's a soft limit we can (and typically w=
ill) exceed. [=E2=80=A6]
The hard limit of 2**32-1 is still there. The higher pid limit only comes w=
ith the epoch patches and those actually have this as as a hard limit.

I think implementing a hard limit for this feature is not so important, so =
I changed the message to indicate that there will be a renegotiation.


http://gerrit.openvpn.net/c/openvpn/+/796/comment/55c0c5e2_32a406f5 :
PS12, Line 3027:         || aead_usage_limit_reached(usage_limit, &key_ctx_=
bi->decrypt,
> This is a safety precaution? The sending party is ultimately responsible =
for not exceeding the limit [=E2=80=A6]
My thinking was that this code will most certainly only be in use when only=
 one side is aware of the limitation. Since if both sides are aware, then b=
oth sides will probably also switch to use epoch data channel instead, whic=
h only the sender checks.

I will add a comment to indicate this as well.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Thu, 12 Dec 2024 15:49:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: syzzer <steffan@...1856...>
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--2D0CL752Izc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, cron2, flichtenheld, syzzer=
. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/796/comment/c237d8e4_41a211f7">Patch Set #10, Line 134:</a> <=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;"><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">static int64_t<br>tls_get_limit_aead(const char *ciphername)<br=
>{<br>    int64_t limit =3D cipher_get_aead_limits(ciphername);<br><br>    =
if (limit =3D=3D 0)<br>    {<br>        return 0;<br>    }<br><br>    /* se=
t limit to 7/8 of the limit so the renogiation can succeed before<br>     *=
 we go over the limit */<br>    limit =3D limit * 7/8;<br><br>    msg(D_SHO=
W_KEYS, &quot;Note: AEAD cipher %s will be limited to a sum of %&quot;<br> =
       PRIi64 &quot; for block and packets before renegotiation&quot;,<br> =
       ciphername, limit);<br>    return limit;<br>}<br></pre></blockquote>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">This function could return uint</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/796/comment/9c45c755_8086e09c">Patch Set #12, Line 144:</a> <code=
 style=3D"font-family:monospace,monospace">    /* set limit to 7/8 of the l=
imit so the renogiation can succeed before</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">renegoti=
ation</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
96/comment/ee3d97c9_67c4d1c6">Patch Set #12, Line 146:</a> <code style=3D"f=
ont-family:monospace,monospace">    limit =3D limit * 7/8;</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Consider adding overflow checks. [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I changed the order to /=
8 * 7 which does not have the overflow problem and I think if we now off by=
 a few packets because of the lower precision that is not doing much in the=
 grand scheme.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/796/comment/2ddba798_2401cb2d">Patch Set #12, Line 149:</a> <code style=3D=
"font-family:monospace,monospace">        PRIi64 &quot; for block and packe=
ts before renegotiation&quot;,</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This suggests a hard l=
imit, but it&#39;s a soft limit we can (and typically will) exceed. [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">The hard limit of 2**32-1 is still there. The higher pid limit only co=
mes with the epoch patches and those actually have this as as a hard limit.=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I think impl=
ementing a hard limit for this feature is not so important, so I changed th=
e message to indicate that there will be a renegotiation.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comment/55c0c5e2_32a406f5">=
Patch Set #12, Line 3027:</a> <code style=3D"font-family:monospace,monospac=
e">        || aead_usage_limit_reached(usage_limit, &amp;key_ctx_bi-&gt;dec=
rypt,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">This is a safety precaution? The sending party =
is ultimately responsible for not exceeding the limit [=E2=80=A6]</blockquo=
te></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">My thinki=
ng was that this code will most certainly only be in use when only one side=
 is aware of the limitation. Since if both sides are aware, then both sides=
 will probably also switch to use epoch data channel instead, which only th=
e sender checks.</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">I will add a comment to indicate this as well.</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=
=3Demail">change 796</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Dec 2024 15:49:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: syzzer &lt;steffan@...1852...=
6...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--2D0CL752Izc=--

