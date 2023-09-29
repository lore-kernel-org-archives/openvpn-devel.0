Content-Type: multipart/alternative;
 boundary="------------23k7D0fd9jfXvwEDKIOvHjS0"
Message-ID: <68a68aa4-0c57-655c-e0c9-ff9f1e0bf040@...1227...>
Date: Fri, 29 Sep 2023 02:55:41 +0200
MIME-Version: 1.0
References: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
 <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
 <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
Subject: Re: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mike tancsa <mike@...1800...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------23k7D0fd9jfXvwEDKIOvHjS0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


Am 29.09.2023 um 01:08 schrieb mike tancsa:
>
> Hi Selva,
>
>     Thank you for looking!
>
>
>> My guess is that something in the certificate or private key is not to
>> OpenSSL 3.1's liking and it rejects it. Is there any way for you to 
>> check the
>> contents of the token independently using a tool linked against 
>> OpenSSL 3.1 ?
>>
> What am I looking for in that case ?  Taking a look at the cert just 
> with openssl 3.0 on FreeBSD releng14 it seems ok with it. Same with 
> the Windows version 3.1.x that comes with OpenVPN. Is it possible it 
> doesnt like the sha1RSA sig ?
>
>
OpenSSL 3.0 has security 1 by default (OpenSSL 3.1 has 2 by default)  
and that does not allow SHA1 signatures anymore. See 
https://www.openssl.org/docs/man3.1/man3/SSL_CTX_set_security_level.html


Arne

--------------23k7D0fd9jfXvwEDKIOvHjS0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 29.09.2023 um 01:08 schrieb mike
      tancsa:<br>
    </div>
    <blockquote type="cite"
      cite="mid:850037b2-36d0-4240-8c73-04dab1a90777@...1800...">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>Hi Selva,</p>
      <p>    Thank you for looking!<br>
      </p>
      <br>
      <blockquote type="cite"
cite="mid:CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...">
        <div dir="ltr">
          <div class="gmail_quote">
            <div>My guess is that something in the certificate or
              private key is not to</div>
            <div>OpenSSL 3.1's liking and it rejects it. Is there any
              way for you to check the</div>
            <div>contents of the token independently using a tool linked
              against OpenSSL 3.1 ?</div>
            <div><br>
            </div>
          </div>
        </div>
      </blockquote>
      <p>What am I looking for in that case ?  Taking a look at the cert
        just with openssl 3.0 on FreeBSD releng14 it seems ok with it.
        Same with the Windows version 3.1.x that comes with OpenVPN. Is
        it possible it doesnt like the sha1RSA sig ?<br>
      </p>
      <br>
    </blockquote>
    <p>OpenSSL 3.0 has security 1 by default (OpenSSL 3.1 has 2 by
      default)  and that does not allow SHA1 signatures anymore. See
      <a class="moz-txt-link-freetext" href="https://www.openssl.org/docs/man3.1/man3/SSL_CTX_set_security_level.html">https://www.openssl.org/docs/man3.1/man3/SSL_CTX_set_security_level.html</a></p>
    <p><br>
    </p>
    <p>Arne<br>
    </p>
  </body>
</html>

--------------23k7D0fd9jfXvwEDKIOvHjS0--

