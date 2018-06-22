MIME-Version: 1.0
References: <20180620044650.18041-1-rosenp@...277...>
 <20180620050012.GR57262@...1296...>
In-Reply-To: <20180620050012.GR57262@...1296...>
From: Rosen Penev <rosenp@...277...>
Date: Thu, 21 Jun 2018 18:42:11 -0700
Message-ID: <CAKxU2N99kz-gHTvBXVfp800PHESGmJ73gF-fKgq-nyC=bd3oLw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Fix compilation with
 deprecated APIs disabled on 1.1
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
To: gert@...1296...
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jun 19, 2018 at 10:00 PM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Tue, Jun 19, 2018 at 09:46:50PM -0700, Rosen Penev wrote:
> > Signed-off-by: Rosen Penev <rosenp@...277...>
> > ---
> >  src/openvpn/crypto_openssl.c     |  9 +++++++++
> >  src/openvpn/ssl_openssl.c        | 32 +++++++++++++++++++++++++++++++-
> >  src/openvpn/ssl_verify_openssl.c |  1 +
> >  3 files changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> > index 4fb2f6d6..816d8002 100644
> > --- a/src/openvpn/crypto_openssl.c
> > +++ b/src/openvpn/crypto_openssl.c
> > @@ -670,11 +670,16 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
> >  {
> >      ASSERT(NULL != kt && NULL != ctx);
> >
> > +#if OPENSSL_VERSION_NUMBER < 0x10100000L
> >      EVP_CIPHER_CTX_init(ctx);
> > +#else
> > +    EVP_CIPHER_CTX_new();
> > +#endif
>
> Thanks for the patch, but this is not the way we want our source to
> look like.  As in: these extra #if will make maintaining the code
> harder and more error-prone.
>
>
> A patch along the lines of the existing openssl 1.1 / 1.0 compat layer
> (the .c files call the 1.1 API and if that API is not available,
> openssl_compat.h provides a substitute function) would be something
> we might look more closely into.
I ran this on a client. Turns out there are more problems than this. I
will submit a partial fix in the meantime.
>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...

