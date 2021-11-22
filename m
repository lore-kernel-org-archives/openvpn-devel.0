MIME-Version: 1.0
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
In-Reply-To: <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 22 Nov 2021 19:20:43 +0200
Message-ID: <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

I added a commit to vcpkg/openssl PR
(https://github.com/microsoft/vcpkg/pull/21540) which gives an option
to customize ENGINESDIR. Unfortunately openssl doesn't make it easy -
ENGINESDIR is built based on --prefix, which is set to vcpkg build
dir. The prefix cannot be set to something like C:\SSL, because in
this case vcpkg build would require an elevated prompt. So I had to
patch the makefile template. Let's see if there are less hacky ways to
do it.

OpenSSL 1.1.1l  24 Aug 2021
built on: Mon Nov 22 17:10:12 2021 UTC
platform: VC-WIN64A
options:  bn(64,64) rc4(16x,int) des(long) idea(int) blowfish(ptr)
compiler: cl /Zi /Fdossl_static.pdb /Gs0 /GF /Gy /MD /W3 /wd4090
/nologo /O2 -utf-8 -FS -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ
-DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5
-DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM
-DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM
-DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM
OPENSSLDIR: "C:\Program Files\OpenVPN\ssl"
ENGINESDIR: "c:\Program Files\OpenVPN\ssl_engines"
Seeding source: os-specific

pe 19. marrask. 2021 klo 23.27 Selva Nair (selva.nair@...277...) kirjoitti:
>
> Hi,
>
> On Fri, Nov 19, 2021 at 3:04 PM <lstipakov@...277...> wrote:
>>
>> Ok, my idea was to fix only config loading dir. Apparently this is not e=
nough, so I=E2=80=99ll look into ENGINESDIR too.
>
>
> What we need is a proper build that can be safely distributed. Whatever t=
hat takes. My understanding is that if we have to get with prefix and OPENS=
SLDIR set to values recommended by OpenSSL on Windows or something appropri=
ate for our own use and still safe.
>
> Default location of configs, engine dlls, modules etc. depend on those tw=
o definitions -- we can't leave them at arbitrary values that are not write=
 protected or unusable.
>
> Selva



--=20
-Lev

