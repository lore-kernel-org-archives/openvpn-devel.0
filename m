References: <tencent_634348984485969552F3189D5284B3FD7C08@...1414...>
 <CAAUX2SVnf4dr8FNsgNXbFiRMK1VWQQJWE-JUmDPs4VgzcPsDaA@...278...>
 <fdf4b3e6-6130-04c4-7f4e-7f249d5db3ea@...1227...>
 <CAAUX2SVMaOXeKrkck4CUXVdMdtP5WBGS0rvfzQm9s5NFYECXqA@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <5c166cc4-8f0c-f9be-a926-10bcde144259@...1147...>
Date: Wed, 2 Dec 2020 12:23:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SVMaOXeKrkck4CUXVdMdtP5WBGS0rvfzQm9s5NFYECXqA@...278...>
Content-Type: multipart/alternative;
 boundary="------------0457B2681680D53D3F488CA6"
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
To: Tony He <huangya90@...277...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, lev@...515..., Antonio Quartulli <a@...2181...>

This is a multi-part message in MIME format.
--------------0457B2681680D53D3F488CA6
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

hi Tony,

On 01/12/20 02:50, Tony He wrote:
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

these numbers look suspiciously like you're using the linux cryptodev 
module. Openssl speed results for the linux cryptodev module are totally 
unreliable and I'd even go so far as to say that the *only* numbers I 
trust in the output above are for aes-128-gcm

For example, if I do the same on an i5-6800 I get *without* the 
cryptodev module:
   $ openssl speed -evp aes-128-cbc
   aes-128-cbc    1,104,599.38k  1,208,651.07k  1,231,766.70k 
1,237,545.64k  1,248,793.94k

and with the module I get
   aes-128-cbc      45,087.41k   127,822.72k   581,517.17k 2,256,593.19k 
27,583,804.51k

the second set of numbers doesn't make sense, and a much better test is 
to do an actual encryption test, e.g.

*without* the module
cat BIGFILE | openssl aes-256-cbc -e -pass  pass:thisisabadpassword |  
pv > /dev/null
2.93GB 0:00:05 [ 549MB/s] [ <=> ]

('pv' aka 'pipeview' is a handy tool to measure the throughput of a UNIX 
pipe)

and with the module:
cat BIGFILE | ./openssl aes-256-cbc -e -pass pass:thisisabadpassword 
-engine cryptodev|  pv > /dev/null
engine "cryptodev" set.
2.93GB 0:00:07 [ 426MB/s] [              <=>

so you see that using the cryptodev module actually slows things down - 
which is to be expected, as the application needs to do more work using 
the cryptodev module.

My advice is to rerun your tests *without* the cryptodev module and then 
decide wheter you really need CBC+CCM hmacs.

HTH,

JJK


> Arne Schwabe <arne@...1227... <mailto:arne@...1227...>> 
> 于2020年11月26日周四 下午6:40写道：
>
>     Am 26.11.20 um 10:41 schrieb Tony He:
>     > Hi Arne,
>     >
>     >>Since the original thread was not on the mailing list I am
>     missing your
>     >>goal but if your crypto acelator already works with OpenSSL, then it
>     >>will also work with the "normal" OpenVPN
>     >
>     > Yes, it wokrs with "normal" OpenVPN(OpenVPN2), but according to
>     the test
>     > result, it's still not fast(about 60Mbps).
>     > The bottleneck is not encryption operation any more. It comes
>     from the
>     > switch of user space and kernel space in the OpenVPN2,
>     > which makes the poor CPU of  embedded device very busy. That's
>     why we
>     > need OpenVPN3 running in the kernel space.
>
>
>     What numbers are we are talking in crypto speed? Could you provide
>     from
>     your "poor" device:
>
>
>     openssl speed -evp aes-128-cbc
>     openssl speed -evp aes-128-gcm
>     openssl speed -evp aes-128-ccm
>     openssl speed -evp sha1
>     openssl speed -evp chacha20-poly1305
>
>     I want to what difference/gain in terms of raw crypto speed we are
>     talking here.
>
>     Arne
>
>
>
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------0457B2681680D53D3F488CA6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">hi Tony,<br>
      <br>
      On 01/12/20 02:50, Tony He wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAUX2SVMaOXeKrkck4CUXVdMdtP5WBGS0rvfzQm9s5NFYECXqA@...278...">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
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
    cryptodev module. Openssl speed results for the linux cryptodev
    module are totally unreliable and I'd even go so far as to say that
    the *only* numbers I trust in the output above are for aes-128-gcm<br>
    <br>
    For example, if I do the same on an i5-6800 I get *without* the
    cryptodev module:<br>
      $ openssl speed -evp aes-128-cbc <br>
      aes-128-cbc    1,104,599.38k  1,208,651.07k  1,231,766.70k 
    1,237,545.64k  1,248,793.94k<br>
    <br>
    and with the module I get<br>
      aes-128-cbc      45,087.41k   127,822.72k   581,517.17k 
    2,256,593.19k 27,583,804.51k<br>
    <br>
    the second set of numbers doesn't make sense, and a much better test
    is to do an actual encryption test, e.g.<br>
    <br>
    *without* the module<br>
    cat BIGFILE | openssl aes-256-cbc -e -pass  pass:thisisabadpassword
    |  pv &gt; /dev/null<br>
    2.93GB 0:00:05 [ 549MB/s] [         
&lt;=&gt;                                                                             
    ]<br>
    <br>
    ('pv' aka 'pipeview' is a handy tool to measure the throughput of a
    UNIX pipe)<br>
    <br>
    and with the module:<br>
    cat BIGFILE | ./openssl aes-256-cbc -e -pass 
    pass:thisisabadpassword -engine cryptodev|  pv &gt; /dev/null<br>
    engine "cryptodev" set.<br>
    2.93GB 0:00:07 [ 426MB/s] [              &lt;=&gt;<br>
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
    <blockquote type="cite"
cite="mid:CAAUX2SVMaOXeKrkck4CUXVdMdtP5WBGS0rvfzQm9s5NFYECXqA@...278...">
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">Arne Schwabe &lt;<a
            href="mailto:arne@...1227..." moz-do-not-send="true">arne@...1227...</a>&gt;
          于2020年11月26日周四 下午6:40写道：<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am
          26.11.20 um 10:41 schrieb Tony He:<br>
          &gt; Hi Arne,<br>
          &gt; <br>
          &gt;&gt;Since the original thread was not on the mailing list
          I am missing your<br>
          &gt;&gt;goal but if your crypto acelator already works with
          OpenSSL, then it<br>
          &gt;&gt;will also work with the "normal" OpenVPN<br>
          &gt; <br>
          &gt; Yes, it wokrs with "normal" OpenVPN(OpenVPN2), but
          according to the test<br>
          &gt; result, it's still not fast(about 60Mbps).<br>
          &gt; The bottleneck is not encryption operation any more. It
          comes from the<br>
          &gt; switch of user space and kernel space in the OpenVPN2,<br>
          &gt; which makes the poor CPU of  embedded device very
          busy. That's why we<br>
          &gt; need OpenVPN3 running in the kernel space.<br>
          <br>
          <br>
          What numbers are we are talking in crypto speed? Could you
          provide from<br>
          your "poor" device:<br>
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
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0457B2681680D53D3F488CA6--

