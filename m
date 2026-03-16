From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 16 Mar 2026 19:24:02 +0000
In-Reply-To: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
References: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <813b232ec2404dd7cc85413a8b878947e7ba0014-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u7ljql+a3cw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Cache built
 crypto libraries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u7ljql+a3cw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1577?usp=3Demail )

Change subject: GHA: Cache built crypto libraries
......................................................................


Patch Set 3:

(2 comments)

File .github/workflows/build.yaml:

http://gerrit.openvpn.net/c/openvpn/+/1577/comment/ecacc00c_aa858274?usp=3D=
email :
PS3, Line 428:           path: /opt/
> This does not seem to work. In my actions I see [=E2=80=A6]
Yes I didn't expect /opt already to be full other stuff. Will address this =
in a new version.


http://gerrit.openvpn.net/c/openvpn/+/1577/comment/eb005d2c_ec4f7bd8?usp=3D=
email :
PS3, Line 429:           key: ${{ matrix.os }}-mbedtls-${{ env.MBEDTLS_VERS=
ION }}
> Do we need separate caches for the "normal" and the "asan" build?
I think you are right. Since we set CFLAGS also for the crypto library buil=
d it is probably better to include it in the cache key. Better safe than so=
rry.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
Gerrit-Change-Number: 1577
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 16 Mar 2026 19:24:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--u7ljql+a3cw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File .github/workflows/build.yaml:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1577/comment/ecacc00c_aa858274?usp=3Demail">Patch=
 Set #3, Line 428:</a> <code style=3D"font-family:monospace,monospace">    =
      path: /opt/</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">This does not seem to work. In my a=
ctions I see [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Yes I didn&#39;t expect /opt alre=
ady to be full other stuff. Will address this in a new version.</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1577/comment/eb005d2c_ec4=
f7bd8?usp=3Demail">Patch Set #3, Line 429:</a> <code style=3D"font-family:m=
onospace,monospace">          key: ${{ matrix.os }}-mbedtls-${{ env.MBEDTLS=
_VERSION }}</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">Do we need separate caches for the &quot;=
normal&quot; and the &quot;asan&quot; build?</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think you a=
re right. Since we set CFLAGS also for the crypto library build it is proba=
bly better to include it in the cache key. Better safe than sorry.</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1577?usp=3Demail">change 1577</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1577?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08=
c775eee7e3745 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1577 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Mar 2026 19:24:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--u7ljql+a3cw=--

