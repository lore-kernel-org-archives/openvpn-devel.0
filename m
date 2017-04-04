Message-ID: <58E37DD3.4070506@...1147...>
Date: Tue, 04 Apr 2017 13:04:51 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
	<a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
	<ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
	<b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
In-Reply-To: <b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
Content-Type: multipart/alternative;
	boundary="------------010908020906030400070500"
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Steffan Karger <steffan@...1856...>

This is a multi-part message in MIME format.
--------------010908020906030400070500
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing3-ams.mf.surf.net id v34B4vpO000834
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi David,

On 03/04/17 22:43, David Sommerseth wrote:
> On 03/04/17 16:12, Jan Just Keijser wrote:
>
>
> On 03/04/17 15:53, Samuli Sepp=C3=A4nen wrote:
>>> On 02/04/2017 10:57, Steffan Karger wrote:
>>>> Hi,
>>>>
>>>> On 31-03-17 22:34, David Sommerseth wrote:
>>>>> On 31/03/17 10:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>>>>>> 2017-03-31 13:26 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>>>>>> <mailto:samuli@...515...>>:
>>>>>>
>>>>>>       Hi,
>>>>>>
>>>>>>       We still bundle EasyRSA 2 with our Windows installers and it is
>>>>>>       prominently advertised on our widely linked to HOWTO:
>>>>>>
>>>>>>       <https://openvpn.net/index.php/open-source/documentation/howto=
.html
>>>>>>       <https://openvpn.net/index.php/open-source/documentation/howto=
.html>>
>>>>>>
>>>>>>       As such, EasyRSA 2 is used by many/most OpenVPN server admins.
>>>>>>
>>>>>>       However, the default values for EasyRSA 2 such as MD5 hashing =
algorithm
>>>>>>       and 1024-bit keysize seem totally inadequate for today's stand=
ards:
>>>>>>
>>>>>>       <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/=
2.0/vars#L53
>>>>>>       <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/=
2.0/vars#L53>>
>>>>>>       <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/=
2.0/openssl-1.0.0.cnf#L57
>>>>>>       <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/=
2.0/openssl-1.0.0.cnf#L57>>
>>>>>>
>>>>>>       I think we should upgrade these to something more recent. What=
 would
>>>>>>       more modern reasonable defaults be?
>>>>>>
>>>>>>
>>>>>>
>>>>>> someday we decided to use DSA (instead of default RSA)
>>>>>> it worked ... until we started to use OpenVPN Connect for iOS.
>>>>>> next, we had to change back to RSA
>>>>>>
>>>>>>
>>>>>> the conclusion would be "test all available platforms and take a
>>>>>> decision", probably even set up special test server and ask people on
>>>>>> openvpn-users mailing list
>>>>> Always a good idea to test as many platforms as possible.  But we can
>>>>> also leverage all the testing which have been done indirectly by othe=
rs
>>>>> as well.
>>>>>
>>>>> The suggestion from Samuli is to update the default key size and hash=
ing
>>>>> algorithm.  MD5 is broken.  MD5 have been broken for years.  SHA1 have
>>>>> the recent SHAttering panic, which have its own set of challenges - a=
nd
>>>>> should not be used for certificates any longer (if I have understood =
the
>>>>> crypto-gurus correctly).
>>>>>
>>>>> Also considering that the "world in general" have been moving towards
>>>>> stronger keys *and* have moved towards SHA256 hashing in certificates,
>>>>> updating EasyRSA is more than reasonable.
>>>>>
>>>>> So, I would highly recommend using SHA256.  I have used that for my
>>>>> OpenVPN setups for several years already.  That works fine for me, an=
d I
>>>>> know others have done the same.  This is actually the most challenging
>>>>> move, from a technical point of view - using a new algorithm.  But th=
is
>>>>> algorithm is well supported by all OpenSSL and mbed TLS implementatio=
ns
>>>>> OpenVPN can be built against.
>>>>>
>>>>> Secondly, updating the key length from 1024 bits to at least 2048 sho=
uld
>>>>> not cause any issues at all.  Many users (myself included) often use
>>>>> 4096 bits keys without any issues.
>>>>>
>>>>> Swapping RSA for DSA is an issue of a completely different league. And
>>>>> DSA is by OpenSSH considered too weak; IIRC it was even removed in
>>>>> OpenSSH v7.0.
>>>> Yes, upgrading would be good if we still ship it.  I can echo David's
>>>> SHA256 / RSA2048+ recommendation.  Enough security margin, and very go=
od
>>>> interop (not only crypto libs, but also smart cards, OS key stores,
>>>> ...).  To not dramatically slow down connection setup on low-cpu-power
>>>> devices (e.g. home routers), don't go beyond RSA4096 though.
>>>>
>>>> DSA is _not_ a preferred choice.  The original 1024-bit DSA is too weak
>>>> nowadays, and the 'larger' DSA variants are not even close to the wide
>>>> support that RSA has.
>>>>
>>>> -Steffan
>>>>
>>> Hi,
>>>
>>> I've issue a pull request here and review would be appreciated:
>>>
>>> <https://github.com/OpenVPN/easy-rsa-old/pull/1>
>>>
>>> I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key size was
>>> set to 4096-bits and signature algorithm to SHA256WithRSAEncryption.
>>>
>>> The only real issue was DH parameter generation: it took ~25 minutes on
>>> my Intel i5 laptop. Is that acceptable default behavior?
>>>
>> what kind of i5 is this? on my i7-4810 it took 5 minutes. Can you give t=
he full CPUID string (from /proc/cpuinfo) ?  then I can
>> guestimate whether the 25 minutes is realistic for slower hardware.
> I've run a a couple of "quick" tests ... on a two different laptops
>
> --- test 1 ----------------------------------------------------------
> $ time openssl gendh -out test 4096
> [...snip...]
>
> real    35m40.098s
> user    35m38.922s
> sys     0m0.367s
> $ cat /proc/cpuinfo  | grep model\ name | uniq -c
>        4 model name      : Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
>
> <http://ark.intel.com/products/88193/Intel-Core-i5-6200U-Processor-3M-Cac=
he-up-to-2_80-GHz>
>
> --- test 2 ----------------------------------------------------------
> $ time openssl gendh -out test 4096
> [...snip...]
>
> real	13m59.742s
> user	13m59.448s
> sys	0m0.140s
> $ cat /proc/cpuinfo  | grep model\ name | uniq -c
>        4 model name	: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz
>
> <http://ark.intel.com/products/85215/Intel-Core-i7-5600U-Processor-4M-Cac=
he-up-to-3_20-GHz>
>
>
> --- test 3 ----------------------------------------------------------
> $ time openssl gendh -out test 4096
> [...snip...]
>
> real	14m54.432s
> user	14m53.475s
> sys	0m0.339s
> $ cat /proc/cpuinfo | grep model\ name | uniq -c
>        4 model name	: Intel(R) Xeon(R) CPU E3-1220L V2 @ 2.30GHz
>
> <http://ark.intel.com/products/53401/Intel-Xeon-Processor-E3-1220L-3M-Cac=
he-2_20-GHz>
>
>
> The main difference, if I looked at the correct "Intel Ark" page for
> your i7-4800 [1], is the CPU cache (yours is 6MB, while the others are
> 3-4MB.  The i5 have max turbo freq at 2.8GHz, while the others are quite
> closer (3.2-3.4 GHz, yours is at 3.8GHz).
>
> [1]
> <http://ark.intel.com/products/78937/Intel-Core-i7-4810MQ-Processor-6M-Ca=
che-up-to-3_80-GHz>
thanks for all the numbers and I just realized that the "openssl gendh"=20
performance is related not only to the CPU and clock speed, but also to=20
the available "randomness" in the machine: If I re-run "openssl gendh"=20
on my laptop the numbers vary from a few minutes to ~20 minutes.=20
However, if I wiggle the mouse before and while the "openssl gendh" is=20
running then the time is shorter - the random mouse movements translate=20
into more randomness for the kernel. This suggests that doing *other*=20
stuff on your PC/laptop while "openssl gendh" is running will actually=20
*speed it up* - contrary to most compute-intensive operations.

Also, "openssl gendh" does not depend on the CPU's cache size - the=20
amount of data generated is far too low to exceed the L2 cache.
As a final note: more modern Linux kernels (4.2+ ish) have a=20
jitterentropy_rng.ko=20
<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3Dbb5530e4082446aac3a3d69780cd4dbfa4520013>=20
kernel module, which might help as well.

HTH,

JJK


--------------010908020906030400070500
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing3-ams.mf.surf.net id v34B4vpO000834
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Hi David,<br>
      <br>
      On 03/04/17 22:43, David Sommerseth wrote:<br>
    </div>
    <blockquote
cite=3D"mid:b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080..."
      type=3D"cite">
      <pre wrap=3D"">On 03/04/17 16:12, Jan Just Keijser wrote:


On 03/04/17 15:53, Samuli Sepp=C3=A4nen wrote:
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre wrap=3D"">On 02/04/2017 10:57, Steffan Karger wrote:
</pre>
          <blockquote type=3D"cite">
            <pre wrap=3D"">Hi,

On 31-03-17 22:34, David Sommerseth wrote:
</pre>
            <blockquote type=3D"cite">
              <pre wrap=3D"">On 31/03/17 10:56, =D0=98=D0=BB=D1=8C=D1=8F =
=D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
</pre>
              <blockquote type=3D"cite">
                <pre wrap=3D"">2017-03-31 13:26 GMT+05:00 Samuli Sepp=C3=A4=
nen &lt;<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:samuli@...2092...=
..">samuli@...515...</a>
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:samuli@...515...">&lt;mai=
lto:samuli@...515...&gt;</a>&gt;:

     Hi,

     We still bundle EasyRSA 2 with our Windows installers and it is
     prominently advertised on our widely linked to HOWTO:

     &lt;<a class=3D"moz-txt-link-freetext" href=3D"https://openvpn.net/ind=
ex.php/open-source/documentation/howto.html">https://openvpn.net/index.php/=
open-source/documentation/howto.html</a>
     <a class=3D"moz-txt-link-rfc2396E" href=3D"https://openvpn.net/index.p=
hp/open-source/documentation/howto.html">&lt;https://openvpn.net/index.php/=
open-source/documentation/howto.html&gt;</a>&gt;

     As such, EasyRSA 2 is used by many/most OpenVPN server admins.

     However, the default values for EasyRSA 2 such as MD5 hashing algorithm
     and 1024-bit keysize seem totally inadequate for today's standards:

     &lt;<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/Open=
VPN/easy-rsa-old/blob/master/easy-rsa/2.0/vars#L53">https://github.com/Open=
VPN/easy-rsa-old/blob/master/easy-rsa/2.0/vars#L53</a>
     <a class=3D"moz-txt-link-rfc2396E" href=3D"https://github.com/OpenVPN/=
easy-rsa-old/blob/master/easy-rsa/2.0/vars#L53">&lt;https://github.com/Open=
VPN/easy-rsa-old/blob/master/easy-rsa/2.0/vars#L53&gt;</a>&gt;
     &lt;<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/Open=
VPN/easy-rsa-old/blob/master/easy-rsa/2.0/openssl-1.0.0.cnf#L57">https://gi=
thub.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/openssl-1.0.0.cnf#L5=
7</a>
     <a class=3D"moz-txt-link-rfc2396E" href=3D"https://github.com/OpenVPN/=
easy-rsa-old/blob/master/easy-rsa/2.0/openssl-1.0.0.cnf#L57">&lt;https://gi=
thub.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/openssl-1.0.0.cnf#L5=
7&gt;</a>&gt;

     I think we should upgrade these to something more recent. What would
     more modern reasonable defaults be?



someday we decided to use DSA (instead of default RSA)
it worked ... until we started to use OpenVPN Connect for iOS.
next, we had to change back to RSA


the conclusion would be "test all available platforms and take a
decision", probably even set up special test server and ask people on
openvpn-users mailing list
</pre>
              </blockquote>
              <pre wrap=3D"">Always a good idea to test as many platforms a=
s possible.  But we can
also leverage all the testing which have been done indirectly by others
as well.

The suggestion from Samuli is to update the default key size and hashing
algorithm.  MD5 is broken.  MD5 have been broken for years.  SHA1 have
the recent SHAttering panic, which have its own set of challenges - and
should not be used for certificates any longer (if I have understood the
crypto-gurus correctly).

Also considering that the "world in general" have been moving towards
stronger keys *and* have moved towards SHA256 hashing in certificates,
updating EasyRSA is more than reasonable.

So, I would highly recommend using SHA256.  I have used that for my
OpenVPN setups for several years already.  That works fine for me, and I
know others have done the same.  This is actually the most challenging
move, from a technical point of view - using a new algorithm.  But this
algorithm is well supported by all OpenSSL and mbed TLS implementations
OpenVPN can be built against.

Secondly, updating the key length from 1024 bits to at least 2048 should
not cause any issues at all.  Many users (myself included) often use
4096 bits keys without any issues.

Swapping RSA for DSA is an issue of a completely different league. And
DSA is by OpenSSH considered too weak; IIRC it was even removed in
OpenSSH v7.0.
</pre>
            </blockquote>
            <pre wrap=3D"">Yes, upgrading would be good if we still ship it=
.  I can echo David's
SHA256 / RSA2048+ recommendation.  Enough security margin, and very good
interop (not only crypto libs, but also smart cards, OS key stores,
...).  To not dramatically slow down connection setup on low-cpu-power
devices (e.g. home routers), don't go beyond RSA4096 though.

DSA is _not_ a preferred choice.  The original 1024-bit DSA is too weak
nowadays, and the 'larger' DSA variants are not even close to the wide
support that RSA has.

-Steffan

</pre>
          </blockquote>
          <pre wrap=3D"">Hi,

I've issue a pull request here and review would be appreciated:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://github.com/OpenVPN/easy-=
rsa-old/pull/1">&lt;https://github.com/OpenVPN/easy-rsa-old/pull/1&gt;</a>

I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key size was
set to 4096-bits and signature algorithm to SHA256WithRSAEncryption.

The only real issue was DH parameter generation: it took ~25 minutes on
my Intel i5 laptop. Is that acceptable default behavior?

</pre>
        </blockquote>
        <pre wrap=3D"">what kind of i5 is this? on my i7-4810 it took 5 min=
utes. Can you give the full CPUID string (from /proc/cpuinfo) ?  then I can=
=20
guestimate whether the 25 minutes is realistic for slower hardware.
</pre>
      </blockquote>
      <pre wrap=3D"">
I've run a a couple of "quick" tests ... on a two different laptops

--- test 1 ----------------------------------------------------------
$ time openssl gendh -out test 4096
[...snip...]

real    35m40.098s
user    35m38.922s
sys     0m0.367s
$ cat /proc/cpuinfo  | grep model\ name | uniq -c
      4 model name      : Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz

<a class=3D"moz-txt-link-rfc2396E" href=3D"http://ark.intel.com/products/88=
193/Intel-Core-i5-6200U-Processor-3M-Cache-up-to-2_80-GHz">&lt;http://ark.i=
ntel.com/products/88193/Intel-Core-i5-6200U-Processor-3M-Cache-up-to-2_80-G=
Hz&gt;</a>

--- test 2 ----------------------------------------------------------
$ time openssl gendh -out test 4096
[...snip...]

real	13m59.742s
user	13m59.448s
sys	0m0.140s
$ cat /proc/cpuinfo  | grep model\ name | uniq -c
      4 model name	: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz

<a class=3D"moz-txt-link-rfc2396E" href=3D"http://ark.intel.com/products/85=
215/Intel-Core-i7-5600U-Processor-4M-Cache-up-to-3_20-GHz">&lt;http://ark.i=
ntel.com/products/85215/Intel-Core-i7-5600U-Processor-4M-Cache-up-to-3_20-G=
Hz&gt;</a>


--- test 3 ----------------------------------------------------------
$ time openssl gendh -out test 4096
[...snip...]

real	14m54.432s
user	14m53.475s
sys	0m0.339s
$ cat /proc/cpuinfo | grep model\ name | uniq -c
      4 model name	: Intel(R) Xeon(R) CPU E3-1220L V2 @ 2.30GHz

<a class=3D"moz-txt-link-rfc2396E" href=3D"http://ark.intel.com/products/53=
401/Intel-Xeon-Processor-E3-1220L-3M-Cache-2_20-GHz">&lt;http://ark.intel.c=
om/products/53401/Intel-Xeon-Processor-E3-1220L-3M-Cache-2_20-GHz&gt;</a>


The main difference, if I looked at the correct "Intel Ark" page for
your i7-4800 [1], is the CPU cache (yours is 6MB, while the others are
3-4MB.  The i5 have max turbo freq at 2.8GHz, while the others are quite
closer (3.2-3.4 GHz, yours is at 3.8GHz).

[1]
<a class=3D"moz-txt-link-rfc2396E" href=3D"http://ark.intel.com/products/78=
937/Intel-Core-i7-4810MQ-Processor-6M-Cache-up-to-3_80-GHz">&lt;http://ark.=
intel.com/products/78937/Intel-Core-i7-4810MQ-Processor-6M-Cache-up-to-3_80=
-GHz&gt;</a>
</pre>
    </blockquote>
    thanks for all the numbers and I just realized that the "openssl
    gendh" performance is related not only to the CPU and clock speed,
    but also to the available "randomness" in the machine: If I re-run
    "openssl gendh" on my laptop the numbers vary from a few minutes to
    ~20 minutes. However, if I wiggle the mouse before and while the
    "openssl gendh" is running then the time is shorter - the random
    mouse movements translate into more randomness for the kernel. This
    suggests that doing *other* stuff on your PC/laptop while "openssl
    gendh" is running will actually *speed it up* - contrary to most
    compute-intensive operations.<br>
    <br>
    Also, "openssl gendh" does not depend on the CPU's cache size - the
    amount of data generated is far too low to exceed the L2 cache. <br>
    As a final note: more modern Linux kernels (4.2+ ish) have a <a
href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dbb5530e4082446aac3a3d69780cd4dbfa4520013">jitterentropy_rng.ko</a>
    kernel module, which might help as well.<br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------010908020906030400070500--

