References: <CAFHpkQEbh-5aOm-R7HPUBYq2TcFXYQ=XNd8rAo3955LVFjaK9Q@...278...>
 <3437a0a5-6522-9f29-4e98-b3b90f490f4d@...1147...>
 <CAFHpkQHAhBJctSON82bstHdcq89z8TLAyRA5M443yoTa6oKxag@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <491d08a7-c343-0e63-05fb-c045ea34dc8e@...1147...>
Date: Thu, 14 Jan 2021 09:49:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHAhBJctSON82bstHdcq89z8TLAyRA5M443yoTa6oKxag@...278...>
Content-Type: multipart/alternative;
 boundary="------------EC02B84E88A63F45FB1CA5AD"
Content-Language: en-US
Subject: Re: [Openvpn-devel] is it possible to store saved password in tpm
 instead of registry ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------EC02B84E88A63F45FB1CA5AD
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi,

On 13/01/21 19:29, Илья Шипицин wrote:
>
>
> ср, 13 янв. 2021 г. в 22:01, Jan Just Keijser <janjust@...1147... 
> <mailto:janjust@...1147...>>:
>
>     Hi,
>
>     On 13/01/21 17:20, Илья Шипицин wrote:
>     > Hello,
>     >
>     > if user save password, it might be stolen from well known location
>     > (there are popular password stealers).
>     >
>     > in theory, is it possible to keep password in tpm ? will it prevent
>     > password from being stolen ?
>     >
>     in theory, yes, but as always, it depends on the circumstances.
>
>     With TPM 1.2 you can only store a very limited amount of data in
>     the TPM
>     chip; the (open source) implementation I have seen (tss, trousers)
>     store
>
>
> I meant openvpn-gui + user/password authentication + password is kept 
> in registry encrypted by data protection api (not clear text, but 
> might be decrypted and stolen easily).
>
> trousers is linux, right ?
>
ah yes, indeed, trousers is Linux; I guess I defaulted to Open source 
software for an open source VPN ;)

As for storing any old password in a TPM: yes that seems possible in 
Windows 10 (with the right TPM support, I presume). For example, this
https://superuser.com/questions/1527685/how-to-remove-webauthn-credentials-from-onboard-tpm-on-win10-device?rq=1

posts that someone wants to *get rid* of edge/chrome authn details 
stored in the TPM.
Could be that support for this is also present in chromium, which means 
you should be able to find the source code that does this.

HTH,

JJK

--------------EC02B84E88A63F45FB1CA5AD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi,<br>
      <br>
      On 13/01/21 19:29, Илья Шипицин wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAFHpkQHAhBJctSON82bstHdcq89z8TLAyRA5M443yoTa6oKxag@...278...">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">ср, 13 янв. 2021 г. в 22:01,
            Jan Just Keijser &lt;<a href="mailto:janjust@...1147..."
              moz-do-not-send="true">janjust@...1147...</a>&gt;:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Hi,<br>
            <br>
            On 13/01/21 17:20, Илья Шипицин wrote:<br>
            &gt; Hello,<br>
            &gt;<br>
            &gt; if user save password, it might be stolen from well
            known location <br>
            &gt; (there are popular password stealers).<br>
            &gt;<br>
            &gt; in theory, is it possible to keep password in tpm ?
            will it prevent <br>
            &gt; password from being stolen ?<br>
            &gt;<br>
            in theory, yes, but as always, it depends on the
            circumstances.<br>
            <br>
            With TPM 1.2 you can only store a very limited amount of
            data in the TPM <br>
            chip; the (open source) implementation I have seen (tss,
            trousers) store <br>
          </blockquote>
          <div><br>
          </div>
          <div>I meant openvpn-gui + user/password authentication +
            password is kept in registry encrypted by data protection
            api (not clear text, but might be decrypted and stolen
            easily).</div>
          <div><br>
          </div>
          <div>trousers is linux, right ? <br>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    ah yes, indeed, trousers is Linux; I guess I defaulted to Open
    source software for an open source VPN ;)<br>
    <br>
    As for storing any old password in a TPM: yes that seems possible in
    Windows 10 (with the right TPM support, I presume). For example,
    this<br>
     
<a class="moz-txt-link-freetext" href="https://superuser.com/questions/1527685/how-to-remove-webauthn-credentials-from-onboard-tpm-on-win10-device?rq=1">https://superuser.com/questions/1527685/how-to-remove-webauthn-credentials-from-onboard-tpm-on-win10-device?rq=1</a><br>
    <br>
    posts that someone wants to *get rid* of edge/chrome authn details
    stored in the TPM.<br>
    Could be that support for this is also present in chromium, which
    means you should be able to find the source code that does this.<br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
  </body>
</html>

--------------EC02B84E88A63F45FB1CA5AD--

