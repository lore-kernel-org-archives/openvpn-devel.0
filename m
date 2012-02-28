Message-ID: <4F4C6A50.5070103@...1550...>
Date: Tue, 28 Feb 2012 09:46:56 +0400
From: Igor Novgorodov <igor@...1550...>
MIME-Version: 1.0
References: <4F4BE07E.70603@...1550...>
	<CAP+U6tJFjY8g3bNTcjCKoU+W2hg3=kaPfYS2XGp4Lc1BUNTbAA@...278...>
In-Reply-To: <CAP+U6tJFjY8g3bNTcjCKoU+W2hg3=kaPfYS2XGp4Lc1BUNTbAA@...278...>
Content-Type: multipart/mixed; boundary="------------010100060408060601050605"
Subject: Re: [Openvpn-devel] [PATCH 01/02] Add support for PolarSSL 1.1.x
 branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010100060408060601050605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.2012 1:37, Fabian Knittel wrote:
> Hi Igor,
>
> 2012/2/27 Igor Novgorodov<igor@...1550...>:
>> The attached patch adds checking for PolarSSL version on crypto_polarssl.c
>> and depending on which version we are using (1.0.x or 1.1.x) chooses a new
>> shiny havege_random() function, or an old ugly while{} loop hack to generate
>> randomness.
> Your patch removes the code that causes havege_init() to only be
> called once. You never want to initialise your PRNG more than once,
> otherwise you increase the risk that your randomness is predictable.
> So please revert that part of your patch.
Yes, my fault. I didn't notice that the variable was static, so i though 
that it
was local-scope only and removed the check... The fixed patch is attached

> (The rest looks fine, although I haven't tested it and don't have any
> experience with PolarSSL.)
>
> Cheers
> Fabian



--------------010100060408060601050605
Content-Type: text/plain;
 name="001-polarssl-havege-random.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="001-polarssl-havege-random.patch"

LS0tIGEvY3J5cHRvX3BvbGFyc3NsLmMKKysrIGIvY3J5cHRvX3BvbGFyc3NsLmMKQEAgLTQx
LDYgKzQxLDcgQEAKICNpbmNsdWRlIDxwb2xhcnNzbC9tZDUuaD4KICNpbmNsdWRlIDxwb2xh
cnNzbC9jaXBoZXIuaD4KICNpbmNsdWRlIDxwb2xhcnNzbC9oYXZlZ2UuaD4KKyNpbmNsdWRl
IDxwb2xhcnNzbC92ZXJzaW9uLmg+CiAKIC8qCiAgKgpAQCAtMTU4LDcgKzE1OSw2IEBACiB7
CiAgIHN0YXRpYyBoYXZlZ2Vfc3RhdGUgaHMgPSB7MH07CiAgIHN0YXRpYyBib29sIGhzX2lu
aXRpYWxpc2VkID0gZmFsc2U7Ci0gIGNvbnN0IGludCBpbnRfc2l6ZSA9IHNpemVvZihpbnQp
OwogCiAgIGlmICghaHNfaW5pdGlhbGlzZWQpCiAgICAgewpAQCAtMTY3LDE1ICsxNjcsMjEg
QEAKICAgICAgIGhzX2luaXRpYWxpc2VkID0gdHJ1ZTsKICAgICB9CiAKKyNpZiAoUE9MQVJT
U0xfVkVSU0lPTl9NQUpPUiA+PSAxICYmIFBPTEFSU1NMX1ZFUlNJT05fTUlOT1IgPj0gMSkK
KyAgaGF2ZWdlX3JhbmRvbSgmaHMsIG91dHB1dCwgbGVuKTsKKyNlbHNlCisgIGNvbnN0IGlu
dCBpbnRfc2l6ZSA9IHNpemVvZihpbnQpOworCiAgIHdoaWxlIChsZW4gPiAwKQogICAgIHsK
LSAgICAgIGNvbnN0IGludCBibGVuIAk9IG1pbl9pbnQgKGxlbiwgaW50X3NpemUpOwotICAg
ICAgY29uc3QgaW50IHJhbmRfaW50IAk9IGhhdmVnZV9yYW5kKCZocyk7CisgICAgICBjb25z
dCBpbnQgYmxlbiAgICA9IG1pbl9pbnQgKGxlbiwgaW50X3NpemUpOworICAgICAgY29uc3Qg
aW50IHJhbmRfaW50ICAgICAgICA9IGhhdmVnZV9yYW5kKCZocyk7CiAKICAgICAgIG1lbWNw
eSAob3V0cHV0LCAmcmFuZF9pbnQsIGJsZW4pOwogICAgICAgb3V0cHV0ICs9IGJsZW47CiAg
ICAgICBsZW4gLT0gYmxlbjsKICAgICB9CisjZW5kaWYKICAgcmV0dXJuIDE7CiB9CiAK
--------------010100060408060601050605--

