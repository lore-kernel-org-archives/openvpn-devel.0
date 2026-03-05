From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 5 Mar 2026 11:08:16 +0000
In-Reply-To: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@...2715...>
References: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ca4ccd3dd8d48a157edd49f942f4d907f30c471f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NORr9VtOH70="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: wfp: add flag to
 allow DNS traffic to loopback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NORr9VtOH70=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change by d12fk. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1541?usp=3Demail )

Change subject: wfp: add flag to allow DNS traffic to loopback
......................................................................


Patch Set 4: Code-Review-1

(2 comments)

File doc/man-sections/windows-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1541/comment/cdd6f755_709f8251?usp=3D=
email :
PS1, Line 23:   Windows XP) to ignore said error. Note that pushing unknown=
 options from
> Hm, I find the whole paragraph of limited use and would remove it rather =
completely. [=E2=80=A6]
Feel free to put it in a separate patch *nudge*, *nudge*, *wink*, *wink* ;)

Either way, it is just a suggestion, it doesn't influence the merge of this=
 patch.


File src/openvpn/wfp_block.h:

http://gerrit.openvpn.net/c/openvpn/+/1541/comment/2a9315b1_d4e0a1d9?usp=3D=
email :
PS4, Line 48:  * @param engine_handle On successful return contains the han=
dle for a newly opened fwp
Parameter names are wrong

```
wfp_block.h:48: warning: argument 'engine_handle' of command @param is not =
found in the argument list of add_wfp_block_filters(HANDLE *engine, int ifa=
ce_index, const WCHAR *exe_path, wfp_block_msg_handler_t msg_handler_callba=
ck, const wfp_block_t block_type)
wfp_block.h:48: warning: argument 'index' of command @param is not found in=
 the argument list of add_wfp_block_filters(HANDLE *engine, int iface_index=
, const WCHAR *exe_path, wfp_block_msg_handler_t msg_handler_callback, cons=
t wfp_block_t block_type)
wfp_block.h:48: warning: argument 'msg_handler' of command @param is not fo=
und in the argument list of add_wfp_block_filters(HANDLE *engine, int iface=
_index, const WCHAR *exe_path, wfp_block_msg_handler_t msg_handler_callback=
, const wfp_block_t block_type)
wfp_block.h:48: warning: The following parameters of add_wfp_block_filters(=
HANDLE *engine, int iface_index, const WCHAR *exe_path, wfp_block_msg_handl=
er_t msg_handler_callback, const wfp_block_t block_type) are not documented:
  parameter 'engine'
  parameter 'iface_index'
  parameter 'msg_handler_callback'
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6
Gerrit-Change-Number: 1541
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Thu, 05 Mar 2026 11:08:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: d12fk <heiko@...515...>

--NORr9VtOH70=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/windows-=
options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1541/comment/cdd6f755_709f8251?usp=3D=
email">Patch Set #1, Line 23:</a> <code style=3D"font-family:monospace,mono=
space">  Windows XP) to ignore said error. Note that pushing unknown option=
s from</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Hm, I find the whole paragraph of limited use =
and would remove it rather completely. [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Feel fr=
ee to put it in a separate patch *nudge*, *nudge*, *wink*, *wink* ;)</p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ei=
ther way, it is just a suggestion, it doesn&#39;t influence the merge of th=
is patch.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/wfp_block.h:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1541/comment/2a9315b1_d4e0a=
1d9?usp=3Demail">Patch Set #4, Line 48:</a> <code style=3D"font-family:mono=
space,monospace"> * @param engine_handle On successful return contains the =
handle for a newly opened fwp</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Parameter names are wrong</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">```<br>wfp_block.h:48: warning: argument &#39;engine_handle&#39; o=
f command @param is not found in the argument list of add_wfp_block_filters=
(HANDLE *engine, int iface_index, const WCHAR *exe_path, wfp_block_msg_hand=
ler_t msg_handler_callback, const wfp_block_t block_type)<br>wfp_block.h:48=
: warning: argument &#39;index&#39; of command @param is not found in the a=
rgument list of add_wfp_block_filters(HANDLE *engine, int iface_index, cons=
t WCHAR *exe_path, wfp_block_msg_handler_t msg_handler_callback, const wfp_=
block_t block_type)<br>wfp_block.h:48: warning: argument &#39;msg_handler&#=
39; of command @param is not found in the argument list of add_wfp_block_fi=
lters(HANDLE *engine, int iface_index, const WCHAR *exe_path, wfp_block_msg=
_handler_t msg_handler_callback, const wfp_block_t block_type)<br>wfp_block=
.h:48: warning: The following parameters of add_wfp_block_filters(HANDLE *e=
ngine, int iface_index, const WCHAR *exe_path, wfp_block_msg_handler_t msg_=
handler_callback, const wfp_block_t block_type) are not documented:<br>  pa=
rameter &#39;engine&#39;<br>  parameter &#39;iface_index&#39;<br>  paramete=
r &#39;msg_handler_callback&#39;<br>```</pre></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail">=
change 1541</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f94=
1f9cc2241cdb6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1541 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Mar 2026 11:08:16=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>

</body></html>=

--NORr9VtOH70=--

