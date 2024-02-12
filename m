Content-Type: multipart/alternative;
 boundary="------------HahO0Zb8yCjPfJE4BsAzNkUB"
Message-ID: <6dd9197d-36e6-4694-8b9d-2e5d403c5835@...2525...>
Date: Mon, 12 Feb 2024 10:57:41 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20240209155109.110542-1-juliusz@...2525...>
 <5a267442-43f6-423a-9112-24b53cb5ca2e@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
In-Reply-To: <5a267442-43f6-423a-9112-24b53cb5ca2e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] wolfssl: include "ssl.h" by
 "src/openvpn/ssl.h"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------HahO0Zb8yCjPfJE4BsAzNkUB
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Arne,

commit 70b39f2bea9fd6e57f31e32b2041246731140cb2 has added the use of 
ACK_SIZE and RELIABLE_ACK_SIZE in test_ssl.c. These are defined in 
reliable.h which should be included through your ssl.h. Since our ssl.h 
is being picked up, these never get defined and make check results in 
the following error:

test_ssl.c: In function ‘init_frame_parameters’:
test_ssl.c:160:17: warning: implicit declaration of function ‘ACK_SIZE’ 
[-Wimplicit-function-declaration]
   160 |     overhead += ACK_SIZE(RELIABLE_ACK_SIZE);
       |                 ^~~~~~~~
test_ssl.c:160:26: error: ‘RELIABLE_ACK_SIZE’ undeclared (first use in 
this function)
   160 |     overhead += ACK_SIZE(RELIABLE_ACK_SIZE);
       |                          ^~~~~~~~~~~~~~~~~

Somehow, this has never come up as an issue.

Sincerely
Juliusz Sosinowicz

On 09/02/2024 21:50, Arne Schwabe wrote:
> Am 09.02.24 um 16:51 schrieb Juliusz Sosinowicz:
>> Including "ssl.h" conflicts with the wolfSSL ssl.h header file. The 
>> include/wolfssl directory is included before openvpn/src. 
>> include/wolfssl needs to be included so that openvpn can pick up 
>> wolfSSL compatibility headers instead of OpenSSL headers without 
>> changing the paths.
>
> Neither the ssl.h (2005, so forever) in OpenVPN nor the ssl.h in 
> wolfssl (2014 according to git blame) are particulary new. Why is this 
> now a problem when it was never before?
>
> Arne
>
--------------HahO0Zb8yCjPfJE4BsAzNkUB
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Arne,</p>
    <p>commit 70b39f2bea9fd6e57f31e32b2041246731140cb2 has added the use
      of ACK_SIZE and RELIABLE_ACK_SIZE in test_ssl.c. These are defined
      in reliable.h which should be included through your ssl.h. Since
      our ssl.h is being picked up, these never get defined and make
      check results in the following error:</p>
    <p><font size="4" face="monospace">test_ssl.c: In function
        ‘init_frame_parameters’:<br>
        test_ssl.c:160:17: warning: implicit declaration of function
        ‘ACK_SIZE’ [-Wimplicit-function-declaration]<br>
          160 |     overhead += ACK_SIZE(RELIABLE_ACK_SIZE);<br>
              |                 ^~~~~~~~<br>
        test_ssl.c:160:26: error: ‘RELIABLE_ACK_SIZE’ undeclared (first
        use in this function)<br>
          160 |     overhead += ACK_SIZE(RELIABLE_ACK_SIZE);<br>
              |                          ^~~~~~~~~~~~~~~~~</font></p>
    <p>Somehow, this has never come up as an issue.</p>
    <p>Sincerely<br>
      Juliusz Sosinowicz<br>
    </p>
    <div class="moz-cite-prefix">On 09/02/2024 21:50, Arne Schwabe
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:5a267442-43f6-423a-9112-24b53cb5ca2e@...1227...">Am
      09.02.24 um 16:51 schrieb Juliusz Sosinowicz:
      <br>
      <blockquote type="cite">Including "ssl.h" conflicts with the
        wolfSSL ssl.h header file. The include/wolfssl directory is
        included before openvpn/src. include/wolfssl needs to be
        included so that openvpn can pick up wolfSSL compatibility
        headers instead of OpenSSL headers without changing the paths.
        <br>
      </blockquote>
      <br>
      Neither the ssl.h (2005, so forever) in OpenVPN nor the ssl.h in
      wolfssl (2014 according to git blame) are particulary new. Why is
      this now a problem when it was never before?
      <br>
      <br>
      Arne
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------HahO0Zb8yCjPfJE4BsAzNkUB--

