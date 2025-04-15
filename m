From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Apr 2025 18:14:41 +0000
In-Reply-To: <gerrit.1744192676000.I9a27248557fabcd9f7584deb4aba16cd71fb803c@...2715...>
References: <gerrit.1744192676000.I9a27248557fabcd9f7584deb4aba16cd71fb803c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dbf9ca767dc12b8c4654f66c3eec3e1cf078df0b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gw3F+68dCHo="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Gw3F+68dCHo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/936?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/936/2

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
Gerrit-MessageType: newpatchset

--Gw3F+68dCHo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/936?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Doxygen: Clean up tls-crypt documentation<br><br=
>- Fix broken links to OpenSSL documentation<br>- Remove some unnecessary \=
c for function names.<br>  Doxygen does handle them automatically.<br>- Add=
 some \c for --option since otherwise --<br>  gets converted to one charact=
er (e.g. &amp;ndash; in<br>  HTML).<br><br>Change-Id: I9a27248557fabcd9f758=
4deb4aba16cd71fb803c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message=
-Id: &lt;20250415155720.13034-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg31434.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/doxygen/doc_con=
trol_tls.h<br>M src/openvpn/tls_crypt.h<br>2 files changed, 16 insertions(+=
), 16 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/36/936/2</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/doc/doxygen/doc_control_tls.h =
b/doc/doxygen/doc_control_tls.h</span><br><span>index 7ff5e99..3c92a76 1006=
44</span><br><span>--- a/doc/doxygen/doc_control_tls.h</span><br><span>+++ =
b/doc/doxygen/doc_control_tls.h</span><br><span>@@ -49,7 +49,7 @@</span><br=
><span>  *</span><br><span>  * @par</span><br><span>  * The former role is =
described below.  The latter is described in the</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * documentation for the \c verify_callback() fu=
nction.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * documenta=
tion for the verify_callback() function.</span><br><span>  *</span><br><spa=
n>  * @par</span><br><span>  * In other words, this module takes care of th=
e confidentiality and</span><br><span>@@ -61,7 +61,7 @@</span><br><span>  *=
 Because of the one-to-one relationship between control channel TLS</span><=
br><span>  * state and \c key_state structures, the initialization and clea=
nup of an</span><br><span>  * instance of the Control Channel TLS module&#3=
9;s state happens within the</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * \c key_state_init() and \c key_state_free() functions.  In other =
words,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * key_state_=
init() and key_state_free() functions.  In other words,</span><br><span>  *=
 each \c key_state object contains exactly one OpenSSL SSL-BIO object,</spa=
n><br><span>  * which is initialized and cleaned up together with the rest =
of the \c</span><br><span>  * key_state object.</span><br><span>@@ -69,26 +=
69,26 @@</span><br><span>  * @par Packet processing functions</span><br><sp=
an>  * This object behaves somewhat like a black box with a ciphertext and =
a</span><br><span>  * plaintext I/O port. Its interaction with OpenVPN&#39;=
s control channel</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * d=
uring operation takes place within the \c tls_process() function of</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * during operation takes p=
lace within the tls_process() function of</span><br><span>  * the \link con=
trol_processor Control Channel Processor\endlink.  The</span><br><span>  * =
following functions are available for processing packets:</span><br><span> =
 * - If ciphertext received from the remote peer is available in the \link<=
/span><br><span>  *   reliable Reliability Layer\endlink:</span><br><span> =
 *   - Insert it into the ciphertext-side of the SSL-BIO.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *   - Use function: \c key_state_write=
_ciphertext()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   -=
 Use function: key_state_write_ciphertext()</span><br><span>  * - If cipher=
text can be extracted from the ciphertext-side of the</span><br><span>  *  =
 SSL-BIO:</span><br><span>  *   - Pass it to the \link reliable Reliability=
 Layer\endlink for sending</span><br><span>  *     to the remote peer.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *   - Use function: \c ke=
y_state_read_ciphertext()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *   - Use function: key_state_read_ciphertext()</span><br><span>  * =
- If plaintext can be extracted from the plaintext-side of the SSL-BIO:</sp=
an><br><span>  *   - Pass it on to the \link control_processor Control Chan=
nel</span><br><span>  *     Processor\endlink for local processing.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *   - Use function: \c key_s=
tate_read_plaintext()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *   - Use function: key_state_read_plaintext()</span><br><span>  * - If =
plaintext from the \link control_processor Control Channel</span><br><span>=
  *   Processor\endlink is available to be sent to the remote peer:</span><=
br><span>  *   - Insert it into the plaintext-side of the SSL-BIO.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *   - Use function: \c key_st=
ate_write_plaintext() or \c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *   - Use function: key_state_write_plaintext() or</span><br><span=
>  *     key_state_write_plaintext_const()</span><br><span>  *</span><br><s=
pan>  * @par Transport Layer Security protocol implementation</span><br><sp=
an>@@ -98,7 +98,7 @@</span><br><span>  * @par</span><br><span>  * For more =
information on the OpenSSL library&#39;s BIO objects, please see:</span><br=
><span>  *  - OpenSSL&#39;s generic BIO objects:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *    http://www.openssl.org/docs/crypto/bio.htm=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    https://docs=
.openssl.org/master/man7/bio/#bio</span><br><span>  *  - OpenSSL&#39;s SSL-=
BIO object:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    http=
://www.openssl.org/docs/crypto/BIO_f_ssl.html</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *    https://docs.openssl.org/master/man3/BIO_f_=
ssl/#bio_f_ssl</span><br><span>  */</span><br><span>diff --git a/src/openvp=
n/tls_crypt.h b/src/openvpn/tls_crypt.h</span><br><span>index 1a604ce..87e9=
867 100644</span><br><span>--- a/src/openvpn/tls_crypt.h</span><br><span>++=
+ b/src/openvpn/tls_crypt.h</span><br><span>@@ -22,11 +22,11 @@</span><br><=
span>  */</span><br><span> </span><br><span> /**</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @defgroup tls_crypt Control channel encryptio=
n (--tls-crypt, --tls-crypt-v2)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @defgroup tls_crypt Control channel encryption (tls-crypt, t=
ls-crypt-v2)</span><br><span>  * @ingroup control_tls</span><br><span>  * @=
{</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * Control channel encryption uses a pre-shared static key (like the --tls-=
auth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Control chan=
nel encryption uses a pre-shared static key (like the @c --tls-auth</span><=
br><span>  * key) to encrypt control channel packets.</span><br><span>  *</=
span><br><span>  * Encrypting control channel packets has three main advant=
ages:</span><br><span>@@ -36,8 +36,8 @@</span><br><span>  *  - It provides =
&quot;poor-man&#39;s&quot; post-quantum security, against attackers who</sp=
an><br><span>  *    will never know the pre-shared key (i.e. no forward sec=
recy).</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * --tls-crypt uses a tls-auth-style group key, where all servers and =
clients</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * share the s=
ame group key. --tls-crypt-v2 adds support for client-specific</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @c --tls-crypt uses a tls-aut=
h-style group key, where all servers and clients</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * share the same group key. @c --tls-crypt-v2=
 adds support for client-specific</span><br><span>  * keys, where all serve=
rs share the same client-key encryption key, and each</span><br><span>  * c=
lients receives a unique client key, both in plaintext and in encrypted</sp=
an><br><span>  * form.  When connecting to a server, the client sends the e=
ncrypted key to</span><br><span>@@ -103,7 +103,7 @@</span><br><span>       =
                                              + sizeof(uint16_t)))</span><b=
r><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Initialize a key_ctx_bi structure for use with --tls-crypt.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initialize a key_ctx=
_bi structure for use with @c --tls-crypt.</span><br><span>  *</span><br><s=
pan>  * @param key           The key context to initialize</span><br><span>=
  * @param key_file      The file to read the key from or the key itself if=
</span><br><span>@@ -141,7 +141,7 @@</span><br><span>  * @param dst   Any d=
ata present in this buffer is first authenticated, then</span><br><span>  *=
              the wrapped packet id and data from the src buffer are append=
ed.</span><br><span>  *              Must have at least tls_crypt_buf_overh=
ead()+BLEN(src) headroom.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param opt   The crypto state for this --tls-crypt instance.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opt   The crypto =
state for this @c --tls-crypt instance.</span><br><span>  *</span><br><span=
>  * @returns true iff wrapping succeeded.</span><br><span>  */</span><br><=
span>@@ -154,7 +154,7 @@</span><br><span>  *</span><br><span>  * @param src=
   Data to decrypt and authenticate.</span><br><span>  * @param dst   Retur=
ns the decrypted data, if unwrapping was successful.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param opt   The crypto state for this -=
-tls-crypt instance.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param opt   The crypto state for this @c --tls-crypt instance.</span><=
br><span>  *</span><br><span>  * @returns true iff unwrapping succeeded (da=
ta authenticated correctly and was</span><br><span>  * no replay).</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/936?usp=3Demail">change 936</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
936?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Gw3F+68dCHo=--

