References: <20210407191554.25811-1-maximilian.fillinger@...2507...>
 <E1lUDfq-000423-FN@...2487...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <72fe8d0a-1732-3c25-3050-abc54c606e4d@...2181...>
Date: Thu, 8 Apr 2021 00:40:41 +0200
MIME-Version: 1.0
In-Reply-To: <E1lUDfq-000423-FN@...2487...>
Content-Type: multipart/mixed; boundary="------------076775E3F262E6FDDC910E94"
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/1] Rework mbedtls CRL handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------076775E3F262E6FDDC910E94
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Max,

On 07/04/2021 21:15, Max Fillinger wrote:
> This commit fixes the following two issues:
> 
> The config belonging to a mbedtls_ssl_ctx struct is not supposed to be
> changed after mbedtls_ssl_setup() has been called. Previously, we
> modified the CRL structure in place when a new CRL was loaded, but a
> pointer to this struct appears in configs that are currently in use.
> 
> This commit uses reference counting to ensure that CRLs remain in memory
> while the mbedtls_ssl_ctx struct and config remain.
> 

To fix this issue, wouldn't be enough to reload the CRL *before* calling
mbedtls_ssl_setup()?
This way we know that a new ssl_ctx is always initialized with the
latest CRL, rather than having the old one still around?

I have attached a proposal for your review. Please let me know what you
think about it.

As a side note: how did you notice this issue?

> The other issue fixed by this commit is that, if OpenVPN failed to read
> the CRL in init_ssl(), but succeeded in reading it later, it would not
> actually use that CRL.

Mh... I have tried to reproduce this issue, but I was not able to.
Would you be able to provide me with the exact steps to hit this situation?

What I tried was:
1) create empty file crl.pem;
2) start server with --crl-verify crl.pem;
3) connect with client -> connection denied due to verification issue
(VERIFY ERROR: CRL not loaded);
4) I overwrote crl.pem with a real CRL (without restarting the server);
5) I connected with my client and it worked;
6) I connected with a certificate in the CRL -> connection denied.


Btw, Signed-off-by line is missing - a patch submitted for inclusion
should always have one.



Regards,


-- 
Antonio Quartulli

--------------076775E3F262E6FDDC910E94
Content-Type: text/x-patch; charset=UTF-8;
 name="crl.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="crl.diff"

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d8662d00..eda7fae1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -899,6 +899,17 @@ key_state_init(struct tls_session *session, struct k=
ey_state *ks)
=20
     CLEAR(*ks);
=20
+    /*
+     * Attempt CRL reload before any TLS operation. Won't be performed i=
f
+     * the file was not modified since the last reload
+     */
+    if (session->opt->crl_file
+        && !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
+    {
+        tls_ctx_reload_crl(&session->opt->ssl_ctx, session->opt->crl_fil=
e,
+                           session->opt->crl_file_inline);
+    }
+
     /*
      * Build TLS object that reads/writes ciphertext
      * to/from memory BIOs.
@@ -2728,17 +2739,6 @@ tls_process(struct tls_multi *multi,
             ks->state =3D S_START;
             state_change =3D true;
=20
-            /*
-             * Attempt CRL reload before TLS negotiation. Won't be perfo=
rmed if
-             * the file was not modified since the last reload
-             */
-            if (session->opt->crl_file
-                && !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
-            {
-                tls_ctx_reload_crl(&session->opt->ssl_ctx,
-                                   session->opt->crl_file, session->opt-=
>crl_file_inline);
-            }
-
             /* New connection, remove any old X509 env variables */
             tls_x509_clear_env(session->opt->es);
=20

--------------076775E3F262E6FDDC910E94--

