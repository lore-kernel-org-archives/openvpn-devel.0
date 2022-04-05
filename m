References: <CAAUX2SXYyxz-A_cWsf+ZuCyPkHz_O+D+fdZNS2p_7qV6fDR4EA@...278...>
 <581cf124-143b-690c-37d2-72fb2bd0e39a@...277...>
 <CAAUX2SXzyFLZmPCC0ruV9BYxEoEnJs41zRFw3hbVDypKQdFJxQ@...278...>
From: Jan Just Keijser <jan.just.keijser@...277...>
Message-ID: <144bd291-8203-84a8-9ccd-d4f4040cbe11@...277...>
Date: Tue, 5 Apr 2022 17:46:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAAUX2SXzyFLZmPCC0ruV9BYxEoEnJs41zRFw3hbVDypKQdFJxQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] How to benchmark kernel crypto
 performance?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Tony,

On 05/04/22 15:04, Tony He wrote:
> Hi JJK,
>
> Yeah, I know this way, but there is still context switching in the
> kernel space and user space. I have been looking for a way
> to benchmark in the kernel space. I expect there is a kernel module like below:
>
> insmod benchmark.ko AES-256-GCM
> (After it's done,  this module will exit automatically)

that would be 'tcrypt' then, I guess ; on my Fedora boxen I have
#  modinfo tcrypt
filename: /lib/modules/5.16.18-100.fc34.x86_64/kernel/crypto/tcrypt.ko.xz
author:         James Morris <jmorris@...2670...>
description:    Quick & dirty crypto testing module
[...]
parm:           alg:charp
parm:           type:uint
parm:           mask:uint
parm:           mode:int
parm:           sec:Length in seconds of speed tests (defaults to zero 
which uses CPU cycles instead) (uint)
parm:           num_mb:Number of concurrent requests to be used in mb 
speed tests (defaults to 8) (uint)
parm:           klen:Key length (defaults to 0) (uint)


cheers,

JJK

> Jan Just Keijser <jan.just.keijser@...277...> 于2022年4月5日周二 19:26写道：
>> hi Tony,
>>
>> On 02/04/22 11:40, Tony He wrote:
>>> Hi Antonio,
>>>
>>> I am porting ovpn-dco to embedded ARMv8 device with hardware crypto
>>> engine. However the performance is not very good.
>>> It's about 130-140Mbps. I expect more. The SDK already provides kernel
>>> CryptoAPI(CFI) interface  to access the crypto engine.
>>> I want to know if the crypto operation is the bottleneck. Do you know
>>> how to benchmark crypto performance in the kernel space?
>>> Any advice is welcome. Thank you!
>>>
>> a quick & dirty way to test the hardware crypto engine is to use the
>> Linux cryptodev engine in combination with openssl ; it's a bit tricky
>> to get it working but it *is* a nice way to test hardware crypto.
>>
>> * https://github.com/cryptodev-linux/cryptodev-linux.git
>> * do a custom openssl build with
>>       ./Configure -DHAVE_CRYPTODEV -DUSE_CRYPTODEV_DIGESTS enable-engine
>> enable-dso enable-devcryptoeng <platform>
>> * run openssl speed using
>>     ./openssl speed -elapsed -engine devcrypto -evp aes-128-cbc
>>
>> and compare the results with "-engine devcrypto" removed.
>>
>> HTH,
>>
>> JJK
>>
>>
>>


