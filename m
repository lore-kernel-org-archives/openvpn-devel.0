Message-ID: <55B1FF56.4000209@...1147...>
Date: Fri, 24 Jul 2015 11:03:18 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <COL128-W360F356FA6F45FADFFC4D6CA810@...512...>
In-Reply-To: <COL128-W360F356FA6F45FADFFC4D6CA810@...512...>
Content-Type: multipart/alternative;
	boundary="------------030700090307010608070801"
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
--------------030700090307010608070801
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/07/15 10:40, li yuqian wrote:
> Hi,
>
> I am working on try use the cryptodev hardware accelerator in Openvpn, 
> i know this question is belong to user list, but i got confused for 
> the issue, so, i think maybe need developer to help :)
>
> I have two boards, one is Freescale LS1021a ARM cpu, another one is 
> INTEL E3815 cpu, both of them i can enable the cryptodev hardware 
> accelerator, and tested them in openssl, it working good when enabled 
> the cryptodev, i can got about 72 times performance improved with 
> command "openssl speed -evp aes-128-cbc", here is a INTEL cpu test result
> ----------
> with cryptodev support:
> ----------
> root@...2048...:/etc/openvpn# /usr/local/ssl/bin/openssl speed -evp 
> aes-128-cbc
> Doing aes-128-cbc for 3s on 16 size blocks: 1324358 aes-128-cbc's in 0.47s
> Doing aes-128-cbc for 3s on 64 size blocks: 986320 aes-128-cbc's in 0.33s
> Doing aes-128-cbc for 3s on 256 size blocks: 487522 aes-128-cbc's in 0.19s
> Doing aes-128-cbc for 3s on 1024 size blocks: 157636 aes-128-cbc's in 
> 0.05s
> Doing aes-128-cbc for 3s on 8192 size blocks: 22318 aes-128-cbc's in 0.01s
> OpenSSL 1.0.2 22 Jan 2015
> built on: reproducible build, date unspecified
> options:bn(64,64) rc4(16x,int) des(idx,cisc,16,int) aes(partial) 
> idea(int) blowfish(idx)
> compiler: gcc -I. -I.. -I../include  -DOPENSSL_THREADS -D_REENTRANT 
> -DDSO_DLFCN -DHAVE_DLFCN_H -DHAVE_CRYPTODEV -DUSE_CRYPTDEV_DIGESTS 
> -Wa,--noexecstack -m64 -DL_ENDIAN -DTERMIO -O3 -Wall 
> -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 
> -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DMD5_ASM 
> -DAES_ASM -DVPAES_ASM -DBSAES_ASM -DWHIRLPOOL_ASM -DGHASH_ASM 
> -DECP_NISTZ256_ASM
> The 'numbers' are in 1000s of bytes per second processed.
> type             16 bytes     64 bytes    256 bytes   1024 bytes   
> 8192 bytes
> aes-128-cbc      45084.53k   191286.30k   656871.75k  3228385.28k 
> 18282905.60k
> root@...2048...:/etc/openvpn#
> ----------
> without cryptodev support:
> ----------
> root@...2048...:/etc/openvpn# /usr/local/ssl/bin/openssl speed -evp 
> aes-128-cbc
> Doing aes-128-cbc for 3s on 16 size blocks: 29624370 aes-128-cbc's in 
> 2.99s
> Doing aes-128-cbc for 3s on 64 size blocks: 10070739 aes-128-cbc's in 
> 3.01s
> Doing aes-128-cbc for 3s on 256 size blocks: 2846673 aes-128-cbc's in 
> 3.00s
> Doing aes-128-cbc for 3s on 1024 size blocks: 735685 aes-128-cbc's in 
> 3.01s
> Doing aes-128-cbc for 3s on 8192 size blocks: 92783 aes-128-cbc's in 3.00s
> OpenSSL 1.0.2 22 Jan 2015
> built on: reproducible build, date unspecified
> options:bn(64,64) rc4(16x,int) des(idx,cisc,16,int) aes(partial) 
> idea(int) blowfish(idx)
> compiler: gcc -I. -I.. -I../include  -DOPENSSL_THREADS -D_REENTRANT 
> -DDSO_DLFCN -DHAVE_DLFCN_H -DHAVE_CRYPTODEV -DUSE_CRYPTDEV_DIGESTS 
> -Wa,--noexecstack -m64 -DL_ENDIAN -DTERMIO -O3 -Wall 
> -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 
> -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DMD5_ASM 
> -DAES_ASM -DVPAES_ASM -DBSAES_ASM -DWHIRLPOOL_ASM -DGHASH_ASM 
> -DECP_NISTZ256_ASM
> The 'numbers' are in 1000s of bytes per second processed.
> type             16 bytes     64 bytes    256 bytes   1024 bytes   
> 8192 bytes
> aes-128-cbc     158525.06k   214128.67k   242916.10k 250279.55k   
> 253359.45k
> ----------
>
> it was got big improved with cryptodev hardware accelerator you can 
> see from above shows
>
> but when i configured and compiled Openvpn with HAVE_OPENSSL_ENGINE 
> supported, and i can make sure Openvpn can working with cryptodev ?

> ------
> root@...2048...:/etc/openvpn# /opt/openvpn/sbin/openvpn --show-engines
> OpenSSL Crypto Engines
>
> BSD cryptodev engine [cryptodev]
> Intel RDRAND engine [rdrand]
> Dynamic engine loading support [dynamic]
> IBM 4758 CCA hardware engine support [4758cca]
> Aep hardware engine support [aep]
> Atalla hardware engine support [atalla]
> CryptoSwift hardware engine support [cswift]
> CHIL hardware engine support [chil]
> Nuron hardware engine support [nuron]
> SureWare hardware engine support [sureware]
> UBSEC hardware engine support [ubsec]
> Reference implementation of GOST engine [gost]
> -------
>
what kind of hardware cryptodev accelerator is on the Intel board? how 
did you enable it in openssl ?
from the numbers you post I can see that there must be some external 
accelerator which is not part of the CPU.
OpenVPN can be made to use such accelerators but you must load the 
engine in OpenVPN in the right manner - which of the engines are using 
for your openssl test? what does
   openssl engine -c -t
report?

JJK


--------------030700090307010608070801
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing1-ams.mf.surf.net id t6O93KW6020472
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      On 24/07/15 10:40, li yuqian wrote:<br>
    </div>
    <blockquote cite=3D"mid:COL128-W360F356FA6F45FADFFC4D6CA810@...512..."
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
      <div dir=3D"ltr">Hi,
        <div><br>
        </div>
        <div>I am working on try use the cryptodev hardware accelerator
          in Openvpn, i know this question is belong to user list, but i
          got confused for the issue, so, i think maybe need developer
          to help :)=A0</div>
        <div><span style=3D"font-size: 12pt;"><br>
          </span></div>
        <div><span style=3D"font-size: 12pt;">I have two boards, one is
            Freescale LS1021a ARM cpu, another one is INTEL E3815 cpu,
            both of them i can enable the cryptodev hardware
            accelerator, and tested them in openssl, it working good
            when enabled the cryptodev, i can got about 72 times
            performance improved with command "</span>openssl speed -evp
          aes-128-cbc<span style=3D"font-size: 12pt;">", here is a INTEL
            cpu test result</span></div>
        <div><span style=3D"font-size: 12pt;">----------</span></div>
        <div><span style=3D"font-size: 12pt;">with cryptodev support:</span=
></div>
        <div><span style=3D"font-size: 12pt;">----------</span></div>
        <div>root@...2048...:/etc/openvpn# /usr/local/ssl/bin/openssl speed
          -evp aes-128-cbc</div>
        <div>Doing aes-128-cbc for 3s on 16 size blocks: 1324358
          aes-128-cbc's in 0.47s</div>
        <div>Doing aes-128-cbc for 3s on 64 size blocks: 986320
          aes-128-cbc's in 0.33s</div>
        <div>Doing aes-128-cbc for 3s on 256 size blocks: 487522
          aes-128-cbc's in 0.19s</div>
        <div>Doing aes-128-cbc for 3s on 1024 size blocks: 157636
          aes-128-cbc's in 0.05s</div>
        <div>Doing aes-128-cbc for 3s on 8192 size blocks: 22318
          aes-128-cbc's in 0.01s</div>
        <div>OpenSSL 1.0.2 22 Jan 2015</div>
        <div>built on: reproducible build, date unspecified</div>
        <div>options:bn(64,64) rc4(16x,int) des(idx,cisc,16,int)
          aes(partial) idea(int) blowfish(idx)</div>
        <div>compiler: gcc -I. -I.. -I../include =A0-DOPENSSL_THREADS
          -D_REENTRANT -DDSO_DLFCN -DHAVE_DLFCN_H -DHAVE_CRYPTODEV
          -DUSE_CRYPTDEV_DIGESTS -Wa,--noexecstack -m64 -DL_ENDIAN
          -DTERMIO -O3 -Wall -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT
          -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM
          -DSHA256_ASM -DSHA512_ASM -DMD5_ASM -DAES_ASM -DVPAES_ASM
          -DBSAES_ASM -DWHIRLPOOL_ASM -DGHASH_ASM -DECP_NISTZ256_ASM</div>
        <div>The 'numbers' are in 1000s of bytes per second processed.</div>
        <div>type =A0 =A0 =A0 =A0 =A0 =A0 16 bytes =A0 =A0 64 bytes =A0 =A0=
256 bytes =A0 1024
          bytes =A0 8192 bytes</div>
        <div>aes-128-cbc =A0 =A0 =A045084.53k =A0 191286.30k =A0 656871.75k
          =A03228385.28k 18282905.60k</div>
        <div>root@...2048...:/etc/openvpn#</div>
        <div><span style=3D"font-size: 12pt;">----------</span></div>
        <div><span style=3D"font-size: 12pt;">without =A0</span><span
            style=3D"font-size: 12pt;">cryptodev support:</span></div>
        <div><span style=3D"font-size: 12pt;">----------</span></div>
        <div>root@...2048...:/etc/openvpn# /usr/local/ssl/bin/openssl speed
          -evp aes-128-cbc</div>
        <div>Doing aes-128-cbc for 3s on 16 size blocks: 29624370
          aes-128-cbc's in 2.99s</div>
        <div>Doing aes-128-cbc for 3s on 64 size blocks: 10070739
          aes-128-cbc's in 3.01s</div>
        <div>Doing aes-128-cbc for 3s on 256 size blocks: 2846673
          aes-128-cbc's in 3.00s</div>
        <div>Doing aes-128-cbc for 3s on 1024 size blocks: 735685
          aes-128-cbc's in 3.01s</div>
        <div>Doing aes-128-cbc for 3s on 8192 size blocks: 92783
          aes-128-cbc's in 3.00s</div>
        <div>OpenSSL 1.0.2 22 Jan 2015</div>
        <div>built on: reproducible build, date unspecified</div>
        <div>options:bn(64,64) rc4(16x,int) des(idx,cisc,16,int)
          aes(partial) idea(int) blowfish(idx)</div>
        <div>compiler: gcc -I. -I.. -I../include =A0-DOPENSSL_THREADS
          -D_REENTRANT -DDSO_DLFCN -DHAVE_DLFCN_H -DHAVE_CRYPTODEV
          -DUSE_CRYPTDEV_DIGESTS -Wa,--noexecstack -m64 -DL_ENDIAN
          -DTERMIO -O3 -Wall -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT
          -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM
          -DSHA256_ASM -DSHA512_ASM -DMD5_ASM -DAES_ASM -DVPAES_ASM
          -DBSAES_ASM -DWHIRLPOOL_ASM -DGHASH_ASM -DECP_NISTZ256_ASM</div>
        <div>The 'numbers' are in 1000s of bytes per second processed.</div>
        <div>type =A0 =A0 =A0 =A0 =A0 =A0 16 bytes =A0 =A0 64 bytes =A0 =A0=
256 bytes =A0 1024
          bytes =A0 8192 bytes</div>
        <div>aes-128-cbc =A0 =A0 158525.06k =A0 214128.67k =A0 242916.10k =
=A0
          250279.55k =A0 253359.45k</div>
        <div><span style=3D"font-size: 12pt;">----------</span></div>
        <div><span style=3D"font-size: 12pt;"><br>
          </span></div>
        <div><span style=3D"font-size: 12pt;">it was got big improved with
            =A0</span><span style=3D"font-size: 12pt;">cryptodev hardware
            accelerator you can see from above shows</span></div>
        <div><span style=3D"font-size: 12pt;"><br>
          </span></div>
        <div><span style=3D"font-size: 12pt;">but when i configured and
            compiled Openvpn with=A0</span>HAVE_OPENSSL_ENGINE supported,
          and i can make sure Openvpn can working with cryptodev ?</div>
      </div>
    </blockquote>
    <br>
    <blockquote cite=3D"mid:COL128-W360F356FA6F45FADFFC4D6CA810@...512..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>------</div>
        <div>
          <div>root@...2048...:/etc/openvpn# /opt/openvpn/sbin/openvpn
            --show-engines</div>
          <div>OpenSSL Crypto Engines</div>
          <div><br>
          </div>
          <div>BSD cryptodev engine [cryptodev]</div>
          <div>Intel RDRAND engine [rdrand]</div>
          <div>Dynamic engine loading support [dynamic]</div>
          <div>IBM 4758 CCA hardware engine support [4758cca]</div>
          <div>Aep hardware engine support [aep]</div>
          <div>Atalla hardware engine support [atalla]</div>
          <div>CryptoSwift hardware engine support [cswift]</div>
          <div>CHIL hardware engine support [chil]</div>
          <div>Nuron hardware engine support [nuron]</div>
          <div>SureWare hardware engine support [sureware]</div>
          <div>UBSEC hardware engine support [ubsec]</div>
          <div>Reference implementation of GOST engine [gost]</div>
        </div>
        <div>-------</div>
        <br>
      </div>
    </blockquote>
    what kind of hardware cryptodev accelerator is on the Intel board?
    how did you enable it in openssl ?<br>
    from the numbers you post I can see that there must be some external
    accelerator which is not part of the CPU.<br>
    OpenVPN can be made to use such accelerators but you must load the
    engine in OpenVPN in the right manner - which of the engines are
    using for your openssl test? what does<br>
    =A0 openssl engine -c -t <br>
    report?<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------030700090307010608070801--

