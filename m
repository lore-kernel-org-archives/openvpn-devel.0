Message-ID: <1517252540.3969.29.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 29 Jan 2018 11:02:20 -0800
In-Reply-To: <955e1519-6ecb-6e5e-bc95-eab7db284848@...1227...>
References: <1516998568.3034.15.camel@...2316...>
 <1516998620.3034.16.camel@...2316...>
 <955e1519-6ecb-6e5e-bc95-eab7db284848@...1227...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] PATCH v3 1/2] openssl: add engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On Mon, 2018-01-29 at 08:43 +0100, Arne Schwabe wrote:
> Am 26.01.18 um 21:30 schrieb James Bottomley:
> > 
> > As well as doing crypto acceleration, engines can also be used to
> > load key files.  If the engine is set, and the private key loading
> > fails for bio methods, this patch makes openvpn try to get the
> > engine to load the key.  If that succeeds, we end up using an
> > engine based key. This can be used with the openssl tpm engines to
> > make openvpn use a TPM wrapped key file.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@...2376...
> > om>
> > 
> > ---
> > 
> > v2: add better configuration guarding
> > ---
> >  src/openvpn/crypto_openssl.c | 55
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  src/openvpn/crypto_openssl.h | 12 ++++++++++
> >  src/openvpn/ssl_openssl.c    |  6 ++++-
> >  3 files changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/openvpn/crypto_openssl.c
> > b/src/openvpn/crypto_openssl.c
> > index 20a519ec..d3f35030 100644
> > --- a/src/openvpn/crypto_openssl.c
> > +++ b/src/openvpn/crypto_openssl.c
> > @@ -969,4 +969,59 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
> >      HMAC_Final(ctx, dst, &in_hmac_len);
> >  }
> >  
> > +#if HAVE_OPENSSL_ENGINE
> > +static int
> > +ui_read(UI *ui, UI_STRING *uis)
> 
> I would rather a bit more verbose method name here. ui_read seems a
> bit too generic.

I can call it anything you like, but the naming scheme in the file
seems to be <openssl structure>_<function>, like md_ctx_init() etc,
EVP_MD_CTX is the structure and init the function.  Here UI is the
structure and read the function.  Would you prefer UI_reader to match
the method set name?

> > +{
> > +    SSL_CTX *ctx = UI_get0_user_data(ui);
> > +
> > +    if (UI_get_string_type(uis) == UIT_PROMPT) {
> > +        pem_password_cb *cb = SSL_CTX_get_default_passwd_cb(ctx);
> > +        void *d = SSL_CTX_get_default_passwd_cb_userdata(ctx);
> 
> This pointer is never used and the function also seem to have no side
> effects. So seem like this can be removed.

It's used two lines below:

> > 
> > +        char password[64];
> > +
> > +        cb(password, sizeof(password), 0, d);

Here              -----------------------------^

If you mean it can be removed because the openssl password callback
data pointer is never used in the openvpn implementation then, yes,
that's true, but I think following the openssl standard practice is
better otherwise engine keys would break if someone ever found a future
openvpn use for the data pointer.

> > +        UI_set_result(ui, uis, password);
> > +
> > +        return 1;
> > +    }
> > +    return 0;
> > +}
> > +#endif
> > +
> > +EVP_PKEY *
> > +engine_load_key(const char *file, SSL_CTX *ctx)
> > +{
> > +#if HAVE_OPENSSL_ENGINE
> > +    UI_METHOD *ui;
> > +    EVP_PKEY *pkey;
> > +
> > +    if (!engine_persist)
> > +        return NULL;
> > +
> > +    ui = UI_create_method("openvpn");
> > +
> > +    if (!ui)
> > +        return NULL;
> > +
> > +    UI_method_set_reader(ui, ui_read);
> > +
> > +    ERR_clear_error();		/* BIO read failure */
> > +    if (!ENGINE_init(engine_persist)) {
> > +	ERR_print_errors_fp(stderr);
> 
> This should use our standard openssl error reporting. Not directly
> writing to stderr.

Agreed, I'll make them crypto_msg() calls.

James

> > 
> > +	pkey = NULL;
> > +	goto out;
> > +    }
> > +    pkey = ENGINE_load_private_key(engine_persist, file, ui, ctx);
> > +    ENGINE_finish(engine_persist);
> > +    if (!pkey)
> > +	ERR_print_errors_fp(stderr);
> 
> Same as above.
> 
> > 
> > + out:
> > +    UI_destroy_method(ui);
> > +    return pkey;
> > +#else
> > +    return NULL;
> > +#endif
> > +}
> 


