References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SUZ3X6VUiASQePp2WCX-hr7A21B6ZW5GnFQzr8jUP0+Xw@...278...>
 <82a1a09d-e557-144f-7f08-307a11877018@...2181...>
 <CAAUX2SWjyUoZ2YLkSPNawW51Pfnjs8A4uhH8A25gX9f2MffCBg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6039e55c-46f9-723d-115c-e4d779177cd8@...1227...>
Date: Wed, 31 Mar 2021 14:10:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAAUX2SWjyUoZ2YLkSPNawW51Pfnjs8A4uhH8A25gX9f2MffCBg@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
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
To: Tony He <huangya90@...277...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 31.03.21 um 09:56 schrieb Tony He:
> 
> 
> Antonio Quartulli <a@...2181...> 于2021年3月31日周三 下午3:32写道：
> 
>     Hi,
> 
>     On 31/03/2021 09:29, Tony He wrote:
>     > Hi Arne,
>     >
>     > I'm going to test encryption "none" to narrow down this issue, but I
>     > found your dco branch doesn't support this. 
>     > Can you support?
> 
>     For the sake of this test, could you use the ovpn-cli.c tool in the
>     ovpn-dco/tests folder? Or that's not an option?
> 
> Because of cross-compilation,  I need to put ovpn-cli.c into the
> buildroot. This needs some work.
> But Arne's openvpn dco branch is already in. Anyway, I will have a try.

I updated the branch to support none but you still need to manually add
it to DCO_SUPPORTED_CIPHERS in src/openvpn/networking_linuxdco.h as we
do not want to officially support none.

Arne

