MIME-Version: 1.0
References: <tencent_96A169E5C17C7A673CE1697FDA9001A65506@...1414...>
 <CAAUX2SVFZG3J2gU=4_ayob04H4gmF+rbpyVgWrUJ7mpb05GyBg@...278...>
In-Reply-To: <CAAUX2SVFZG3J2gU=4_ayob04H4gmF+rbpyVgWrUJ7mpb05GyBg@...278...>
From: Tony He <huangya90@...277...>
Date: Mon, 7 Dec 2020 10:05:04 +0800
Message-ID: <CAAUX2SV4OQw_5gTS=Lftz32QvDczoYixKibSBaMXAq6kRLQ4dg@...278...>
Content-Type: multipart/alternative; boundary="000000000000d801f105b5d641bb"
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, lev@...515..., Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--000000000000d801f105b5d641bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan, Antonio

>actually, I see the same on my i5-6800 with OpenSSL 1.0.2m but NOT with
OpenSSL 1.1.1g; this leads me to believe that CCM support in the openssl
1.0.x speed command is screwed up.   It will be worthwhile to build openssl
1.1.1 for the AL314 just to see if aes-128-ccm is a viable option or not.

Yes, this should be OpenSSL 1.0.x bug.  I tested 1.1.1h and see normal and
expected low values for the Al314.@...2587..., I saw your another mail to
announce CCM support,
but I'm afraid I can not benifit this. Anyway, it might be helpful for
other devices. Thanks for your work.

With cryptodev:
# openssl speed -evp aes-128-ccm -elapsed You have chosen to measure
elapsed time instead of user CPU time. Doing aes-128-ccm for 3s on 16 size
blocks: 3453400 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 64 size
blocks: 1513715 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 256 size
blocks: 472417 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 1024 size
blocks: 125752 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 8192 size
blocks: 15984 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 16384 size
blocks: 7982 aes-128-ccm's in 3.00s OpenSSL 1.1.1h 22 Sep 2020 built on:
Mon Dec 7 01:33:13 2020 UTC ................... type 16 bytes 64 bytes 256
bytes 1024 bytes 8192 bytes 16384 bytes aes-128-ccm 18418.13k 32292.59k
40312.92k 42923.35k 43646.98k 43592.36k Without cryptodev: # openssl speed
-evp aes-128-ccm -elapsed You have chosen to measure elapsed time instead
of user CPU time. Doing aes-128-ccm for 3s on 16 size blocks: 3432128
aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 64 size blocks: 1513301
aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 256 size blocks: 470389
aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 1024 size blocks: 125731
aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 8192 size blocks: 15989
aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 16384 size blocks: 8010
aes-128-ccm's in 3.00s OpenSSL 1.1.1h 22 Sep 2020 built on: Mon Dec 7
01:33:13 2020 UTC ................... type 16 bytes 64 bytes 256 bytes 1024
bytes 8192 bytes 16384 bytes aes-128-ccm 18304.68k 32283.75k 40139.86k
42916.18k 43660.63k 43745.28k
Tony

Tony He <huangya90@...277...> =E4=BA=8E2020=E5=B9=B412=E6=9C=886=E6=97=A5=
=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8810:57=E5=86=99=E9=81=93=EF=BC=9A

> Hi Jan,
>
> The driver is open source.
> https://github.com/SVoxel/R9000/tree/master/git_home/linux.git/drivers/cr=
ypto/al.
> I'm newbie to crypto stuff. Not sure if there is any HW limitation for
> this engine to support GCM. If only need to modify the code, maybe there =
is
> chance that someone will implement this.
>
>
>>
>>
>> ------------------ =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 ----------------=
--
>> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* "Jan Just Keijser" <janjust@...1147...>;
>> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2020=E5=B9=B412=E6=9C=884=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) =E6=99=9A=E4=B8=8A6:19
>> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* "Tony He"<huangya90@...277...>;
>> *=E6=8A=84=E9=80=81:* "lev"<lev@...515...>;"Antonio Quartulli"<a@...2588...=
...
>> >;"openvpn-devel"<openvpn-devel@lists.sourceforge.net>;
>> *=E4=B8=BB=E9=A2=98:* Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac support=
ed?
>>
>> hi Tony,
>>
>> On 04/12/20 11:12, Tony He wrote:
>>
>> Hi Jan,
>>
>> >what HW engine is this?  I think your best bet is to actually get the
>> engine to support GCM; with AES and SHA acceleration in place there is v=
ery
>> little to stop the HW engine from not being able to support GCM..
>> The HW engine is a part of SoC al314. It connects with A15 CPU via PCI in
>> SoC. Chip vendor will not support GCM due to all kinds of reasons.
>>
>> ah pity, and the source code to this HW engine is closed source?
>>
>> >the numbers do suggest some form of cryptodev acceleration - can you
>> unload the cryptodev module or block access to it (e.g. chmod 000
>> /dev/crypto) ?
>> In my second set of test numbers, I uploaded the cryptodev moduled. You
>> can see the CCM performance is almost same.
>>
>> actually, I see the same on my i5-6800 with OpenSSL 1.0.2m but NOT with
>> OpenSSL 1.1.1g; this leads me to believe that CCM support in the openssl
>> 1.0.x speed command is screwed up.   It will be worthwhile to build open=
ssl
>> 1.1.1 for the AL314 just to see if aes-128-ccm is a viable option or not.
>>
>> JJK
>>
>> Jan Just Keijser <janjust@...1147...> =E4=BA=8E2020=E5=B9=B412=E6=9C=884=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:49=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>>> Hi Tony,
>>>
>>> On 04/12/20 08:41, Tony He wrote:
>>>
>>> Hi Jan,
>>> Yeah, need option " -elapsed" because OpenSSL counts user time instead
>>> of total time(user+sys time) without this option. You can see:
>>> * aes-128-cbc and sha1 are accelerated by HW engine. I believe speed is
>>> faster for openvpn dco module because it uses the HW engine in kernel s=
pace
>>> and bypasses the path between openssl and cryptodev.
>>>
>>> that is correct the openvpn dco module sits in kernel space and does
>>> need to pass the userspace<->kernelspace barrier and thus should have
>>> better performance
>>>
>>> * aes-128-gcm is NOT accelerated by HW engine.
>>>
>>> what HW engine is this?  I think your best bet is to actually get the
>>> engine to support GCM; with AES and SHA acceleration in place there is =
very
>>> little to stop the HW engine from not being able to support GCM...
>>>
>>> * aes-128-ccm is NOT accelerated by HW engine but it seems that it is
>>> accelerated by HW instruction or other. I don't know my device has such
>>> function. SoC type is al314.
>>>
>>> the numbers do suggest some form of cryptodev acceleration - can you
>>> unload the cryptodev module or block access to it (e.g. chmod 000
>>> /dev/crypto) ?
>>>
>>> The AL314 is a quad core Cortex A15 CPU @ 1.7 GHz ; the numbers
>>> *without* cryptodev look about right for that particular CPU.
>>>
>>> Most modern crypto packages use AES-GCM or chacha20-poly1305 as they are
>>> considered more secure. CBC is considered a bit outdated and as far as I
>>> know no openvpn release supports CCM thus far (which is a shame, really=
).
>>>
>>> HTH,
>>>
>>> JJK
>>>
>>>
>>>
>>> With cryptodev: # openssl speed -evp aes-128-cbc -elapsed You have
>>> chosen to measure elapsed time instead of user CPU time. Doing aes-128-=
cbc
>>> for 3s on 16 size blocks: 252783 aes-128-cbc's in 3.00s Doing aes-128-c=
bc
>>> for 3s on 64 size blocks: 253044 aes-128-cbc's in 3.00s Doing aes-128-c=
bc
>>> for 3s on 256 size blocks: 251746 aes-128-cbc's in 3.00s Doing aes-128-=
cbc
>>> for 3s on 1024 size blocks: 190306 aes-128-cbc's in 3.00s Doing aes-128=
-cbc
>>> for 3s on 8192 size blocks: 122657 aes-128-cbc's in 3.00s
>>> ...................... type 16 bytes 64 bytes 256 bytes 1024 bytes 8192
>>> bytes aes-128-cbc 1348.18k 5398.27k 21482.33k 64957.78k 334935.38k #
>>> openssl speed -evp aes-128-gcm -elapsed You have chosen to measure elap=
sed
>>> time instead of user CPU time. Doing aes-128-gcm for 3s on 16 size bloc=
ks:
>>> 3509485 aes-128-gcm's in 3.00s Doing aes-128-gcm for 3s on 64 size bloc=
ks:
>>> 900678 aes-128-gcm's in 3.00s Doing aes-128-gcm for 3s on 256 size bloc=
ks:
>>> 228961 aes-128-gcm's in 3.00s Doing aes-128-gcm for 3s on 1024 size blo=
cks:
>>> 57475 aes-128-gcm's in 3.00s Doing aes-128-gcm for 3s on 8192 size bloc=
ks:
>>> 7189 aes-128-gcm's in 3.00s .................. type 16 bytes 64 bytes 2=
56
>>> bytes 1024 bytes 8192 bytes aes-128-gcm 18717.25k 19214.46k 19538.01k
>>> 19618.13k 19630.76k
>>> # openssl speed -evp aes-128-ccm -elapsed You have chosen to measure
>>> elapsed time instead of user CPU time. Doing aes-128-ccm for 3s on 16 s=
ize
>>> blocks: 10179383 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 64 =
size
>>> blocks: 10179215 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 256
>>> size blocks: 10179785 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on
>>> 1024 size blocks: 10182095 aes-128-ccm's in 3.00s Doing aes-128-ccm for=
 3s
>>> on 8192 size blocks: 10179225 aes-128-ccm's in 3.00s ..................
>>> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-ccm
>>> 54290.04k 217156.59k 868674.99k 3475488.43k 27796070.40k # openssl speed
>>> -evp sha1 -elapsed You have chosen to measure elapsed time instead of u=
ser
>>> CPU time. Doing sha1 for 3s on 16 size blocks: 95252 sha1's in 3.00s Do=
ing
>>> sha1 for 3s on 64 size blocks: 95166 sha1's in 3.00s Doing sha1 for 3s =
on
>>> 256 size blocks: 76177 sha1's in 3.00s Doing sha1 for 3s on 1024 size
>>> blocks: 68799 sha1's in 3.00s Doing sha1 for 3s on 8192 size blocks: 53=
034
>>> sha1's in 3.00s ................. type 16 bytes 64 bytes 256 bytes 1024
>>> bytes 8192 bytes sha1 508.01k 2030.21k 6500.44k 23483.39k 144818.18k
>>> Without cryptodev:
>>> # openssl speed -evp aes-128-cbc -elapsed You have chosen to measure
>>> elapsed time instead of user CPU time. Doing aes-128-cbc for 3s on 16 s=
ize
>>> blocks: 9235207 aes-128-cbc's in 3.00s Doing aes-128-cbc for 3s on 64 s=
ize
>>> blocks: 2498066 aes-128-cbc's in 3.00s Doing aes-128-cbc for 3s on 256 =
size
>>> blocks: 645288 aes-128-cbc's in 3.00s Doing aes-128-cbc for 3s on 1024 =
size
>>> blocks: 161372 aes-128-cbc's in 3.00s Doing aes-128-cbc for 3s on 8192 =
size
>>> blocks: 20385 aes-128-cbc's in 3.00s ................ type 16 bytes 64
>>> bytes 256 bytes 1024 bytes 8192 bytes aes-128-cbc 49254.44k 53292.07k
>>> 55064.58k 55081.64k 55664.64k
>>> # openssl speed -evp aes-128-gcm -elapsed You have chosen to measure
>>> elapsed time instead of user CPU time. Doing aes-128-gcm for 3s on 16 s=
ize
>>> blocks: 3507422 aes-128-gcm's in 3.00s Doing aes-128-gcm for 3s on 64 s=
ize
>>> blocks: 901036 aes-128-gcm's in 3.00s Doing aes-128-gcm for 3s on 256 s=
ize
>>> blocks: 228857 aes-128-gcm's in 3.00s Doing aes-128-gcm for 3s on 1024 =
size
>>> blocks: 57411 aes-128-gcm's in 3.00s Doing aes-128-gcm for 3s on 8192 s=
ize
>>> blocks: 7188 aes-128-gcm's in 3.00s ................ type 16 bytes 64 b=
ytes
>>> 256 bytes 1024 bytes 8192 bytes aes-128-gcm 18706.25k 19222.10k 19529.1=
3k
>>> 19596.29k 19628.03k
>>> # openssl speed -evp aes-128-ccm -elapsed You have chosen to measure
>>> elapsed time instead of user CPU time. Doing aes-128-ccm for 3s on 16 s=
ize
>>> blocks: 10170897 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 64 =
size
>>> blocks: 10167692 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on 256
>>> size blocks: 10166117 aes-128-ccm's in 3.00s Doing aes-128-ccm for 3s on
>>> 1024 size blocks: 10167095 aes-128-ccm's in 3.00s Doing aes-128-ccm for=
 3s
>>> on 8192 size blocks: 10172046 aes-128-ccm's in 3.00s ................. =
type
>>> 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-ccm 54244.78k
>>> 216910.76k 867508.65k 3470368.43k 27776466.94k
>>> openssl speed -evp sha1 -elapsed You have chosen to measure elapsed time
>>> instead of user CPU time. Doing sha1 for 3s on 16 size blocks: 1877571
>>> sha1's in 3.00s Doing sha1 for 3s on 64 size blocks: 1250523 sha1's in
>>> 3.00s Doing sha1 for 3s on 256 size blocks: 603090 sha1's in 3.00s Doing
>>> sha1 for 3s on 1024 size blocks: 198963 sha1's in 3.00s Doing sha1 for =
3s
>>> on 8192 size blocks: 27380 sha1's in 3.00s ............... type 16 byte=
s 64
>>> bytes 256 bytes 1024 bytes 8192 bytes sha1 10013.71k 26677.82k 51463.68k
>>> 67912.70k 74765.65k
>>> Tony
>>>
>>> Jan Just Keijser <janjust@...1147...> =E4=BA=8E2020=E5=B9=B412=E6=9C=88=
2=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:24=E5=86=99=E9=81=93=EF=
=BC=9A
>>>
>>>> Hi Tony,
>>>>
>>>> On 02/12/20 15:51, Jan Just Keijser wrote:
>>>>
>>>>
>>>> On 02/12/20 15:22, Tony He wrote:
>>>>
>>>> Hi Jan,
>>>>
>>>> Welcome to join the discussion.
>>>>
>>>> >the second set of numbers doesn't make sense, and a much better test
>>>> is to do an actual encryption test
>>>> I don't compile cryptodev kernel module for my PC and can not reproduce
>>>> this issue for now.  You don't understand  the reason why the performa=
nce
>>>> is much worse with cryptodev module for *big* blocks, right?
>>>> If yes, I guess the reason maybe kernel assign the work to multi cores
>>>> while OpenSSL uses one core. Would you share the output of command "mp=
stat
>>>> -P ALL 2"?
>>>>
>>>> sure, while using the cryptodev I see this:
>>>>
>>>> 15:28:36     CPU    %usr   %nice    %sys %iowait    %irq   %soft
>>>> %steal  %guest  %gnice   %idle
>>>> 15:28:38     all    1.87    0.00   23.19    0.12    0.00    0.00
>>>> 0.00    0.00    0.00   74.81
>>>> 15:28:38       0    0.00    0.00    0.00    0.50    0.00    0.00
>>>> 0.00    0.00    0.00   99.50
>>>> 15:28:38       1    7.00    0.00   93.00    0.00    0.00    0.00
>>>> 0.00    0.00    0.00    0.00
>>>> 15:28:38       2    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 0.00    0.00    0.00  100.00
>>>> 15:28:38       3    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 0.00    0.00    0.00  100.00
>>>>
>>>> 15:28:38     CPU    %usr   %nice    %sys %iowait    %irq   %soft
>>>> %steal  %guest  %gnice   %idle
>>>> 15:28:40     all    0.75    0.00   24.19    0.00    0.00    0.00
>>>> 0.00    0.00    0.00   75.06
>>>> 15:28:40       0    0.00    0.00    0.00    0.50    0.00    0.00
>>>> 0.00    0.00    0.00   99.50
>>>> 15:28:40       1    3.50    0.00   96.50    0.00    0.00    0.00
>>>> 0.00    0.00    0.00    0.00
>>>> 15:28:40       2    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 0.00    0.00    0.00  100.00
>>>> 15:28:40       3    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 0.00    0.00    0.00  100.00
>>>>
>>>> on a 4 core box; this means that 1 core is used 100% (which is what I
>>>> expected).
>>>>
>>>>
>>>> I suspect the main reason the cryptodev results on my i5-6800 go off
>>>> the rails is due to this:
>>>> (look at the "Doing aes-128-cbc lines")
>>>>
>>>> $ ./openssl speed -evp aes-128-cbc
>>>> Doing aes-128-cbc for 3s on 16 size blocks: 2835368 aes-128-cbc's in
>>>> 1.14s
>>>> Doing aes-128-cbc for 3s on 64 size blocks: 2720745 aes-128-cbc's in
>>>> 1.01s
>>>> Doing aes-128-cbc for 3s on 256 size blocks: 2377830 aes-128-cbc's in
>>>> *0.74s*
>>>> Doing aes-128-cbc for 3s on 1024 size blocks: 1538693 aes-128-cbc's in
>>>> *0.40s*
>>>> Doing aes-128-cbc for 3s on 8192 size blocks: 370202 aes-128-cbc's in
>>>> *0.11s*
>>>> OpenSSL 1.0.2m  2 Nov 2017
>>>> built on: reproducible build, date unspecified
>>>> options:bn(64,64) rc4(16x,int) des(idx,cisc,16,int) aes(partial)
>>>> idea(int) blowfish(idx)
>>>> compiler: gcc -I. -I.. -I../include  -DOPENSSL_THREADS -D_REENTRANT
>>>> -DDSO_DLFCN -DHAVE_DLFCN_H -DHAVE_CRYPTODEV -DUSE_CRYPTODEV_DIGESTS
>>>> -Wa,--noexecstack -m64 -DL_ENDIAN -O3 -Wall -DOPENSSL_IA32_SSE2
>>>> -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m
>>>> -DRC4_ASM -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DMD5_ASM -DAES_ASM
>>>> -DVPAES_ASM -DBSAES_ASM -DWHIRLPOOL_ASM -DGHASH_ASM -DECP_NISTZ256_ASM
>>>> The 'numbers' are in 1000s of bytes per second processed.
>>>> type             16 bytes     64 bytes    256 bytes   1024 bytes   8192
>>>> bytes
>>>> aes-128-cbc      39794.64k   172403.64k   822600.65k  3939054.08k
>>>> 27569952.58k
>>>>
>>>>
>>>> The timing for how quickly the results are returned are way off and
>>>> probably just wrong. The Openssl speed test is supposed to run for 3
>>>> seconds. The actual results returned for 8192 byte blocks is
>>>>
>>>> Doing aes-128-cbc for 3s on 8192 size blocks: 370202 aes-128-cbc's in
>>>> *0.11s*
>>>>
>>>> whereas without cryptodev I see
>>>>
>>>> Doing aes-128-cbc for 3s on 8192 size blocks: 457255 aes-128-cbc's in
>>>> *3.00s*
>>>>
>>>> So you can see that without cryptodev the i5-6800 actually says it's
>>>> doing more blocks (457,255 vs 370,202) but with cryptodev it is doing =
it in
>>>> WAY less time.  This leads me to believe the openssl speed code when u=
sing
>>>> cryptodev just "goes wrong".
>>>> It will be very interesting to see what the encryption test will bring
>>>> - that is a much better real-life-like example than a simple speed tes=
t.
>>>>
>>>> as a follow-up : someone whispered in my ear (thanks, Andr=C3=A9 ;) ) =
that
>>>> one should use the -elapsed option for this, so here are new results:
>>>>
>>>> *with* cryptodev:
>>>>
>>>> ./openssl speed -evp aes-128-cbc -elapsed
>>>> You have chosen to measure elapsed time instead of user CPU time.
>>>> Doing aes-128-cbc for 3s on 16 size blocks: 2825786 aes-128-cbc's in
>>>> 3.00s
>>>> Doing aes-128-cbc for 3s on 64 size blocks: 2716822 aes-128-cbc's in
>>>> 3.00s
>>>> Doing aes-128-cbc for 3s on 256 size blocks: 2369723 aes-128-cbc's in
>>>> 3.00s
>>>> Doing aes-128-cbc for 3s on 1024 size blocks: 1536054 aes-128-cbc's in
>>>> 3.00s
>>>> Doing aes-128-cbc for 3s on 8192 size blocks: 369984 aes-128-cbc's in
>>>> 3.00s
>>>> [...]
>>>> aes-128-cbc      15,070.86k    57,958.87k   202,216.36k   524,306.43k
>>>> 1,010,302.98k
>>>>
>>>> *without* cryptodev:
>>>>
>>>> $ openssl speed -evp aes-128-cbc -elapsed
>>>> You have chosen to measure elapsed time instead of user CPU time.
>>>> Doing aes-128-cbc for 3s on 16 size blocks: 207188725 aes-128-cbc's in
>>>> 3.00s
>>>> Doing aes-128-cbc for 3s on 64 size blocks: 56855717 aes-128-cbc's in
>>>> 3.00s
>>>> Doing aes-128-cbc for 3s on 256 size blocks: 14382122 aes-128-cbc's in
>>>> 3.00s
>>>> Doing aes-128-cbc for 3s on 1024 size blocks: 3618996 aes-128-cbc's in
>>>> 3.00s
>>>> Doing aes-128-cbc for 3s on 8192 size blocks: 456727 aes-128-cbc's in
>>>> 3.00s
>>>> [...]
>>>> aes-128-cbc    1,105,006.53k  1,212,921.96k  1,227,274.41k
>>>> 1,235,283.97k  1,247,169.19k
>>>>
>>>> which more or less reflects the encryption test results I posted
>>>> earlier.
>>>> The question becomes, what are you results when using the -elapsed fla=
g?
>>>>
>>>> JJK
>>>>
>>>>
>>>> >My advice is to rerun your tests *without* the cryptodev module and
>>>> then decide wheter you really need CBC+CCM hmacs.
>>>> Yes, I confirm that without the cryptodev the performance is very bad
>>>> for my device. I don't have that device in my hand right now. But I sa=
ved
>>>> one aes-256-cbc result in my web notebook as below:
>>>>
>>>> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes
>>>> aes-256-cbc 19626.95k 24289.71k 25054.46k 25347.75k 25337.86k
>>>> Please note, there are two modes to accelerate encryption/decryption.
>>>> 1. HW instructions like intel x86 CPU.
>>>> 2. Using a crypto engine.
>>>> When your device is 2 and its CPU is not powerful, normally with
>>>> cryptodev speed is much faster at least for big blocks. Maybe for small
>>>> blocks it's slower because
>>>> it needs the time to push the work to kernel and then HW engine and the
>>>> time spent is may longer than the time costed by OpenSSL directly does=
 the
>>>> encryption/decryption.
>>>> Tony
>>>>
>>>> Jan Just Keijser <janjust@...1147...> =E4=BA=8E2020=E5=B9=B412=E6=9C=
=882=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:24=E5=86=99=E9=81=93=EF=
=BC=9A
>>>>
>>>>> hi Tony,
>>>>>
>>>>> On 01/12/20 02:50, Tony He wrote:
>>>>>
>>>>> Hi Arne,
>>>>>
>>>>> openssl speed -evp aes-128-cbc
>>>>> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-cbc
>>>>> 20035.60k 123261.54k 267081.60k 1094764.09k 9181370.18k
>>>>> openssl speed -evp aes-128-gcm
>>>>> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-gcm
>>>>> 18738.76k 19284.91k 19524.44k 19606.87k 19685.46k
>>>>> openssl speed -evp aes-128-ccm
>>>>> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-ccm
>>>>> 53859.07k 215581.12k 862070.02k 3460786.43k 27566347.61k
>>>>> openssl speed -evp sha1
>>>>> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes sha1 3108.57k
>>>>> 12177.79k 57325.18k 181610.34k 1207364.27k
>>>>> openssl speed -evp chacha20-poly1305
>>>>> chacha20-poly1305 is an unknown cipher or digest
>>>>> Using old openssl, so chacha20-poly1305 is not supported.
>>>>>
>>>>>
>>>>> these numbers look suspiciously like you're using the linux cryptodev
>>>>> module. Openssl speed results for the linux cryptodev module are tota=
lly
>>>>> unreliable and I'd even go so far as to say that the *only* numbers I=
 trust
>>>>> in the output above are for aes-128-gcm
>>>>>
>>>>> For example, if I do the same on an i5-6800 I get *without* the
>>>>> cryptodev module:
>>>>>   $ openssl speed -evp aes-128-cbc
>>>>>   aes-128-cbc    1,104,599.38k  1,208,651.07k  1,231,766.70k
>>>>> 1,237,545.64k  1,248,793.94k
>>>>>
>>>>> and with the module I get
>>>>>   aes-128-cbc      45,087.41k   127,822.72k   581,517.17k
>>>>> 2,256,593.19k 27,583,804.51k
>>>>>
>>>>> the second set of numbers doesn't make sense, and a much better test
>>>>> is to do an actual encryption test, e.g.
>>>>>
>>>>> *without* the module
>>>>> cat BIGFILE | openssl aes-256-cbc -e -pass  pass:thisisabadpassword |
>>>>> pv > /dev/null
>>>>> 2.93GB 0:00:05 [ 549MB/s] [
>>>>> <=3D>
>>>>> ]
>>>>>
>>>>> ('pv' aka 'pipeview' is a handy tool to measure the throughput of a
>>>>> UNIX pipe)
>>>>>
>>>>> and with the module:
>>>>> cat BIGFILE | ./openssl aes-256-cbc -e -pass  pass:thisisabadpassword
>>>>> -engine cryptodev|  pv > /dev/null
>>>>> engine "cryptodev" set.
>>>>> 2.93GB 0:00:07 [ 426MB/s] [              <=3D>
>>>>>
>>>>> so you see that using the cryptodev module actually slows things down
>>>>> - which is to be expected, as the application needs to do more work u=
sing
>>>>> the cryptodev module.
>>>>>
>>>>> My advice is to rerun your tests *without* the cryptodev module and
>>>>> then decide wheter you really need CBC+CCM hmacs.
>>>>>
>>>>> HTH,
>>>>>
>>>>> JJK
>>>>>
>>>>>
>>>>> Arne Schwabe <arne@...1227...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:40=E5=86=99=E9=81=93=EF=BC=9A
>>>>>
>>>>>> Am 26.11.20 um 10:41 schrieb Tony He:
>>>>>> > Hi Arne,
>>>>>> >
>>>>>> >>Since the original thread was not on the mailing list I am missing
>>>>>> your
>>>>>> >>goal but if your crypto acelator already works with OpenSSL, then =
it
>>>>>> >>will also work with the "normal" OpenVPN
>>>>>> >
>>>>>> > Yes, it wokrs with "normal" OpenVPN(OpenVPN2), but according to the
>>>>>> test
>>>>>> > result, it's still not fast(about 60Mbps).
>>>>>> > The bottleneck is not encryption operation any more. It comes from
>>>>>> the
>>>>>> > switch of user space and kernel space in the OpenVPN2,
>>>>>> > which makes the poor CPU of  embedded device very busy. That's why
>>>>>> we
>>>>>> > need OpenVPN3 running in the kernel space.
>>>>>>
>>>>>>
>>>>>> What numbers are we are talking in crypto speed? Could you provide
>>>>>> from
>>>>>> your "poor" device:
>>>>>>
>>>>>>
>>>>>> openssl speed -evp aes-128-cbc
>>>>>> openssl speed -evp aes-128-gcm
>>>>>> openssl speed -evp aes-128-ccm
>>>>>> openssl speed -evp sha1
>>>>>> openssl speed -evp chacha20-poly1305
>>>>>>
>>>>>> I want to what difference/gain in terms of raw crypto speed we are
>>>>>> talking here.
>>>>>>
>>>>>
>>>
>>

--000000000000d801f105b5d641bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jan, Antonio<div><br></div><div>&gt;<span style=3D"colo=
r:rgb(80,0,80)">actually, I see the same on my i5-6800 with OpenSSL 1.0.2m =
but NOT with OpenSSL 1.1.1g; this leads me to believe that CCM support in t=
he openssl 1.0.x speed command is screwed up.=C2=A0=C2=A0 It will be worthw=
hile to build openssl 1.1.1 for the AL314 just to see if aes-128-ccm is a v=
iable option or not.</span></div><div><br></div><div>Yes, this should be Op=
enSSL 1.0.x bug.=C2=A0 I tested 1.1.1h and see normal and expected low valu=
es for the Al314.@...2587..., I saw your another mail to announce=C2=A0CCM =
support,</div><div>but I&#39;m afraid I can not benifit this. Anyway, it mi=
ght be helpful for other devices.=C2=A0Thanks for your work.</div><div><br>=
</div><div>With cryptodev:</div><div><div style=3D"white-space:pre-wrap">
# openssl speed -evp aes-128-ccm -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing aes-128-ccm for 3s on 16 size blocks: 3453400 aes-128-ccm&#39;s in 3.=
00s
Doing aes-128-ccm for 3s on 64 size blocks: 1513715 aes-128-ccm&#39;s in 3.=
00s
Doing aes-128-ccm for 3s on 256 size blocks: 472417 aes-128-ccm&#39;s in 3.=
00s
Doing aes-128-ccm for 3s on 1024 size blocks: 125752 aes-128-ccm&#39;s in 3=
.00s
Doing aes-128-ccm for 3s on 8192 size blocks: 15984 aes-128-ccm&#39;s in 3.=
00s
Doing aes-128-ccm for 3s on 16384 size blocks: 7982 aes-128-ccm&#39;s in 3.=
00s
OpenSSL 1.1.1h  22 Sep 2020
built on: Mon Dec  7 01:33:13 2020 UTC
...................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es  16384 bytes
aes-128-ccm      18418.13k    32292.59k    40312.92k    42923.35k    43646.=
98k    43592.36k


Without cryptodev:
# openssl speed -evp aes-128-ccm -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing aes-128-ccm for 3s on 16 size blocks: 3432128 aes-128-ccm&#39;s in 3.=
00s
Doing aes-128-ccm for 3s on 64 size blocks: 1513301 aes-128-ccm&#39;s in 3.=
00s
Doing aes-128-ccm for 3s on 256 size blocks: 470389 aes-128-ccm&#39;s in 3.=
00s
Doing aes-128-ccm for 3s on 1024 size blocks: 125731 aes-128-ccm&#39;s in 3=
.00s
Doing aes-128-ccm for 3s on 8192 size blocks: 15989 aes-128-ccm&#39;s in 3.=
00s
Doing aes-128-ccm for 3s on 16384 size blocks: 8010 aes-128-ccm&#39;s in 3.=
00s
OpenSSL 1.1.1h  22 Sep 2020
built on: Mon Dec  7 01:33:13 2020 UTC
...................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es  16384 bytes
aes-128-ccm      18304.68k    32283.75k    40139.86k    42916.18k    43660.=
63k    43745.28k
            </div></div><div style=3D"white-space:pre-wrap">Tony</div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Tony =
He &lt;<a href=3D"mailto:huangya90@...277...">huangya90@...277...</a>&gt; =
=E4=BA=8E2020=E5=B9=B412=E6=9C=886=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=
=8D=8810:57=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div>Hi Jan,</div><div><br></div><d=
iv><div>The driver is open source. <a href=3D"https://github.com/SVoxel/R90=
00/tree/master/git_home/linux.git/drivers/crypto/al." rel=3D"noopener" targ=
et=3D"_blank">https://github.com/SVoxel/R9000/tree/master/git_home/linux.gi=
t/drivers/crypto/al.</a></div><div>I&#39;m
 newbie to crypto stuff. Not sure if there is any HW limitation for this
 engine to support GCM. If only need to modify the code, maybe there is=20
chance that someone will implement this.</div></div><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div><br></div><div><div><br></div><div><br></di=
v><div style=3D"font-size:12px;font-family:&quot;Arial Narrow&quot;;padding=
:2px 0px">------------------=C2=A0=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=C2=
=A0------------------</div><div style=3D"font-size:12px;background:none 0% =
0% repeat scroll rgb(239,239,239);padding:8px"><div><b>=E5=8F=91=E4=BB=B6=
=E4=BA=BA:</b>                                                             =
                                                           &quot;Jan Just K=
eijser&quot;                                                               =
                     &lt;<a href=3D"mailto:janjust@...1147..." target=3D"_b=
lank">janjust@...1147...</a>&gt;;</div><div><b>=E5=8F=91=E9=80=81=E6=97=B6=
=E9=97=B4:</b>=C2=A02020=E5=B9=B412=E6=9C=884=E6=97=A5(=E6=98=9F=E6=9C=9F=
=E4=BA=94) =E6=99=9A=E4=B8=8A6:19</div><div><b>=E6=94=B6=E4=BB=B6=E4=BA=BA:=
</b>=C2=A0&quot;Tony He&quot;&lt;<a href=3D"mailto:huangya90@...277..." tar=
get=3D"_blank">huangya90@...277...</a>&gt;;</div><div><b>=E6=8A=84=E9=80=81=
:</b>=C2=A0&quot;lev&quot;&lt;<a href=3D"mailto:lev@...515..." target=3D"_b=
lank">lev@...515...</a>&gt;;&quot;Antonio Quartulli&quot;&lt;a@...2181...&g=
t;;&quot;openvpn-devel&quot;&lt;<a href=3D"mailto:openvpn-devel@...1011...=
eforge.net" target=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt;;<=
/div><div><b>=E4=B8=BB=E9=A2=98:</b>=C2=A0Re: [Openvpn-devel] [ovpn-dco] Is=
 cbc-hmac supported?</div></div><div><br></div>
=20=20
=20=20=20=20
=20=20
=20=20
    <div>hi Tony,<br>
      <br>
      On 04/12/20 11:12, Tony He wrote:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div dir=3D"ltr">Hi Jan,
        <div><br>
        </div>
        <div>&gt;what HW engine is this?=C2=A0 I think your best bet is to
          actually get the engine to support GCM; with AES and SHA
          acceleration in place there is very little to stop the HW
          engine from not being able to support GCM..</div>
        <div>The HW engine is a part of SoC al314. It connects with A15
          CPU via PCI in SoC. Chip vendor will not support GCM due to
          all kinds of reasons.</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    ah pity, and the source code to this HW engine is closed source?<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>&gt;the numbers do suggest some form of cryptodev
          acceleration - can you unload the cryptodev module or block
          access to it (e.g. chmod 000 /dev/crypto) ?</div>
        <div>In my second set of test numbers, I uploaded the cryptodev
          moduled. You can see the CCM performance is almost same.</div>
        <br>
      </div>
    </blockquote>
    actually, I see the same on my i5-6800 with OpenSSL 1.0.2m but NOT
    with OpenSSL 1.1.1g; this leads me to believe that CCM support in
    the openssl 1.0.x speed command is screwed up.=C2=A0=C2=A0 It will be
    worthwhile to build openssl 1.1.1 for the AL314 just to see if
    aes-128-ccm is a viable option or not.<br>
    <br>
    JJK<br>
    <br>
    <blockquote type=3D"cite">
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">Jan Just Keijser &lt;<a href=
=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>&gt;
          =E4=BA=8E2020=E5=B9=B412=E6=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=
=B8=8B=E5=8D=885:49=E5=86=99=E9=81=93=EF=BC=9A<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div bgcolor=3D"#FFFFFF">
            <div>Hi Tony,<br>
              <br>
              On 04/12/20 08:41, Tony He wrote:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">Hi Jan,
                <div>
                  <div style=3D"white-space:pre-wrap">
</div>
                  <div style=3D"white-space:pre-wrap">Yeah, need option &qu=
ot; -elapsed&quot; because OpenSSL counts user time instead of total time(u=
ser+sys time) without this option. You can see:</div>
                  <div style=3D"white-space:pre-wrap">* aes-128-cbc and sha=
1 are accelerated by HW engine. I believe speed is faster  for openvpn dco =
module because it uses the HW engine in kernel space and bypasses the path =
between openssl and cryptodev.</div>
                </div>
              </div>
            </blockquote>
            that is correct the openvpn dco module sits in kernel space
            and does need to pass the userspace&lt;-&gt;kernelspace
            barrier and thus should have better performance<br>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>
                  <div style=3D"white-space:pre-wrap">* aes-128-gcm is NOT =
accelerated by HW engine.</div>
                </div>
              </div>
            </blockquote>
            what HW engine is this?=C2=A0 I think your best bet is to
            actually get the engine to support GCM; with AES and SHA
            acceleration in place there is very little to stop the HW
            engine from not being able to support GCM...<br>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>
                  <div style=3D"white-space:pre-wrap">* aes-128-ccm is NOT =
accelerated by HW engine but it seems that it is accelerated by HW instruct=
ion or other. I don&#39;t know my device has such function. SoC type is al3=
14.</div>
                  <div style=3D"white-space:pre-wrap">
</div>
                </div>
              </div>
            </blockquote>
            the numbers do suggest some form of cryptodev acceleration -
            can you unload the cryptodev module or block access to it
            (e.g. chmod 000 /dev/crypto) ?<br>
            <br>
            The AL314 is a quad core Cortex A15 CPU @ 1.7 GHz ; the
            numbers *without* cryptodev look about right for that
            particular CPU.<br>
            <br>
            Most modern crypto packages use AES-GCM or chacha20-poly1305
            as they are considered more secure. CBC is considered a bit
            outdated and as far as I know no openvpn release supports
            CCM thus far (which is a shame, really).<br>
            <br>
            HTH,<br>
            <br>
            JJK<br>
            <br>
            <br>
            <br>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>
                  <div style=3D"white-space:pre-wrap">
</div>
                  <div style=3D"white-space:pre-wrap">With cryptodev:
# openssl speed -evp aes-128-cbc -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing aes-128-cbc for 3s on 16 size blocks: 252783 aes-128-cbc&#39;s in 3.0=
0s
Doing aes-128-cbc for 3s on 64 size blocks: 253044 aes-128-cbc&#39;s in 3.0=
0s
Doing aes-128-cbc for 3s on 256 size blocks: 251746 aes-128-cbc&#39;s in 3.=
00s
Doing aes-128-cbc for 3s on 1024 size blocks: 190306 aes-128-cbc&#39;s in 3=
.00s
Doing aes-128-cbc for 3s on 8192 size blocks: 122657 aes-128-cbc&#39;s in 3=
.00s
......................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
aes-128-cbc       1348.18k     5398.27k    21482.33k    64957.78k   334935.=
38k
# openssl speed -evp aes-128-gcm -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing aes-128-gcm for 3s on 16 size blocks: 3509485 aes-128-gcm&#39;s in 3.=
00s
Doing aes-128-gcm for 3s on 64 size blocks: 900678 aes-128-gcm&#39;s in 3.0=
0s
Doing aes-128-gcm for 3s on 256 size blocks: 228961 aes-128-gcm&#39;s in 3.=
00s
Doing aes-128-gcm for 3s on 1024 size blocks: 57475 aes-128-gcm&#39;s in 3.=
00s
Doing aes-128-gcm for 3s on 8192 size blocks: 7189 aes-128-gcm&#39;s in 3.0=
0s
..................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
aes-128-gcm      18717.25k    19214.46k    19538.01k    19618.13k    19630.=
76k</div>
                  <div style=3D"white-space:pre-wrap">
# openssl speed -evp aes-128-ccm -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing aes-128-ccm for 3s on 16 size blocks: 10179383 aes-128-ccm&#39;s in 3=
.00s
Doing aes-128-ccm for 3s on 64 size blocks: 10179215 aes-128-ccm&#39;s in 3=
.00s
Doing aes-128-ccm for 3s on 256 size blocks: 10179785 aes-128-ccm&#39;s in =
3.00s
Doing aes-128-ccm for 3s on 1024 size blocks: 10182095 aes-128-ccm&#39;s in=
 3.00s
Doing aes-128-ccm for 3s on 8192 size blocks: 10179225 aes-128-ccm&#39;s in=
 3.00s
..................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
aes-128-ccm      54290.04k   217156.59k   868674.99k  3475488.43k 27796070.=
40k
# openssl speed -evp sha1 -elapsed=20=20=20=20=20=20=20
You have chosen to measure elapsed time instead of user CPU time.
Doing sha1 for 3s on 16 size blocks: 95252 sha1&#39;s in 3.00s
Doing sha1 for 3s on 64 size blocks: 95166 sha1&#39;s in 3.00s
Doing sha1 for 3s on 256 size blocks: 76177 sha1&#39;s in 3.00s
Doing sha1 for 3s on 1024 size blocks: 68799 sha1&#39;s in 3.00s
Doing sha1 for 3s on 8192 size blocks: 53034 sha1&#39;s in 3.00s
.................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
sha1               508.01k     2030.21k     6500.44k    23483.39k   144818.=
18k

            </div>
                </div>
                <div style=3D"white-space:pre-wrap">
</div>
                <div style=3D"white-space:pre-wrap">Without cryptodev:</div>
                <div style=3D"white-space:pre-wrap"><div># openssl speed -e=
vp aes-128-cbc -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing aes-128-cbc for 3s on 16 size blocks: 9235207 aes-128-cbc&#39;s in 3.=
00s
Doing aes-128-cbc for 3s on 64 size blocks: 2498066 aes-128-cbc&#39;s in 3.=
00s
Doing aes-128-cbc for 3s on 256 size blocks: 645288 aes-128-cbc&#39;s in 3.=
00s
Doing aes-128-cbc for 3s on 1024 size blocks: 161372 aes-128-cbc&#39;s in 3=
.00s
Doing aes-128-cbc for 3s on 8192 size blocks: 20385 aes-128-cbc&#39;s in 3.=
00s
................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
aes-128-cbc      49254.44k    53292.07k    55064.58k    55081.64k    55664.=
64k</div><div>
# openssl speed -evp aes-128-gcm -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing aes-128-gcm for 3s on 16 size blocks: 3507422 aes-128-gcm&#39;s in 3.=
00s
Doing aes-128-gcm for 3s on 64 size blocks: 901036 aes-128-gcm&#39;s in 3.0=
0s
Doing aes-128-gcm for 3s on 256 size blocks: 228857 aes-128-gcm&#39;s in 3.=
00s
Doing aes-128-gcm for 3s on 1024 size blocks: 57411 aes-128-gcm&#39;s in 3.=
00s
Doing aes-128-gcm for 3s on 8192 size blocks: 7188 aes-128-gcm&#39;s in 3.0=
0s
................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
aes-128-gcm      18706.25k    19222.10k    19529.13k    19596.29k    19628.=
03k</div><div>
# openssl speed -evp aes-128-ccm -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing aes-128-ccm for 3s on 16 size blocks: 10170897 aes-128-ccm&#39;s in 3=
.00s
Doing aes-128-ccm for 3s on 64 size blocks: 10167692 aes-128-ccm&#39;s in 3=
.00s
Doing aes-128-ccm for 3s on 256 size blocks: 10166117 aes-128-ccm&#39;s in =
3.00s
Doing aes-128-ccm for 3s on 1024 size blocks: 10167095 aes-128-ccm&#39;s in=
 3.00s
Doing aes-128-ccm for 3s on 8192 size blocks: 10172046 aes-128-ccm&#39;s in=
 3.00s
.................
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
aes-128-ccm      54244.78k   216910.76k   867508.65k  3470368.43k 27776466.=
94k</div><div>
openssl speed -evp sha1 -elapsed
You have chosen to measure elapsed time instead of user CPU time.
Doing sha1 for 3s on 16 size blocks: 1877571 sha1&#39;s in 3.00s
Doing sha1 for 3s on 64 size blocks: 1250523 sha1&#39;s in 3.00s
Doing sha1 for 3s on 256 size blocks: 603090 sha1&#39;s in 3.00s
Doing sha1 for 3s on 1024 size blocks: 198963 sha1&#39;s in 3.00s
Doing sha1 for 3s on 8192 size blocks: 27380 sha1&#39;s in 3.00s
...............
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
sha1             10013.71k    26677.82k    51463.68k    67912.70k    74765.=
65k
             </div><div>
</div><div>Tony</div></div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">Jan Just Keijser &lt;=
<a href=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...<=
/a>&gt;
                  =E4=BA=8E2020=E5=B9=B412=E6=9C=882=E6=97=A5=E5=91=A8=E4=
=B8=89 =E4=B8=8B=E5=8D=8811:24=E5=86=99=E9=81=93=EF=BC=9A<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  <div bgcolor=3D"#FFFFFF">
                    <div>Hi Tony,<br>
                      <br>
                      On 02/12/20 15:51, Jan Just Keijser wrote:<br>
                    </div>
                    <blockquote type=3D"cite">
                      <div><br>
                        On 02/12/20 15:22, Tony He wrote:<br>
                      </div>
                      <blockquote type=3D"cite">
                        <div dir=3D"ltr">
                          <div>Hi Jan,</div>
                          <div><br>
                          </div>
                          <div>Welcome to join the discussion.</div>
                          <div><br>
                          </div>
                          <div>&gt;the second set of numbers doesn&#39;t
                            make sense, and a much better test is to do
                            an actual encryption test</div>
                          <div>I don&#39;t compile cryptodev kernel module
                            for my PC and can not reproduce this issue
                            for now.=C2=A0 You don&#39;t understand=C2=A0 t=
he reason
                            why the performance is much worse with
                            cryptodev module for *big* blocks, right?<br>
                          </div>
                          <div>If yes, I guess the reason maybe kernel
                            assign the work to multi cores while OpenSSL
                            uses one core. Would you share the output of
                            command &quot;mpstat -P ALL 2&quot;?</div>
                          <div><br>
                          </div>
                        </div>
                      </blockquote>
                      sure, while using the cryptodev I see this:<br>
                      <br>
                      15:28:36=C2=A0=C2=A0=C2=A0=C2=A0 CPU=C2=A0=C2=A0=C2=
=A0 %usr=C2=A0=C2=A0 %nice=C2=A0=C2=A0=C2=A0 %sys
                      %iowait=C2=A0=C2=A0=C2=A0 %irq=C2=A0=C2=A0 %soft=C2=
=A0 %steal=C2=A0 %guest=C2=A0 %gnice=C2=A0=C2=A0
                      %idle<br>
                      15:28:38=C2=A0=C2=A0=C2=A0=C2=A0 all=C2=A0=C2=A0=C2=
=A0 1.87=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0 23.19=C2=A0=C2=A0=C2=A0
                      0.12=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=
=A0
                      74.81<br>
                      15:28:38=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
=C2=A0
                      0.50=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=
=A0
                      99.50<br>
                      15:28:38=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=
=C2=A0=C2=A0 7.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0 93.00=C2=A0=C2=A0=C2=A0
                      0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=
=A0=C2=A0
                      0.00<br>
                      15:28:38=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
=C2=A0
                      0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0
                      100.00<br>
                      15:28:38=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
=C2=A0
                      0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0
                      100.00<br>
                      <br>
                      15:28:38=C2=A0=C2=A0=C2=A0=C2=A0 CPU=C2=A0=C2=A0=C2=
=A0 %usr=C2=A0=C2=A0 %nice=C2=A0=C2=A0=C2=A0 %sys
                      %iowait=C2=A0=C2=A0=C2=A0 %irq=C2=A0=C2=A0 %soft=C2=
=A0 %steal=C2=A0 %guest=C2=A0 %gnice=C2=A0=C2=A0
                      %idle<br>
                      15:28:40=C2=A0=C2=A0=C2=A0=C2=A0 all=C2=A0=C2=A0=C2=
=A0 0.75=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0 24.19=C2=A0=C2=A0=C2=A0
                      0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=
=A0
                      75.06<br>
                      15:28:40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
=C2=A0
                      0.50=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=
=A0
                      99.50<br>
                      15:28:40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=
=C2=A0=C2=A0 3.50=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0 96.50=C2=A0=C2=A0=C2=A0
                      0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=
=A0=C2=A0
                      0.00<br>
                      15:28:40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
=C2=A0
                      0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0
                      100.00<br>
                      15:28:40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
=C2=A0
                      0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0
                      100.00<br>
                      <br>
                      on a 4 core box; this means that 1 core is used
                      100% (which is what I expected).<br>
                      <br>
                      <br>
                      I suspect the main reason the cryptodev results on
                      my i5-6800 go off the rails is due to this:<br>
                      (look at the &quot;Doing aes-128-cbc lines&quot;)<br>
                      <br>
                      $ ./openssl speed -evp aes-128-cbc<br>
                      Doing aes-128-cbc for 3s on 16 size blocks:
                      2835368 aes-128-cbc&#39;s in 1.14s<br>
                      Doing aes-128-cbc for 3s on 64 size blocks:
                      2720745 aes-128-cbc&#39;s in 1.01s<br>
                      Doing aes-128-cbc for 3s on 256 size blocks:
                      2377830 aes-128-cbc&#39;s in <b>0.74s</b><br>
                      Doing aes-128-cbc for 3s on 1024 size blocks:
                      1538693 aes-128-cbc&#39;s in <b>0.40s</b><br>
                      Doing aes-128-cbc for 3s on 8192 size blocks:
                      370202 aes-128-cbc&#39;s in <b>0.11s</b><br>
                      OpenSSL 1.0.2m=C2=A0 2 Nov 2017<br>
                      built on: reproducible build, date unspecified<br>
                      options:bn(64,64) rc4(16x,int)
                      des(idx,cisc,16,int) aes(partial) idea(int)
                      blowfish(idx) <br>
                      compiler: gcc -I. -I.. -I../include=C2=A0
                      -DOPENSSL_THREADS -D_REENTRANT -DDSO_DLFCN
                      -DHAVE_DLFCN_H -DHAVE_CRYPTODEV
                      -DUSE_CRYPTODEV_DIGESTS -Wa,--noexecstack -m64
                      -DL_ENDIAN -O3 -Wall -DOPENSSL_IA32_SSE2
                      -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5
                      -DOPENSSL_BN_ASM_GF2m -DRC4_ASM -DSHA1_ASM
                      -DSHA256_ASM -DSHA512_ASM -DMD5_ASM -DAES_ASM
                      -DVPAES_ASM -DBSAES_ASM -DWHIRLPOOL_ASM
                      -DGHASH_ASM -DECP_NISTZ256_ASM<br>
                      The &#39;numbers&#39; are in 1000s of bytes per second
                      processed.<br>
                      type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 16 bytes=C2=A0=C2=A0=C2=A0=C2=A0 64 bytes=C2=A0=C2=
=A0=C2=A0 256
                      bytes=C2=A0=C2=A0 1024 bytes=C2=A0=C2=A0 8192 bytes<b=
r>
                      aes-128-cbc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 39794.64k=
=C2=A0=C2=A0 172403.64k=C2=A0=C2=A0
                      822600.65k=C2=A0 3939054.08k 27569952.58k<br>
                      <br>
                      <br>
                      The timing for how quickly the results are
                      returned are way off and probably just wrong. The
                      Openssl speed test is supposed to run for 3
                      seconds. The actual results returned for 8192 byte
                      blocks is<br>
                      <br>
                      Doing aes-128-cbc for 3s on 8192 size blocks:
                      370202 aes-128-cbc&#39;s in <b>0.11s</b><br>
                      <br>
                      whereas without cryptodev I see<br>
                      <br>
                      Doing aes-128-cbc for 3s on 8192 size blocks:
                      457255 aes-128-cbc&#39;s in <b>3.00s</b><br>
                      <br>
                      So you can see that without cryptodev the i5-6800
                      actually says it&#39;s doing more blocks (457,255 vs
                      370,202) but with cryptodev it is doing it in WAY
                      less time.=C2=A0 This leads me to believe the openssl
                      speed code when using cryptodev just &quot;goes wrong=
&quot;.<br>
                      It will be very interesting to see what the
                      encryption test will bring - that is a much better
                      real-life-like example than a simple speed test.<br>
                      <br>
                    </blockquote>
                    as a follow-up : someone whispered in my ear
                    (thanks, Andr=C3=A9 ;) ) that one should use the -elaps=
ed
                    option for this, so here are new results:<br>
                    <br>
                    *with* cryptodev:<br>
                    <br>
                    ./openssl speed -evp aes-128-cbc -elapsed<br>
                    You have chosen to measure elapsed time instead of
                    user CPU time.<br>
                    Doing aes-128-cbc for 3s on 16 size blocks: 2825786
                    aes-128-cbc&#39;s in 3.00s<br>
                    Doing aes-128-cbc for 3s on 64 size blocks: 2716822
                    aes-128-cbc&#39;s in 3.00s<br>
                    Doing aes-128-cbc for 3s on 256 size blocks: 2369723
                    aes-128-cbc&#39;s in 3.00s<br>
                    Doing aes-128-cbc for 3s on 1024 size blocks:
                    1536054 aes-128-cbc&#39;s in 3.00s<br>
                    Doing aes-128-cbc for 3s on 8192 size blocks: 369984
                    aes-128-cbc&#39;s in 3.00s<br>
                    [...]<br>
                    aes-128-cbc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15,070.86k=C2=
=A0=C2=A0=C2=A0 57,958.87k=C2=A0=C2=A0
                    202,216.36k=C2=A0=C2=A0 524,306.43k=C2=A0 1,010,302.98k=
<br>
                    <br>
                    *without* cryptodev:<br>
                    <br>
                    $ openssl speed -evp aes-128-cbc -elapsed<br>
                    You have chosen to measure elapsed time instead of
                    user CPU time.<br>
                    Doing aes-128-cbc for 3s on 16 size blocks:
                    207188725 aes-128-cbc&#39;s in 3.00s<br>
                    Doing aes-128-cbc for 3s on 64 size blocks: 56855717
                    aes-128-cbc&#39;s in 3.00s<br>
                    Doing aes-128-cbc for 3s on 256 size blocks:
                    14382122 aes-128-cbc&#39;s in 3.00s<br>
                    Doing aes-128-cbc for 3s on 1024 size blocks:
                    3618996 aes-128-cbc&#39;s in 3.00s<br>
                    Doing aes-128-cbc for 3s on 8192 size blocks: 456727
                    aes-128-cbc&#39;s in 3.00s<br>
                    [...]<br>
                    aes-128-cbc=C2=A0=C2=A0=C2=A0 1,105,006.53k=C2=A0 1,212=
,921.96k=C2=A0
                    1,227,274.41k=C2=A0 1,235,283.97k=C2=A0 1,247,169.19k<b=
r>
                    <br>
                    which more or less reflects the encryption test
                    results I posted earlier.<br>
                    The question becomes, what are you results when
                    using the -elapsed flag?<br>
                    <br>
                    JJK<br>
                    <br>
                    <blockquote type=3D"cite"> <br>
                      <blockquote type=3D"cite">
                        <div dir=3D"ltr">
                          <div>&gt;My advice is to rerun your tests
                            *without* the cryptodev module and then
                            decide wheter you really need CBC+CCM hmacs.</d=
iv>
                          <div>Yes, I confirm that without the cryptodev
                            the performance is very bad for my device. I
                            don&#39;t have that device in my hand right now.
                            But I saved one aes-256-cbc result in my web
                            notebook as below:</div>
                          <div><br>
                          </div>
                          <div>
                            <div style=3D"white-space:pre-wrap;line-height:=
1.75;font-size:14px;text-align:left">type             16 bytes     64 bytes=
    256 bytes   1024 bytes   8192 bytes</div>
                            <div style=3D"white-space:pre-wrap;line-height:=
1.75;font-size:14px;text-align:left">aes-256-cbc      19626.95k    24289.71=
k    25054.46k    25347.75k    25337.86k</div>
                            <div style=3D"white-space:pre-wrap;line-height:=
1.75;font-size:14px;text-align:left">
</div>
                            <div>Please note, there are two modes to
                              accelerate encryption/decryption.</div>
                            <div style=3D"white-space:pre-wrap;line-height:=
1.75;font-size:14px;text-align:left"><div>1. HW instructions like intel x86=
 CPU.</div><div>2. Using a crypto engine.</div><div>
</div><div>When your device is 2 and its CPU is not powerful, normally with=
 cryptodev speed is much faster at least for big blocks. Maybe for small bl=
ocks it&#39;s slower because</div><div>it needs the time to push the work t=
o kernel and then HW engine and the time spent is may longer than the time =
costed by OpenSSL directly does the encryption/decryption.
</div><div>
</div></div>
                            <div style=3D"white-space:pre-wrap;line-height:=
1.75;font-size:14px;text-align:left">Tony
</div>
                          </div>
                        </div>
                        <br>
                        <div class=3D"gmail_quote">
                          <div dir=3D"ltr" class=3D"gmail_attr">Jan Just
                            Keijser &lt;<a href=3D"mailto:janjust@...1421...=
." target=3D"_blank">janjust@...1147...</a>&gt;
                            =E4=BA=8E2020=E5=B9=B412=E6=9C=882=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:24=E5=86=99=E9=81=93=EF=BC=9A<br>
                          </div>
                          <blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                            <div bgcolor=3D"#FFFFFF">
                              <div>hi Tony,<br>
                                <br>
                                On 01/12/20 02:50, Tony He wrote:<br>
                              </div>
                              <blockquote type=3D"cite">
                                <div dir=3D"ltr">Hi Arne,
                                  <div><br>
                                  </div>
                                  <div>openssl speed -evp aes-128-cbc</div>
                                  <div>
                                    <div style=3D"white-space:pre-wrap">   =
       type             16 bytes     64 bytes    256 bytes   1024 bytes   8=
192 bytes
aes-128-cbc      20035.60k   123261.54k   267081.60k  1094764.09k  9181370.=
18k
              </div>
                                    openssl speed -evp aes-128-gcm</div>
                                  <div>
                                    <div style=3D"white-space:pre-wrap">   =
             type             16 bytes     64 bytes    256 bytes   1024 byt=
es   8192 bytes
aes-128-gcm      18738.76k    19284.91k    19524.44k    19606.87k    19685.=
46k
              </div>
                                    openssl speed -evp aes-128-ccm</div>
                                  <div>
                                    <div style=3D"white-space:pre-wrap">   =
             type             16 bytes     64 bytes    256 bytes   1024 byt=
es   8192 bytes
aes-128-ccm      53859.07k   215581.12k   862070.02k  3460786.43k 27566347.=
61k
              </div>
                                    openssl speed -evp sha1</div>
                                  <div>
                                    <div style=3D"white-space:pre-wrap">   =
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byt=
es
sha1              3108.57k    12177.79k    57325.18k   181610.34k  1207364.=
27k
              </div>
                                    openssl speed -evp chacha20-poly1305<br>
                                  </div>
                                  <div>
                                    <div style=3D"white-space:pre-wrap">cha=
cha20-poly1305 is an unknown cipher or digest</div>
                                    <div style=3D"white-space:pre-wrap">Usi=
ng old openssl, so chacha20-poly1305 is not supported.</div>
                                  </div>
                                </div>
                              </blockquote>
                              <br>
                              these numbers look suspiciously like
                              you&#39;re using the linux cryptodev module.
                              Openssl speed results for the linux
                              cryptodev module are totally unreliable
                              and I&#39;d even go so far as to say that the
                              *only* numbers I trust in the output above
                              are for aes-128-gcm<br>
                              <br>
                              For example, if I do the same on an
                              i5-6800 I get *without* the cryptodev
                              module:<br>
                              =C2=A0 $ openssl speed -evp aes-128-cbc <br>
                              =C2=A0 aes-128-cbc=C2=A0=C2=A0=C2=A0 1,104,59=
9.38k=C2=A0
                              1,208,651.07k=C2=A0 1,231,766.70k=C2=A0
                              1,237,545.64k=C2=A0 1,248,793.94k<br>
                              <br>
                              and with the module I get<br>
                              =C2=A0 aes-128-cbc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 45,087.41k=C2=A0=C2=A0
                              127,822.72k=C2=A0=C2=A0 581,517.17k=C2=A0 2,2=
56,593.19k
                              27,583,804.51k<br>
                              <br>
                              the second set of numbers doesn&#39;t make
                              sense, and a much better test is to do an
                              actual encryption test, e.g.<br>
                              <br>
                              *without* the module<br>
                              cat BIGFILE | openssl aes-256-cbc -e
                              -pass=C2=A0 pass:thisisabadpassword |=C2=A0 p=
v &gt;
                              /dev/null<br>
                              2.93GB 0:00:05 [ 549MB/s] [=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&lt;=3D&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
                              ]<br>
                              <br>
                              (&#39;pv&#39; aka &#39;pipeview&#39; is a han=
dy tool to
                              measure the throughput of a UNIX pipe)<br>
                              <br>
                              and with the module:<br>
                              cat BIGFILE | ./openssl aes-256-cbc -e
                              -pass=C2=A0 pass:thisisabadpassword -engine
                              cryptodev|=C2=A0 pv &gt; /dev/null<br>
                              engine &quot;cryptodev&quot; set.<br>
                              2.93GB 0:00:07 [ 426MB/s] [=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                              &lt;=3D&gt;<br>
                              <br>
                              so you see that using the cryptodev module
                              actually slows things down - which is to
                              be expected, as the application needs to
                              do more work using the cryptodev module.<br>
                              <br>
                              My advice is to rerun your tests *without*
                              the cryptodev module and then decide
                              wheter you really need CBC+CCM hmacs.<br>
                              <br>
                              HTH,<br>
                              <br>
                              JJK<br>
                              <br>
                              <br>
                              <blockquote type=3D"cite">
                                <div class=3D"gmail_quote">
                                  <div dir=3D"ltr" class=3D"gmail_attr">Arne
                                    Schwabe &lt;<a href=3D"mailto:arne@...1386...=
227..." target=3D"_blank">arne@...1227...</a>&gt;
                                    =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:40=E5=86=99=E9=81=93=EF=BC=9A<=
br>
                                  </div>
                                  <blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Am
                                    26.11.20 um 10:41 schrieb Tony He:<br>
                                    &gt; Hi Arne,<br>
                                    &gt; <br>
                                    &gt;&gt;Since the original thread
                                    was not on the mailing list I am
                                    missing your<br>
                                    &gt;&gt;goal but if your crypto
                                    acelator already works with OpenSSL,
                                    then it<br>
                                    &gt;&gt;will also work with the
                                    &quot;normal&quot; OpenVPN<br>
                                    &gt; <br>
                                    &gt; Yes, it wokrs with &quot;normal&qu=
ot;
                                    OpenVPN(OpenVPN2), but according to
                                    the test<br>
                                    &gt; result, it&#39;s still not
                                    fast(about 60Mbps).<br>
                                    &gt; The bottleneck is not
                                    encryption operation any more. It
                                    comes from the<br>
                                    &gt; switch of user space and kernel
                                    space in the OpenVPN2,<br>
                                    &gt; which makes the poor CPU of=C2=A0
                                    embedded device=C2=A0very busy.=C2=A0Th=
at&#39;s
                                    why we<br>
                                    &gt; need OpenVPN3 running in the
                                    kernel space.<br>
                                    <br>
                                    <br>
                                    What numbers are we are talking in
                                    crypto speed? Could you provide from<br>
                                    your &quot;poor&quot; device:<br>
                                    <br>
                                    <br>
                                    openssl speed -evp aes-128-cbc<br>
                                    openssl speed -evp aes-128-gcm<br>
                                    openssl speed -evp aes-128-ccm<br>
                                    openssl speed -evp sha1<br>
                                    openssl speed -evp chacha20-poly1305<br>
                                    <br>
                                    I want to what difference/gain in
                                    terms of raw crypto speed we are<br>
                                    talking here.<br>
                                  </blockquote>
                                </div>
                              </blockquote>
                            </div>
                          </blockquote>
                        </div>
                      </blockquote>
                    </blockquote>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br></div></blockquote></div></div>
</blockquote></div>

--000000000000d801f105b5d641bb--

