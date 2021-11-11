References: <YYfa3rAEKJKQ4RpK@...1296...>
 <CAFChrgKoORqRzTsDx8GJy-V+WyDaMsVAw=oDsXvaHhnomH9Bhw@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <c7fb6804-3e3d-b341-e207-754c468792bd@...1147...>
Date: Thu, 11 Nov 2021 09:36:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAFChrgKoORqRzTsDx8GJy-V+WyDaMsVAw=oDsXvaHhnomH9Bhw@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [Openvpn-users] NTLMv1,
 NTLMv2 HTTP proxy support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Jason Haar <jason_haar@...1490...>, openvpn-devel@lists.sourceforge.net

Hi Jason,

On 09/11/21 09:37, Jason Haar wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> How about ditching the NTLM and adding HTTPS proxy support instead? ;-)
> Does the privacy aspect of talking to proxies "properly" of course (Basic
> is fine over HTTPS)
>
> (and accidentally makes openvpn-over-TCP look like real TLS traffic too...)

this was also discussed at the OpenVPN Hackathon last weekend; I have 
code laying around for it
   https://github.com/jjkeijser/connect-proxy/
which allows you to run a separate HTTPS proxy and then connect OpenVPN 
to it using  127.0.0.1:<some port>

This needs to be integrated into OpenVPN in some form - I think we 
decided to use the (delayed-then-forgotten) transport obfuscation plugin 
for this. We talked about it a few years ago, but it was never fully 
implemented.

@Gert, list:  who was working on this and who still has the code for the 
transport obfuscation plugin ?  would be a good clean-up project to move 
all proxy (socks, http AND https) code into this plugin.

cheers,

JJK

> On 2021-11-07 at 13:55, gert@...1296... wrote:
>> Hi Community,
>>
>> OpenVPN supports HTTP proxies that require NTLM authentication,
>> supporting NTLMv1 and NTLMv2 protocols.
>>
>> This is old code, which was written in the dark ages, is not currently
>> unit/client tested, and uses DES which got deprecated in OpenSSL 3.0.0...
>>
>> That said, if people still *use* it, we are likely to keep it - otherwise
>> it might just become lost :-)
>>
>> So - if you use HTTP proxy in OpenVPN, and that proxy authenticates
>> against a Windows AD domain, and you use NTLMv1 or NTLMv2 authentication,
>> please speak up and tell us about your use case!
>>


