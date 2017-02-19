References: <cover.1487368114.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
Date: Sun, 19 Feb 2017 13:03:45 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1487368114.git.logout@...260...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi Emmanuel,

On 17-02-17 23:00, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
> 
> The purpose of this RFC series is to make the latest master of OpenVPN
> (2.5-git) linkable with OpenSSL v1.1.x. It may not be complete (I may
> have missed something due to my work environment, but any missing pieces
> will be added next week) so be a bit cautious with this. The 
> configuration I used (--without-systemd, --without-lzo) seems to work
> but I must confess I did not tested much. 
> 
> As you may know, the important information about the API of OpenSSL 1.1
> if that it no longer provide access to the content of its objects. The
> structure types are now opaque and various functions have been added to
> fetch information from these objects. 
> 
> Once theses patches have been applied, it is possible to compile 
> OpenSSL with the latest 1.0.1 and with the latest 1.1.0. I still have to
> check whether compilation with 1.0.0 and 0.9.8 works. I don't try to 
> get the OpenSSL version -- I instead decided to check for the presence
> of individual functions in the library and chose to reimplement the 
> missing ones. Then I changed caller code in order to use this new
> interface. The net result is that OpenVPN is now using the OpenSSL 1.1
> API -- regardless of the real version of OpenSSL. This might make futur
> changes simpler at the cost of adding more functions in the 
> openssl_compat.h file. 
> 
> Las but not least, because of the way I worked I introduced some strange 
> artefacts (I believe they are not really relevant but some of them are 
> weird enough to need some explaination). 
> 
> * I had to introduce a function of the 1.0 API in the 1.1 code. In the
>   1.0 API, HMAC_CTX is populated with HMAC_CTX_init() and cleaned with
>   HMAC_CTX_cleanup(). In 1.1 these two functions are gone and replaced
>   with HMAC_CTX_reset(). I decided to use _reset() to implement 
>   _cleanup() but since I then could not use it for _init() (that would
>   break an OpenVPN linked with 1.0) I created a small wrapper in 1.1
>   mode. So, in 1.1, HMAC_CTX_init() calls _reset() -- and everybody is
>   happy (well, maybe not everybody).  
>   
> * HMAC_CTX, EVP_MD_CTX and a few other objects cannot be allocated using
>   malloc() so I had to change the way these object are used and 
>   initialized. I introduces a few new functions in the crypto backend to
>   handle this.
> 
> * x509_verify_ns_cert_type() checks had to be changed. OpenSSL 1.1 does 
>   not provide any solution to access both X509::ex_flags and 
>   X509::ex_nscert so the check could not be implemented this way. The
>   only solution I found was to use X509_check_purpose() but I'm worried
>   that the implemented test is now far more strict. 
> 
> * weirdly enough, it's no longer possible to duplicate the n parameter
>   of a RSA public key into another RSA public key. If you do so, you
>   also need to duplicate the e parameter. The reason is that you cannot
>   have (n && !e) or (!n && e) (see RSA_set0_key[1]). I deciced to go
>   the same route in my implementation and thus I needed to change the
>   code in tls_ctx_use_external_private_key(). 
> 
> Thanks for your comprehension, 
> 
> [1] https://github.com/openssl/openssl/blob/master/crypto/rsa/rsa_lib.c#L191
> 
> -- Emmanuel Deloget

Thank you very much.  You approach looks good to me, and quite closely
matches what I had in mind for when I would find the time to tackle
this.  (Which might have taken me a while, so really happy to see these
patches!)

As discussed in other threads, we do want to support building on RHEL6,
which is why we would prefer to be compatible with (patched) OpenSSL
0.9.8.  I haven't tested anything yet, but looking at the patches this
might very well just work, or otherwise just needs some minor tweaking.

Also very good that this is split up into small and independently
reviewable patches.  I'll start review soon.

-Steffan

