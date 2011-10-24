Message-ID: <4EA529C7.1090202@...1147...>
Date: Mon, 24 Oct 2011 11:03:03 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1319445962-21686-1-git-send-email-dejong@...1435...>
	<1319445962-21686-3-git-send-email-dejong@...1435...>
	<4EA52800.4080205@...1147...>
	<1CED409804E2164C8104F9E623B08B90127CB75804@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90127CB75804@...1436...>
Content-Type: multipart/alternative;
	boundary="------------070906080503030500000104"
Subject: Re: [Openvpn-devel] [PATCH 3/3] Changed default algorithm for
 PolarSSL to AES-128, as BF is not supported
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070906080503030500000104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Adriaan de Jong wrote:
> Unfortunately BF isn't supported in PolarSSL though. 
>
> Do you have any other suggestions? I'm open to most ideas other than "implement blowfish" :)
>   
hmmm then perhaps the default should be changed to AES-128 ?

I foresee a lot of openvpn-users mails and forums hits from people
saying stuff like 'I am running opevpn 2.1 on the server using default
settings and am connecting using openvpn 2.3/polarssl and bla bla' : we
need to think  about how we want to tackle issues like that (is there a
way to determine at runtime which version of which SSL implementation is
used? OpenSSL has such a (runtime!) call.

The ideal solution would be to set a 'crypto negotiation phase' during
which the client and server negotiate about the available crypto
routines, pretty much like the "standard" TLS/SSL protocol does (and
which is done on the OpenVPN control channel, but not on the data channel).

JJK
>> -----Original Message-----
>> From: Jan Just Keijser [mailto:janjust@...1147...]
>> Sent: maandag 24 oktober 2011 10:55
>> To: Adriaan de Jong
>> Cc: openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] [PATCH 3/3] Changed default algorithm for
>> PolarSSL to AES-128, as BF is not supported
>>
>> I'd NACK this patch : the default behaviour of OpenVPN should be
>> independent of the SSL implementation.
>>
>> JJK
>>
>> Adriaan de Jong wrote:
>>     
>>> Signed-off-by: Adriaan de Jong <dejong@...1435...>
>>> ---
>>>  options.c |    5 +++++
>>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/options.c b/options.c
>>> index 39e7a57..d917072 100644
>>> --- a/options.c
>>> +++ b/options.c
>>> @@ -810,7 +810,12 @@ init_options (struct options *o, const bool
>>>       
>> init_gc)
>>     
>>>    o->server_poll_timeout = 0;
>>>  #endif
>>>  #ifdef USE_CRYPTO
>>> +#ifdef USE_OPENSSL
>>>    o->ciphername = "BF-CBC";
>>> +#endif
>>> +#ifdef USE_POLARSSL
>>> +  o->ciphername = "AES-128-CBC";
>>> +#endif
>>>    o->ciphername_defined = true;
>>>    o->authname = "SHA1";
>>>    o->authname_defined = true;
>>>
>>>       
>
>   


--------------070906080503030500000104
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Adriaan de Jong wrote:
<blockquote
 cite="mid:1CED409804E2164C8104F9E623B08B90127CB75804@...1436..."
 type="cite">
  <pre wrap="">Unfortunately BF isn't supported in PolarSSL though. 

Do you have any other suggestions? I'm open to most ideas other than "implement blowfish" :)
  </pre>
</blockquote>
hmmm then perhaps the default should be changed to AES-128 ?<br>
<br>
I foresee a lot of openvpn-users mails and forums hits from people
saying stuff like 'I am running opevpn 2.1 on the server using default
settings and am connecting using openvpn 2.3/polarssl and bla bla' : we
need to think&nbsp; about how we want to tackle issues like that (is there a
way to determine at runtime which version of which SSL implementation
is used? OpenSSL has such a (runtime!) call. <br>
<br>
The ideal solution would be to set a 'crypto negotiation phase' during
which the client and server negotiate about the available crypto
routines, pretty much like the "standard" TLS/SSL protocol does (and
which is done on the OpenVPN control channel, but not on the data
channel).<br>
<br>
JJK<br>
<blockquote
 cite="mid:1CED409804E2164C8104F9E623B08B90127CB75804@...1436..."
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">-----Original Message-----
From: Jan Just Keijser [<a class="moz-txt-link-freetext" href="mailto:janjust@...1147...">mailto:janjust@...1147...</a>]
Sent: maandag 24 oktober 2011 10:55
To: Adriaan de Jong
Cc: <a class="moz-txt-link-abbreviated" href="mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@lists.sourceforge.net</a>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Changed default algorithm for
PolarSSL to AES-128, as BF is not supported

I'd NACK this patch : the default behaviour of OpenVPN should be
independent of the SSL implementation.

JJK

Adriaan de Jong wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Signed-off-by: Adriaan de Jong <a class="moz-txt-link-rfc2396E" href="mailto:dejong@...1435...">&lt;dejong@...1435...&gt;</a>
---
 options.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index 39e7a57..d917072 100644
--- a/options.c
+++ b/options.c
@@ -810,7 +810,12 @@ init_options (struct options *o, const bool
      </pre>
    </blockquote>
    <pre wrap="">init_gc)
    </pre>
    <blockquote type="cite">
      <pre wrap="">   o-&gt;server_poll_timeout = 0;
 #endif
 #ifdef USE_CRYPTO
+#ifdef USE_OPENSSL
   o-&gt;ciphername = "BF-CBC";
+#endif
+#ifdef USE_POLARSSL
+  o-&gt;ciphername = "AES-128-CBC";
+#endif
   o-&gt;ciphername_defined = true;
   o-&gt;authname = "SHA1";
   o-&gt;authname_defined = true;

      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
<br>
</body>
</html>

--------------070906080503030500000104--

