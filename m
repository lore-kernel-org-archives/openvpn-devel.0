MIME-Version: 1.0
References: <20211201180727.2496903-1-arne@...1227...>
 <20211210130651.3623725-1-arne@...1227...>
 <YbNtaWgZi/8MAyJW@...1296...>
In-Reply-To: <YbNtaWgZi/8MAyJW@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 10 Dec 2021 13:02:34 -0500
Message-ID: <CAKuzo_iRhRH8vx3vsHVUpe3GVFvFTBHXyarpwWDCuMAFH_UoFA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 7/9] Remove cipher_kt_t and change
 type to const char* in API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Fri, Dec 10, 2021 at 10:09 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Fri, Dec 10, 2021 at 02:06:51PM +0100, Arne Schwabe wrote:
> > Patch v3: fix errors with mbed TLS without having md_kt to const char *=
 patch
> >           also applied, fix logic inversion in tls_crypt_tk
>
> Thanks, this is much better than v2 - now all client-side tests pass
> that led to "openvpn exiting" previously, or SIGSEGV'ing.
>
> *BUT* - it totally fails to work on a connection that negotiates BF-CBC,
> though, both with mbedTLS 2.27.0 and with OpenSSL 1.1.1l - I did not see
> it in the client side tests first (because I only ran a limited subset),
> but it is easily triggered by connecting to a 2.3 server, requiring
> fallback to BF-CBC.
>
> It also fails all server side tests that end up in trying to use BF-CBC
> (long e-mail cut short).
>
> Most notable indication is: with an older binary, I get these lines
> in the log:
>
> 2021-12-10 15:53:14 us=3D406619 cron2-freebsd-tc-amd64-24/194.97.140.21:4=
0161 Outgoing Data Channel: Cipher 'BF-CBC' initialized with 128 bit key
> 2021-12-10 15:53:14 us=3D406645 cron2-freebsd-tc-amd64-24/194.97.140.21:4=
0161 WARNING: INSECURE cipher (BF-CBC) with block size less than 128 bit (6=
4 bit).  This allows attacks like SWEET32.  Mitigate by using a --cipher wi=
th a larger block size (e.g. AES-256-CBC). Support for these insecure ciphe=
rs will be removed in OpenVPN 2.6.
>
> which are totally missing (!) for master + 7/9v3.

This may be related to this chunk:

@@ -2762,16 +2762,19 @@ do_init_crypto_tls_c1(struct context *c)

         * Note that BF-CBC will still be part of the OCC string to retain
         * backwards compatibility with older clients.
         */
+        const char* ciphername =3D options->ciphername;
         if (!streq(options->ciphername, "BF-CBC")
             || tls_item_in_cipher_list("BF-CBC", options->ncp_ciphers)
             || options->enable_ncp_fallback)
         {
-            /* Do not warn if the if the cipher is used only in OCC */
-            bool warn =3D options->enable_ncp_fallback;
-            init_key_type(&c->c1.ks.key_type, options->ciphername,
options->authname,
-                          true, warn);
+            ciphername =3D "none";
         }

+        /* Do not warn if the cipher is used only in OCC */
+        bool warn =3D options->enable_ncp_fallback;
+        init_key_type(&c->c1.ks.key_type, ciphername, options->authname,
+                      true, warn);
+

Selva

