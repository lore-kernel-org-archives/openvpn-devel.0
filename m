From: David Sommerseth <openvpn@...2080...>
Message-ID: <35b26cf2-5b2e-be38-6cd5-99356bece635@...2080...>
Date: Thu, 3 Nov 2016 22:03:53 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] Considering to send AUTH_FAILED on TLS errors
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

During the review of the CRL improvement patch, I briefly mentioned
that clients do not disconnect gracefully if the TLS layer does not
accept the client certificate (like when it is on a CRL).

I have spent some time looking through the code to see what is needed.
 And what is a fairly simple thing seems to get fairly complicated.
So I'm just starting this discussion to see if we can find some good
approaches.

The main challenge is that we should use the send_auth_failed()
function, which takes a struct context object as well as a reason.  So
calling this function like this:

      send_auth_failed(c, "REVOKED: Certificate is revoked");

will result in a control channel message saying:

      AUTH_FAILED,REVOKED: Certificate is revoked

Now this is fairly simple and easy.  send_auth_failed() does all the
needed magic to ensure the rejection is scheduled to be sent to the
client ASAP and formatted properly on the wire.

The challenge is that this function needs a struct context object.
And that object isn't easily available.  So the call chain I've
detected is something like this (in reverse order)

   - send_auth_failed()  [new call, not present today]
   - verify_callback()   [in ssl_verify_{openssl,mbedtls].c]

This isn't bad at all.  The verify_callback() is configured in the SSL
library doing the client verification.

For OpenSSL it is SSL_CTX_set_verify() together with SSL_set_ex_data()
which provides a "data payload" passed to the callback (retrieved via
SSL_get_ex_data()).

For mbedTLS it is a bit simpler, mbedtls_ssl_conf_verify() takes an
argument to both the callback function and a pointer to the data
payload to be passed directly to the verify_callback() function.

All this happens inside the key_state_ssl_init() functions, which have
the same unified API in both OpenSSL and mbedTLS.

We need the struct tls_session object in the verify callback, so I
thought we would wrap this up in a static struct which carries a
pointer to both struct context and the relevant struct tls_session
objects.  But that means we need to get the struct context object to
the key_state_ssl_init() function.  Now it gets more complicated.

   - key_state_ssl_init()   [ssl_{openssl,mbedtls}.c]
   - key_state_init()       [ssl.c]
   - tls_session_init()     [ssl.c]
   - move_session(), reset_session(), tls_multi_init_finalize()

So three paths ...

   * (1) move_session()     [ssl.c]
   - tls_multi_process()    [ssl.c]
   - check_tls_dowork()     [forward.c]
        ** MATCH ** Here we have struct context

   * (2) reset_session()    [ssl.c]
   - tls_muli_process()     [ssl.c]
   - check_tls_dowork()     [forward.c]
        ** MATCH ** Here we have struct context

   * (3) tls_multi_init_finalize() [ssl.c]
   - do_init_finalize_tls_frame()  [init.c]
        ** MATCH ** Here we have struct context


One approach, which will require some efforts is to pass a pointer to
the struct context object through the call chains identified above.
Some of them might be simplified by replacing at least struct
tls_multi objects with struct context, as the struct tls_multi object
is part of struct context_2 which is part of struct context.  Inside
struct tls_multi, you will also find struct tls_session - but there
are more of them, so that is a bit more complicated as we need to pass
the proper tls_session object to the verify_callback() function.

I find this approach to be quite intrusive.  I've done a similar task
for the --auth-gen-token patches to resolve a similar issue [1], and
that also required some refactoring - though not as much as here -
which makes me wonder if I have overlooked two of the code paths
detected in this review.

[1] <http://bit.ly/2ejcwG2> [mail post at mail-archive.com]

There is a more "simple" approach, but I consider that to be bad in a
larger perspective.  The struct tls_session object could carry a
pointer to the main struct context object.  But we already have a few
of those "back-and-forth" object pointers in the struct context,
struct context_2, struct tls_multi and struct tls_session - but for
other elements.  And it can be quite hard to catch who "owns" the main
pointer and who is just "borrowing access".  So I am very reluctant to
take this "easy path".

The question is ... does anyone else see a different or better
approach?  Thoughts, comments?


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYG6Y5AAoJEIbPlEyWcf3yRLgP/3eIB4DxVYxNTWXhIqVs8fU7
ZSF/LcEln+hvb3+1+TrV5es5To3x3DgXRgYNBxf82DuO8AICNV1feopo5TThoJl5
5cu+092U2kKb+qv6za/MfO6tM+WY0UDFMd+dp0CyrKmcX9SRnfNRiZ7+4RmNL0tu
tpFZOppRTBaJCg05ZqSFTbknXdXqTDNJX4789yUa+jcbqxAK6xGlrXLmaoXTZE5N
dp10gXosKcDs6VlhXM+R43HQsnggNeBzdG0Cclc2pBiLFVCLY6joiWvizZkXL+N1
NBpz7HcOeT/x7bxjEw72G19gYUHkesoFOR/TT0rCDJ3wmLG9OAlGewbje7Ac9NrA
lT+3q6qMmnlQEoXnTjF7+I/ajqBtRnvwjaeuMQhcMuXm6+cb0pW4GMC3HZzG3HFx
8ZNFFKAHkDu4bk+kqufWwBYdDzNRgqgXy5gFNMy2veP+oiWMdh17N9ayIZdpyd96
eSMYGjQBQjrfh8ANszqsrysaMlDxJc7diJXf0Ro7OK2CUvap4k31LFwUhZPmhlXK
GFkOfSbYCnspOEfuCMvMNPo2qGVFJftDdJrhHPwba9of31foix3gJBQgfNJstvx+
Co0Q6nU83/2Hr9yLo+hvQ31vk5YXe2Mlxj3y+YCpPOAWW7qQr2OXKTWexudkKmId
kNA0YeHmkgtNfcHUKb8E
=3DM07m
-----END PGP SIGNATURE-----

