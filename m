Subject: Re: [Openvpn-devel] PATCH[1/2]: Use certificates from MS Cert Store with CryptoAPI
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1098084812.36872@...41...>
In-Reply-To: <416D2FE2.7080408@...292...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 18 00:34:03 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Peter 'Luna' Runestig <peter+openvpn@...292...>, openvpn-devel@lists.sourceforge.net

Peter 'Luna' Runestig <peter+openvpn@...292...> said:

> Hi all!
> 
> Let me first say how impressed with the smooth functionality of this
> excellent piece of software! I have evaluated some other, commercial,
> SSL/TLS VPN solutions, but this is the best one, and at a much lower
> price... :-)
> 
> What I really wanted to use with OpenVPN, is smart cards for user
> authentication, on the Microsoft Windows platform. I have written some
> code that adds the option of using certificates (and their private
> keys), that resides in the Windows Certificate System Store. That makes
> it possible to use any smart card, supported by Windows, but also any
> kind of certificate, residing in the Cert Store, that you have access to
> the private key of. I have tested this code with a couple of different
> smart cards (GemSAFE, Cryptoflex and Swedish Post Office eID) on the
> client side, and also an imported PKCS12 software certificate on the
> server side.
> 
> The code adds a new config option: cryptoapicert
> To select a certificate, based on a substring search in the
> certificate's subject:
> 
> cryptoapicert "SUBJ:Peter Runestig"
> 
> To select a certificate, based on certificate's thumbprint:
> 
> cryptoapicert "THUMB:f6 49 24 41 01 b4 ..."
> 
> The thumbprint hex string can easily be copy-and-pasted from the Windows
> Certificate Store GUI.
> 
> Unfortunately, this code don't build with MinGW; e.g. the
> CryptAcquireCertificatePrivateKey() isn't implemented in MinGW, so I had
> to use Microsoft Visual C++ 6.0. So the patch included in this post is
> actually my hack to build OpenVPN using MSVC++, which must be applied
> before the actual CryptoAPI patch, which will be in my next post (I
> split it in two, so the posts don't get so big).
> 
> To build this, using MSVC 6.0:
> 
> o Unpack openvpn-2.0_beta11.zip, apply the MSVC patch in this post, and
> the CryptoAPI patch in my next post.
> 
> o If the OpenSSL and/or LZO libraries (built with MSVC or something else
> that gives you .LIB files) isn't reachable using the INCLUDE and LIB
> environment variables, edit the 'makefile.w32-vc' file to point them out.
> 
> o nmake -f makefile.w32-vc

I've merged the MSVC patch for beta12, but I will hold off on the CryptoAPI
patch until we have some kind of MinGW solution, such as

(1) Add support for native build with MinGW, or
(2) Make SSL_CTX_use_CryptoAPI_certificate.[ch] into an MSVC-built DLL which
can be dynamically linked from MinGW-built code.

James


