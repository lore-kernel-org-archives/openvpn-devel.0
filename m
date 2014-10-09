Message-ID: <5436B50A.7040004@...1227...>
Date: Thu, 09 Oct 2014 18:17:14 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAPd-S-PVJzdHKfOhMuJMmUG8kEETKweTW46owhAJa6aS4Ny+Qg@...278...>	<5433CFD5.5060901@...515...>	<CAPd-S-OgUuuFJwkz0Unmszyi1Vmv2WEgBaG+RCJ-bWXBvfNzxg@...278...>
	<5433FD92.7020400@...1227...> <5436B36A.1050105@...1147...>
In-Reply-To: <5436B36A.1050105@...1147...>
Content-Type: multipart/alternative;
	boundary="------------020209040602060102060901"
Subject: Re: [Openvpn-devel] Paid Engagement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------020209040602060102060901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


>
> So, it looks like running rsa_sign with a cert/key pair coming out of
> the cryptostore store is causing some low level openssl problems.
> Don't know how easy it is fix, but most likely it's not inside the
> OpenVPN code...
>
Pretty easy (for OpenSSL standards...). You have to use the lowlevel
functions instead of rsa_sign. See also
https://code.google.com/p/ics-openvpn/source/browse/main/jni/jbcrypto.cpp

Basically for ics-openvpn the change was to replace

RSA_sign(NID_md5_sha1, (unsigned char*) data, datalen,
        sigret, &siglen, pkey->pkey.rsa) <= 0 )

with

    siglen = RSA_private_encrypt(datalen,(unsigned char*)
data,sigret,pkey->pkey.rsa,RSA_PKCS1_PADDING);

But I haven't looked at the OpenVPN source code yet which code path is
called there.

Arne

--------------020209040602060102060901
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <blockquote cite="mid:5436B36A.1050105@...1147..." type="cite">
      <br>
      So, it looks like running rsa_sign with a cert/key pair coming out
      of the cryptostore store is causing some low level openssl
      problems. Don't know how easy it is fix, but most likely it's not
      inside the OpenVPN code...
      <br>
      <br>
    </blockquote>
    Pretty easy (for OpenSSL standards...). You have to use the lowlevel
    functions instead of rsa_sign. See also
<a class="moz-txt-link-freetext" href="https://code.google.com/p/ics-openvpn/source/browse/main/jni/jbcrypto.cpp">https://code.google.com/p/ics-openvpn/source/browse/main/jni/jbcrypto.cpp</a><br>
    <br>
    Basically for ics-openvpn the change was to replace<br>
    <br>
    <meta charset="utf-8">
    RSA_sign(NID_md5_sha1, (unsigned char*) data, datalen,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sigret, &amp;siglen, pkey-&gt;pkey.rsa) &lt;= 0 )<br>
    <br>
    with<br>
    <br>
    &nbsp;&nbsp;&nbsp; siglen = RSA_private_encrypt(datalen,(unsigned char*)
    data,sigret,pkey-&gt;pkey.rsa,RSA_PKCS1_PADDING);<br>
    <br>
    But I haven't looked at the OpenVPN source code yet which code path
    is called there.<br>
    <br>
    Arne<br>
  </body>
</html>

--------------020209040602060102060901--

