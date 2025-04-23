From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 23 Apr 2025 22:25:52 +0000
In-Reply-To: <gerrit.1744973073000.I621d44ec6b0facc524875c15ddfd11ec47b06c15@...2715...>
References: <gerrit.1744973073000.I621d44ec6b0facc524875c15ddfd11ec47b06c15@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <904dff3f91b309d62be0770ee72f15a9126c40f4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/UAlukQ8PbU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: create adapter
 on demand
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

--/UAlukQ8PbU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

selvanair has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/943?usp=3Demail )

Change subject: win: create adapter on demand
......................................................................


Patch Set 2: Code-Review+2

(4 comments)

File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/943/comment/cb1bafd2_52f5f731 :
PS2, Line 3781: static struct device_instance_id_interface *
This change is not required nor advisable. Same with panel_reg and tap_reg =
below.
Instead define them as const where used -- see below.


http://gerrit.openvpn.net/c/openvpn/+/943/comment/d1ebab33_cae54f35 :
PS2, Line 6656:     struct device_instance_id_interface *device_instance_id=
_interface =3D get_device_instance_id_interface(gc);
Define these three as "const struct ...". One can still re-assign them as r=
equired below.


http://gerrit.openvpn.net/c/openvpn/+/943/comment/ebac2853_5ed7005b :
PS2, Line 6707:                 if (adapter_created || (h && !do_create_ada=
pter_service(h, tt->backend_driver)))
I think we need not limit this using the adapter_created flag. There is a k=
ind of "race condition" where the created adapter may get opened by another=
 openvpn.exe process before this one gets a chance to open it. Especially s=
o with service created instances which all startup together.

In such cases it should be okay to create a new one again in the next round=
 of this while loop. That will work transparently if adapter_created is not=
 set and checked. If some protection against a run-away loop is needed, we =
could keep it as a number instead of as a bool -- like, do not create > 10 =
adapters in a run!


http://gerrit.openvpn.net/c/openvpn/+/943/comment/7ae3b2cb_836cd3b3 :
PS2, Line 6731:             if (tun_try_open_device(tt, *device_guid, devic=
e_instance_id_interface))
I think we should not limit this using the adapter_created flag here. There=
 is a kind of "race condition" where the created adapter may get opened by =
another openvpn.exe process before this one gets a chance to open it. Espec=
ially so with service created instances which all startup together.

In such cases it should be okay to create again inn the second round which =
will work transparently if adapter_created is not set and checked. If some =
protectin against a run-away loop is needed, we could keep it as a number i=
nstead of as a bool -- like, do not create > 10 adapters!



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I621d44ec6b0facc524875c15ddfd11ec47b06c15
Gerrit-Change-Number: 943
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 23 Apr 2025 22:25:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--/UAlukQ8PbU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/943/comment/cb1bafd2_52f5f731">Patch Set #2, Line 3781:</=
a> <code style=3D"font-family:monospace,monospace">static struct device_ins=
tance_id_interface *</code></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">This change is not required nor advisable. Same with panel_r=
eg and tap_reg below.<br>Instead define them as const where used -- see bel=
ow.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/943/commen=
t/d1ebab33_cae54f35">Patch Set #2, Line 6656:</a> <code style=3D"font-famil=
y:monospace,monospace">    struct device_instance_id_interface *device_inst=
ance_id_interface =3D get_device_instance_id_interface(gc);</code></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Define these three as=
 &quot;const struct ...&quot;. One can still re-assign them as required bel=
ow.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/943/commen=
t/ebac2853_5ed7005b">Patch Set #2, Line 6707:</a> <code style=3D"font-famil=
y:monospace,monospace">                if (adapter_created || (h &amp;&amp;=
 !do_create_adapter_service(h, tt-&gt;backend_driver)))</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I think we need not limi=
t this using the adapter_created flag. There is a kind of &quot;race condit=
ion&quot; where the created adapter may get opened by another openvpn.exe p=
rocess before this one gets a chance to open it. Especially so with service=
 created instances which all startup together.</p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">In such cases it should be okay to create=
 a new one again in the next round of this while loop. That will work trans=
parently if adapter_created is not set and checked. If some protection agai=
nst a run-away loop is needed, we could keep it as a number instead of as a=
 bool -- like, do not create &gt; 10 adapters in a run!</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/943/comment/7ae3b2cb_836cd3b3">=
Patch Set #2, Line 6731:</a> <code style=3D"font-family:monospace,monospace=
">            if (tun_try_open_device(tt, *device_guid, device_instance_id_=
interface))</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">I think we should not limit this using the adapter_created flag here.=
 There is a kind of &quot;race condition&quot; where the created adapter ma=
y get opened by another openvpn.exe process before this one gets a chance t=
o open it. Especially so with service created instances which all startup t=
ogether.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">In s=
uch cases it should be okay to create again inn the second round which will=
 work transparently if adapter_created is not set and checked. If some prot=
ectin against a run-away loop is needed, we could keep it as a number inste=
ad of as a bool -- like, do not create &gt; 10 adapters!</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/943=
?usp=3Demail">change 943</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I621d44ec6b0facc524875c15ddf=
d11ec47b06c15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 943 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Apr 2025 22:25:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--/UAlukQ8PbU=--

