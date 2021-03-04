References: <CAAUX2SWYWhU-S97Ak-6XdAVQ+hty_Y8RHu_KSM8hZPiKaP7a1w@...278...>
 <e9f619bb-bd36-c77a-5f66-e7c33f6be579@...1227...>
 <CAAUX2SVde3STTxGmthXod2-pDzLPYkm+yRYvG1T4yyJGoLMKLw@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <63cfcb94-6060-9d45-66f8-6dbfd69d7dd9@...2181...>
Date: Thu, 4 Mar 2021 08:48:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SVde3STTxGmthXod2-pDzLPYkm+yRYvG1T4yyJGoLMKLw@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Segmentation fault in OpenVPN 2.6_git
 [git:dco/fcc852a9b2ea832c]
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
To: Tony He <huangya90@...277...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Tony,

On 04/03/2021 03:10, Tony He wrote:
> 
> Arne Schwabe <arne@...1227... <mailto:arne@...1227...>> 于2021年3月3日
> 周三 下午7:56写道：
> 
>     Am 03.03.21 um 08:46 schrieb Tony He:
>     > Hi Arne,
>     >
>     > I encountered segmentation fault in your dco branch. Master branch is
>     > OK. I reverted the commit "Linux data-channel offload support", but it
>     > still happens.
>     > Anything wrong? Can you reproduce?
> 
>     OpenVPN without any encryption or TLS is not something I tested.
>     Consider this obscure mode broken as part of being a preview release.
> 
> 
> So can you reproduce this issue at your side? Did you just test static
> key? Can you paste your commands or configurations？

What Arne meant is that, given the following message in your log,

******* WARNING *******: All encryption and authentication features
disabled -- All data will be tunnelled as clear text and will not be
protected against man-in-the-middle changes. PLEASE DO RECONSIDER THIS
CONFIGURATION!

it appears that you are testing *without* any form of encryption.
This special case is untested at the moment.

A classic configuration with CA/certs/keys should work.
Have you tried that?

Regards,

>  
> 
>     Thanks for the report.
> 
>     Arne
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

