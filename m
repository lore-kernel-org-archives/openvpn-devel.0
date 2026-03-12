From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 11:42:11 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@...2715...>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8ef16c2126e7936ffdc768717ff506976d345c44-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aNhEmmgUeZ0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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

--aNhEmmgUeZ0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/31?usp=3Demail )

Change subject: Allow to use OpenSSL's SIPHASH implementation when available
......................................................................


Patch Set 11: Code-Review-1

(2 comments)

File src/openvpn/siphash_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/31/comment/35b7160b_cf0664ea?usp=3Dem=
ail :
PS11, Line 20:  *  You should have received a copy of the GNU General Publi=
c License along
This is an old version of the GPL header, please update to the one currentl=
y used in the rest of the files.


http://gerrit.openvpn.net/c/openvpn/+/31/comment/e0286fcc_9737f6c0?usp=3Dem=
ail :
PS11, Line 123: #else /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSI=
ON_NUMBER >=3D 0x30000000L */
The comment here is wrong



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Thu, 12 Mar 2026 11:42:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--aNhEmmgUeZ0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 11:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/siphash_openss=
l.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/31/comment/35b7160b_cf0664ea?usp=3Demail">Pat=
ch Set #11, Line 20:</a> <code style=3D"font-family:monospace,monospace"> *=
  You should have received a copy of the GNU General Public License along</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">This is an old version of the GPL header, please update to the on=
e currently used in the rest of the files.</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/31/comment/e0286fcc_9737f6c0?usp=3Demail">Patc=
h Set #11, Line 123:</a> <code style=3D"font-family:monospace,monospace">#e=
lse /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER =
&gt;=3D 0x30000000L */</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">The comment here is wrong</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
31?usp=3Demail">change 31</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/31?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26=
d54a1c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Mar 2026 11:42:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--aNhEmmgUeZ0=--

