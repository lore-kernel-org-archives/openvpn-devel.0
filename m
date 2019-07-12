MIME-Version: 1.0
References: <20190403225657.8003-1-rosenp@...277...>
 <c6020cbf-4340-7e24-9bbc-50fbe6b2112d@...1227...>
In-Reply-To: <c6020cbf-4340-7e24-9bbc-50fbe6b2112d@...1227...>
From: Rosen Penev <rosenp@...277...>
Date: Fri, 12 Jul 2019 12:22:23 -0700
Message-ID: <CAKxU2N_npn5fTsM=8606-Hkgm3=4pFE9nHLkaw=6Lq11E_33yA@...278...>
Subject: Re: [Openvpn-devel] [PATCHv2] openssl: Fix compilation without
 deprecated OpenSSL 1.1 APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Jun 14, 2019 at 3:38 AM Arne Schwabe <arne@...1227...> wrote:
>
> Am 04.04.19 um 00:56 schrieb Rosen Penev:
> > EVP_CIPHER_CTX_init and _cleanup were deprecated in 1.1 and both were
> > replaced with _reset.
> >
> > Also removed initialization with OpenSSL 1.1 as it is no longer needed and
> > causes compilation errors when disabling deprecated APIs.
> >
> > Same with SSL_CTX_set_ecdh_auto as it got removed.
> >
>
> This gets kind of an ACK but needs some additional changes to be really
> good.
>
>
> >
> > +#if !defined(HAVE_EVP_CIPHER_CTX_INIT)
> > +#define EVP_CIPHER_CTX_init EVP_CIPHER_CTX_reset
> > +#endif
> > +
> > +#if !defined(HAVE_EVP_CIPHER_CTX_CLEANUP)
> > +#define EVP_CIPHER_CTX_cleanup EVP_CIPHER_CTX_reset
> > +#endif
>
> These two keep the older API instead of switching to the new one, from
> OpenSSL.
Yes I know. I feel that it's a cleaner solution as _init and _cleanup
both get defined to _reset.
>
> # if OPENSSL_API_COMPAT < 0x10100000L
> #  define EVP_CIPHER_CTX_init(c)      EVP_CIPHER_CTX_reset(c)
> #  define EVP_CIPHER_CTX_cleanup(c)   EVP_CIPHER_CTX_reset(c)
> # endif
>
> Since just using only the new API in this case does not really work I
> think in case it would be better to rather always use
> EVP_CIPHER_CTX_reset isntead of init and  have ifdefs in the 2-3 places
> where we actually use EVP_CIPHER_CTX_cleanup so we can remove the old
> API when we bump our minimum OpenSSL version (and find this thing easy
> since it is an ifdef depending on the openssl version).
OK. Will change.
>
> > +
> > +#if !defined(HAVE_X509_GET0_NOTBEFORE)
> > +#define X509_get0_notBefore X509_get_notBefore
> > +#endif
> > +
> > +#if !defined(HAVE_X509_GET0_NOTAFTER)
> > +#define X509_get0_notAfter X509_get_notAfter
> > +#endif
> > +
> >  #if !defined(HAVE_HMAC_CTX_RESET)
> >  /**
> >   * Reset a HMAC context
> > diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> > index 8bcebac4..e41cafa5 100644
> > --- a/src/openvpn/ssl_openssl.c
> > +++ b/src/openvpn/ssl_openssl.c
> > @@ -76,12 +76,13 @@ int mydata_index; /* GLOBAL */
> >  void
> >  tls_init_lib(void)
> >  {
> > +#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
> >      SSL_library_init();
> > -#ifndef ENABLE_SMALL
> > +# ifndef ENABLE_SMALL
>
> The space between # and ifndef looks wrong.
Will eliminate. Not sure exactly why I added the space ATM.
>
>
> Arne
>

