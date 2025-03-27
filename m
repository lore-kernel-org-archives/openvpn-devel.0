From: "MaxF (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 15:43:08 +0000
In-Reply-To: <gerrit.1742996678000.If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0@...2715...>
References: <gerrit.1742996678000.If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1b6c84cad12ab6a160b901dfc24ff0956fa029d7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ChHFTV+PtYg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix mbed TLS key
 exporter functionality in 3.6.x and cmake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ChHFTV+PtYg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/920?usp=3Demail )

Change subject: Fix mbed TLS key exporter functionality in 3.6.x and cmake
......................................................................


Patch Set 1:

(2 comments)

Patchset:

PS1:
Tiny bug in the error message, but the change makes sense.

What I don't understand is how this gets triggered. I looked at configure.a=
c again and as far as I understand it, it does the following (starting from=
 line 1041):

Set have_export_keying_material to "yes".
Check if mbedtls_ssl_conf_export_keys_ext_cb exists.
If not, check if mbedtls_ssl_set_export_keys_cb exists.
If that doesn't exist either, set have_export_keying_material to "no".


File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/920/comment/1220b775_cb2a77f6 :
PS1, Line 257: HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
The second one should be HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If38e80e268dc0ee7e57de2c175c5b4db0ce55ed0
Gerrit-Change-Number: 920
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 27 Mar 2025 15:43:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--ChHFTV+PtYg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
920?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Tiny bug in the error message, but the change mak=
es sense.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Wha=
t I don&#39;t understand is how this gets triggered. I looked at configure.=
ac again and as far as I understand it, it does the following (starting fro=
m line 1041):</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Set have_export_keying_material to &quot;yes&quot;.<br>Check if mbedtls_ss=
l_conf_export_keys_ext_cb exists.<br>If not, check if mbedtls_ssl_set_expor=
t_keys_cb exists.<br>If that doesn&#39;t exist either, set have_export_keyi=
ng_material to &quot;no&quot;.</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/ssl_mbedtls.c:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/920/=
comment/1220b775_cb2a77f6">Patch Set #1, Line 257:</a> <code style=3D"font-=
family:monospace,monospace">HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">The second o=
ne should be HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/920?usp=3De=
mail">change 920</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/920?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If38e80e268dc0ee7e57de2c175c=
5b4db0ce55ed0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 920 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 27 Mar 2025 15:43:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ChHFTV+PtYg=--

