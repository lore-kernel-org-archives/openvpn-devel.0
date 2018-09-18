References: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
 <1536916459-25900-1-git-send-email-steffan.karger@...1435...>
 <1536916459-25900-3-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b82a18b0-4d79-4896-d732-6ccb59028344@...1227...>
Date: Tue, 18 Sep 2018 10:47:07 +0200
MIME-Version: 1.0
In-Reply-To: <1536916459-25900-3-git-send-email-steffan.karger@...1435...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] mbedtls: remove dependency on
 mbedtls pkcs11 module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

Am 14.09.18 um 11:14 schrieb Steffan Karger:
> Instead of using mbedtls's pkcs11 module, reuse the code we already have
> for management-external-key to also do pkcs11 signatures.  As far as mbed
> is concerned, we simply provide an external signature.
> 
> This has the following advantages:
>  * We no longer need mbed TLS to be compiled with the pkcs11 modules
>    enabled (which is not enabled by default).  This makes it easier to use
>    a system/distribution-provided mbed shared library.
>  * We no longer have a dependency on pkcs11-helper through mbed TLS.  So if
>    we want to migrate to some other pkcs11 lib (see e.g. trac #491, #538
>    and #549 for reason why), this will be easier.
> 
> While touching this code, switch from M_FATAL to M_WARN and proper error
> handling.  This improves the error reporting, and helps prevent potential
> future DoS attacks if someone starts using these functions on peer input.
> 

Ack. The code makes sense. I could not really test it since I don't have
a PCKS#11 environement to test it but it looks good enough and I assume
Steffan has already tested it.

Acked-By: Arne Schwabe <arne@...1227...>

