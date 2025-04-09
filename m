From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 09:57:59 +0000
References: <gerrit.1744192676000.I9a27248557fabcd9f7584deb4aba16cd71fb803c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e95d6b3ee256a49bb0e903ad8a9d9f5a658bfdfa-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3CtGaLwvflU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Doxygen: Clean up
 tls-crypt documentation
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

--3CtGaLwvflU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/936?usp=3Demail

to review the following change.


Change subject: Doxygen: Clean up tls-crypt documentation
......................................................................

Doxygen: Clean up tls-crypt documentation

- Fix broken links to OpenSSL documentation
- Remove some unnecessary \c for function names.
  Doxygen does handle them automatically.
- Add some \c for --option since otherwise --
  gets converted to one character (e.g. &ndash; in
  HTML).

Change-Id: I9a27248557fabcd9f7584deb4aba16cd71fb803c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/doxygen/doc_control_tls.h
M src/openvpn/tls_crypt.h
2 files changed, 16 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/936/1

diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
index 7ff5e99..3c92a76 100644
--- a/doc/doxygen/doc_control_tls.h
+++ b/doc/doxygen/doc_control_tls.h
@@ -49,7 +49,7 @@
  *
  * @par
  * The former role is described below.  The latter is described in the
- * documentation for the \c verify_callback() function.
+ * documentation for the verify_callback() function.
  *
  * @par
  * In other words, this module takes care of the confidentiality and
@@ -61,7 +61,7 @@
  * Because of the one-to-one relationship between control channel TLS
  * state and \c key_state structures, the initialization and cleanup of an
  * instance of the Control Channel TLS module's state happens within the
- * \c key_state_init() and \c key_state_free() functions.  In other words,
+ * key_state_init() and key_state_free() functions.  In other words,
  * each \c key_state object contains exactly one OpenSSL SSL-BIO object,
  * which is initialized and cleaned up together with the rest of the \c
  * key_state object.
@@ -69,26 +69,26 @@
  * @par Packet processing functions
  * This object behaves somewhat like a black box with a ciphertext and a
  * plaintext I/O port. Its interaction with OpenVPN's control channel
- * during operation takes place within the \c tls_process() function of
+ * during operation takes place within the tls_process() function of
  * the \link control_processor Control Channel Processor\endlink.  The
  * following functions are available for processing packets:
  * - If ciphertext received from the remote peer is available in the \link
  *   reliable Reliability Layer\endlink:
  *   - Insert it into the ciphertext-side of the SSL-BIO.
- *   - Use function: \c key_state_write_ciphertext()
+ *   - Use function: key_state_write_ciphertext()
  * - If ciphertext can be extracted from the ciphertext-side of the
  *   SSL-BIO:
  *   - Pass it to the \link reliable Reliability Layer\endlink for sending
  *     to the remote peer.
- *   - Use function: \c key_state_read_ciphertext()
+ *   - Use function: key_state_read_ciphertext()
  * - If plaintext can be extracted from the plaintext-side of the SSL-BIO:
  *   - Pass it on to the \link control_processor Control Channel
  *     Processor\endlink for local processing.
- *   - Use function: \c key_state_read_plaintext()
+ *   - Use function: key_state_read_plaintext()
  * - If plaintext from the \link control_processor Control Channel
  *   Processor\endlink is available to be sent to the remote peer:
  *   - Insert it into the plaintext-side of the SSL-BIO.
- *   - Use function: \c key_state_write_plaintext() or \c
+ *   - Use function: key_state_write_plaintext() or
  *     key_state_write_plaintext_const()
  *
  * @par Transport Layer Security protocol implementation
@@ -98,7 +98,7 @@
  * @par
  * For more information on the OpenSSL library's BIO objects, please see:
  *  - OpenSSL's generic BIO objects:
- *    http://www.openssl.org/docs/crypto/bio.html
+ *    https://docs.openssl.org/master/man7/bio/#bio
  *  - OpenSSL's SSL-BIO object:
- *    http://www.openssl.org/docs/crypto/BIO_f_ssl.html
+ *    https://docs.openssl.org/master/man3/BIO_f_ssl/#bio_f_ssl
  */
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 1a604ce..87e9867 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -22,11 +22,11 @@
  */

 /**
- * @defgroup tls_crypt Control channel encryption (--tls-crypt, --tls-cryp=
t-v2)
+ * @defgroup tls_crypt Control channel encryption (tls-crypt, tls-crypt-v2)
  * @ingroup control_tls
  * @{
  *
- * Control channel encryption uses a pre-shared static key (like the --tls=
-auth
+ * Control channel encryption uses a pre-shared static key (like the @c --=
tls-auth
  * key) to encrypt control channel packets.
  *
  * Encrypting control channel packets has three main advantages:
@@ -36,8 +36,8 @@
  *  - It provides "poor-man's" post-quantum security, against attackers who
  *    will never know the pre-shared key (i.e. no forward secrecy).
  *
- * --tls-crypt uses a tls-auth-style group key, where all servers and clie=
nts
- * share the same group key. --tls-crypt-v2 adds support for client-specif=
ic
+ * @c --tls-crypt uses a tls-auth-style group key, where all servers and c=
lients
+ * share the same group key. @c --tls-crypt-v2 adds support for client-spe=
cific
  * keys, where all servers share the same client-key encryption key, and e=
ach
  * clients receives a unique client key, both in plaintext and in encrypted
  * form.  When connecting to a server, the client sends the encrypted key =
to
@@ -103,7 +103,7 @@
                                                     + sizeof(uint16_t)))

 /**
- * Initialize a key_ctx_bi structure for use with --tls-crypt.
+ * Initialize a key_ctx_bi structure for use with @c --tls-crypt.
  *
  * @param key           The key context to initialize
  * @param key_file      The file to read the key from or the key itself if
@@ -141,7 +141,7 @@
  * @param dst   Any data present in this buffer is first authenticated, th=
en
  *              the wrapped packet id and data from the src buffer are app=
ended.
  *              Must have at least tls_crypt_buf_overhead()+BLEN(src) head=
room.
- * @param opt   The crypto state for this --tls-crypt instance.
+ * @param opt   The crypto state for this @c --tls-crypt instance.
  *
  * @returns true iff wrapping succeeded.
  */
@@ -154,7 +154,7 @@
  *
  * @param src   Data to decrypt and authenticate.
  * @param dst   Returns the decrypted data, if unwrapping was successful.
- * @param opt   The crypto state for this --tls-crypt instance.
+ * @param opt   The crypto state for this @c --tls-crypt instance.
  *
  * @returns true iff unwrapping succeeded (data authenticated correctly an=
d was
  * no replay).

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/936?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9a27248557fabcd9f7584deb4aba16cd71fb803c
Gerrit-Change-Number: 936
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--3CtGaLwvflU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/936?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Doxygen: Clean up tls-crypt documentation<br><br>- Fix broken=
 links to OpenSSL documentation<br>- Remove some unnecessary \c for functio=
n names.<br>  Doxygen does handle them automatically.<br>- Add some \c for =
--option since otherwise --<br>  gets converted to one character (e.g. &amp=
;ndash; in<br>  HTML).<br><br>Change-Id: I9a27248557fabcd9f7584deb4aba16cd7=
1fb803c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---=
<br>M doc/doxygen/doc_control_tls.h<br>M src/openvpn/tls_crypt.h<br>2 files=
 changed, 16 insertions(+), 16 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/36/936/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/d=
oxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h</span><br><span>in=
dex 7ff5e99..3c92a76 100644</span><br><span>--- a/doc/doxygen/doc_control_t=
ls.h</span><br><span>+++ b/doc/doxygen/doc_control_tls.h</span><br><span>@@=
 -49,7 +49,7 @@</span><br><span>  *</span><br><span>  * @par</span><br><spa=
n>  * The former role is described below.  The latter is described in the</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * documentation for th=
e \c verify_callback() function.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * documentation for the verify_callback() function.</span><br=
><span>  *</span><br><span>  * @par</span><br><span>  * In other words, thi=
s module takes care of the confidentiality and</span><br><span>@@ -61,7 +61=
,7 @@</span><br><span>  * Because of the one-to-one relationship between co=
ntrol channel TLS</span><br><span>  * state and \c key_state structures, th=
e initialization and cleanup of an</span><br><span>  * instance of the Cont=
rol Channel TLS module&#39;s state happens within the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * \c key_state_init() and \c key_state_fre=
e() functions.  In other words,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * key_state_init() and key_state_free() functions.  In other w=
ords,</span><br><span>  * each \c key_state object contains exactly one Ope=
nSSL SSL-BIO object,</span><br><span>  * which is initialized and cleaned u=
p together with the rest of the \c</span><br><span>  * key_state object.</s=
pan><br><span>@@ -69,26 +69,26 @@</span><br><span>  * @par Packet processin=
g functions</span><br><span>  * This object behaves somewhat like a black b=
ox with a ciphertext and a</span><br><span>  * plaintext I/O port. Its inte=
raction with OpenVPN&#39;s control channel</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * during operation takes place within the \c tls_proc=
ess() function of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 during operation takes place within the tls_process() function of</span><b=
r><span>  * the \link control_processor Control Channel Processor\endlink. =
 The</span><br><span>  * following functions are available for processing p=
ackets:</span><br><span>  * - If ciphertext received from the remote peer i=
s available in the \link</span><br><span>  *   reliable Reliability Layer\e=
ndlink:</span><br><span>  *   - Insert it into the ciphertext-side of the S=
SL-BIO.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   - Use fun=
ction: \c key_state_write_ciphertext()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *   - Use function: key_state_write_ciphertext()</span>=
<br><span>  * - If ciphertext can be extracted from the ciphertext-side of =
the</span><br><span>  *   SSL-BIO:</span><br><span>  *   - Pass it to the \=
link reliable Reliability Layer\endlink for sending</span><br><span>  *    =
 to the remote peer.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*   - Use function: \c key_state_read_ciphertext()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *   - Use function: key_state_read_cipherte=
xt()</span><br><span>  * - If plaintext can be extracted from the plaintext=
-side of the SSL-BIO:</span><br><span>  *   - Pass it on to the \link contr=
ol_processor Control Channel</span><br><span>  *     Processor\endlink for =
local processing.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
 - Use function: \c key_state_read_plaintext()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *   - Use function: key_state_read_plaintext()<=
/span><br><span>  * - If plaintext from the \link control_processor Control=
 Channel</span><br><span>  *   Processor\endlink is available to be sent to=
 the remote peer:</span><br><span>  *   - Insert it into the plaintext-side=
 of the SSL-BIO.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   =
- Use function: \c key_state_write_plaintext() or \c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   - Use function: key_state_write_plai=
ntext() or</span><br><span>  *     key_state_write_plaintext_const()</span>=
<br><span>  *</span><br><span>  * @par Transport Layer Security protocol im=
plementation</span><br><span>@@ -98,7 +98,7 @@</span><br><span>  * @par</sp=
an><br><span>  * For more information on the OpenSSL library&#39;s BIO obje=
cts, please see:</span><br><span>  *  - OpenSSL&#39;s generic BIO objects:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    http://www.opens=
sl.org/docs/crypto/bio.html</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *    https://docs.openssl.org/master/man7/bio/#bio</span><br><span=
>  *  - OpenSSL&#39;s SSL-BIO object:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *    http://www.openssl.org/docs/crypto/BIO_f_ssl.html</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    https://docs.open=
ssl.org/master/man3/BIO_f_ssl/#bio_f_ssl</span><br><span>  */</span><br><sp=
an>diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h</span><br=
><span>index 1a604ce..87e9867 100644</span><br><span>--- a/src/openvpn/tls_=
crypt.h</span><br><span>+++ b/src/openvpn/tls_crypt.h</span><br><span>@@ -2=
2,11 +22,11 @@</span><br><span>  */</span><br><span> </span><br><span> /**<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @defgroup tls_crypt=
 Control channel encryption (--tls-crypt, --tls-crypt-v2)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @defgroup tls_crypt Control channe=
l encryption (tls-crypt, tls-crypt-v2)</span><br><span>  * @ingroup control=
_tls</span><br><span>  * @{</span><br><span>  *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Control channel encryption uses a pre-shared s=
tatic key (like the --tls-auth</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Control channel encryption uses a pre-shared static key (like=
 the @c --tls-auth</span><br><span>  * key) to encrypt control channel pack=
ets.</span><br><span>  *</span><br><span>  * Encrypting control channel pac=
kets has three main advantages:</span><br><span>@@ -36,8 +36,8 @@</span><br=
><span>  *  - It provides &quot;poor-man&#39;s&quot; post-quantum security,=
 against attackers who</span><br><span>  *    will never know the pre-share=
d key (i.e. no forward secrecy).</span><br><span>  *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * --tls-crypt uses a tls-auth-style group =
key, where all servers and clients</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * share the same group key. --tls-crypt-v2 adds support for c=
lient-specific</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @c=
 --tls-crypt uses a tls-auth-style group key, where all servers and clients=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * share the same g=
roup key. @c --tls-crypt-v2 adds support for client-specific</span><br><spa=
n>  * keys, where all servers share the same client-key encryption key, and=
 each</span><br><span>  * clients receives a unique client key, both in pla=
intext and in encrypted</span><br><span>  * form.  When connecting to a ser=
ver, the client sends the encrypted key to</span><br><span>@@ -103,7 +103,7=
 @@</span><br><span>                                                     + =
sizeof(uint16_t)))</span><br><span> </span><br><span> /**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Initialize a key_ctx_bi structure fo=
r use with --tls-crypt.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Initialize a key_ctx_bi structure for use with @c --tls-crypt.</span=
><br><span>  *</span><br><span>  * @param key           The key context to =
initialize</span><br><span>  * @param key_file      The file to read the ke=
y from or the key itself if</span><br><span>@@ -141,7 +141,7 @@</span><br><=
span>  * @param dst   Any data present in this buffer is first authenticate=
d, then</span><br><span>  *              the wrapped packet id and data fro=
m the src buffer are appended.</span><br><span>  *              Must have a=
t least tls_crypt_buf_overhead()+BLEN(src) headroom.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param opt   The crypto state for this -=
-tls-crypt instance.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param opt   The crypto state for this @c --tls-crypt instance.</span><=
br><span>  *</span><br><span>  * @returns true iff wrapping succeeded.</spa=
n><br><span>  */</span><br><span>@@ -154,7 +154,7 @@</span><br><span>  *</s=
pan><br><span>  * @param src   Data to decrypt and authenticate.</span><br>=
<span>  * @param dst   Returns the decrypted data, if unwrapping was succes=
sful.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param opt   =
The crypto state for this --tls-crypt instance.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param opt   The crypto state for this @c --=
tls-crypt instance.</span><br><span>  *</span><br><span>  * @returns true i=
ff unwrapping succeeded (data authenticated correctly and was</span><br><sp=
an>  * no replay).</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/936?usp=3Demail">change 936</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/936?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a27248557fabcd9f7584deb4ab=
a16cd71fb803c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 936 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--3CtGaLwvflU=--

