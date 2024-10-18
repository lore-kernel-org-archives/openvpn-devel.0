From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 18 Oct 2024 07:03:47 +0000
In-Reply-To: <gerrit.1729216832000.Ib480e57b62ea33f2aea52bee895badaf5607b72d@...2715...>
References: <gerrit.1729216832000.Ib480e57b62ea33f2aea52bee895badaf5607b72d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <857ac5d40a49aba11915c4c6969c531c547f0822-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bqvspbaVtoo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove unused
 methods write_key/read_key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bqvspbaVtoo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/784?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Remove unused methods write_key/read_key
......................................................................

Remove unused methods write_key/read_key

These were used in the key-method 1 that we remove by commit
36bef1b52 in 2020.  That commit unfortunately missed that these
methods were only used for directly sending/receiving key material
over the control channel.

Change-Id: Ib480e57b62ea33f2aea52bee895badaf5607b72d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241018063123.11631-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
595.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 0 insertions(+), 86 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/784/2

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 064e59e..8f34eaa 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1540,87 +1540,6 @@
     }
 }

-/* given a key and key_type, write key to buffer */
-bool
-write_key(const struct key *key, const struct key_type *kt,
-          struct buffer *buf)
-{
-    ASSERT(cipher_kt_key_size(kt->cipher) <=3D MAX_CIPHER_KEY_LENGTH
-           && md_kt_size(kt->digest) <=3D MAX_HMAC_KEY_LENGTH);
-
-    const uint8_t cipher_length =3D (uint8_t)cipher_kt_key_size(kt->cipher=
);
-    if (!buf_write(buf, &cipher_length, 1))
-    {
-        return false;
-    }
-
-    uint8_t hmac_length =3D (uint8_t)md_kt_size(kt->digest);
-
-    if (!buf_write(buf, &hmac_length, 1))
-    {
-        return false;
-    }
-    if (!buf_write(buf, key->cipher, cipher_kt_key_size(kt->cipher)))
-    {
-        return false;
-    }
-    if (!buf_write(buf, key->hmac, hmac_length))
-    {
-        return false;
-    }
-
-    return true;
-}
-
-/*
- * Given a key_type and buffer, read key from buffer.
- * Return: 1 on success
- *        -1 read failure
- *         0 on key length mismatch
- */
-int
-read_key(struct key *key, const struct key_type *kt, struct buffer *buf)
-{
-    uint8_t cipher_length;
-    uint8_t hmac_length;
-
-    CLEAR(*key);
-    if (!buf_read(buf, &cipher_length, 1))
-    {
-        goto read_err;
-    }
-    if (!buf_read(buf, &hmac_length, 1))
-    {
-        goto read_err;
-    }
-
-    if (cipher_length !=3D cipher_kt_key_size(kt->cipher) || hmac_length !=
=3D md_kt_size(kt->digest))
-    {
-        goto key_len_err;
-    }
-
-    if (!buf_read(buf, key->cipher, cipher_length))
-    {
-        goto read_err;
-    }
-    if (!buf_read(buf, key->hmac, hmac_length))
-    {
-        goto read_err;
-    }
-
-    return 1;
-
-read_err:
-    msg(D_TLS_ERRORS, "TLS Error: error reading key from remote");
-    return -1;
-
-key_len_err:
-    msg(D_TLS_ERRORS,
-        "TLS Error: key length mismatch, local cipher/hmac %d/%d, remote c=
ipher/hmac %d/%d",
-        cipher_kt_key_size(kt->cipher), md_kt_size(kt->digest), cipher_len=
gth, hmac_length);
-    return 0;
-}
-
 void
 prng_bytes(uint8_t *output, int len)
 {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index d91de74..074dad6 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -313,11 +313,6 @@

 bool check_key(struct key *key, const struct key_type *kt);

-bool write_key(const struct key *key, const struct key_type *kt,
-               struct buffer *buf);
-
-int read_key(struct key *key, const struct key_type *kt, struct buffer *bu=
f);
-
 /**
  * Initialize a key_type structure with.
  *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/784?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib480e57b62ea33f2aea52bee895badaf5607b72d
Gerrit-Change-Number: 784
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--bqvspbaVtoo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
784?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Remove unused methods write_key/read_key<br><br>Thes=
e were used in the key-method 1 that we remove by commit<br>36bef1b52 in 20=
20.  That commit unfortunately missed that these<br>methods were only used =
for directly sending/receiving key material<br>over the control channel.<br=
><br>Change-Id: Ib480e57b62ea33f2aea52bee895badaf5607b72d<br>Signed-off-by:=
 Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>Message-Id: &lt;20241018063123.11631-1-gert@...1296...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g29595.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>2 files changed, 0 in=
sertions(+), 86 deletions(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/84/784/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c=
 b/src/openvpn/crypto.c</span><br><span>index 064e59e..8f34eaa 100644</span=
><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/cry=
pto.c</span><br><span>@@ -1540,87 +1540,6 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* given a key and key_type, write key to buffer */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-write_key(const struct key *key, const struct key_type=
 *kt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          struct=
 buffer *buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_kt_key_siz=
e(kt-&gt;cipher) &lt;=3D MAX_CIPHER_KEY_LENGTH</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-           &amp;&amp; md_kt_size(kt-&gt;digest) &l=
t;=3D MAX_HMAC_KEY_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint8=
_t cipher_length =3D (uint8_t)cipher_kt_key_size(kt-&gt;cipher);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_write(buf, &amp;cip=
her_length, 1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint8_t hmac_length =3D (uint8_t)md_kt_size(kt-&gt;dige=
st);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_write(buf, &amp;hmac_leng=
th, 1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!buf_write(buf, key-&gt;cipher, cipher=
_kt_key_size(kt-&gt;cipher)))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_write(buf, =
key-&gt;hmac, hmac_length))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Given a key_type and buffer, read =
key from buffer.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Re=
turn: 1 on success</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
       -1 read failure</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *         0 on key length mismatch</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_key(struct key *=
key, const struct key_type *kt, struct buffer *buf)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    uint8_t cipher_length;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    uint8_t hmac_length;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   CLEAR(*key);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!buf_read(buf, &amp;cipher_length, 1))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        goto read_err;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf=
_read(buf, &amp;hmac_length, 1))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   goto read_err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (cipher_length !=3D cipher_kt_key_=
size(kt-&gt;cipher) || hmac_length !=3D md_kt_size(kt-&gt;digest))</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        goto key_len_err;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!buf_read(buf, key-&gt;cipher, cipher_length))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        goto read_err;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!buf_read(buf, key-&gt;hmac, hmac_length))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        goto read_err;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-read_err:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg(D_TLS_ERRORS, &quot;TLS Error: error reading key from remo=
te&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
-1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-key_len_err:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(D_TLS_ERRORS,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        &quot;TLS Error: key length mismatch, lo=
cal cipher/hmac %d/%d, remote cipher/hmac %d/%d&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        cipher_kt_key_size(kt-&gt;cipher),=
 md_kt_size(kt-&gt;digest), cipher_length, hmac_length);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> void</span><br><span> prng_bytes(uint8_t *output, =
int len)</span><br><span> {</span><br><span>diff --git a/src/openvpn/crypto=
.h b/src/openvpn/crypto.h</span><br><span>index d91de74..074dad6 100644</sp=
an><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/c=
rypto.h</span><br><span>@@ -313,11 +313,6 @@</span><br><span> </span><br><s=
pan> bool check_key(struct key *key, const struct key_type *kt);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool write_key=
(const struct key *key, const struct key_type *kt,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-               struct buffer *buf);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-int read_key(struct key *key, const struct key_type *=
kt, struct buffer *buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> /**</span><br><span>  * Initialize a key_type structur=
e with.</span><br><span>  *</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/784?usp=3Demail">chang=
e 784</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/784?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib480e57b62ea33f2aea52bee895=
badaf5607b72d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 784 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--bqvspbaVtoo=--

