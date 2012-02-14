Message-ID: <4F3AD2B8.1030201@...1549...>
Date: Tue, 14 Feb 2012 22:31:36 +0100
From: Freek Dijkstra <public@...1549...>
MIME-Version: 1.0
References: <4F36E202.3010503@...1549...>
	<1CED409804E2164C8104F9E623B08B90129336981D@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90129336981D@...1436...>
Subject: Re: [Openvpn-devel] Cipher problem on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Adriaan,

Thanks a lot for your efforts!

> --- SNIP ---
> #include <stdio.h>
> #include <openssl/evp.h>
>=20
> int main()
> {
>         OpenSSL_add_all_algorithms();
>=20
>         const EVP_CIPHER *ciph =3D EVP_get_cipherbyname ("BF-CBC");
>         printf("%p\n", ciph);
>=20
>         printf ("EVP_CIPH_CBC_MODE: %u\n", EVP_CIPH_CBC_MODE);
>         printf ("Function: %lu\n", EVP_CIPHER_mode (ciph));
>         return 0;
> }
>=20
> --- SNIP ---
>=20
> The commands would be:
>=20
> $ gcc <sourcefile.c> -lssl
> $ ./a.out

I added -lcrypto as well:

% gcc -L/opt/local/lib -I/opt/local/include -lssl -lcrypt sourcefile.c
% ./a.out
0x100e37d60
EVP_CIPH_CBC_MODE: 2
Function: 2

FYI, this is with Openssl 1.0.0f (installed with MacPorts, a package
maanger for Mac OS X).

The result with OpenSSL 0.9.8r (that came with Mac OS X) is:

% gcc -L/usr/lib -I/usr/include -lssl -lcrypto sourcefile.c
sourcefile.c: In function =E2=80=98main=E2=80=99:
sourcefile.c:6: warning: =E2=80=98OPENSSL_add_all_algorithms_noconf=E2=80=
=99 is
deprecated (declared at /usr/include/openssl/evp.h:828)
sourcefile.c:8: warning: =E2=80=98EVP_get_cipherbyname=E2=80=99 is deprecat=
ed (declared
at /usr/include/openssl/evp.h:848)
sourcefile.c:12: warning: =E2=80=98EVP_CIPHER_flags=E2=80=99 is deprecated =
(declared at
/usr/include/openssl/evp.h:496)
% ./a.out
0x7fff75d9d000
EVP_CIPH_CBC_MODE: 2
Function: 2

> Unfortunately I don't have direct access to a mac

If required, I may be able to get you access next weekend.

Freek

