From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 14 Feb 2012 18:27:37 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90129336981D@...1436...>
References: <4F36E202.3010503@...1549...>
In-Reply-To: <4F36E202.3010503@...1549...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Cipher problem on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Freek Dijkstra <public@...1549...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Freek Dijkstra [mailto:public@...1549...]
>=20
> Hi,


Hi Freek,

Sorry for the delay, but I've had some trouble replicating the bug.=20

>=20
> Sat Feb 11 22:46:37 2012 OpenVPN 2.x-master x86_64-apple-darwin11.2.0
> [SSL (OpenSSL)] [LZO2] [eurephia] [MH] [PF_INET6] [IPv6 payload
> 20110522-1 (2.2.0)] built on Feb 11 2012 Sat Feb 11 22:46:37 2012
> Cipher 'BF-CBC' uses a mode not supported by OpenVPN in your current
> ...

I've tried to replicate the bug on Linux and have been unsuccessful so far.=
 Thankfully a colleague managed to replicate it on a Mac using the stock Op=
enSSL (v0.9.8.something). I think it's related to the value returned by EVP=
_cipher_mode(). Unfortunately I don't have direct access to a mac, so could=
 you try compiling and running the following code, please?

--- SNIP ---
#include <stdio.h>
#include <openssl/evp.h>

int main()
{
        OpenSSL_add_all_algorithms();

        const EVP_CIPHER *ciph =3D EVP_get_cipherbyname ("BF-CBC");
        printf("%p\n", ciph);

        printf ("EVP_CIPH_CBC_MODE: %u\n", EVP_CIPH_CBC_MODE);
        printf ("Function: %lu\n", EVP_CIPHER_mode (ciph));
        return 0;
}

--- SNIP ---

The commands would be:

$ gcc <sourcefile.c> -lssl
$ ./a.out

Thanks,
Adriaan de Jong

