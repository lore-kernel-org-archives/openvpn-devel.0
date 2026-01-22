From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 22 Jan 2026 09:10:50 +0000
In-Reply-To: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
References: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f2fb1bcabbe672717682d2dee0f6f8d2dbd393f8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hq6JsSOtDjY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Merge
 stream_buf_get_next and stream_buf_set_next
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Hq6JsSOtDjY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1477?usp=3Demail )

Change subject: Merge stream_buf_get_next and stream_buf_set_next
......................................................................


Patch Set 3:

(6 comments)

File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/1477/comment/f7398ccd_99a35101?usp=3D=
email :
PS3, Line 552:  * required and other false. (full packet is ready)
> "otherwise"?
Done


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/1477/comment/39240118_2bfb6057?usp=3D=
email :
PS3, Line 2067:  * resets the stream buffer to be setup for the next round =
of
> "set up"
Done


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/40e9a444_87973fac?usp=3D=
email :
PS3, Line 2122:  * Sets the parameter buf to  the current buffer of sb->buf.
> superfluous whitespace in the middle of the sentence
Done


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/a122986d_eed4a789?usp=3D=
email :
PS3, Line 2154:  * move anything in sb->buf beyond a full beyond packet to =
sb->residual
> Remove second "beyond"
Done


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/3f3c7b97_17270177?usp=3D=
email :
PS3, Line 2160:  * If a packet is outside of the allowed range is detected,=
 the error state
> Remove first "is"
Done


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/ee70cc87_34f67587?usp=3D=
email :
PS3, Line 2164:  * @param length_added The length that has been added to sb=
->buf
> Would be good to add a little more information here. I see this can be 0.=
 [=E2=80=A6]
Added a paragraph for that.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
Gerrit-Change-Number: 1477
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 22 Jan 2026 09:10:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--Hq6JsSOtDjY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail">View =
Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.h:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1477/comment/f7398ccd_99a35101?usp=3Demail">Patch Set #3,=
 Line 552:</a> <code style=3D"font-family:monospace,monospace"> * required =
and other false. (full packet is ready)</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;otherwi=
se&quot;?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/socket.c:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477/com=
ment/39240118_2bfb6057?usp=3Demail">Patch Set #3, Line 2067:</a> <code styl=
e=3D"font-family:monospace,monospace"> * resets the stream buffer to be set=
up for the next round of</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;set up&quot;</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
477/comment/40e9a444_87973fac?usp=3Demail">Patch Set #3, Line 2122:</a> <co=
de style=3D"font-family:monospace,monospace"> * Sets the parameter buf to  =
the current buffer of sb-&gt;buf.</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">superfluous whitesp=
ace in the middle of the sentence</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1477/comment/a122986d_eed4a789?=
usp=3Demail">Patch Set #3, Line 2154:</a> <code style=3D"font-family:monosp=
ace,monospace"> * move anything in sb-&gt;buf beyond a full beyond packet t=
o sb-&gt;residual</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">Remove second &quot;beyond&quot;</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1477/comment/3f3c7b97_17270177?usp=3Demail">Patch Set #3, Line 2160:<=
/a> <code style=3D"font-family:monospace,monospace"> * If a packet is outsi=
de of the allowed range is detected, the error state</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Remove first &quot;is&quot;</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1477/comment/ee70cc87_34f67587?usp=3Dem=
ail">Patch Set #3, Line 2164:</a> <code style=3D"font-family:monospace,mono=
space"> * @param length_added The length that has been added to sb-&gt;buf<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">Would be good to add a little more information here. =
I see this can be 0. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Added a paragraph for th=
at.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1477?usp=3Demail">change 1477</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1477?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e1798=
65e3dbd0dbfbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1477 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 22 Jan 2026 09:10:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--Hq6JsSOtDjY=--

