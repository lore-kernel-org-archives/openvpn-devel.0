MIME-Version: 1.0
In-Reply-To: <1602769.mufAxrVebs@...2113...>
References: <1452433475-16779-1-git-send-email-niels_ole@...2112...>
	<4a50bbce-f8a1-f295-4c93-8817be8612c8@...1227...>
	<1602769.mufAxrVebs@...2113...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 10 Jan 2016 16:32:06 +0100
Message-ID: <CAA1AbxKcwc611-Z6jdNAeLuM0cR-n3rCmnEgGB5coSBAkrrkwg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix build with libressl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Niels Ole Salscheider <niels_ole@...2112...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Jan 10, 2016 at 3:23 PM, Niels Ole Salscheider
<niels_ole@...2112...> wrote:
> On Sunday, 10 January 2016, 15:15:49 CET, Arne Schwabe wrote:
>> On 10.01.2016 14:44, Niels Ole Salscheider wrote:
>> > Signed-off-by: Niels Ole Salscheider <niels_ole@...2112...>
>> > ---
>> >
>> >  src/openvpn/ssl_openssl.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> > index d2f40e7..e390f4d 100644
>> > --- a/src/openvpn/ssl_openssl.c
>> > +++ b/src/openvpn/ssl_openssl.c
>> > @@ -358,7 +358,7 @@ tls_ctx_check_cert_time (const struct tls_root_ctx
>> > *ctx)>
>> >    ASSERT (ctx);
>> >
>> > -#if OPENSSL_VERSION_NUMBER >= 0x10002000L
>> > +#if OPENSSL_VERSION_NUMBER >= 0x10002000L &&
>> > !defined(LIBRESSL_VERSION_NUMBER)>
>> >    /* OpenSSL 1.0.2 and up */
>> >    cert = SSL_CTX_get0_certificate (ctx->ctx);
>> >
>> >  #else
>> >
>> > @@ -393,7 +393,7 @@ tls_ctx_check_cert_time (const struct tls_root_ctx
>> > *ctx)>
>> >      }
>> >
>> >  cleanup:
>> > -#if OPENSSL_VERSION_NUMBER < 0x10002000L
>> > +#if OPENSSL_VERSION_NUMBER < 0x10002000L ||
>> > defined(LIBRESSL_VERSION_NUMBER)>
>> >    SSL_free (ssl);
>> >
>> >  #endif
>> >
>> >    return;
>>
>> LibreSSL is like: We are OpenSSL 1.0.2 but have a different API?! That
>> sounds like a LibreSSL bug.
>
> LibreSSL just returns its version number in OPENSSL_VERSION_NUMBER (which is
> currently higher than OpenSSL's one).

No, libressl returns a fixed version (2.0.0) in OPENSSL_VERSION_NUMBER.

> Since they removed some old stuff they
> cannot offer a superset of OpenSSL's API anyway and thus it is not clear how
> to choose the "right" value (according to your reasoning) for
> OPENSSL_VERSION_NUMBER.
> I guess we have no choice but to handle this ourselves (or to leave it broken
> for LibreSSL).

Tbh, I didn't even know that openvpn compiled with libressl.  And just
to be perfectly clear on this: we do not support libressl as a crypto
backend.

That said, this patch is rather minimal and if this indeed is the only
thing needed to work with libressl, I can live with it.  In other
words: slightly reluctant ACK.

-Steffan

