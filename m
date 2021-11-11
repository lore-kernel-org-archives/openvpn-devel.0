MIME-Version: 1.0
References: <20210520151148.2565578-7-arne@...1227...>
 <20211111192051.3706965-1-arne@...1227...>
 <YY2GYxV5lT8xVoF8@...1296...>
In-Reply-To: <YY2GYxV5lT8xVoF8@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Nov 2021 16:26:17 -0500
Message-ID: <CAKuzo_jqbuwOtwfjh9DZnf8OiMZ22AdSi6y3Nbw7dv+QU=GHDg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v5] [OSSL 3.0] Allow loading of non
 default providers
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
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, Nov 11, 2021 at 4:09 PM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Thu, Nov 11, 2021 at 08:20:51PM +0100, Arne Schwabe wrote:
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> > index b5d65d293..b1f9473dc 100644
> > --- a/src/openvpn/options.c
> > +++ b/src/openvpn/options.c
> > @@ -8157,6 +8158,13 @@ add_option(struct options *options,
> >              options->engine = "auto";
> >          }
> >      }
> > +    else if (streq(p[0], "providers") && p[1])
> > +    {
> > +        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL;j++)
> > +        {
> > +            options->providers.names[j] = p[j];
> > +        }
> > +    }
> >  #endif /* ENABLE_CRYPTO_MBEDTLS */
>
> This seems to be in an #ifndef ENABLE_CRYPTO_MBEDTLS block, which
> means an mbedTLS build won't understand the option "--providers"
> (but --help shows it, and there's a "mbed TLS provider functionality
> is not available" patch in crypto_mbedtls.c...)

hmm.. obviously I did not build with mbed TLS nor think about it. Some
empty functions in crypto_mbedtls.c are still required as the load and
unload are unconditionally called.

Moving this out of the #ifndef will make --help consistent with  the
option, but at the same time it's misleading to include this in --help
for mbedTLS builds: the user will get a warning if the option is used.
I think we should add this option to --help only for OpenSSL. And,
while parsing, add provider names to the list only for OpenSSL, show a
warning for mbedTLS. That way the list will remain empty for mbedTLS.
I'm supposing that we do not want --provider to become a M_FATAL error
in mbedTLS builds.

Whether the msg(WARN,..) in crypto_mbedtls.c are removed or not is a
matter of taste -- they will never get executed if not parsed here.

Selva

