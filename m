References: <80e6b449-c536-dc87-7215-3693872bce5a@...376...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ca3ab76a-ecc4-e652-4d23-275d389f0380@...1856...>
Date: Thu, 5 Oct 2017 15:49:19 +0200
MIME-Version: 1.0
In-Reply-To: <80e6b449-c536-dc87-7215-3693872bce5a@...376...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] openssl 1.1 tls version support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Kurt Roeckx <kurt@...2310...>

Hi,

Thanks for taking this to the openvpn-devel list.

The proposed patch doesn't follow our approach of hiding the openssl
1.0/1.1 API compatibility mess inside openssl_compat.h, so we'll have to
rework it before including it.  I will pick this up some time soon, but
have very limited access to internet (nor time to hack on openvpn)
currently, so it might take me a few weeks.  But there won't be a
release before that time anyway, and in the mean time users that are
really caught by this can put "@SECLEVEL=1" inside their --tls-cipher to
work around this if I understand the docs correctly [0].

@Kurt: for future reference, how are we supposed to be aware of these
kind of deprecated functions, and how do we know what The New Right Way
is?  https://wiki.openssl.org/index.php/OpenSSL_1.1.0_Changes for
example does not mention this at all.

-Steffan

[0]
https://www.openssl.org/docs/man1.1.0/ssl/SSL_CTX_get_security_level.html

On 04-10-17 16:38, Bernhard Schmidt wrote:
> Hi,
> 
> in https://bugs.debian.org/873302 Kurt Roeckx (Debian OpenSSL
> maintainer) submitted a patch for OpenVPN to properly set  the minimum
> and maximum TLS version. On Debian Buster (current development) OpenSSL
> 1.1 defaults to TLSv1.2+ only.
> 
> I'm unwilling to carry crypto specific patches in Debian. Can anyone
> make some sense out of this and apply the patch if possible?
> 
> Please keep Kurt CCed and direct any questions to him.
> 
> Bernhard
> 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

