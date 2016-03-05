Message-ID: <56DA3817.5040602@...1147...>
Date: Sat, 05 Mar 2016 02:36:23 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <56D8A6C4.5080803@...2070...>
	<56DA04EE.8000200@...2070...>
In-Reply-To: <56DA04EE.8000200@...2070...>
Content-Type: multipart/alternative;
	boundary="------------040308000102010502040605"
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040308000102010502040605
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04/03/16 22:58, ValdikSS wrote:
> I have good news and bad news:
>
> Good news:
>
>   * OpenVPN sends all certificates from the server supplied for
>     --server directive (although with a small bug that a certificate
>     which you have private key for must be supplied on the top)
>   * OpenVPN Connect for Android can successfully connect to my server
>     with a chain
>
>
> Bad news:
>
>   * OpenVPN 2.3 and master can't connect to this server, with both
>     OpenSSL and PolarSSL backends. Maybe if I supply certificates in
>     correct order, client would work.
>
>
>
how did you generate the cross-signed CA certs? I've looked around but 
all cross-signing either requires you to use the same private key (i.e. 
bit size) or that you extend the trust of one CA with that of another. 
The first is of no help as the key size needs to be different. The 
second (extending trust) does not work as you'd need to install this 
cross-trust CA at the client side.  I found this interesting example on 
how to generate cross-signed certs here:
https://chromium.googlesource.com/chromium/src/net/+/master/data/ssl


JJK

> On 03/04/2016 12:04 AM, ValdikSS wrote:
>> Hello everyone,
>>
>> I'm trying to leisurely move from an old existing 1024 bit CA to a new 4096 bit one without a hassle for a clients.
>>  From a X.509 perspective it shouldn't be a problem, and I already have new CA self-signed and cross-signed with old CA, it should work just fine.
>>
>> While there's no problem authenticating clients from both old and new CA using single instance (multiple certificates in --ca are supported, this information is
>> documented), I need to send two certificates from OpenVPN server: server certificate, which is signed by new CA, and cross-signed new CA with old CA. This way
>> it should work for clients either with old or new CA in configuration files.
>>
>> I can't manage server to send more than one certificate to the client. It seems that multiple certificates in --cert directive are supported only on client
>> side. Am I missing something, is there a way to push multiple certificates from server? If there isn't a way currently, are there any protocol limitations which
>> allows only one certificate to be sent?
>>
>>
>
>
>
> ------------------------------------------------------------------------------
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------040308000102010502040605
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing2-ams.mf.surf.net id u251aOrU001601
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      On 04/03/16 22:58, ValdikSS wrote:<br>
    </div>
    <blockquote cite=3D"mid:56DA04EE.8000200@...2070..." type=3D"cite">
      <meta content=3D"text/html; charset=3Dwindows-1252"
        http-equiv=3D"Content-Type">
      I have good news and bad news:<br>
      <br>
      Good news:<br>
      <ul>
        <li>OpenVPN sends all certificates from the server supplied for
          --server directive (although with a small bug that a
          certificate which you have private key for must be supplied on
          the top)</li>
        <li>OpenVPN Connect for Android can successfully connect to my
          server with a chain</li>
      </ul>
      <br>
      Bad news:<br>
      <ul>
        <li>OpenVPN 2.3 and master can't connect to this server, with
          both OpenSSL and PolarSSL backends. Maybe if I supply
          certificates in correct order, client would work. </li>
      </ul>
      <br>
      <br>
    </blockquote>
    how did you generate the cross-signed CA certs? I've looked around
    but all cross-signing either requires you to use the same private
    key (i.e. bit size) or that you extend the trust of one CA with that
    of another. The first is of no help as the key size needs to be
    different. The second (extending trust) does not work as you'd need
    to install this cross-trust CA at the client side.=A0 I found this
    interesting example on how to generate cross-signed certs here:<br>
    =A0
    <a class=3D"moz-txt-link-freetext" href=3D"https://chromium.googlesourc=
e.com/chromium/src/net/+/master/data/ssl">https://chromium.googlesource.com=
/chromium/src/net/+/master/data/ssl</a><br>
    <br>
    <br>
    JJK<br>
    <br>
    <blockquote cite=3D"mid:56DA04EE.8000200@...2070..." type=3D"cite">
      <div class=3D"moz-cite-prefix">On 03/04/2016 12:04 AM, ValdikSS
        wrote:<br>
      </div>
      <blockquote cite=3D"mid:56D8A6C4.5080803@...2070..."
        type=3D"cite">
        <pre wrap=3D"">Hello everyone,

I'm trying to leisurely move from an old existing 1024 bit CA to a new 4096=
 bit one without a hassle for a clients.
From a X.509 perspective it shouldn't be a problem, and I already have new=
 CA self-signed and cross-signed with old CA, it should work just fine.

While there's no problem authenticating clients from both old and new CA us=
ing single instance (multiple certificates in --ca are supported, this info=
rmation is
documented), I need to send two certificates from OpenVPN server: server ce=
rtificate, which is signed by new CA, and cross-signed new CA with old CA. =
This way
it should work for clients either with old or new CA in configuration files.

I can't manage server to send more than one certificate to the client. It s=
eems that multiple certificates in --cert directive are supported only on c=
lient
side. Am I missing something, is there a way to push multiple certificates =
from server? If there isn't a way currently, are there any protocol limitat=
ions which
allows only one certificate to be sent?


</pre>
      </blockquote>
      <br>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040308000102010502040605--

