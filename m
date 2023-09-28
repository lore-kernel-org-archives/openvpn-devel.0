Content-Type: multipart/alternative;
 boundary="------------afnKzVkUEIrXfr0uURNKxLti"
Message-ID: <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
Date: Thu, 28 Sep 2023 19:08:26 -0400
MIME-Version: 1.0
Content-Language: en-US
References: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
 <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
From: mike tancsa <mike@...1800...>
In-Reply-To: <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
Subject: Re: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------afnKzVkUEIrXfr0uURNKxLti
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Selva,

     Thank you for looking!


> My guess is that something in the certificate or private key is not to
> OpenSSL 3.1's liking and it rejects it. Is there any way for you to 
> check the
> contents of the token independently using a tool linked against 
> OpenSSL 3.1 ?
>
What am I looking for in that case ?  Taking a look at the cert just 
with openssl 3.0 on FreeBSD releng14 it seems ok with it. Same with the 
Windows version 3.1.x that comes with OpenVPN. Is it possible it doesnt 
like the sha1RSA sig ?

# openssl version
OpenSSL 3.0.10 1 Aug 2023 (Library: OpenSSL 3.0.10 1 Aug 2023)
#

Certificate:
     Data:
         Version: 3 (0x2)
         Serial Number: 7109 (0x1bc5)
         Signature Algorithm: sha1WithRSAEncryption
         Issuer: C = CA, ST = ON, L = Cambridge, O = Sentex CA, CN = 
Sentex private1test CA CA, emailAddress = mike@...2750...
         Validity
             Not Before: Sep 27 19:43:01 2023 GMT
             Not After : Nov 13 19:43:01 2033 GMT
         Subject: C = CA, ST = ON, L = Cambridge, O = Sentex CA, OU = 
win10, CN = test123456mdt, emailAddress = mike@...2750...
         Subject Public Key Info:
             Public Key Algorithm: rsaEncryption
                 Public-Key: (2048 bit)
                 Modulus:
                     00:f5:e0:27:b5:28:0a:f8:a9:ce:13:33:a2:ca:27:

...

                     ac:a8:b6:55:bb:a3:a4:43:e5:74:05:aa:c8:69:3d:
                     ed:ef
                 Exponent: 65537 (0x10001)
         X509v3 extensions:
             X509v3 Basic Constraints:
                 CA:FALSE
             Netscape Comment:
                 Easy-RSA Generated Certificate
             X509v3 Subject Key Identifier:
74:72:3A:87:0D:34:7B:1E:11:C6:18:D2:41:99:C6:5E:D1:8A:81:95
             X509v3 Authority Key Identifier:
keyid:4F:A0:B0:94:92:6F:24:A7:D4:C6:93:A6:AA:25:63:6C:ED:1E:E3:8C
                 DirName:/C=CA/ST=ON/L=Cambridge/O=Sentex Parklands 
CA/CN=Sentex Parklands CA CA/emailAddress=ppsupport@...2750...
                 serial:F5:3E:37:76:69:AC:EF:EC
             X509v3 Extended Key Usage:
                 TLS Web Client Authentication
             X509v3 Key Usage:
                 Digital Signature
     Signature Algorithm: sha1WithRSAEncryption
     Signature Value:
         10:72:36:db:5c:f3:f5:fb:52:82:c7:4c:72:8f:31:ae:

--------------afnKzVkUEIrXfr0uURNKxLti
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Selva,</p>
    <p>    Thank you for looking!<br>
    </p>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...">
      <div dir="ltr">
        <div class="gmail_quote">
          <div>My guess is that something in the certificate or private
            key is not to</div>
          <div>OpenSSL 3.1's liking and it rejects it. Is there any way
            for you to check the</div>
          <div>contents of the token independently using a tool linked
            against OpenSSL 3.1 ?</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>What am I looking for in that case ?  Taking a look at the cert
      just with openssl 3.0 on FreeBSD releng14 it seems ok with it.
      Same with the Windows version 3.1.x that comes with OpenVPN. Is it
      possible it doesnt like the sha1RSA sig ?<br>
    </p>
    <p># openssl version<br>
      OpenSSL 3.0.10 1 Aug 2023 (Library: OpenSSL 3.0.10 1 Aug 2023)<br>
      # <br>
    </p>
    <p>Certificate:<br>
          Data:<br>
              Version: 3 (0x2)<br>
              Serial Number: 7109 (0x1bc5)<br>
              Signature Algorithm: sha1WithRSAEncryption<br>
              Issuer: C = CA, ST = ON, L = Cambridge, O = Sentex CA, CN
      = Sentex private1test CA CA, emailAddress = <a class="moz-txt-link-abbreviated" href="mailto:mike@...2750...">mike@...2750...</a><br>
              Validity<br>
                  Not Before: Sep 27 19:43:01 2023 GMT<br>
                  Not After : Nov 13 19:43:01 2033 GMT<br>
              Subject: C = CA, ST = ON, L = Cambridge, O = Sentex CA, OU
      = win10, CN = test123456mdt, emailAddress = <a class="moz-txt-link-abbreviated" href="mailto:mike@...2750...">mike@...2750...</a><br>
              Subject Public Key Info:<br>
                  Public Key Algorithm: rsaEncryption<br>
                      Public-Key: (2048 bit)<br>
                      Modulus:<br>
                          00:f5:e0:27:b5:28:0a:f8:a9:ce:13:33:a2:ca:27:</p>
    <p>...</p>
    <p>                    ac:a8:b6:55:bb:a3:a4:43:e5:74:05:aa:c8:69:3d:<br>
                          ed:ef<br>
                      Exponent: 65537 (0x10001)<br>
              X509v3 extensions:<br>
                  X509v3 Basic Constraints: <br>
                      CA:FALSE<br>
                  Netscape Comment: <br>
                      Easy-RSA Generated Certificate<br>
                  X509v3 Subject Key Identifier: <br>
                     
      74:72:3A:87:0D:34:7B:1E:11:C6:18:D2:41:99:C6:5E:D1:8A:81:95<br>
                  X509v3 Authority Key Identifier: <br>
                     
      keyid:4F:A0:B0:94:92:6F:24:A7:D4:C6:93:A6:AA:25:63:6C:ED:1E:E3:8C<br>
                      DirName:/C=CA/ST=ON/L=Cambridge/O=Sentex Parklands
      CA/CN=Sentex Parklands CA <a class="moz-txt-link-abbreviated" href="mailto:CA/emailAddress=ppsupport@...2750...">CA/emailAddress=ppsupport@...2750...</a><br>
                      serial:F5:3E:37:76:69:AC:EF:EC<br>
                  X509v3 Extended Key Usage: <br>
                      TLS Web Client Authentication<br>
                  X509v3 Key Usage: <br>
                      Digital Signature<br>
          Signature Algorithm: sha1WithRSAEncryption<br>
          Signature Value:<br>
              10:72:36:db:5c:f3:f5:fb:52:82:c7:4c:72:8f:31:ae:<br>
    </p>
  </body>
</html>

--------------afnKzVkUEIrXfr0uURNKxLti--

