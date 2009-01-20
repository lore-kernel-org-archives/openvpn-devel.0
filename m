Message-ID: <49759A44.1060207@...1107...>
Date: Tue, 20 Jan 2009 10:32:52 +0100
From: Andrzej Chmielowiec <andrzej.chmielowiec@...1107...>
MIME-Version: 1.0
References: <496DA8AB.3070301@...1185...> <496E1D39.9090606@...41...>
In-Reply-To: <496E1D39.9090606@...41...>
Content-Type: multipart/alternative;
	boundary="------------000200070308070908040704"
Subject: Re: [Openvpn-devel] OpenVPN affected? - Incorrect checks for
 malformed signatures in OpenSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000200070308070908040704
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

OpenVPN can use DSA certificates if you choose one of the following=20
--tls-cipher:

    DHE-DSS-AES256-SHA
    EDH-DSS-DES-CBC3-SHA
    DHE-DSS-AES128-SHA
    EDH-DSS-DES-CBC-SHA
    EXP-EDH-DSS-DES-CBC-SHA

If someone use one of the above sipher suite, then he should change OpenSSL
version to 0.9.8j.

By the way, do you plan to add my patch with ECDH support to OpenVPN?

Regards,
Andrzej Chmielowiec

> I don't believe this issue significantly affects OpenVPN.  OpenVPN does=20
> not use the EVP_VerifyFinal function.  The issue is that some internal=20
> OpenSSL functions do not properly check the return value of this=20
> function.  The issue is primarily of concern if you are using DSA or=20
> ECDSA certificates, however these are not generally used with OpenVPN=20
> (OpenVPN uses RSA certificates and does not currently support DSA or=20
> ECDSA certificates).
>
> James
>
> Michael A. G=FCtlbauer wrote:
>  =20
>> Hallo!
>>
>> I'm sure, you know the "OpenSSL Security Advisory [07-Jan-2009]"=20
>> (http://www.openssl.org/news/secadv_20090107.txt)
>>
>> Because there's absolutely no information on your website, whether=20
>> OpenVPN is affected and/or a bug-fix will be available, I'd like to ask =

>> you to do so.
>>
>> Many thanks!
>>
>> Michael
>>    =20
>
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by:
> SourcForge Community
> SourceForge wants to tell your story.
> http://p.sf.net/sfu/sf-spreadtheword
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>  =20


--------------000200070308070908040704
Content-Type: text/html; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DISO-8859-15"
 http-equiv=3D"Content-Type">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
<tt>Hi,<br>
<br>
OpenVPN can use DSA certificates if you choose one of the following
--tls-cipher:<br>
<br>
=A0=A0=A0 DHE-DSS-AES256-SHA<br>
=A0=A0=A0 EDH-DSS-DES-CBC3-SHA<br>
=A0=A0=A0 DHE-DSS-AES128-SHA<br>
=A0=A0=A0 EDH-DSS-DES-CBC-SHA<br>
=A0=A0=A0 EXP-EDH-DSS-DES-CBC-SHA<br>
<br>
If someone use one of the above sipher suite, then he should change
OpenSSL <br>
version to 0.9.8j.<br>
<br>
By the way, do you plan to add my patch with ECDH support to OpenVPN?<br>
<br>
Regards,<br>
Andrzej Chmielowiec<br>
<br>
</tt>
<blockquote cite=3D"mid:496E1D39.9090606@...41..." type=3D"cite">
  <pre wrap=3D"">I don't believe this issue significantly affects OpenVPN. =
 OpenVPN does=20
not use the EVP_VerifyFinal function.  The issue is that some internal=20
OpenSSL functions do not properly check the return value of this=20
function.  The issue is primarily of concern if you are using DSA or=20
ECDSA certificates, however these are not generally used with OpenVPN=20
(OpenVPN uses RSA certificates and does not currently support DSA or=20
ECDSA certificates).

James

Michael A. G=FCtlbauer wrote:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">Hallo!

I'm sure, you know the "OpenSSL Security Advisory [07-Jan-2009]"=20
(<a class=3D"moz-txt-link-freetext" href=3D"http://www.openssl.org/news/sec=
adv_20090107.txt">http://www.openssl.org/news/secadv_20090107.txt</a>)

Because there's absolutely no information on your website, whether=20
OpenVPN is affected and/or a bug-fix will be available, I'd like to ask=20
you to do so.

Many thanks!

Michael
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
---------------------------------------------------------------------------=
---
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
<a class=3D"moz-txt-link-freetext" href=3D"http://p.sf.net/sfu/sf-spreadthe=
word">http://p.sf.net/sfu/sf-spreadtheword</a>
_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@lists.so=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>

  </pre>
</blockquote>
<br>
</body>
</html>

--------------000200070308070908040704--

