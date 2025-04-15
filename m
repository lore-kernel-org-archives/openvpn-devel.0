From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Apr 2025 18:14:43 +0000
In-Reply-To: <gerrit.1744192676000.I9a27248557fabcd9f7584deb4aba16cd71fb803c@...2715...>
References: <gerrit.1744192676000.I9a27248557fabcd9f7584deb4aba16cd71fb803c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dbf9ca767dc12b8c4654f66c3eec3e1cf078df0b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VbfJw0Ark+4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VbfJw0Ark+4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
6?usp=3Demail )

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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250415155720.13034-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
434.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/doxygen/doc_control_tls.h
M src/openvpn/tls_crypt.h
2 files changed, 16 insertions(+), 16 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--VbfJw0Ark+4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/936?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Doxygen: Clean up tls-crypt documentation<br><=
br>- Fix broken links to OpenSSL documentation<br>- Remove some unnecessary=
 \c for function names.<br>  Doxygen does handle them automatically.<br>- A=
dd some \c for --option since otherwise --<br>  gets converted to one chara=
cter (e.g. &amp;ndash; in<br>  HTML).<br><br>Change-Id: I9a27248557fabcd9f7=
584deb4aba16cd71fb803c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Messa=
ge-Id: &lt;20250415155720.13034-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg31434.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/doxygen/doc_c=
ontrol_tls.h<br>M src/openvpn/tls_crypt.h<br>2 files changed, 16 insertions=
(+), 16 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls=
.h</span><br><span>index 7ff5e99..3c92a76 100644</span><br><span>--- a/doc/=
doxygen/doc_control_tls.h</span><br><span>+++ b/doc/doxygen/doc_control_tls=
.h</span><br><span>@@ -49,7 +49,7 @@</span><br><span>  *</span><br><span>  =
* @par</span><br><span>  * The former role is described below.  The latter =
is described in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 documentation for the \c verify_callback() function.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * documentation for the verify_callback(=
) function.</span><br><span>  *</span><br><span>  * @par</span><br><span>  =
* In other words, this module takes care of the confidentiality and</span><=
br><span>@@ -61,7 +61,7 @@</span><br><span>  * Because of the one-to-one re=
lationship between control channel TLS</span><br><span>  * state and \c key=
_state structures, the initialization and cleanup of an</span><br><span>  *=
 instance of the Control Channel TLS module&#39;s state happens within the<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * \c key_state_init()=
 and \c key_state_free() functions.  In other words,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * key_state_init() and key_state_free() =
functions.  In other words,</span><br><span>  * each \c key_state object co=
ntains exactly one OpenSSL SSL-BIO object,</span><br><span>  * which is ini=
tialized and cleaned up together with the rest of the \c</span><br><span>  =
* key_state object.</span><br><span>@@ -69,26 +69,26 @@</span><br><span>  *=
 @par Packet processing functions</span><br><span>  * This object behaves s=
omewhat like a black box with a ciphertext and a</span><br><span>  * plaint=
ext I/O port. Its interaction with OpenVPN&#39;s control channel</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * during operation takes place =
within the \c tls_process() function of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * during operation takes place within the tls_process(=
) function of</span><br><span>  * the \link control_processor Control Chann=
el Processor\endlink.  The</span><br><span>  * following functions are avai=
lable for processing packets:</span><br><span>  * - If ciphertext received =
from the remote peer is available in the \link</span><br><span>  *   reliab=
le Reliability Layer\endlink:</span><br><span>  *   - Insert it into the ci=
phertext-side of the SSL-BIO.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *   - Use function: \c key_state_write_ciphertext()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *   - Use function: key_state_wri=
te_ciphertext()</span><br><span>  * - If ciphertext can be extracted from t=
he ciphertext-side of the</span><br><span>  *   SSL-BIO:</span><br><span>  =
*   - Pass it to the \link reliable Reliability Layer\endlink for sending</=
span><br><span>  *     to the remote peer.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *   - Use function: \c key_state_read_ciphertext()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - Use function: k=
ey_state_read_ciphertext()</span><br><span>  * - If plaintext can be extrac=
ted from the plaintext-side of the SSL-BIO:</span><br><span>  *   - Pass it=
 on to the \link control_processor Control Channel</span><br><span>  *     =
Processor\endlink for local processing.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *   - Use function: \c key_state_read_plaintext()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - Use function: key_s=
tate_read_plaintext()</span><br><span>  * - If plaintext from the \link con=
trol_processor Control Channel</span><br><span>  *   Processor\endlink is a=
vailable to be sent to the remote peer:</span><br><span>  *   - Insert it i=
nto the plaintext-side of the SSL-BIO.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *   - Use function: \c key_state_write_plaintext() or \c<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - Use function:=
 key_state_write_plaintext() or</span><br><span>  *     key_state_write_pla=
intext_const()</span><br><span>  *</span><br><span>  * @par Transport Layer=
 Security protocol implementation</span><br><span>@@ -98,7 +98,7 @@</span><=
br><span>  * @par</span><br><span>  * For more information on the OpenSSL l=
ibrary&#39;s BIO objects, please see:</span><br><span>  *  - OpenSSL&#39;s =
generic BIO objects:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*    http://www.openssl.org/docs/crypto/bio.html</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *    https://docs.openssl.org/master/man7/bio=
/#bio</span><br><span>  *  - OpenSSL&#39;s SSL-BIO object:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *    http://www.openssl.org/docs/cryp=
to/BIO_f_ssl.html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
    https://docs.openssl.org/master/man3/BIO_f_ssl/#bio_f_ssl</span><br><sp=
an>  */</span><br><span>diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/=
tls_crypt.h</span><br><span>index 1a604ce..87e9867 100644</span><br><span>-=
-- a/src/openvpn/tls_crypt.h</span><br><span>+++ b/src/openvpn/tls_crypt.h<=
/span><br><span>@@ -22,11 +22,11 @@</span><br><span>  */</span><br><span> <=
/span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @defgroup tls_crypt Control channel encryption (--tls-crypt, --tls-crypt-=
v2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @defgroup tls=
_crypt Control channel encryption (tls-crypt, tls-crypt-v2)</span><br><span=
>  * @ingroup control_tls</span><br><span>  * @{</span><br><span>  *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Control channel encryptio=
n uses a pre-shared static key (like the --tls-auth</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Control channel encryption uses a pre-=
shared static key (like the @c --tls-auth</span><br><span>  * key) to encry=
pt control channel packets.</span><br><span>  *</span><br><span>  * Encrypt=
ing control channel packets has three main advantages:</span><br><span>@@ -=
36,8 +36,8 @@</span><br><span>  *  - It provides &quot;poor-man&#39;s&quot;=
 post-quantum security, against attackers who</span><br><span>  *    will n=
ever know the pre-shared key (i.e. no forward secrecy).</span><br><span>  *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --tls-crypt uses a=
 tls-auth-style group key, where all servers and clients</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * share the same group key. --tls-crypt=
-v2 adds support for client-specific</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @c --tls-crypt uses a tls-auth-style group key, where a=
ll servers and clients</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * share the same group key. @c --tls-crypt-v2 adds support for client-s=
pecific</span><br><span>  * keys, where all servers share the same client-k=
ey encryption key, and each</span><br><span>  * clients receives a unique c=
lient key, both in plaintext and in encrypted</span><br><span>  * form.  Wh=
en connecting to a server, the client sends the encrypted key to</span><br>=
<span>@@ -103,7 +103,7 @@</span><br><span>                                 =
                    + sizeof(uint16_t)))</span><br><span> </span><br><span>=
 /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Initialize a k=
ey_ctx_bi structure for use with --tls-crypt.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Initialize a key_ctx_bi structure for use with=
 @c --tls-crypt.</span><br><span>  *</span><br><span>  * @param key        =
   The key context to initialize</span><br><span>  * @param key_file      T=
he file to read the key from or the key itself if</span><br><span>@@ -141,7=
 +141,7 @@</span><br><span>  * @param dst   Any data present in this buffer=
 is first authenticated, then</span><br><span>  *              the wrapped =
packet id and data from the src buffer are appended.</span><br><span>  *   =
           Must have at least tls_crypt_buf_overhead()+BLEN(src) headroom.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param opt   The cr=
ypto state for this --tls-crypt instance.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param opt   The crypto state for this @c --tls-cr=
ypt instance.</span><br><span>  *</span><br><span>  * @returns true iff wra=
pping succeeded.</span><br><span>  */</span><br><span>@@ -154,7 +154,7 @@</=
span><br><span>  *</span><br><span>  * @param src   Data to decrypt and aut=
henticate.</span><br><span>  * @param dst   Returns the decrypted data, if =
unwrapping was successful.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @param opt   The crypto state for this --tls-crypt instance.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opt   The crypto=
 state for this @c --tls-crypt instance.</span><br><span>  *</span><br><spa=
n>  * @returns true iff unwrapping succeeded (data authenticated correctly =
and was</span><br><span>  * no replay).</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/936?usp=3D=
email">change 936</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/936?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a27248557fabcd9f7584deb4ab=
a16cd71fb803c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 936 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--VbfJw0Ark+4=--

