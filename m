From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 14 Jan 2026 16:56:40 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, steffan@...1856..., max@...2606...
Message-ID: <9c9e7554f0f1d2b55067dcaeea8386bcf95b8ae9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="W5ML2X7OtQM="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add support for
 Mbed TLS 4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: syzzer <steffan@...1856...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--W5ML2X7OtQM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos, syzzer.

flichtenheld has posted comments on this change by MaxF. ( http://gerrit.op=
envpn.net/c/openvpn/+/1441?usp=3Demail )

Change subject: Add support for Mbed TLS 4
......................................................................


Patch Set 5: Code-Review-2

(1 comment)

Patchset:

PS5:
I have added http://gerrit.openvpn.net/c/openvpn/+/1474 that updates the GH=
A definition to use mbedtls 4. But it has multiple failures (see https://gi=
thub.com/flichtenheld/openvpn/actions/runs/21002319306/job/60375385060)

On Ubuntu 22.04 it builds but then fails in t_server_null.sh with

    2026-01-14 16:50:43 Mbed TLS 4 only supports pre-defined Diffie-Hellman=
 groups.
    2026-01-14 16:50:43 Exiting due to fatal error

On Ubuntu 24.04 it doesn't build

```
  CC       ssl_mbedtls.o
ssl_mbedtls.c:607:1: error: unused function 'external_pkcs1_sign' [-Werror,=
-Wunused-function]
external_pkcs1_sign(void *ctx_voidptr, int (*f_rng)(void *, unsigned char *=
, size_t), void *p_rng,
^
ssl_mbedtls.c:703:1: error: unused function 'external_key_len' [-Werror,-Wu=
nused-function]
external_key_len(void *vctx)
^
2 errors generated.
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae
Gerrit-Change-Number: 1441
Gerrit-PatchSet: 5
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 14 Jan 2026 16:56:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--W5ML2X7OtQM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos, syzzer. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1441?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I have adde=
d http://gerrit.openvpn.net/c/openvpn/+/1474 that updates the GHA definitio=
n to use mbedtls 4. But it has multiple failures (see https://github.com/fl=
ichtenheld/openvpn/actions/runs/21002319306/job/60375385060)</p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">On Ubuntu =
22.04 it builds but then fails in t_server_null.sh with</p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">  =
  2026-01-14 16:50:43 Mbed TLS 4 only supports pre-defined Diffie-Hellman g=
roups.<br>    2026-01-14 16:50:43 Exiting due to fatal error</pre><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">On Ubun=
tu 24.04 it doesn&#39;t build</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">```<br>  CC       ssl_mbedtl=
s.o<br>ssl_mbedtls.c:607:1: error: unused function &#39;external_pkcs1_sign=
&#39; [-Werror,-Wunused-function]<br>external_pkcs1_sign(void *ctx_voidptr,=
 int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,<br>^<br>ssl_mb=
edtls.c:703:1: error: unused function &#39;external_key_len&#39; [-Werror,-=
Wunused-function]<br>external_key_len(void *vctx)<br>^<br>2 errors generate=
d.<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1441?usp=3Demail">change 1441</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1441?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111=
bcc627cdb0fae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 14 Jan 2026 16:56:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--W5ML2X7OtQM=--

