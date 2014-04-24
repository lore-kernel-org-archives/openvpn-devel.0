Message-ID: <5358C5C0.6090007@...1901...>
Date: Thu, 24 Apr 2014 04:05:20 -0400
From: Timothe Litt <litt@...1901...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...> <20140423081058.GJ16637@...1296...>
	<53579C5D.5000902@...1435...> <5357DDFC.2010401@...1901...>
	<53581D43.6060501@...1856...> <53584B0C.8020209@...1901...>
	<20140424070116.GN16637@...1296...>
In-Reply-To: <20140424070116.GN16637@...1296...>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms050906010601050807090109"
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms050906010601050807090109
Content-Type: multipart/alternative;
	boundary="------------090605000705060906030300"

This is a multi-part message in MIME format.
--------------090605000705060906030300
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

> Uh, this is a double misinformation :-)
It's good to know that cross-compiling is an option, though=20
cross-debugging (e.g. with an interactive debugger) can be an adventure too.

Source of my comment was:

http://community.openvpn.net/openvpn/wiki/BuildingOnWindows, which says
> his new build system allows building OpenVPN on Windows more easily,=20
> but some parts of the build may r*equire a commercial version of the=20
> Visual Studio development environment.*
> /Visual Studio 2008 Professional/is used to build OpenVPN on Windows.=20
> Note that the free Express edition might not work.
> Full installation installs*/x86 cross-tools/*which *may cause nasty,=20
> hard to debug issues*.
(The professional tools are > $1,000 US, which is not in my budget.)

You may want to reword that after validating your comment.  M$'s name=20
for the 'free' tools is 'express edition'.  The license terms vary based=20
on M$'s whims, the current statement is:
> http://www.visualstudio.com/products/visual-studio-express-vs
> Visual Studio Express products are available at no charge and may be=20
> used for commercial, production usage subject to the license terms=20
> provided with each product. For example, you can use Express for=20
> Windows to create apps that you can then submit for sale in the=20
> Windows Store.
The current version requires at least windows 7 and a 2.2GHz+=20
processor.  (My XP laptop won't do.)
The 2008 Express edition=20
(http://www.microsoft.com/en-us/download/confirmation.aspx?id=3D7940) is=20
also a resource hog.
It doesn't include all of the templates and other files needed to make=20
many kinds of applications, though it is serviceable.

I do run these on a windows 7 machine, but can't reconfigure them just=20
for debugging OpenVPN.

In any case, I think that we have found root cause of this issue the=20
old-fashioned way - code inspection based on some debugging I did on the=20
server and a hint from Steffan.

It seems that the cryptoapi interface (and probably other external key=20
loaders, such as pkcs11 according to James) has not be updated for=20
TLS1.2.  TLS1.2 adds some new signatures.  The error that I saw comes -=20
I believe - from code that sanity checks the requested hash size against=20
the generated hash size; cryptoapi only knows how to generate md5/sha1=20
signatures.

This makes it clear that:
   - the key loaders need to be updated for TLS1.2  This includes the=20
cryptoAPI on windows, pkcs11, and the cert stores on other platforms=20
(IOS, Android, Mac - if that's ever merged).
   - There does need to be a way to specify a maximum TLS version (1.1=20
will do in this case)
   - I'm inclined to have components, such as the key loaders, specify=20
their min/max requirements so that if you specify an option (e.g.=20
cryptoapicert), the auto-negotiation does the right thing=20
transparently.  And as things get fixed, the auto-negotiation will=20
upgrade to higher security.  A quick fix would be for the options=20
invoking these features to adjust & lock the version max (and I suppose=20
min) value - that's all in options.h,c.  Long term, a more expressive=20
API would be better.

James is suggesting that --tls-version-{min,max} should be the only=20
controls.  The advantage is that the code is localized; the disadvantage=20
is that the config file writer gets involved.  And since once 'things=20
work' they aren't changed, I suspect people will tend to stay with less=20
secure configurations forever. Especially on the client end.

I'll leave sorting that out to you folks.

Timothe Litt
ACM Distinguished Engineer
--------------------------
This communication may not represent the ACM or my employer's views,
if any, on the matters discussed.

On 24-Apr-14 03:01, Gert Doering wrote:
> Hi,
>
> On Wed, Apr 23, 2014 at 07:21:48PM -0400, Timothe Litt wrote:
>> As I can't build the windows client (it's really annoying that it
>> requires commercial tools), further debug will need help from folks who =
can.
> Uh, this is a double misinformation :-)
>
>   - you can build with MSVC, and you can get a MSVC version for free for
>     some sort of "non-commercial use" (I'm not sure about the exact terms=
) -
>     but you don't really want that, as building on windows is more painful
>     than the alternative
>
>   - you build with mingw64 on linux, see here:
>
> https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem
>
>     (basically cross-compiling).  It's still not as easy as building on
>     the linux target platform, but I find it much easier than with MSVC.
>
> gert
>


--------------090605000705060906030300
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">
      <blockquote type=3D"cite">
        <pre wrap=3D"">Uh, this is a double misinformation :-)
</pre>
      </blockquote>
      It's good to know that cross-compiling is an option, though
      cross-debugging (e.g. with an interactive debugger) can be an
      adventure too.<br>
      <br>
      Source of my comment was:<br>
      <br>
      <a class=3D"moz-txt-link-freetext"
        href=3D"http://community.openvpn.net/openvpn/wiki/BuildingOnWindows=
">http://community.openvpn.net/openvpn/wiki/BuildingOnWindows</a>,
      which says<br>
      <blockquote type=3D"cite"><span style=3D"color: rgb(0, 0, 0);
          font-family: Verdana, Arial, 'Bitstream Vera Sans', Helvetica,
          sans-serif; font-size: 13px; font-style: normal; font-variant:
          normal; font-weight: normal; letter-spacing: normal;
          line-height: normal; orphans: auto; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          widows: auto; word-spacing: 0px; -webkit-text-stroke-width:
          0px; background-color: rgb(255, 255, 255); display: inline
          !important; float: none;">his new build system allows building
          OpenVPN on Windows more easily, but some parts of the build
          may r<b>equire a commercial version of the Visual Studio
            development environment.</b> <br>
        </span></blockquote>
      <blockquote type=3D"cite"><em style=3D"color: rgb(0, 0, 0);
          font-family: Verdana, Arial, 'Bitstream Vera Sans', Helvetica,
          sans-serif; font-size: 13px; font-variant: normal;
          font-weight: normal; letter-spacing: normal; line-height:
          normal; orphans: auto; text-align: left; text-indent: 0px;
          text-transform: none; white-space: normal; widows: auto;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(255, 255, 255);">Visual Studio 2008
          Professional</em><span style=3D"color: rgb(0, 0, 0);
          font-family: Verdana, Arial, 'Bitstream Vera Sans', Helvetica,
          sans-serif; font-size: 13px; font-style: normal; font-variant:
          normal; font-weight: normal; letter-spacing: normal;
          line-height: normal; orphans: auto; text-align: left;
          text-indent: 0px; text-transform: none; white-space: normal;
          widows: auto; word-spacing: 0px; -webkit-text-stroke-width:
          0px; background-color: rgb(255, 255, 255); display: inline
          !important; float: none;"><span class=3D"Apple-converted-space">&=
nbsp;</span>is

          used to build OpenVPN on Windows. <small>Note that the free
            Express edition might not work.</small><span
            class=3D"Apple-converted-space">&nbsp;</span></span></blockquot=
e>
      <blockquote type=3D"cite"><span style=3D"color: rgb(0, 0, 0);
          font-family: Verdana, Arial, 'Bitstream Vera Sans', Helvetica,
          sans-serif; font-size: 13px; font-style: normal; font-variant:
          normal; font-weight: normal; letter-spacing: normal;
          line-height: normal; orphans: auto; text-align: left;
          text-indent: 0px; text-transform: none; white-space: normal;
          widows: auto; word-spacing: 0px; -webkit-text-stroke-width:
          0px; background-color: rgb(255, 255, 255); display: inline
          !important; float: none;"><span class=3D"Apple-converted-space">&=
nbsp;</span>Full

          installation installs<span class=3D"Apple-converted-space">&nbsp;=
</span></span><b><em
            style=3D"color: rgb(0, 0, 0); font-family: Verdana, Arial,
            'Bitstream Vera Sans', Helvetica, sans-serif; font-size:
            13px; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: left; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(255,
            255, 255);">x86 cross-tools</em></b><span style=3D"color:
          rgb(0, 0, 0); font-family: Verdana, Arial, 'Bitstream Vera
          Sans', Helvetica, sans-serif; font-size: 13px; font-style:
          normal; font-variant: normal; font-weight: normal;
          letter-spacing: normal; line-height: normal; orphans: auto;
          text-align: left; text-indent: 0px; text-transform: none;
          white-space: normal; widows: auto; word-spacing: 0px;
          -webkit-text-stroke-width: 0px; background-color: rgb(255,
          255, 255); display: inline !important; float: none;"><span
            class=3D"Apple-converted-space">&nbsp;</span>which <b>may cause
            nasty, hard to debug issues</b>.<span
            class=3D"Apple-converted-space">&nbsp;</span></span></blockquot=
e>
      (The professional tools are &gt; $1,000 US, which is not in my
      budget.)<br>
      <br>
      You may want to reword that after validating your comment.&nbsp; M$'s
      name for the 'free' tools is 'express edition'.&nbsp; The license ter=
ms
      vary based on M$'s whims, the current statement is:<br>
      <blockquote type=3D"cite"><a class=3D"moz-txt-link-freetext" href=3D"=
http://www.visualstudio.com/products/visual-studio-express-vs">http://www.v=
isualstudio.com/products/visual-studio-express-vs</a></blockquote>
      <blockquote type=3D"cite"><span style=3D"color: rgb(51, 51, 51);
          font-family: 'Segoe UI', Tahoma, Helvetica, sans-serif;
          font-size: 13px; font-style: normal; font-variant: normal;
          font-weight: normal; letter-spacing: normal; line-height:
          20px; orphans: auto; text-align: start; text-indent: 0px;
          text-transform: none; white-space: normal; widows: auto;
          word-spacing: 0px; -webkit-text-stroke-width: 0px; display:
          inline !important; float: none;">Visual Studio Express
          products are available at no charge and may be used for
          commercial, production usage subject to the license terms
          provided with each product. For example, you can use Express
          for Windows to create apps that you can then submit for sale
          in the Windows Store.</span></blockquote>
      The current version requires at least windows 7 and a 2.2GHz+
      processor.&nbsp; (My XP laptop won't do.)<br>
      The 2008 Express edition
      (<a class=3D"moz-txt-link-freetext" href=3D"http://www.microsoft.com/=
en-us/download/confirmation.aspx?id=3D7940">http://www.microsoft.com/en-us/=
download/confirmation.aspx?id=3D7940</a>)
      is also a resource hog.<br>
      It doesn't include all of the templates and other files needed to
      make many kinds of applications, though it is serviceable.<br>
      <br>
      I do run these on a windows 7 machine, but can't reconfigure them
      just for debugging OpenVPN.<br>
      <br>
      In any case, I think that we have found root cause of this issue
      the old-fashioned way - code inspection based on some debugging I
      did on the server and a hint from Steffan.<br>
      <br>
      It seems that the cryptoapi interface (and probably other external
      key loaders, such as pkcs11 according to James) has not be updated
      for TLS1.2.&nbsp; TLS1.2 adds some new signatures.&nbsp; The error th=
at I
      saw comes - I believe - from code that sanity checks the requested
      hash size against the generated hash size; cryptoapi only knows
      how to generate md5/sha1 signatures.<br>
      <br>
      This makes it clear that:<br>
      &nbsp; - the key loaders need to be updated for TLS1.2&nbsp; This inc=
ludes
      the cryptoAPI on windows, pkcs11, and the cert stores on other
      platforms (IOS, Android, Mac - if that's ever merged).<br>
      &nbsp; - There does need to be a way to specify a maximum TLS version
      (1.1 will do in this case)<br>
      &nbsp; - I'm inclined to have components, such as the key loaders,
      specify their min/max requirements so that if you specify an
      option (e.g. cryptoapicert), the auto-negotiation does the right
      thing transparently.&nbsp; And as things get fixed, the
      auto-negotiation will upgrade to higher security.&nbsp; A quick fix
      would be for the options invoking these features to adjust &amp;
      lock the version max (and I suppose min) value - that's all in
      options.h,c.&nbsp; Long term, a more expressive API would be better.<=
br>
      <br>
      James is suggesting that --tls-version-{min,max} should be the
      only controls.&nbsp; The advantage is that the code is localized; the
      disadvantage is that the config file writer gets involved.&nbsp; And
      since once 'things work' they aren't changed, I suspect people
      will tend to stay with less secure configurations forever.&nbsp;
      Especially on the client end.<br>
      <br>
      I'll leave sorting that out to you folks.<br>
      <br>
      <pre class=3D"moz-signature" cols=3D"72">Timothe Litt
ACM Distinguished Engineer
--------------------------
This communication may not represent the ACM or my employer's views,
if any, on the matters discussed.=20
</pre>
      On 24-Apr-14 03:01, Gert Doering wrote:<br>
    </div>
    <blockquote cite=3D"mid:20140424070116.GN16637@...1296..."
      type=3D"cite">
      <pre wrap=3D"">Hi,

On Wed, Apr 23, 2014 at 07:21:48PM -0400, Timothe Litt wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">As I can't build the windows client (it's really ann=
oying that it=20
requires commercial tools), further debug will need help from folks who can.
</pre>
      </blockquote>
      <pre wrap=3D"">
Uh, this is a double misinformation :-)

 - you can build with MSVC, and you can get a MSVC version for free for
   some sort of "non-commercial use" (I'm not sure about the exact terms) -
   but you don't really want that, as building on windows is more painful
   than the alternative

 - you build with mingw64 on linux, see here:

<a class=3D"moz-txt-link-freetext" href=3D"https://community.openvpn.net/op=
envpn/wiki/BuildingUsingGenericBuildsystem">https://community.openvpn.net/o=
penvpn/wiki/BuildingUsingGenericBuildsystem</a>

   (basically cross-compiling).  It's still not as easy as building on
   the linux target platform, but I find it much easier than with MSVC.

gert

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------090605000705060906030300--

--------------ms050906010601050807090109
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIPDzCC
BjQwggQcoAMCAQICASAwDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDI1NVoXDTE3MTAyNDIxMDI1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMsohUWcASz7GfKrpTOM
KqANy9BV7V0igWdGxA8IU77L3aTxErQ+fcxtDYZ36Z6GH0YFn7fq5RADteP0AYzrCA+EQTfi
8q1+kA3m0nwtwXG94M5sIqsvs7lRP1aycBke/s5g9hJHryZ2acScnzczjBCAo7X1v5G3yw8M
DP2m2RCye0KfgZ4nODerZJVzhAlOD9YejvAXZqHksw56HzElVIoYSZ3q4+RJuPXXfIoyby+Y
2m1E+YzX5iCZXBx05gk6MKAW1vaw4/v2OOLy6FZH3XHHtOkzUreG//CsFnB9+uaYSlR65cdG
zTsmoIK8WH1ygoXhRBm98SD7Hf/r3FELNvUCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBSuVYNv7DHKufcd+q9rMfPIHeOsuzAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBADqp
Jw3I07QWke9plNBpxUxcffc7nUrIQpJHDci91DFG7fVhHRkMZ1J+BKg5UNUxIFJ2Z9B90Mic
c/NXcs7kPBRdn6XGO/vPc87Y6R+cWS9Nc9+fp3Enmsm94OxOwI9wn8qnr/6o3mD4noP9Jphw
UPTXwHovjavRnhUQHLfo/i2NG0XXgTHXS2Xm0kVUozXqpYpAdumMiB/vezj1QHQJDmUdPYMc
p+reg9901zkyT3fDW/ivJVv6pWtkh6Pw2ytZT7mvg7YhX3V50Nv860cV11mocUVcqBLv0gcT
+HBDYtbuvexNftwNQKD5193A7zN4vG7CTYkXxytSjKuXrpEatEiFPxWgb84nVj25SU5q/r1X
hwby6mLhkbaXslkVtwEWT3Van49rKjlK4XrUKYYWtnfzq6aSak5u0Vpxd1rY79tWhD3EdCvO
hNz/QplNa+VkIsrcp7+8ZhP1l1b2U6MaxIVteuVMD3X0vziIwr7jxYae9FZjbxlpUemqXjcC
0QaFfN7qI0JsQMALL7iGRBg7K0CoOBzECdD3fuZil5kU/LP9cr1BK31U0Uy651bFnAMMMkqh
AChIbn0ei72VnbpSsrrSdF0BAGYQ8vyHae5aCg+H75dVCV33K6FuxZrf09yTz+Vx/PkdRUYk
XmZz/OTfyJXsUOUXrym6KvI2rYpccSk5MIII0zCCB7ugAwIBAgICJtUwDQYJKoZIhvcNAQEF
BQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBD
bGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xMjA5MjUxODQyMTha
Fw0xNDA5MjcxOTIyNDJaMIGQMRkwFwYDVQQNExBPZ3RBNVhZZXZheGFkbGtKMQswCQYDVQQG
EwJVUzEWMBQGA1UECBMNTWFzc2FjaHVzZXR0czEVMBMGA1UEBxMMU291dGhib3JvdWdoMRUw
EwYDVQQDEwxUaW1vdGhlIExpdHQxIDAeBgkqhkiG9w0BCQEWEXRpbW90aGVAbGl0dHMubmV0
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA38JrSHJ7GVdQiTppuafIBrhphuLL
HAmpeAFNvUBuUUh4X8Nx4Ag03hrC/B7OWYpUJI1HgWCK/eMtKEWF7UMwFhkMeqWSdrZyb4uk
EqTf46SyyAghF6BGuuVTiptED63FwzQY2PTXCmAJviuRXoJMzlhAwzUFpsWTFhswigFLrMCn
kJ9nndqnxQmMFpD7pjJ6kFkxKz/5k1CEzAfSerWHkIOBuXFyYpDDgDFXN1+qF25HsVVw+4xT
1/tNvCEVQ9WAleUznLvWgT5sV8tTewsUiYOgSqyoHiuJCOc9YJF2pUHGZVV+WzS8YIb95ax5
5yoS+C3D3FFzl6CbcI3nc6csqkP4bNBqm96Z/WdfTV4ouoycI4N9AJ86l6/Ygjz3/juFI9ni
as8nE051hksnyCon87fyP3/NezZ9NcUYVUnki1cVhfh2cN+s79fGWbUJePjT0fmso0FVcSRp
ddLyeZladbifFG+TiQO9BFt97e16OwyFpXRIzZWnfEiG2ss51Vpv9au8RrLgBD07aKE3mzZp
xZzoZ8c/jgb1YcUyAyaVmdOk4A3eGe7c8Loa+eYIRwkbjoE6H/PKcoRNIqnYQ44zvOOONRDI
S3vBpzofVK5Ndx0NVDIvsbWEPb9ntR32taUUZ334SPN447UO3sjvItFg1oOuC1i6kL6l1vRM
GNouPvECAwEAAaOCBDcwggQzMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUJZNwH8x9MtxbZmI9AK6Jj+IELcowHwYD
VR0jBBgwFoAUrlWDb+wxyrn3HfqvazHzyB3jrLswgaYGA1UdEQSBnjCBm4ERdGltb3RoZUBs
aXR0cy5uZXSBEXRpbW90aGVAbGl0dHMubmV0gQxsaXR0QGFjbS5vcmeBDWxpdHRAaWVlZS5v
cmeBFGhvc3RtYXN0ZXJAbGl0dHMubmV0gRdsaXR0c25ldGFkbWluQGxpdHRzLm5ldIETd2lr
aWFkbWluQGxpdHRzLm5ldIESc2VjdXJpdHlAbGl0dHMubmV0MIICIQYDVR0gBIICGDCCAhQw
ggIQBgsrBgEEAYG1NwECAjCCAf8wLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2lu
dGVybWVkaWF0ZS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3Jk
aW5nIHRvIHRoZSBDbGFzcyAyIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFy
dENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3Nl
IGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggr
BgEFBQcCAjCBjzAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRM
aWFiaWxpdHkgYW5kIHdhcnJhbnRpZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdh
bCBhbmQgTGltaXRhdGlvbnMiIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQv
MC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsG
AQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIv
Y2xhc3MyL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20v
Y2VydHMvc3ViLmNsYXNzMi5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEAXJ5dj2hKDwAh3aPsYWSJdC6PE7O2
u4pZz4H1mucRf3ZLoLjrAMhtINAqrWkvfiOTWQruNpQAXL+Gb6pk5sDoSXwISbPraVMb4uCS
g++F/XTCvqfsCitXd6Jhl5dyV0pi2MwmHyrBsjsER1EwA+39av+cfoL0gKuJy5y92wRt0It8
Eu77N5HaMlDlxEXXTQWP5Q2g7IZy+/ZeeG8FjrUM/bmwyvdb3mBreKgL2mZHnG+mf09IDACG
9ogoV2xJNQ0lRHxH5NJ/XGSztQACboxl3wK/t86Vhh6i1JeaLMcJ5oaemxdATK0NZVk/hIK0
hXGzTMVw1xoP/9LSYyoRD6yypzGCBNowggTWAgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQG
A1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNh
dGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAibVMAkGBSsOAwIaBQCgggIbMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDQyNDA4MDUyMFowIwYJKoZIhvcNAQkEMRYEFIT8
MoltSSW/RIKmOtVOYjvSOclxMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgaQGCSsGAQQBgjcQBDGBljCBkzCBjDELMAkGA1UEBhMC
SUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENl
cnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJ
bnRlcm1lZGlhdGUgQ2xpZW50IENBAgIm1TCBpgYLKoZIhvcNAQkQAgsxgZaggZMwgYwxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFBy
aW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQICJtUwDQYJKoZIhvcNAQEBBQAEggIAzLwg
YoJAuICO2xE6mTXYX0t8gcfLuMvVtb8mV3PvJ/JtD+X4SVFgXu3VDbJqQkQxm/haKaWyazSe
OsgLDm9QRTUCpR8CCYRyd2YePDbkBL8HfJGpkT6cAUMZYQgWh18zrv7dh6YQgU4RJenH3B9D
Kyugy3kHq2b2v2qO9x69I7+FatPZQJonK4ywWkmy6/WyF0KZDFP/FhJGLSN0Je6cnJpmgYvh
8zbLJyxdDfmHYMtfInWv4JA5oR/ZysCWj6oY+wx1KO7stR60jOMBupmhGrDnkY3mCHUuGeDq
SH7DHepQVaVWgwKOamuOd9F2eH+NRVIrFO26/2wWGJqwNcclv0L9QQQZS0vZHGAgpBItQPGy
p+0Qo08u2284T9ZGU/JxRVbJJIE6NrqhdLPEDktb48I9oTNTSCNkTqm5kBkP1X7gGZslJabd
D0No8Ee3R6qeZKX4fZdcfzKqlHJuMoMZNqoB1mZ/fbbd9jqmhhNrwZX1ax89wy0+UYiZA+uz
Y7gu7LaRB46b+dM9AB3264LY1GO/kv3VOVh8w/FxWJxvpvWgpYvKYpDBWMn2O9dFfvPckn6M
Vh8ikZK/VimfDbiJoA4EfRrYQostLmuyi5ObaFTHYptAfMLUbeuqFYXtgbLjlw6V/AsVjJ1B
ejWZhWurLHJ/EfBdC/qxypOqpfTCUogAAAAAAAA=
--------------ms050906010601050807090109--

