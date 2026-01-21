From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 21 Jan 2026 12:14:08 +0000
In-Reply-To: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
References: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e63e33821e1e8760618774f7b73feca3b810e38d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zjuxilRpJqI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zjuxilRpJqI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1477?usp=3Demail )

Change subject: Merge stream_buf_get_next and stream_buf_set_next
......................................................................


Patch Set 3: Code-Review-1

(6 comments)

File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/1477/comment/c97b5e83_9e9c469d?usp=3D=
email :
PS3, Line 552:  * required and other false. (full packet is ready)
"otherwise"?


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/1477/comment/487937f5_d30dfd28?usp=3D=
email :
PS3, Line 2067:  * resets the stream buffer to be setup for the next round =
of
"set up"


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/5b1e950d_159c415b?usp=3D=
email :
PS3, Line 2122:  * Sets the parameter buf to  the current buffer of sb->buf.
superfluous whitespace in the middle of the sentence


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/7ccb4681_dd24406d?usp=3D=
email :
PS3, Line 2154:  * move anything in sb->buf beyond a full beyond packet to =
sb->residual
Remove second "beyond"


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/b1bcaa05_4b1c487c?usp=3D=
email :
PS3, Line 2160:  * If a packet is outside of the allowed range is detected,=
 the error state
Remove first "is"


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/73e1c3bb_381e01d3?usp=3D=
email :
PS3, Line 2164:  * @param length_added The length that has been added to sb=
->buf
Would be good to add a little more information here. I see this can be 0. I=
s that for the initial call? When do we call this with non-zero length_adde=
d?



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 21 Jan 2026 12:14:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--zjuxilRpJqI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail">V=
iew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.h:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1477/comment/c97b5e83_9e9c469d?usp=3Demail">Patch Set=
 #3, Line 552:</a> <code style=3D"font-family:monospace,monospace"> * requi=
red and other false. (full packet is ready)</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;otherwise&quot=
;?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/socket.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1477/comment/487937f5_d30dfd28?usp=3D=
email">Patch Set #3, Line 2067:</a> <code style=3D"font-family:monospace,mo=
nospace"> * resets the stream buffer to be setup for the next round of</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">&quot;set up&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1477/comment/5b1e950d_159c415b?usp=3Demail">Patch Set #3, Line =
2122:</a> <code style=3D"font-family:monospace,monospace"> * Sets the param=
eter buf to  the current buffer of sb-&gt;buf.</code></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">superfluous white=
space in the middle of the sentence</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1477/comment/7ccb4681_dd24406d?usp=3Demail">Patch Set=
 #3, Line 2154:</a> <code style=3D"font-family:monospace,monospace"> * move=
 anything in sb-&gt;buf beyond a full beyond packet to sb-&gt;residual</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Remove second &quot;beyond&quot;</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1477/comment/b1bcaa05_4b1c487c?usp=3Demail">Patch=
 Set #3, Line 2160:</a> <code style=3D"font-family:monospace,monospace"> * =
If a packet is outside of the allowed range is detected, the error state</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Remove first &quot;is&quot;</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1477/comment/73e1c3bb_381e01d3?usp=3Demail">Patch Se=
t #3, Line 2164:</a> <code style=3D"font-family:monospace,monospace"> * @pa=
ram length_added The length that has been added to sb-&gt;buf</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Wo=
uld be good to add a little more information here. I see this can be 0. Is =
that for the initial call? When do we call this with non-zero length_added?=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1477?usp=3Demail">change 1477</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1477?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 21 Jan 2026 12:14:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--zjuxilRpJqI=--

