Message-ID: <53B8585A.1050506@...1856...>
Date: Sat, 05 Jul 2014 21:56:10 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <20140705104614.C1FB0C00CF@...1920...>
In-Reply-To: <20140705104614.C1FB0C00CF@...1920...>
Subject: Re: [Openvpn-devel] Security fix: Patch RSA key length from 4096 to
 16384 bits to support enough security for negotiation of AES-256.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Thank you for sharing your concerns.

On 05-07-14 12:46, caritas.moral@...1919... wrote:
> NSA says you have to protect an AES-256 key with RSA/Diffie Hellman 15360 bit.
> http://www.nsa.gov/business/programs/elliptic_curve.shtml
> 
> 4096 bit RSA/Diffie Hellman is only secure for AES-128.
> NSA: "To use RSA or Diffie-Hellman to protect 128-bit AES keys one should use 3072-bit parameters"
> 
> EU says you have to protect an AES-256 key with RSA 15424 bit.
> http://ec.europa.eu/information_society/apps/projects/logos/6/216676/080/deliverables/001_DSPA20.pdf
>  Page 30 (39 of 121) Table 7.2

What those documents do is try to match the strengths of the different
algorithms. It is true that the weakest link defines the end security
level you achieve, but it is not true that e.g. one *has to* protect
AES-256 with 15424 bits RSA keys. Shorter keys work just fine, you'll
just and up with a lower overall security level.

Also, if you want to achieve such security levels, consider using ECDSA
and ECDH instead of RSA and DH, that reduces the computational cost a
lot at the same security level. The OpenVPN master branch (working
towards 2.4) has full support for both ECDH and ECDSA.

> Please support 16384 bit RSA/Diffie Hellman keys like NSS/OpenSSL.

It is not the OpenVPN implementation that limits the RSA key
size, but the OpenSSL implementation. Up to very recently (this
afternoon actually) OpenSSL limited the RSA key size to 4096 bits in
their SSL code. See:
http://rt.openssl.org/Ticket/Display.html?user=guest&pass=guest&id=319
and
https://github.com/openssl/openssl/commit/c923132e9dfc9bb42c5dda822033b822d1d5cbe8

I just verified this locally; when supplying OpenVPN with 8192 bits RSA
keys, it will produce this error:

TLS_ERROR: BIO read tls_read_plaintext error: error:1408E098:SSL
routines:SSL3_GET_MESSAGE:excessive message size

That error originates from OpenSSL, not OpenVPN.

The same happens when using large DH keys, see this report on the
OpenVPN forum:
https://forums.openvpn.net/topic13776.html

Also note the time it took that user to generate his 8192 bits
DH-params. That's why I didn't verify that myself.

> In src/openvpn/ssl.h#L113
> you have to change
>             #define TLS_OPTIONS_LEN 512
> (512 bytes = 4096 bit)
> to
>              #define TLS_OPTIONS_LEN 2048
> (2048 bytes = 16384 bit)

That actually has nothing to do with TLS key lengths; TLS_OPTIONS_LEN
limits the length of openvpn-specific options exchanged after a
successful TLS session was established.

> Most people don't know that using RSA 4096 bit with Diffie Hellman 1024 bit results to a security as you would use a RSA 1024 bit key.
> So additionally you should implement a check that RSA and DH key have the same lengths.

Although I'm not immediately opposed to this, it should be a warning at
most. Enforcing this would break a lot of setups.

Furthermore, in practicable terms DH-keys can be considered 'safer' than
RSA-keys of the same size, see for example:
http://security.stackexchange.com/questions/42812/1024-bit-dhe-vs-2048-bit-rsa

The gist of it (in this context) is:
1) The best known algorithms for solving the factorization (RSA) problem
are a bit more efficient than those solving the discrete logarithm (DH)
problem.
2) When using RSA private keys, the DH keys are freshly generated (and
thus unique) for each connection, while RSA private keys are the same
for each connection.

Combining that with the large computational cost of large keys, I think
there certainly is a case for using DH keys smaller than your RSA keys.

Note that all this assumed using RSA private keys for you peers. One
could (probably, I didn't test) use DH-private keys (a DH private key
signed by your CA). In that case the DH key *is* reused for every
connection, but since there is no private RSA key in this scenario,
there's nothing to check. However, I've never seen someone using OpenVPN
this way.

I hope this helps answer your concerns.

Regards,
-Steffan

