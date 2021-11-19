MIME-Version: 1.0
References: <CAKuzo_gHxUQfam=J8uKtMAL2ma_Vu0zZcOBMgGHy4BtcQ5panw@...278...>
 <CAGyAFMXvP0iwEiE-G4-d6P4ANSRpr9w-tF++VDL-amgrmPmGuQ@...278...>
 <CAKuzo_gOVrTYqK7s3ZryCSxJmbXE1ogquTDyQfMfZ6GUy4coGA@...278...>
 <CAGyAFMXfhmN+79joNEgcGR9E-+3EMgWyWDCUcC7JAD5bWFvzAA@...278...>
 <CAKuzo_gY+U1KKwLZXiMM=t_2QvJkN3nKxYYhtwzSi2CMrNc9Pg@...278...>
In-Reply-To: <CAKuzo_gY+U1KKwLZXiMM=t_2QvJkN3nKxYYhtwzSi2CMrNc9Pg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 19 Nov 2021 18:15:50 +0200
Message-ID: <CAGyAFMUXsMwaL=wrxrQBh0s+D0RrK=GYbGC1y+HNhXbgvCQq=A@...278...>
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
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Here is what output of openssl.exe built with abovementioned patch on
my machine:

c:\Users\lev\Projects\vcpkg\packages\openssl_x64-windows-ovpn\tools\openssl>openssl.exe
version -a
OpenSSL 1.1.1l  24 Aug 2021
built on: Fri Nov 19 09:43:38 2021 UTC
platform: VC-WIN64A
options:  bn(64,64) rc4(16x,int) des(long) idea(int) blowfish(ptr)
compiler: cl /Zi /Fdossl_static.pdb /Gs0 /GF /Gy /MD /W3 /wd4090
/nologo /O2 -utf-8 -FS -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ
-DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5
-DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM
-DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM
-DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM
OPENSSLDIR: "C:\Program Files\OpenVPN\ssl"
ENGINESDIR: "C:\Users\lev\Projects\vcpkg\packages\openssl_x64-windows-ovpn\lib\engines-1_1"
Seeding source: os-specific

ENGINESDIR looks good, no? Is it something we use?

-Lev

