Message-ID: <4B96616C.1010806@...1114...>
Date: Tue, 09 Mar 2010 15:55:40 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268145282-8727-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1268145282-8727-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Don't ASSERT() on stream cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: "Vladimir I. Kobylyanskiy" <kentlinux@...384...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/03/10 15:34, David Sommerseth wrote:
> From: Vladimir I. Kobylyanskiy <kentlinux@...384...>
> 
> We (Ltd. LISSI, http://www.lissi.ru, info at lissi.ru),
> are trying to use OpenVPN with stream ciphers,
> including Russian cipher GOST
> 28147-89(ALLOW_NON_CBC_CIPHERS flag is set).
> 
> And we found the bug:
> function EVP_CipherFinal() returns 0, when cipher has
> block_size == 1(stream cipher). So hear is the patch to
> fix the bug.
> 
> sf.net tracker:
> <https://sourceforge.net/tracker/?func=detail&aid=1552062&group_id=48978&atid=454721>
> 
[...snip...]
> +	  if (mode == EVP_CIPH_CBC_MODE)
> +            ASSERT (outlen == iv_size);

Could someone please reassure that this is the right way how to solve
this issue?  This new if statement seems to me to be too invasive.  The
different cipher modes I found references to are:

#define         EVP_CIPH_STREAM_CIPHER          0x0
#define         EVP_CIPH_ECB_MODE               0x1
#define         EVP_CIPH_CBC_MODE               0x2
#define         EVP_CIPH_CFB_MODE               0x3
#define         EVP_CIPH_OFB_MODE               0x4
#define         EVP_CIPH_MODE                   0x7
(Extracts from /usr/include/openssl/evp.h)

I'm not a crypto expert, but for me this change seems to skip the
ASSERT() check on too many EVP_CIPH_*_MODEs.  On cipher modes supporting
streams, that probably need to be skipped.

Any objections or clarifications are highly appreciated.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuWYWgACgkQDC186MBRfroc9QCbBhd+ZImYE8MO557HPXBdnWMM
p/IAn1RlDN7WuKfYpmPkOIiTtH4zZ5Gv
=KX7E
-----END PGP SIGNATURE-----

