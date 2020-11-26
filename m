References: <tencent_634348984485969552F3189D5284B3FD7C08@...1414...>
 <CAAUX2SVnf4dr8FNsgNXbFiRMK1VWQQJWE-JUmDPs4VgzcPsDaA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fdf4b3e6-6130-04c4-7f4e-7f249d5db3ea@...1227...>
Date: Thu, 26 Nov 2020 11:40:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SVnf4dr8FNsgNXbFiRMK1VWQQJWE-JUmDPs4VgzcPsDaA@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>, Antonio Quartulli <a@...2181...>, lev@...515..., openvpn-devel@lists.sourceforge.net

Am 26.11.20 um 10:41 schrieb Tony He:
> Hi Arne,
> 
>>Since the original thread was not on the mailing list I am missing your
>>goal but if your crypto acelator already works with OpenSSL, then it
>>will also work with the "normal" OpenVPN
> 
> Yes, it wokrs with "normal" OpenVPN(OpenVPN2), but according to the test
> result, it's still not fast(about 60Mbps).
> The bottleneck is not encryption operation any more. It comes from the
> switch of user space and kernel space in the OpenVPN2,
> which makes the poor CPU of  embedded device very busy. That's why we
> need OpenVPN3 running in the kernel space.


What numbers are we are talking in crypto speed? Could you provide from
your "poor" device:


openssl speed -evp aes-128-cbc
openssl speed -evp aes-128-gcm
openssl speed -evp aes-128-ccm
openssl speed -evp sha1
openssl speed -evp chacha20-poly1305

I want to what difference/gain in terms of raw crypto speed we are
talking here.

Arne



