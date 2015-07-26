Message-ID: <55B56347.7010304@...1147...>
Date: Mon, 27 Jul 2015 00:46:31 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <COL128-W360F356FA6F45FADFFC4D6CA810@...512...>,
	<55B1FF56.4000209@...1147...>
	<COL128-W59456CBB4B786DDF3AECEECA800@...512...>
In-Reply-To: <COL128-W59456CBB4B786DDF3AECEECA800@...512...>
Content-Type: multipart/alternative;
	boundary="------------060309060200030604000808"
Subject: Re: [Openvpn-devel] Does Openvpn really support cryptodev hardware
 accelerators
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: li yuqian <liyuqian08@...2047...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060309060200030604000808
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 25/07/15 03:06, li yuqian wrote:
> Hi JJK,
>
> thanks for your reply.
>
> >>what kind of hardware cryptodev accelerator is on the Intel board?
> We don't have extra accelerator used in INTEL board, just enable 
> cryptodev in kernel and installed cryptodev-linux-1.7.tar.gz , then i 
> can got improved performance in openssl test. but i believe the 
> cryptodev must be called CPU hardware encryption accelerator, here is 
> my kernel configuration


ah OK; I've grabbed a copy, built and installed it on 2 servers and ran 
some test: I get similar figures for 'openssl speed' but those numbers 
are artificial, i.e. they do not reflect true performance of the system. 
According to the site http://cryptodev-linux.org/index.html I should be 
getting some improvement but not *that* much.

I've built and linked openvpn against openssl 1.0.2d with the cryptodev 
engine enabled:

export OPENSSL_SSL_CFLAGS="-I/home/janjust/src/openssl-1.0.2d/include"
export OPENSSL_SSL_LIBS="-L/home/janjust/src/openssl-1.0.2d -lssl -ldl"
export OPENSSL_CRYPTO_CFLAGS="-I/home/janjust/src/openssl-1.0.2d/include"
export OPENSSL_CRYPTO_LIBS="-L/home/janjust/src/openssl-1.0.2d -lcrypto 
-ldl"
./configure
make

Now I can run openvpn with cryptodev support enabled:

  /home/janjust/src/openvpn-2.3.7-cryptodev/src/openvpn/openvpn 
--ifconfig 10.200.0.1 10.200.0.2 --dev tun --secret secret.key --cipher 
aes-256-cbc --engine cryptodev
Mon Jul 27 00:27:29 2015 OpenVPN 2.3.7 x86_64-unknown-linux-gnu [SSL 
(OpenSSL)] [LZO] [EPOLL] [MH] [IPv6] built on Jul 27 2015
Mon Jul 27 00:27:29 2015 library versions: OpenSSL 1.0.2d 9 Jul 2015, 
LZO 2.03
Mon Jul 27 00:27:29 2015 Initializing OpenSSL support for engine 'cryptodev'
....


and performance is ~ 10% higher in one direction, and actually lower in 
the opposite direction.


On 25/07/15 03:06, li yuqian wrote:
> Hi Gert,
>
> thanks for your reply
>
> >>as our way to do --daemon wasn't compatible with cryptodev...
> do you mean it is suggested in daemon mode when running openvpn with 
> cryptodev?
>
Gert's comment was about freebsd crypyodev support ... on Linux openvpn 
2.3.7 builds and runs just fine.

> also, i found some post said the Openvpn support cryptodev is not 
> good, as Openvpn need do lot of job copy data to/from user space to 
> kernel, "Hoewever the user-to-kernel and kernel-to-user copying of 
> packets (context switches) is the bottleneck. The OpenVPN speed gets 
> capped long before the crypto accel would make a difference. Its only 
> useful for pure Kernel based VPNs like IPSec or L2TP." (source 
> https://forum.openwrt.org/viewtopic.php?id=19586)
>
>

this is partly true - openvpn minimizes the user-to-kernel and 
kernel-to-user copying of packets but it does happen and yes this is 
indeed the bottleneck. There is little we can do about this, although 
other tools such as vtun get slightly better performance.

My 2 servers are hooked up over gigabit ethernet, with iperf giving a 
nice and stable 960 Mbps without a VPN in both directions.
With openvpn and with all crypto turned off, performance drops to 350 
Mbps in one direction, 370 in the other. This is due mostly to the 
*clockspeed* of the CPUs used (2 Xeon E5s, one is running at 2.0 GHz). 
If I hook up two 3.0+ GHz CPUs then openvpn without crypto will give me 
~900 Mbps both ways (and with aes-256 crypto I still get a decent 560 Mbps).

What figures do you get when running openvpn with
   --cipher none --auth none
?


HTH,

JJK


> -----
> CONFIG_CRYPTO=y
>
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=y
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_PCOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> # CONFIG_CRYPTO_GF128MUL is not set
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_PCRYPT is not set
> CONFIG_CRYPTO_WORKQUEUE=y
> # CONFIG_CRYPTO_CRYPTD is not set
> # CONFIG_CRYPTO_MCRYPTD is not set
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
>
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> # CONFIG_CRYPTO_GCM is not set
> CONFIG_CRYPTO_SEQIV=y
>
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CTR=y
> # CONFIG_CRYPTO_CTS is not set
> # CONFIG_CRYPTO_ECB is not set
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_PCBC is not set
> # CONFIG_CRYPTO_XTS is not set
>
> #
> # Hash modes
> #
> # CONFIG_CRYPTO_CMAC is not set
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_VMAC is not set
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_CRC32C_INTEL is not set
> # CONFIG_CRYPTO_CRC32 is not set
> # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> # CONFIG_CRYPTO_CRCT10DIF is not set
> # CONFIG_CRYPTO_GHASH is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_RMD128 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_RMD256 is not set
> # CONFIG_CRYPTO_RMD320 is not set
> CONFIG_CRYPTO_SHA1=y
> # CONFIG_CRYPTO_SHA1_SSSE3 is not set
> # CONFIG_CRYPTO_SHA256_SSSE3 is not set
> # CONFIG_CRYPTO_SHA512_SSSE3 is not set
> # CONFIG_CRYPTO_SHA1_MB is not set
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> # CONFIG_CRYPTO_DRBG_MENU is not set
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> CONFIG_CRYPTO_HW=y
> # CONFIG_CRYPTO_DEV_PADLOCK is not set
> # CONFIG_CRYPTO_DEV_CCP is not set
> CONFIG_CRYPTO_DEV_QAT=m
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
> # CONFIG_ASYMMETRIC_KEY_TYPE is not set
> CONFIG_HAVE_KVM=y
> CONFIG_VIRTUALIZATION=y
> # CONFIG_KVM is not set
> CONFIG_BINARY_PRINTF=y
> -----
> >>how did you enable it in openssl ?
> i used openssl-1.0.2d and manual compile it by with "./config 
> -DHAVE_CRYPTODEV -DUSE_CRYPTDEV_DIGESTS"
> ----
> root@...2048...:/usr/src# /usr/local/ssl/bin/openssl engine
> (cryptodev) BSD cryptodev engine
> (rdrand) Intel RDRAND engine
> (dynamic) Dynamic engine loading support
> (4758cca) IBM 4758 CCA hardware engine support
> (aep) Aep hardware engine support
> (atalla) Atalla hardware engine support
> (cswift) CryptoSwift hardware engine support
> (chil) CHIL hardware engine support
> (nuron) Nuron hardware engine support
> (sureware) SureWare hardware engine support
> (ubsec) UBSEC hardware engine support
> (gost) Reference implementation of GOST engine
> ----
>
> >>from the numbers you post I can see that there must be some external 
> accelerator which is not part of the CPU.
> there is no external accelerator, i just enable the hardware cryptodev 
> in kernel and compiled and installed cryptodev-linux-1.7.tar.gz then 
> insert the cryptodev.ko in test.
>
> >>OpenVPN can be made to use such accelerators but you must load the engine in OpenVPN in 
> the right manner - which of the engines are using for your openssl 
> test? what does
>   openssl engine -c -t
> report?
>
> i think so, but why the cryptodev can not working properly, i am 
> confused :( . and just enabled the cryptodev.ko in test. and openssl 
> engine -c -t  show as following
> -------
> root@...2048...:/usr/src# /usr/local/ssl/bin/openssl engine -c -t
> (cryptodev) BSD cryptodev engine
>  [RSA, DSA, DH, DES-CBC, DES-EDE3-CBC, AES-128-CBC, AES-192-CBC, 
> AES-256-CBC]
>      [ available ]
> (rdrand) Intel RDRAND engine
>  [RAND]
>      [ available ]
> (dynamic) Dynamic engine loading support
>      [ unavailable ]
> (4758cca) IBM 4758 CCA hardware engine support
>  [RSA, RAND]
>      [ unavailable ]
> (aep) Aep hardware engine support
>  [RSA, DSA, DH]
>      [ unavailable ]
> (atalla) Atalla hardware engine support
>  [RSA, DSA, DH]
>      [ unavailable ]
> (cswift) CryptoSwift hardware engine support
>  [RSA, DSA, DH, RAND]
>      [ unavailable ]
> (chil) CHIL hardware engine support
>  [RSA, DH, RAND]
>      [ unavailable ]
> (nuron) Nuron hardware engine support
>  [RSA, DSA, DH]
>      [ unavailable ]
> (sureware) SureWare hardware engine support
>  [RSA, DSA, DH, RAND]
>      [ unavailable ]
> (ubsec) UBSEC hardware engine support
>  [RSA, DSA, DH]
>      [ unavailable ]
> (gost) Reference implementation of GOST engine
>  [gost89, gost89-cnt, md_gost94, gost-mac, gost94, gost2001, gost-mac]
>      [ available ]
> root@...2048...:/usr/src#
> ----
> any suggestion, i really need openvpn get working :(
>
> Yuqian
> ------------------------------------------------------------------------
>
>


--------------060309060200030604000808
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing1-ams.mf.surf.net id t6QMkWqM022707
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      On 25/07/15 03:06, li yuqian wrote:<br>
    </div>
    <blockquote cite=3D"mid:COL128-W59456CBB4B786DDF3AECEECA800@...512..."
      type=3D"cite">
      <style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 12pt;
font-family:Calibri
}
--></style>
      <div dir=3D"ltr">Hi JJK,
        <div><br>
        </div>
        <div>thanks for your reply.</div>
        <div><br>
        </div>
        <div>&gt;&gt;what kind of hardware cryptodev accelerator is on
          the Intel board?=C2=A0</div>
        <div>We don't have extra accelerator used in INTEL board, just
          enable cryptodev in kernel and installed=C2=A0<span
            style=3D"font-family: Consolas, Menlo, Monaco, 'Lucida
            Console', 'Liberation Mono', 'DejaVu Sans Mono', 'Bitstream
            Vera Sans Mono', 'Courier New', monospace, serif; color:
            rgb(68, 68, 68); font-size: 13px; background-color: rgb(238,
            238, 238);">cryptodev-linux-1.7.tar.gz</span><span
            style=3D"font-size: 12pt;">=C2=A0, then i can got improved
            performance in openssl test. but i believe the cryptodev
            must be called CPU hardware encryption accelerator, here is
            my kernel configuration=C2=A0</span></div>
      </div>
    </blockquote>
    <br>
    <br>
    ah OK; I've grabbed a copy, built and installed it on 2 servers and
    ran some test: I get similar figures for 'openssl speed' but those
    numbers are artificial, i.e. they do not reflect true performance of
    the system. According to the site
    <a class=3D"moz-txt-link-freetext" href=3D"http://cryptodev-linux.org/i=
ndex.html">http://cryptodev-linux.org/index.html</a> I should be getting so=
me
    improvement but not *that* much.<br>
    <br>
    I've built and linked openvpn against openssl 1.0.2d with the
    cryptodev engine enabled:<br>
    <br>
    export
    OPENSSL_SSL_CFLAGS=3D"-I/home/janjust/src/openssl-1.0.2d/include"<br>
    export OPENSSL_SSL_LIBS=3D"-L/home/janjust/src/openssl-1.0.2d -lssl
    -ldl"<br>
    export
    OPENSSL_CRYPTO_CFLAGS=3D"-I/home/janjust/src/openssl-1.0.2d/include"<br>
    export OPENSSL_CRYPTO_LIBS=3D"-L/home/janjust/src/openssl-1.0.2d
    -lcrypto -ldl"<br>
    ./configure<br>
    make<br>
    <br>
    Now I can run openvpn with cryptodev support enabled:<br>
    <br>
    =C2=A0/home/janjust/src/openvpn-2.3.7-cryptodev/src/openvpn/openvpn
    --ifconfig 10.200.0.1 10.200.0.2 --dev tun --secret secret.key
    --cipher aes-256-cbc --engine cryptodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <br>
    Mon Jul 27 00:27:29 2015 OpenVPN 2.3.7 x86_64-unknown-linux-gnu [SSL
    (OpenSSL)] [LZO] [EPOLL] [MH] [IPv6] built on Jul 27 2015<br>
    Mon Jul 27 00:27:29 2015 library versions: OpenSSL 1.0.2d 9 Jul
    2015, LZO 2.03<br>
    Mon Jul 27 00:27:29 2015 Initializing OpenSSL support for engine
    'cryptodev'<br>
    ....<br>
    <br>
    <br>
    and performance is ~ 10% higher in one direction, and actually lower
    in the opposite direction.<br>
    <br>
    <br>
    On 25/07/15 03:06, li yuqian wrote:<br>
    <blockquote type=3D"cite">Hi Gert,
      <div><br>
      </div>
      <div>thanks for your reply</div>
      <div><br>
      </div>
      <div>&gt;&gt;as our way to do --daemon wasn't compatible with
        cryptodev...</div>
      <div>do you mean it is suggested in daemon mode when running
        openvpn with cryptodev?</div>
      <div><br>
      </div>
    </blockquote>
    Gert's comment was about freebsd crypyodev support ... on Linux
    openvpn 2.3.7 builds and runs just fine.<br>
    <br>
    <blockquote type=3D"cite">
      <div>also, i found some post said the Openvpn support cryptodev is
        not good, as Openvpn need do lot of job copy data to/from user
        space to kernel, "<span style=3D"color: rgb(34, 34, 34);
          font-family: Verdana, Helvetica, Arial, sans-serif; font-size:
          12px; line-height: 18px; background-color: rgb(250, 250,
          250);">Hoewever the user-to-kernel and kernel-to-user copying
          of packets (context switches) is the bottleneck. The OpenVPN
          speed gets capped long before the crypto accel would make a
          difference. Its only useful for pure Kernel based VPNs like
          IPSec or L2TP.</span><span style=3D"font-size: 12pt;">" (source=
=C2=A0</span><a
          href=3D"https://forum.openwrt.org/viewtopic.php?id=3D19586"
          target=3D"_blank" style=3D"font-size: 12pt;">https://forum.openwr=
t.org/viewtopic.php?id=3D19586</a>)=C2=A0</div>
      <div><br>
      </div>
      <br>
    </blockquote>
    <br>
    this is partly true - openvpn minimizes the user-to-kernel and
    kernel-to-user copying of packets but it does happen and yes this is
    indeed the bottleneck. There is little we can do about this,
    although other tools such as vtun get slightly better performance. <br>
    <br>
    My 2 servers are hooked up over gigabit ethernet, with iperf giving
    a nice and stable 960 Mbps without a VPN in both directions.<br>
    With openvpn and with all crypto turned off, performance drops to
    350 Mbps in one direction, 370 in the other. This is due mostly to
    the *clockspeed* of the CPUs used (2 Xeon E5s, one is running at 2.0
    GHz). If I hook up two 3.0+ GHz CPUs then openvpn without crypto
    will give me ~900 Mbps both ways (and with aes-256 crypto I still
    get a decent 560 Mbps).<br>
    <br>
    What figures do you get when running openvpn with<br>
    =C2=A0 --cipher none --auth none<br>
    ?<br>
    <br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
    <br>
    <blockquote cite=3D"mid:COL128-W59456CBB4B786DDF3AECEECA800@...512..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div><span style=3D"font-size: 12pt;">-----</span></div>
        <div>
          <div>CONFIG_CRYPTO=3Dy</div>
          <div><br>
          </div>
          <div>#</div>
          <div># Crypto core or helper</div>
          <div>#</div>
          <div>CONFIG_CRYPTO_ALGAPI=3Dy</div>
          <div>CONFIG_CRYPTO_ALGAPI2=3Dy</div>
          <div>CONFIG_CRYPTO_AEAD=3Dy</div>
          <div>CONFIG_CRYPTO_AEAD2=3Dy</div>
          <div>CONFIG_CRYPTO_BLKCIPHER=3Dy</div>
          <div>CONFIG_CRYPTO_BLKCIPHER2=3Dy</div>
          <div>CONFIG_CRYPTO_HASH=3Dy</div>
        </div>
        <div>
          <div>CONFIG_CRYPTO_HASH2=3Dy</div>
          <div>CONFIG_CRYPTO_RNG=3Dy</div>
          <div>CONFIG_CRYPTO_RNG2=3Dy</div>
          <div>CONFIG_CRYPTO_PCOMP2=3Dy</div>
          <div>CONFIG_CRYPTO_MANAGER=3Dy</div>
          <div>CONFIG_CRYPTO_MANAGER2=3Dy</div>
          <div># CONFIG_CRYPTO_USER is not set</div>
          <div>CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy</div>
          <div># CONFIG_CRYPTO_GF128MUL is not set</div>
          <div># CONFIG_CRYPTO_NULL is not set</div>
          <div># CONFIG_CRYPTO_PCRYPT is not set</div>
          <div>CONFIG_CRYPTO_WORKQUEUE=3Dy</div>
          <div># CONFIG_CRYPTO_CRYPTD is not set</div>
          <div># CONFIG_CRYPTO_MCRYPTD is not set</div>
          <div>CONFIG_CRYPTO_AUTHENC=3Dy</div>
          <div># CONFIG_CRYPTO_TEST is not set</div>
          <div><br>
          </div>
          <div>#</div>
          <div># Authenticated Encryption with Associated Data</div>
          <div>#</div>
          <div>CONFIG_CRYPTO_CCM=3Dy</div>
          <div># CONFIG_CRYPTO_GCM is not set</div>
        </div>
        <div>
          <div>CONFIG_CRYPTO_SEQIV=3Dy</div>
          <div><br>
          </div>
          <div>#</div>
          <div># Block modes</div>
          <div>#</div>
          <div>CONFIG_CRYPTO_CBC=3Dy</div>
          <div>CONFIG_CRYPTO_CTR=3Dy</div>
          <div># CONFIG_CRYPTO_CTS is not set</div>
          <div># CONFIG_CRYPTO_ECB is not set</div>
          <div># CONFIG_CRYPTO_LRW is not set</div>
          <div># CONFIG_CRYPTO_PCBC is not set</div>
          <div># CONFIG_CRYPTO_XTS is not set</div>
          <div><br>
          </div>
          <div>#</div>
          <div># Hash modes</div>
          <div>#</div>
          <div># CONFIG_CRYPTO_CMAC is not set</div>
          <div>CONFIG_CRYPTO_HMAC=3Dy</div>
          <div># CONFIG_CRYPTO_XCBC is not set</div>
          <div># CONFIG_CRYPTO_VMAC is not set</div>
        </div>
        <div>
          <div>#</div>
          <div># Digest</div>
          <div>#</div>
          <div>CONFIG_CRYPTO_CRC32C=3Dy</div>
          <div># CONFIG_CRYPTO_CRC32C_INTEL is not set</div>
          <div># CONFIG_CRYPTO_CRC32 is not set</div>
          <div># CONFIG_CRYPTO_CRC32_PCLMUL is not set</div>
          <div># CONFIG_CRYPTO_CRCT10DIF is not set</div>
          <div># CONFIG_CRYPTO_GHASH is not set</div>
          <div># CONFIG_CRYPTO_MD4 is not set</div>
          <div>CONFIG_CRYPTO_MD5=3Dy</div>
          <div># CONFIG_CRYPTO_MICHAEL_MIC is not set</div>
          <div># CONFIG_CRYPTO_RMD128 is not set</div>
          <div># CONFIG_CRYPTO_RMD160 is not set</div>
          <div># CONFIG_CRYPTO_RMD256 is not set</div>
          <div># CONFIG_CRYPTO_RMD320 is not set</div>
          <div>CONFIG_CRYPTO_SHA1=3Dy</div>
          <div># CONFIG_CRYPTO_SHA1_SSSE3 is not set</div>
          <div># CONFIG_CRYPTO_SHA256_SSSE3 is not set</div>
          <div># CONFIG_CRYPTO_SHA512_SSSE3 is not set</div>
          <div># CONFIG_CRYPTO_SHA1_MB is not set</div>
          <div>CONFIG_CRYPTO_SHA256=3Dm</div>
          <div>CONFIG_CRYPTO_SHA512=3Dm</div>
        </div>
        <div>
          <div># CONFIG_CRYPTO_ANSI_CPRNG is not set</div>
          <div># CONFIG_CRYPTO_DRBG_MENU is not set</div>
          <div># CONFIG_CRYPTO_USER_API_HASH is not set</div>
          <div># CONFIG_CRYPTO_USER_API_SKCIPHER is not set</div>
          <div>CONFIG_CRYPTO_HW=3Dy</div>
          <div># CONFIG_CRYPTO_DEV_PADLOCK is not set</div>
          <div># CONFIG_CRYPTO_DEV_CCP is not set</div>
          <div>CONFIG_CRYPTO_DEV_QAT=3Dm</div>
          <div>CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm</div>
          <div># CONFIG_ASYMMETRIC_KEY_TYPE is not set</div>
          <div>CONFIG_HAVE_KVM=3Dy</div>
          <div>CONFIG_VIRTUALIZATION=3Dy</div>
          <div># CONFIG_KVM is not set</div>
          <div>CONFIG_BINARY_PRINTF=3Dy</div>
        </div>
        <div>-----</div>
        <div>&gt;&gt;<span style=3D"font-size: 12pt;">how did you enable
            it in openssl ?</span></div>
        <div>i used openssl-1.0.2d and manual compile it by with "<span
            style=3D"font-size: 12pt;">./config -DHAVE_CRYPTODEV
            -DUSE_CRYPTDEV_DIGESTS"=C2=A0</span></div>
        <div><span style=3D"font-size: 12pt;">----</span></div>
        <div>
          <div>root@...2048...:/usr/src# /usr/local/ssl/bin/openssl engine<=
/div>
          <div>(cryptodev) BSD cryptodev engine</div>
          <div>(rdrand) Intel RDRAND engine</div>
          <div>(dynamic) Dynamic engine loading support</div>
          <div>(4758cca) IBM 4758 CCA hardware engine support</div>
          <div>(aep) Aep hardware engine support</div>
          <div>(atalla) Atalla hardware engine support</div>
          <div>(cswift) CryptoSwift hardware engine support</div>
          <div>(chil) CHIL hardware engine support</div>
          <div>(nuron) Nuron hardware engine support</div>
          <div>(sureware) SureWare hardware engine support</div>
          <div>(ubsec) UBSEC hardware engine support</div>
          <div>(gost) Reference implementation of GOST engine</div>
        </div>
        <div>----</div>
        <div><br>
        </div>
        <div>&gt;&gt;from the numbers you post I can see that there must
          be some external accelerator which is not part of the CPU.</div>
        <div>there is no external accelerator, i just enable the
          hardware cryptodev in kernel and compiled and installed=C2=A0<span
            style=3D"color: rgb(68, 68, 68); font-family: Consolas, Menlo,
            Monaco, 'Lucida Console', 'Liberation Mono', 'DejaVu Sans
            Mono', 'Bitstream Vera Sans Mono', 'Courier New', monospace,
            serif; font-size: 13px; background-color: rgb(238, 238,
            238);">cryptodev-linux-1.7.tar.gz</span><span
            style=3D"font-size: 12pt;">=C2=A0then insert the cryptodev.ko in
            test.</span></div>
        <div><span style=3D"font-size: 12pt;"><br>
          </span></div>
        <div><span style=3D"font-size: 12pt;">&gt;&gt;OpenVPN can be made
            to use such accelerators but you must load the engine in
            OpenVPN in the right manner - which of the engines are using
            for your openssl test? what does</span></div>
        <div>=C2=A0 openssl engine -c -t=C2=A0<br>
          report?</div>
        <div><br>
        </div>
        <div>i think so, but why the cryptodev can not working properly,
          i am confused :( . and just enabled the cryptodev.ko in test.
          and=C2=A0openssl engine -c -t=C2=A0 show as following<br>
          -------<br>
          <div>root@...2048...:/usr/src# /usr/local/ssl/bin/openssl engine
            -c -t</div>
          <div>(cryptodev) BSD cryptodev engine</div>
          <div>=C2=A0[RSA, DSA, DH, DES-CBC, DES-EDE3-CBC, AES-128-CBC,
            AES-192-CBC, AES-256-CBC]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ available ]</div>
          <div>(rdrand) Intel RDRAND engine</div>
          <div>=C2=A0[RAND]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ available ]</div>
          <div>(dynamic) Dynamic engine loading support</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(4758cca) IBM 4758 CCA hardware engine support</div>
          <div>=C2=A0[RSA, RAND]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(aep) Aep hardware engine support</div>
          <div>=C2=A0[RSA, DSA, DH]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(atalla) Atalla hardware engine support</div>
          <div>=C2=A0[RSA, DSA, DH]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(cswift) CryptoSwift hardware engine support</div>
          <div>=C2=A0[RSA, DSA, DH, RAND]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(chil) CHIL hardware engine support</div>
          <div>=C2=A0[RSA, DH, RAND]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(nuron) Nuron hardware engine support</div>
          <div>=C2=A0[RSA, DSA, DH]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(sureware) SureWare hardware engine support</div>
          <div>=C2=A0[RSA, DSA, DH, RAND]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(ubsec) UBSEC hardware engine support</div>
          <div>=C2=A0[RSA, DSA, DH]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ unavailable ]</div>
          <div>(gost) Reference implementation of GOST engine</div>
          <div>=C2=A0[gost89, gost89-cnt, md_gost94, gost-mac, gost94,
            gost2001, gost-mac]</div>
          <div>=C2=A0 =C2=A0 =C2=A0[ available ]</div>
          <div>root@...2048...:/usr/src#</div>
          ----</div>
        <div>any suggestion, i really need openvpn get working :(</div>
        <div><br>
        </div>
        <div>Yuqian</div>
        <div>
          <div>
            <hr id=3D"stopSpelling">
            <div class=3D"ecxmoz-cite-prefix"><br>
            </div>
            <br>
          </div>
        </div>
        <style><!--
.ExternalClass .ecxhmmessage P {
padding:0px;
}

.ExternalClass body.ecxhmmessage {
font-size:12pt;
font-family:Calibri;
}

--></style> </div>
    </blockquote>
    <br>
  </body>
</html>

--------------060309060200030604000808--

