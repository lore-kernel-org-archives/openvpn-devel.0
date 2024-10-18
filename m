From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 18 Oct 2024 02:00:42 +0000
References: <gerrit.1729216832000.Ib480e57b62ea33f2aea52bee895badaf5607b72d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f484283124a02bd60d0338e1da8d3527a5060211-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0+O3EXY5yoc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0+O3EXY5yoc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/784?usp=3Demail

to review the following change.


Change subject: Remove unused methods write_key/read_key
......................................................................

Remove unused methods write_key/read_key

These were used in the key-method 1 that we remove by commit
36bef1b52 in 2020.  That commit unfortunately missed that these
methods were only used for directly sending/receiving key material
over the control channel.

Change-Id: Ib480e57b62ea33f2aea52bee895badaf5607b72d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 0 insertions(+), 86 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/784/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--0+O3EXY5yoc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/784?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove unused methods write_key/read_key<br><br>These were us=
ed in the key-method 1 that we remove by commit<br>36bef1b52 in 2020.  That=
 commit unfortunately missed that these<br>methods were only used for direc=
tly sending/receiving key material<br>over the control channel.<br><br>Chan=
ge-Id: Ib480e57b62ea33f2aea52bee895badaf5607b72d<br>Signed-off-by: Arne Sch=
wabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/open=
vpn/crypto.h<br>2 files changed, 0 insertions(+), 86 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/784/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><spa=
n>index 064e59e..8f34eaa 100644</span><br><span>--- a/src/openvpn/crypto.c<=
/span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -1540,87 +154=
0,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/* given a key and key_type, w=
rite key to buffer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_key(const s=
truct key *key, const struct key_type *kt,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-          struct buffer *buf)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ASSERT(cipher_kt_key_size(kt-&gt;cipher) &lt;=3D MAX_CIPHER_KE=
Y_LENGTH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &a=
mp;&amp; md_kt_size(kt-&gt;digest) &lt;=3D MAX_HMAC_KEY_LENGTH);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const uint8_t cipher_length =3D (uint8_t)cipher_k=
t_key_size(kt-&gt;cipher);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!buf_write(buf, &amp;cipher_length, 1))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t hmac_leng=
th =3D (uint8_t)md_kt_size(kt-&gt;digest);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (!buf_write(buf, &amp;hmac_length, 1))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
!buf_write(buf, key-&gt;cipher, cipher_kt_key_size(kt-&gt;cipher)))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!buf_write(buf, key-&gt;hmac, hmac_length))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Given a key_type and buffer, read key from buffer.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * Return: 1 on success</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *        -1 read failure</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *         0 on key length misma=
tch</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-read_key(struct key *key, const struct key_type *kt, s=
truct buffer *buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t cipher_leng=
th;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t hmac_l=
ength;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*key);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!buf_read(buf, &amp;cipher_length=
, 1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        goto read_err;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!buf_read(buf, &amp;hmac_length, 1))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        goto read_err;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (cipher_length !=3D cipher_kt_key_size(kt-&gt;cipher) || hmac_length =
!=3D md_kt_size(kt-&gt;digest))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  goto key_len_err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!buf_read(buf, key-&gt;cipher, =
cipher_length))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto read_err;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_read(buf, key-&gt;hmac, =
hmac_length))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto read_err;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_err:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_TLS_ERRORS, &quo=
t;TLS Error: error reading key from remote&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return -1;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-key_len_err:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
D_TLS_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
&quot;TLS Error: key length mismatch, local cipher/hmac %d/%d, remote ciphe=
r/hmac %d/%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      cipher_kt_key_size(kt-&gt;cipher), md_kt_size(kt-&gt;digest), cipher_=
length, hmac_length);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span=
><br><span> prng_bytes(uint8_t *output, int len)</span><br><span> {</span><=
br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br=
><span>index d91de74..074dad6 100644</span><br><span>--- a/src/openvpn/cryp=
to.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -313,11 =
+313,6 @@</span><br><span> </span><br><span> bool check_key(struct key *key=
, const struct key_type *kt);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-bool write_key(const struct key *key, const struc=
t key_type *kt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
         struct buffer *buf);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int read_key(=
struct key *key, const struct key_type *kt, struct buffer *buf);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br>=
<span>  * Initialize a key_type structure with.</span><br><span>  *</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/784?usp=3Demail">change 784</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/784?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib480e57b62ea33f2aea52bee895=
badaf5607b72d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 784 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--0+O3EXY5yoc=--

