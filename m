MIME-Version: 1.0
In-Reply-To: <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
References: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
 <20180727192636.GK55859@...1296...>
 <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 28 Jul 2018 22:56:48 -0400
Message-ID: <CAKuzo_hpbaD3f4ZOcP_rBpkRpkHW=4HvE9Gw4g4umohk+e7NFA@...278...>
Subject: Re: [Openvpn-devel] Set interface metric instead letting it on auto
 (OS choice) when we have redirect-gateway present to enforce the desired
 effect for IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: s7r@...2137...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Sat, Jul 28, 2018 at 9:46 PM, s7r <s7r@...2137...> wrote:
> Gert Doering wrote:
>> HI,
>>
>> On Fri, Jul 27, 2018 at 05:57:14PM +0300, s7r wrote:
>>> I have run into a problem which raised my attention. I am not sure if I
>>> can call this a bug, but I think it's best to discuss here and decide if
>>> it should be addressed in OpenVPN or let it as it is at operating system
>>> layer.
>>
>> It's always much more interesting if the OS in question is not mentioned at
>> all... :-)
>>
>> gert
>>
>
> Hello,
>
> Sorry - I have missed this information because I thought it's irrelevant
> and it should apply to _any_ operating system, if it is to be applied at
> all. The OS where I experienced the behavior is Windows 10 Enterprise
> (64 bit) all up to date with OpenVPN community version 2.4.6-l602, vpn
> client running in UDP mode.
>
> Hope this information is sufficient.

Not really. Sounds like DNS resolution is changing with metric of the
interface which very much points to a WIndows only behaviour.

And, in that case whether a DNS server is set on the tun interface and
which DNS server gets used when its "working" as expected and when its
"not working" would be relevant. Also whether block-outside-dns is in
use.

Selva

