Message-ID: <4FA8D9BB.3020908@...515...>
Date: Tue, 08 May 2012 11:30:51 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4F901987.9080009@...1147...> <4FA87BA3.3050707@...1147...>
In-Reply-To: <4FA87BA3.3050707@...1147...>
Content-Type: multipart/alternative;
	boundary="------------090405040808090000070302"
Subject: Re: [Openvpn-devel] openssl ouch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090405040808090000070302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


> Jan Just Keijser wrote:
>> ouch:
>>  http://www.openssl.org/news/secadv_20120419.txt
>>
>> we need to investigate whether and how openvpn is affected.
>>
>>
> did somebody end up writing an 'authoritative' answer to the question if 
> and how openvpn is affected by this bug?
>
> cheers,
>
> JJK
>
Hi all,

Got a response from James:

---

My reading on this is that OpenVPN is probably not vulnerable.

Scanning the OpenVPN source for usage of the vulnerable methods 
(d2i_*_bio or d2i_*_fp), I'm seeing several calls of the methods in 
ssl.c, however the data passed to these methods is coming from local 
sources.

$ grep -Er '\bd2i_.*_(bio|fp)\b' .
./ssl.c:          p12 = d2i_PKCS12_bio(b64, NULL);
./ssl.c:          p12 = d2i_PKCS12_fp(fp, NULL);

For example, above, we are passing the PKCS12 file to OpenSSL methods 
that have been cited as vulnerable, however the PKCS12 file is locally 
obtained so there's no capability for a malicious client or server to 
try to push a malformed file to its peer as a part of the OpenVPN or 
SSL/TLS protocols.

Aside from this, the vulnerability text says that "In particular the 
SSL/TLS code of OpenSSL is *not* affected." so the core SSL/TLS 
implementation in OpenVPN should be immune.

And in general, using the "tls-auth" option gives you another level of 
protection against any OpenSSL issues that would involve a direct attack 
on the SSL/TLS protocol.

James

---


--------------090405040808090000070302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <blockquote cite="mid:4FA87BA3.3050707@...1147..." type="cite">
      <pre wrap="">Jan Just Keijser wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">ouch:
 <a class="moz-txt-link-freetext" href="http://www.openssl.org/news/secadv_20120419.txt">http://www.openssl.org/news/secadv_20120419.txt</a>

we need to investigate whether and how openvpn is affected.


</pre>
      </blockquote>
      <pre wrap="">did somebody end up writing an 'authoritative' answer to the question if 
and how openvpn is affected by this bug?

cheers,

JJK

</pre>
    </blockquote>
    Hi all,<br>
    <br>
    Got a response from James:<br>
    <br>
    ---<br>
    <pre wrap="">My reading on this is that OpenVPN is probably not vulnerable.

Scanning the OpenVPN source for usage of the vulnerable methods 
(d2i_*<span class="moz-txt-underscore"><span class="moz-txt-tag">_</span>bio or d2i<span class="moz-txt-tag">_</span></span>*_fp), I'm seeing several calls of the methods in 
ssl.c, however the data passed to these methods is coming from local 
sources.

$ grep -Er '\bd2i_.*_(bio|fp)\b' .
./ssl.c:          p12 = d2i_PKCS12_bio(b64, NULL);
./ssl.c:          p12 = d2i_PKCS12_fp(fp, NULL);

For example, above, we are passing the PKCS12 file to OpenSSL methods 
that have been cited as vulnerable, however the PKCS12 file is locally 
obtained so there's no capability for a malicious client or server to 
try to push a malformed file to its peer as a part of the OpenVPN or 
SSL/TLS protocols.

Aside from this, the vulnerability text says that "In particular the 
SSL/TLS code of OpenSSL is <b class="moz-txt-star"><span class="moz-txt-tag">*</span>not<span class="moz-txt-tag">*</span></b> affected." so the core SSL/TLS 
implementation in OpenVPN should be immune.

And in general, using the "tls-auth" option gives you another level of 
protection against any OpenSSL issues that would involve a direct attack 
on the SSL/TLS protocol.

James

---
</pre>
  </body>
</html>

--------------090405040808090000070302--

