MIME-Version: 1.0
References: <tencent_634348984485969552F3189D5284B3FD7C08@...1414...>
 <CAAUX2SVnf4dr8FNsgNXbFiRMK1VWQQJWE-JUmDPs4VgzcPsDaA@...278...>
 <fdf4b3e6-6130-04c4-7f4e-7f249d5db3ea@...1227...>
 <CAAUX2SVMaOXeKrkck4CUXVdMdtP5WBGS0rvfzQm9s5NFYECXqA@...278...>
 <5c166cc4-8f0c-f9be-a926-10bcde144259@...1147...>
In-Reply-To: <5c166cc4-8f0c-f9be-a926-10bcde144259@...1147...>
From: Tony He <huangya90@...277...>
Date: Wed, 2 Dec 2020 22:22:07 +0800
Message-ID: <CAAUX2SV90sC2G5rrZh=mfBT-Hwb08BitHnG-ancCG1HsRrjsSg@...278...>
Content-Type: multipart/alternative; boundary="000000000000907abb05b57bf88d"
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net, lev@...515..., Antonio Quartulli <a@...2181...>

--000000000000907abb05b57bf88d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Welcome to join the discussion.

>the second set of numbers doesn't make sense, and a much better test is to
do an actual encryption test
I don't compile cryptodev kernel module for my PC and can not reproduce
this issue for now.  You don't understand  the reason why the performance
is much worse with cryptodev module for *big* blocks, right?
If yes, I guess the reason maybe kernel assign the work to multi cores
while OpenSSL uses one core. Would you share the output of command "mpstat
-P ALL 2"?

>My advice is to rerun your tests *without* the cryptodev module and then
decide wheter you really need CBC+CCM hmacs.
Yes, I confirm that without the cryptodev the performance is very bad for
my device. I don't have that device in my hand right now. But I saved one
aes-256-cbc result in my web notebook as below:

type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes
aes-256-cbc 19626.95k 24289.71k 25054.46k 25347.75k 25337.86k

Please note, there are two modes to accelerate encryption/decryption.
1. HW instructions like intel x86 CPU.
2. Using a crypto engine.

When your device is 2 and its CPU is not powerful, normally with cryptodev
speed is much faster at least for big blocks. Maybe for small blocks it's
slower because
it needs the time to push the work to kernel and then HW engine and the
time spent is may longer than the time costed by OpenSSL directly does the
encryption/decryption.

Tony

Jan Just Keijser <janjust@...1147...> =E4=BA=8E2020=E5=B9=B412=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:24=E5=86=99=E9=81=93=EF=BC=9A

> hi Tony,
>
> On 01/12/20 02:50, Tony He wrote:
>
> Hi Arne,
>
> openssl speed -evp aes-128-cbc
> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-cbc
> 20035.60k 123261.54k 267081.60k 1094764.09k 9181370.18k
> openssl speed -evp aes-128-gcm
> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-gcm
> 18738.76k 19284.91k 19524.44k 19606.87k 19685.46k
> openssl speed -evp aes-128-ccm
> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-ccm
> 53859.07k 215581.12k 862070.02k 3460786.43k 27566347.61k
> openssl speed -evp sha1
> type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes sha1 3108.57k
> 12177.79k 57325.18k 181610.34k 1207364.27k
> openssl speed -evp chacha20-poly1305
> chacha20-poly1305 is an unknown cipher or digest
> Using old openssl, so chacha20-poly1305 is not supported.
>
>
> these numbers look suspiciously like you're using the linux cryptodev
> module. Openssl speed results for the linux cryptodev module are totally
> unreliable and I'd even go so far as to say that the *only* numbers I tru=
st
> in the output above are for aes-128-gcm
>
> For example, if I do the same on an i5-6800 I get *without* the cryptodev
> module:
>   $ openssl speed -evp aes-128-cbc
>   aes-128-cbc    1,104,599.38k  1,208,651.07k  1,231,766.70k
> 1,237,545.64k  1,248,793.94k
>
> and with the module I get
>   aes-128-cbc      45,087.41k   127,822.72k   581,517.17k  2,256,593.19k
> 27,583,804.51k
>
> the second set of numbers doesn't make sense, and a much better test is to
> do an actual encryption test, e.g.
>
> *without* the module
> cat BIGFILE | openssl aes-256-cbc -e -pass  pass:thisisabadpassword |  pv
> > /dev/null
> 2.93GB 0:00:05 [ 549MB/s] [
> <=3D>
> ]
>
> ('pv' aka 'pipeview' is a handy tool to measure the throughput of a UNIX
> pipe)
>
> and with the module:
> cat BIGFILE | ./openssl aes-256-cbc -e -pass  pass:thisisabadpassword
> -engine cryptodev|  pv > /dev/null
> engine "cryptodev" set.
> 2.93GB 0:00:07 [ 426MB/s] [              <=3D>
>
> so you see that using the cryptodev module actually slows things down -
> which is to be expected, as the application needs to do more work using t=
he
> cryptodev module.
>
> My advice is to rerun your tests *without* the cryptodev module and then
> decide wheter you really need CBC+CCM hmacs.
>
> HTH,
>
> JJK
>
>
> Arne Schwabe <arne@...1227...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:40=E5=86=99=E9=81=93=EF=BC=9A
>
>> Am 26.11.20 um 10:41 schrieb Tony He:
>> > Hi Arne,
>> >
>> >>Since the original thread was not on the mailing list I am missing your
>> >>goal but if your crypto acelator already works with OpenSSL, then it
>> >>will also work with the "normal" OpenVPN
>> >
>> > Yes, it wokrs with "normal" OpenVPN(OpenVPN2), but according to the te=
st
>> > result, it's still not fast(about 60Mbps).
>> > The bottleneck is not encryption operation any more. It comes from the
>> > switch of user space and kernel space in the OpenVPN2,
>> > which makes the poor CPU of  embedded device very busy. That's why we
>> > need OpenVPN3 running in the kernel space.
>>
>>
>> What numbers are we are talking in crypto speed? Could you provide from
>> your "poor" device:
>>
>>
>> openssl speed -evp aes-128-cbc
>> openssl speed -evp aes-128-gcm
>> openssl speed -evp aes-128-ccm
>> openssl speed -evp sha1
>> openssl speed -evp chacha20-poly1305
>>
>> I want to what difference/gain in terms of raw crypto speed we are
>> talking here.
>>
>> Arne
>>
>>
>>
>
>
>
> _______________________________________________
> Openvpn-devel mailing listOpenvpn-devel@...1440...://lists.sourceforge.ne=
t/lists/listinfo/openvpn-devel
>
>
>

--000000000000907abb05b57bf88d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jan,</div><div><br></div><div>Welcome to join the =
discussion.</div><div><br></div><div>&gt;the second set of numbers doesn&#3=
9;t make sense, and a much better test
    is to do an actual encryption test</div><div>I don&#39;t compile crypto=
dev kernel module for my PC and can not reproduce this issue for now.=C2=A0=
 You don&#39;t understand=C2=A0 the reason why the performance is much wors=
e with cryptodev module for *big* blocks, right?<br></div><div>If yes, I gu=
ess the reason maybe kernel assign the work to multi cores while OpenSSL us=
es one core. Would you share the output of command &quot;mpstat -P ALL 2&qu=
ot;?</div><div><br></div><div>&gt;My advice is to rerun your tests *without=
* the cryptodev module and
    then decide wheter you really need CBC+CCM hmacs.</div><div>Yes, I conf=
irm that without the cryptodev the performance is very bad for my device. I=
 don&#39;t have that device in my hand right now. But I saved one aes-256-c=
bc result in my web notebook as below:</div><div><br></div><div><div style=
=3D"white-space:pre-wrap;line-height:1.75;font-size:14px;text-align:left">t=
ype             16 bytes     64 bytes    256 bytes   1024 bytes   8192 byte=
s</div><div style=3D"white-space:pre-wrap;line-height:1.75;font-size:14px;t=
ext-align:left">aes-256-cbc      19626.95k    24289.71k    25054.46k    253=
47.75k    25337.86k</div><div style=3D"white-space:pre-wrap;line-height:1.7=
5;font-size:14px;text-align:left"><br></div><div>Please note,  there are tw=
o modes to accelerate encryption/decryption.</div><div style=3D"white-space=
:pre-wrap;line-height:1.75;font-size:14px;text-align:left"><div>1. HW instr=
uctions like intel x86 CPU.</div><div>2. Using a crypto engine.</div><div><=
br></div><div>When your device is 2 and its CPU is not powerful, normally w=
ith cryptodev speed is much faster at least for big blocks. Maybe for small=
 blocks it&#39;s slower because</div><div>it needs the time to push the wor=
k to kernel and then HW engine and the time spent is may longer than the ti=
me costed by OpenSSL directly does the encryption/decryption.<br></div><div=
><br></div></div><div style=3D"white-space:pre-wrap;line-height:1.75;font-s=
ize:14px;text-align:left">Tony<br></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">Jan Just Keijser &lt;<a href=
=3D"mailto:janjust@...1147...">janjust@...1147...</a>&gt; =E4=BA=8E2020=E5=
=B9=B412=E6=9C=882=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:24=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
=20=20
=20=20=20=20
=20=20
  <div bgcolor=3D"#FFFFFF">
    <div>hi Tony,<br>
      <br>
      On 01/12/20 02:50, Tony He wrote:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div dir=3D"ltr">Hi Arne,
        <div><br>
        </div>
        <div>openssl speed -evp aes-128-cbc</div>
        <div>
          <div style=3D"white-space:pre-wrap">          type             16=
 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
aes-128-cbc      20035.60k   123261.54k   267081.60k  1094764.09k  9181370.=
18k
              </div>
          openssl speed -evp aes-128-gcm</div>
        <div>
          <div style=3D"white-space:pre-wrap">                type         =
    16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
aes-128-gcm      18738.76k    19284.91k    19524.44k    19606.87k    19685.=
46k
              </div>
          openssl speed -evp aes-128-ccm</div>
        <div>
          <div style=3D"white-space:pre-wrap">                type         =
    16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
aes-128-ccm      53859.07k   215581.12k   862070.02k  3460786.43k 27566347.=
61k
              </div>
          openssl speed -evp sha1</div>
        <div>
          <div style=3D"white-space:pre-wrap">   type             16 bytes =
    64 bytes    256 bytes   1024 bytes   8192 bytes
sha1              3108.57k    12177.79k    57325.18k   181610.34k  1207364.=
27k
              </div>
          openssl speed -evp chacha20-poly1305<br>
        </div>
        <div>
          <div style=3D"white-space:pre-wrap">chacha20-poly1305 is an unkno=
wn cipher or digest</div>
          <div style=3D"white-space:pre-wrap">Using old openssl, so chacha2=
0-poly1305 is not supported.</div>
        </div>
      </div>
    </blockquote>
    <br>
    these numbers look suspiciously like you&#39;re using the linux
    cryptodev module. Openssl speed results for the linux cryptodev
    module are totally unreliable and I&#39;d even go so far as to say that
    the *only* numbers I trust in the output above are for aes-128-gcm<br>
    <br>
    For example, if I do the same on an i5-6800 I get *without* the
    cryptodev module:<br>
    =C2=A0 $ openssl speed -evp aes-128-cbc <br>
    =C2=A0 aes-128-cbc=C2=A0=C2=A0=C2=A0 1,104,599.38k=C2=A0 1,208,651.07k=
=C2=A0 1,231,766.70k=C2=A0
    1,237,545.64k=C2=A0 1,248,793.94k<br>
    <br>
    and with the module I get<br>
    =C2=A0 aes-128-cbc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 45,087.41k=C2=A0=C2=A0=
 127,822.72k=C2=A0=C2=A0 581,517.17k=C2=A0
    2,256,593.19k 27,583,804.51k<br>
    <br>
    the second set of numbers doesn&#39;t make sense, and a much better test
    is to do an actual encryption test, e.g.<br>
    <br>
    *without* the module<br>
    cat BIGFILE | openssl aes-256-cbc -e -pass=C2=A0 pass:thisisabadpassword
    |=C2=A0 pv &gt; /dev/null<br>
    2.93GB 0:00:05 [ 549MB/s] [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
&lt;=3D&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
    ]<br>
    <br>
    (&#39;pv&#39; aka &#39;pipeview&#39; is a handy tool to measure the thr=
oughput of a
    UNIX pipe)<br>
    <br>
    and with the module:<br>
    cat BIGFILE | ./openssl aes-256-cbc -e -pass=C2=A0
    pass:thisisabadpassword -engine cryptodev|=C2=A0 pv &gt; /dev/null<br>
    engine &quot;cryptodev&quot; set.<br>
    2.93GB 0:00:07 [ 426MB/s] [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lt;=3D&gt;<br>
    <br>
    so you see that using the cryptodev module actually slows things
    down - which is to be expected, as the application needs to do more
    work using the cryptodev module.<br>
    <br>
    My advice is to rerun your tests *without* the cryptodev module and
    then decide wheter you really need CBC+CCM hmacs.<br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
    <br>
    <blockquote type=3D"cite">
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">Arne Schwabe &lt;<a href=3D"m=
ailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;
          =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B =
=E4=B8=8B=E5=8D=886:40=E5=86=99=E9=81=93=EF=BC=9A<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am
          26.11.20 um 10:41 schrieb Tony He:<br>
          &gt; Hi Arne,<br>
          &gt; <br>
          &gt;&gt;Since the original thread was not on the mailing list
          I am missing your<br>
          &gt;&gt;goal but if your crypto acelator already works with
          OpenSSL, then it<br>
          &gt;&gt;will also work with the &quot;normal&quot; OpenVPN<br>
          &gt; <br>
          &gt; Yes, it wokrs with &quot;normal&quot; OpenVPN(OpenVPN2), but
          according to the test<br>
          &gt; result, it&#39;s still not fast(about 60Mbps).<br>
          &gt; The bottleneck is not encryption operation any more. It
          comes from the<br>
          &gt; switch of user space and kernel space in the OpenVPN2,<br>
          &gt; which makes the poor CPU of=C2=A0 embedded device=C2=A0very
          busy.=C2=A0That&#39;s why we<br>
          &gt; need OpenVPN3 running in the kernel space.<br>
          <br>
          <br>
          What numbers are we are talking in crypto speed? Could you
          provide from<br>
          your &quot;poor&quot; device:<br>
          <br>
          <br>
          openssl speed -evp aes-128-cbc<br>
          openssl speed -evp aes-128-gcm<br>
          openssl speed -evp aes-128-ccm<br>
          openssl speed -evp sha1<br>
          openssl speed -evp chacha20-poly1305<br>
          <br>
          I want to what difference/gain in terms of raw crypto speed we
          are<br>
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
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000907abb05b57bf88d--

