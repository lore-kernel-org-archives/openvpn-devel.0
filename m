References: <tencent_634348984485969552F3189D5284B3FD7C08@...1414...>
 <CAAUX2SVnf4dr8FNsgNXbFiRMK1VWQQJWE-JUmDPs4VgzcPsDaA@...278...>
 <fdf4b3e6-6130-04c4-7f4e-7f249d5db3ea@...1227...>
 <CAAUX2SVMaOXeKrkck4CUXVdMdtP5WBGS0rvfzQm9s5NFYECXqA@...278...>
 <5c166cc4-8f0c-f9be-a926-10bcde144259@...1147...>
 <CAAUX2SV90sC2G5rrZh=mfBT-Hwb08BitHnG-ancCG1HsRrjsSg@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <9ac62807-7edf-d5e2-c09a-e2168f5b2e42@...1147...>
Date: Wed, 2 Dec 2020 15:51:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SV90sC2G5rrZh=mfBT-Hwb08BitHnG-ancCG1HsRrjsSg@...278...>
Content-Type: multipart/alternative;
 boundary="------------E3470ED8DFB8AFBED0E38FB8"
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tony He <huangya90@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net, lev@...515..., Antonio Quartulli <a@...2181...>

This is a multi-part message in MIME format.
--------------E3470ED8DFB8AFBED0E38FB8
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Tony,

On 02/12/20 15:22, Tony He wrote:
> Hi Jan,
>
> Welcome to join the discussion.
>
> >the second set of numbers doesn't make sense, and a much better test 
> is to do an actual encryption test
> I don't compile cryptodev kernel module for my PC and can not 
> reproduce this issue for now.  You don't understand  the reason why 
> the performance is much worse with cryptodev module for *big* blocks, 
> right?
> If yes, I guess the reason maybe kernel assign the work to multi cores 
> while OpenSSL uses one core. Would you share the output of command 
> "mpstat -P ALL 2"?
>
sure, while using the cryptodev I see this:

15:28:36     CPU    %usr   %nice    %sys %iowait    %irq   %soft %steal  
%guest  %gnice   %idle
15:28:38     all    1.87    0.00   23.19    0.12    0.00    0.00 0.00    
0.00    0.00   74.81
15:28:38       0    0.00    0.00    0.00    0.50    0.00    0.00 0.00    
0.00    0.00   99.50
15:28:38       1    7.00    0.00   93.00    0.00    0.00    0.00 0.00    
0.00    0.00    0.00
15:28:38       2    0.00    0.00    0.00    0.00    0.00    0.00 0.00    
0.00    0.00  100.00
15:28:38       3    0.00    0.00    0.00    0.00    0.00    0.00 0.00    
0.00    0.00  100.00

15:28:38     CPU    %usr   %nice    %sys %iowait    %irq   %soft %steal  
%guest  %gnice   %idle
15:28:40     all    0.75    0.00   24.19    0.00    0.00    0.00 0.00    
0.00    0.00   75.06
15:28:40       0    0.00    0.00    0.00    0.50    0.00    0.00 0.00    
0.00    0.00   99.50
15:28:40       1    3.50    0.00   96.50    0.00    0.00    0.00 0.00    
0.00    0.00    0.00
15:28:40       2    0.00    0.00    0.00    0.00    0.00    0.00 0.00    
0.00    0.00  100.00
15:28:40       3    0.00    0.00    0.00    0.00    0.00    0.00 0.00    
0.00    0.00  100.00

on a 4 core box; this means that 1 core is used 100% (which is what I 
expected).


I suspect the main reason the cryptodev results on my i5-6800 go off the 
rails is due to this:
(look at the "Doing aes-128-cbc lines")

$ ./openssl speed -evp aes-128-cbc
Doing aes-128-cbc for 3s on 16 size blocks: 2835368 aes-128-cbc's in 1.14s
Doing aes-128-cbc for 3s on 64 size blocks: 2720745 aes-128-cbc's in 1.01s
Doing aes-128-cbc for 3s on 256 size blocks: 2377830 aes-128-cbc's in 
*0.74s*
Doing aes-128-cbc for 3s on 1024 size blocks: 1538693 aes-128-cbc's in 
*0.40s*
Doing aes-128-cbc for 3s on 8192 size blocks: 370202 aes-128-cbc's in 
*0.11s*
OpenSSL 1.0.2m  2 Nov 2017
built on: reproducible build, date unspecified
options:bn(64,64) rc4(16x,int) des(idx,cisc,16,int) aes(partial) 
idea(int) blowfish(idx)
compiler: gcc -I. -I.. -I../include  -DOPENSSL_THREADS -D_REENTRANT 
-DDSO_DLFCN -DHAVE_DLFCN_H -DHAVE_CRYPTODEV -DUSE_CRYPTODEV_DIGESTS 
-Wa,--noexecstack -m64 -DL_ENDIAN -O3 -Wall -DOPENSSL_IA32_SSE2 
-DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m 
-DRC4_ASM -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DMD5_ASM -DAES_ASM 
-DVPAES_ASM -DBSAES_ASM -DWHIRLPOOL_ASM -DGHASH_ASM -DECP_NISTZ256_ASM
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes 8192 bytes
aes-128-cbc      39794.64k   172403.64k   822600.65k  3939054.08k 
27569952.58k


The timing for how quickly the results are returned are way off and 
probably just wrong. The Openssl speed test is supposed to run for 3 
seconds. The actual results returned for 8192 byte blocks is

Doing aes-128-cbc for 3s on 8192 size blocks: 370202 aes-128-cbc's in 
*0.11s*

whereas without cryptodev I see

Doing aes-128-cbc for 3s on 8192 size blocks: 457255 aes-128-cbc's in 
*3.00s*

So you can see that without cryptodev the i5-6800 actually says it's 
doing more blocks (457,255 vs 370,202) but with cryptodev it is doing it 
in WAY less time.  This leads me to believe the openssl speed code when 
using cryptodev just "goes wrong".
It will be very interesting to see what the encryption test will bring - 
that is a much better real-life-like example than a simple speed test.

HTH,

JJK


> >My advice is to rerun your tests *without* the cryptodev module and 
> then decide wheter you really need CBC+CCM hmacs.
> Yes, I confirm that without the cryptodev the performance is very bad 
> for my device. I don't have that device in my hand right now. But I 
> saved one aes-256-cbc result in my web notebook as below:
>
> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes
> aes-256-cbc 19626.95k 24289.71k 25054.46k 25347.75k 25337.86k
> Please note, there are two modes to accelerate encryption/decryption.
> 1. HW instructions like intel x86 CPU.
> 2. Using a crypto engine.
> When your device is 2 and its CPU is not powerful, normally with 
> cryptodev speed is much faster at least for big blocks. Maybe for 
> small blocks it's slower because
> it needs the time to push the work to kernel and then HW engine and 
> the time spent is may longer than the time costed by OpenSSL directly 
> does the encryption/decryption.
> Tony
>
> Jan Just Keijser <janjust@...1147... <mailto:janjust@...1147...>> 
> 于2020年12月2日周三 下午7:24写道：
>
>     hi Tony,
>
>     On 01/12/20 02:50, Tony He wrote:
>>     Hi Arne,
>>
>>     openssl speed -evp aes-128-cbc
>>     type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes
>>     aes-128-cbc 20035.60k 123261.54k 267081.60k 1094764.09k 9181370.18k
>>     openssl speed -evp aes-128-gcm
>>     type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes
>>     aes-128-gcm 18738.76k 19284.91k 19524.44k 19606.87k 19685.46k
>>     openssl speed -evp aes-128-ccm
>>     type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes
>>     aes-128-ccm 53859.07k 215581.12k 862070.02k 3460786.43k 27566347.61k
>>     openssl speed -evp sha1
>>     type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes sha1
>>     3108.57k 12177.79k 57325.18k 181610.34k 1207364.27k
>>     openssl speed -evp chacha20-poly1305
>>     chacha20-poly1305 is an unknown cipher or digest
>>     Using old openssl, so chacha20-poly1305 is not supported.
>
>     these numbers look suspiciously like you're using the linux
>     cryptodev module. Openssl speed results for the linux cryptodev
>     module are totally unreliable and I'd even go so far as to say
>     that the *only* numbers I trust in the output above are for
>     aes-128-gcm
>
>     For example, if I do the same on an i5-6800 I get *without* the
>     cryptodev module:
>       $ openssl speed -evp aes-128-cbc
>       aes-128-cbc    1,104,599.38k  1,208,651.07k 1,231,766.70k 
>     1,237,545.64k  1,248,793.94k
>
>     and with the module I get
>       aes-128-cbc      45,087.41k   127,822.72k   581,517.17k
>     2,256,593.19k 27,583,804.51k
>
>     the second set of numbers doesn't make sense, and a much better
>     test is to do an actual encryption test, e.g.
>
>     *without* the module
>     cat BIGFILE | openssl aes-256-cbc -e -pass pass:thisisabadpassword
>     |  pv > /dev/null
>     2.93GB 0:00:05 [ 549MB/s] [ <=> ]
>
>     ('pv' aka 'pipeview' is a handy tool to measure the throughput of
>     a UNIX pipe)
>
>     and with the module:
>     cat BIGFILE | ./openssl aes-256-cbc -e -pass
>     pass:thisisabadpassword -engine cryptodev|  pv > /dev/null
>     engine "cryptodev" set.
>     2.93GB 0:00:07 [ 426MB/s] [              <=>
>
>     so you see that using the cryptodev module actually slows things
>     down - which is to be expected, as the application needs to do
>     more work using the cryptodev module.
>
>     My advice is to rerun your tests *without* the cryptodev module
>     and then decide wheter you really need CBC+CCM hmacs.
>
>     HTH,
>
>     JJK
>
>
>>     Arne Schwabe <arne@...1227... <mailto:arne@...1227...>>
>>     于2020年11月26日周四 下午6:40写道：
>>
>>         Am 26.11.20 um 10:41 schrieb Tony He:
>>         > Hi Arne,
>>         >
>>         >>Since the original thread was not on the mailing list I am
>>         missing your
>>         >>goal but if your crypto acelator already works with
>>         OpenSSL, then it
>>         >>will also work with the "normal" OpenVPN
>>         >
>>         > Yes, it wokrs with "normal" OpenVPN(OpenVPN2), but
>>         according to the test
>>         > result, it's still not fast(about 60Mbps).
>>         > The bottleneck is not encryption operation any more. It
>>         comes from the
>>         > switch of user space and kernel space in the OpenVPN2,
>>         > which makes the poor CPU of  embedded device very
>>         busy. That's why we
>>         > need OpenVPN3 running in the kernel space.
>>
>>
>>         What numbers are we are talking in crypto speed? Could you
>>         provide from
>>         your "poor" device:
>>
>>
>>         openssl speed -evp aes-128-cbc
>>         openssl speed -evp aes-128-gcm
>>         openssl speed -evp aes-128-ccm
>>         openssl speed -evp sha1
>>         openssl speed -evp chacha20-poly1305
>>
>>         I want to what difference/gain in terms of raw crypto speed
>>         we are
>>         talking here.
>>
>>         Arne
>>
>>
>>
>>
>>
>>
>>     _______________________________________________
>>     Openvpn-devel mailing list
>>     Openvpn-devel@lists.sourceforge.net
>>     <mailto:Openvpn-devel@lists.sourceforge.net>
>>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


--------------E3470ED8DFB8AFBED0E38FB8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Tony,<br>
      <br>
      On 02/12/20 15:22, Tony He wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAUX2SV90sC2G5rrZh=mfBT-Hwb08BitHnG-ancCG1HsRrjsSg@...278...">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div>Hi Jan,</div>
        <div><br>
        </div>
        <div>Welcome to join the discussion.</div>
        <div><br>
        </div>
        <div>&gt;the second set of numbers doesn't make sense, and a
          much better test is to do an actual encryption test</div>
        <div>I don't compile cryptodev kernel module for my PC and can
          not reproduce this issue for now.  You don't understand  the
          reason why the performance is much worse with cryptodev module
          for *big* blocks, right?<br>
        </div>
        <div>If yes, I guess the reason maybe kernel assign the work to
          multi cores while OpenSSL uses one core. Would you share the
          output of command "mpstat -P ALL 2"?</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    sure, while using the cryptodev I see this:<br>
    <br>
    15:28:36     CPU    %usr   %nice    %sys %iowait    %irq   %soft 
    %steal  %guest  %gnice   %idle<br>
    15:28:38     all    1.87    0.00   23.19    0.12    0.00    0.00   
    0.00    0.00    0.00   74.81<br>
    15:28:38       0    0.00    0.00    0.00    0.50    0.00    0.00   
    0.00    0.00    0.00   99.50<br>
    15:28:38       1    7.00    0.00   93.00    0.00    0.00    0.00   
    0.00    0.00    0.00    0.00<br>
    15:28:38       2    0.00    0.00    0.00    0.00    0.00    0.00   
    0.00    0.00    0.00  100.00<br>
    15:28:38       3    0.00    0.00    0.00    0.00    0.00    0.00   
    0.00    0.00    0.00  100.00<br>
    <br>
    15:28:38     CPU    %usr   %nice    %sys %iowait    %irq   %soft 
    %steal  %guest  %gnice   %idle<br>
    15:28:40     all    0.75    0.00   24.19    0.00    0.00    0.00   
    0.00    0.00    0.00   75.06<br>
    15:28:40       0    0.00    0.00    0.00    0.50    0.00    0.00   
    0.00    0.00    0.00   99.50<br>
    15:28:40       1    3.50    0.00   96.50    0.00    0.00    0.00   
    0.00    0.00    0.00    0.00<br>
    15:28:40       2    0.00    0.00    0.00    0.00    0.00    0.00   
    0.00    0.00    0.00  100.00<br>
    15:28:40       3    0.00    0.00    0.00    0.00    0.00    0.00   
    0.00    0.00    0.00  100.00<br>
    <br>
    on a 4 core box; this means that 1 core is used 100% (which is what
    I expected).<br>
    <br>
    <br>
    I suspect the main reason the cryptodev results on my i5-6800 go off
    the rails is due to this:<br>
    (look at the "Doing aes-128-cbc lines")<br>
    <br>
    $ ./openssl speed -evp aes-128-cbc<br>
    Doing aes-128-cbc for 3s on 16 size blocks: 2835368 aes-128-cbc's in
    1.14s<br>
    Doing aes-128-cbc for 3s on 64 size blocks: 2720745 aes-128-cbc's in
    1.01s<br>
    Doing aes-128-cbc for 3s on 256 size blocks: 2377830 aes-128-cbc's
    in <b>0.74s</b><br>
    Doing aes-128-cbc for 3s on 1024 size blocks: 1538693 aes-128-cbc's
    in <b>0.40s</b><br>
    Doing aes-128-cbc for 3s on 8192 size blocks: 370202 aes-128-cbc's
    in <b>0.11s</b><br>
    OpenSSL 1.0.2m  2 Nov 2017<br>
    built on: reproducible build, date unspecified<br>
    options:bn(64,64) rc4(16x,int) des(idx,cisc,16,int) aes(partial)
    idea(int) blowfish(idx) <br>
    compiler: gcc -I. -I.. -I../include  -DOPENSSL_THREADS -D_REENTRANT
    -DDSO_DLFCN -DHAVE_DLFCN_H -DHAVE_CRYPTODEV -DUSE_CRYPTODEV_DIGESTS
    -Wa,--noexecstack -m64 -DL_ENDIAN -O3 -Wall -DOPENSSL_IA32_SSE2
    -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m
    -DRC4_ASM -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DMD5_ASM -DAES_ASM
    -DVPAES_ASM -DBSAES_ASM -DWHIRLPOOL_ASM -DGHASH_ASM
    -DECP_NISTZ256_ASM<br>
    The 'numbers' are in 1000s of bytes per second processed.<br>
    type             16 bytes     64 bytes    256 bytes   1024 bytes  
    8192 bytes<br>
    aes-128-cbc      39794.64k   172403.64k   822600.65k  3939054.08k
    27569952.58k<br>
    <br>
    <br>
    The timing for how quickly the results are returned are way off and
    probably just wrong. The Openssl speed test is supposed to run for 3
    seconds. The actual results returned for 8192 byte blocks is<br>
    <br>
    Doing aes-128-cbc for 3s on 8192 size blocks: 370202 aes-128-cbc's
    in <b>0.11s</b><br>
    <br>
    whereas without cryptodev I see<br>
    <br>
    Doing aes-128-cbc for 3s on 8192 size blocks: 457255 aes-128-cbc's
    in <b>3.00s</b><br>
    <br>
    So you can see that without cryptodev the i5-6800 actually says it's
    doing more blocks (457,255 vs 370,202) but with cryptodev it is
    doing it in WAY less time.  This leads me to believe the openssl
    speed code when using cryptodev just "goes wrong".<br>
    It will be very interesting to see what the encryption test will
    bring - that is a much better real-life-like example than a simple
    speed test.<br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
    <br>
    <blockquote type="cite"
cite="mid:CAAUX2SV90sC2G5rrZh=mfBT-Hwb08BitHnG-ancCG1HsRrjsSg@...278...">
      <div dir="ltr">
        <div>&gt;My advice is to rerun your tests *without* the
          cryptodev module and then decide wheter you really need
          CBC+CCM hmacs.</div>
        <div>Yes, I confirm that without the cryptodev the performance
          is very bad for my device. I don't have that device in my hand
          right now. But I saved one aes-256-cbc result in my web
          notebook as below:</div>
        <div><br>
        </div>
        <div>
          <div style="white-space:pre-wrap;line-height:1.75;font-size:14px;text-align:left">type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes</div>
          <div style="white-space:pre-wrap;line-height:1.75;font-size:14px;text-align:left">aes-256-cbc      19626.95k    24289.71k    25054.46k    25347.75k    25337.86k</div>
          <div style="white-space:pre-wrap;line-height:1.75;font-size:14px;text-align:left">
</div>
          <div>Please note, there are two modes to accelerate
            encryption/decryption.</div>
          <div style="white-space:pre-wrap;line-height:1.75;font-size:14px;text-align:left"><div>1. HW instructions like intel x86 CPU.</div><div>2. Using a crypto engine.</div><div>
</div><div>When your device is 2 and its CPU is not powerful, normally with cryptodev speed is much faster at least for big blocks. Maybe for small blocks it's slower because</div><div>it needs the time to push the work to kernel and then HW engine and the time spent is may longer than the time costed by OpenSSL directly does the encryption/decryption.
</div><div>
</div></div>
          <div style="white-space:pre-wrap;line-height:1.75;font-size:14px;text-align:left">Tony
</div>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">Jan Just Keijser &lt;<a
            href="mailto:janjust@...1147..." moz-do-not-send="true">janjust@...1147...</a>&gt;
          于2020年12月2日周三 下午7:24写道：<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div bgcolor="#FFFFFF">
            <div>hi Tony,<br>
              <br>
              On 01/12/20 02:50, Tony He wrote:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">Hi Arne,
                <div><br>
                </div>
                <div>openssl speed -evp aes-128-cbc</div>
                <div>
                  <div style="white-space:pre-wrap">          type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
aes-128-cbc      20035.60k   123261.54k   267081.60k  1094764.09k  9181370.18k
              </div>
                  openssl speed -evp aes-128-gcm</div>
                <div>
                  <div style="white-space:pre-wrap">                type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
aes-128-gcm      18738.76k    19284.91k    19524.44k    19606.87k    19685.46k
              </div>
                  openssl speed -evp aes-128-ccm</div>
                <div>
                  <div style="white-space:pre-wrap">                type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
aes-128-ccm      53859.07k   215581.12k   862070.02k  3460786.43k 27566347.61k
              </div>
                  openssl speed -evp sha1</div>
                <div>
                  <div style="white-space:pre-wrap">   type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
sha1              3108.57k    12177.79k    57325.18k   181610.34k  1207364.27k
              </div>
                  openssl speed -evp chacha20-poly1305<br>
                </div>
                <div>
                  <div style="white-space:pre-wrap">chacha20-poly1305 is an unknown cipher or digest</div>
                  <div style="white-space:pre-wrap">Using old openssl, so chacha20-poly1305 is not supported.</div>
                </div>
              </div>
            </blockquote>
            <br>
            these numbers look suspiciously like you're using the linux
            cryptodev module. Openssl speed results for the linux
            cryptodev module are totally unreliable and I'd even go so
            far as to say that the *only* numbers I trust in the output
            above are for aes-128-gcm<br>
            <br>
            For example, if I do the same on an i5-6800 I get *without*
            the cryptodev module:<br>
              $ openssl speed -evp aes-128-cbc <br>
              aes-128-cbc    1,104,599.38k  1,208,651.07k 
            1,231,766.70k  1,237,545.64k  1,248,793.94k<br>
            <br>
            and with the module I get<br>
              aes-128-cbc      45,087.41k   127,822.72k   581,517.17k 
            2,256,593.19k 27,583,804.51k<br>
            <br>
            the second set of numbers doesn't make sense, and a much
            better test is to do an actual encryption test, e.g.<br>
            <br>
            *without* the module<br>
            cat BIGFILE | openssl aes-256-cbc -e -pass 
            pass:thisisabadpassword |  pv &gt; /dev/null<br>
            2.93GB 0:00:05 [ 549MB/s] [         
&lt;=&gt;                                                                             
            ]<br>
            <br>
            ('pv' aka 'pipeview' is a handy tool to measure the
            throughput of a UNIX pipe)<br>
            <br>
            and with the module:<br>
            cat BIGFILE | ./openssl aes-256-cbc -e -pass 
            pass:thisisabadpassword -engine cryptodev|  pv &gt;
            /dev/null<br>
            engine "cryptodev" set.<br>
            2.93GB 0:00:07 [ 426MB/s] [              &lt;=&gt;<br>
            <br>
            so you see that using the cryptodev module actually slows
            things down - which is to be expected, as the application
            needs to do more work using the cryptodev module.<br>
            <br>
            My advice is to rerun your tests *without* the cryptodev
            module and then decide wheter you really need CBC+CCM hmacs.<br>
            <br>
            HTH,<br>
            <br>
            JJK<br>
            <br>
            <br>
            <blockquote type="cite">
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">Arne Schwabe &lt;<a
                    href="mailto:arne@...1227..." target="_blank"
                    moz-do-not-send="true">arne@...1227...</a>&gt;
                  于2020年11月26日周四 下午6:40写道：<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">Am 26.11.20 um
                  10:41 schrieb Tony He:<br>
                  &gt; Hi Arne,<br>
                  &gt; <br>
                  &gt;&gt;Since the original thread was not on the
                  mailing list I am missing your<br>
                  &gt;&gt;goal but if your crypto acelator already works
                  with OpenSSL, then it<br>
                  &gt;&gt;will also work with the "normal" OpenVPN<br>
                  &gt; <br>
                  &gt; Yes, it wokrs with "normal" OpenVPN(OpenVPN2),
                  but according to the test<br>
                  &gt; result, it's still not fast(about 60Mbps).<br>
                  &gt; The bottleneck is not encryption operation any
                  more. It comes from the<br>
                  &gt; switch of user space and kernel space in the
                  OpenVPN2,<br>
                  &gt; which makes the poor CPU of  embedded device very
                  busy. That's why we<br>
                  &gt; need OpenVPN3 running in the kernel space.<br>
                  <br>
                  <br>
                  What numbers are we are talking in crypto speed? Could
                  you provide from<br>
                  your "poor" device:<br>
                  <br>
                  <br>
                  openssl speed -evp aes-128-cbc<br>
                  openssl speed -evp aes-128-gcm<br>
                  openssl speed -evp aes-128-ccm<br>
                  openssl speed -evp sha1<br>
                  openssl speed -evp chacha20-poly1305<br>
                  <br>
                  I want to what difference/gain in terms of raw crypto
                  speed we are<br>
                  talking here.<br>
                  <br>
                  Arne<br>
                  <br>
                  <br>
                </blockquote>
              </div>
              <br>
              <fieldset></fieldset>
              <br>
              <br>
              <fieldset></fieldset>
              <br>
              <pre>_______________________________________________
Openvpn-devel mailing list
<a href="mailto:Openvpn-devel@lists.sourceforge.net" target="_blank" moz-do-not-send="true">Openvpn-devel@lists.sourceforge.net</a>
<a href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel" target="_blank" moz-do-not-send="true">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------E3470ED8DFB8AFBED0E38FB8--

