References: <f40e6882-da83-ae0a-2230-ab1cbbe3d0c1@...2181...>
 <50df7743-5541-40dd-c2ea-f81e3ad9c29c@...1227...>
 <3ba00502-4919-b866-451f-0ae215e6a170@...2181...>
 <5a4c873d-5bc0-2852-0e9f-612031796919@...1227...>
 <24f1514f-c203-aebe-9e88-131cb7a6f594@...2181...>
 <835f099d-56ad-ee13-9c2b-431514402a71@...1227...>
 <e7bc92b4-4d73-3eaa-6ea6-da2f1dfc6de3@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <aad4f854-df53-dff3-28fc-6d3f81c679e0@...1227...>
Date: Mon, 14 Jun 2021 16:26:03 +0200
MIME-Version: 1.0
In-Reply-To: <e7bc92b4-4d73-3eaa-6ea6-da2f1dfc6de3@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] TLS Error: local/remote TLS keys are out of sync
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 14.06.21 um 16:21 schrieb Antonio Quartulli:
> Hi,
> 
> On 14/06/2021 15:58, Arne Schwabe wrote:
>>> At this point I'd ask, why not re-moving/ignoring --hand-window entirely
>>> and live with the 60s default?
>>
>>
>> That is one of the many question why so many protocol things in OpenVPN
>> are finetunable in the first place. We can certainly add warnings when
>> setting these saying that this option should be only used for debugging.
>> And do the same for reneg-sec when set < 120 (or more accurately
>> 2*hand-window)
> 
> When a knob is there, no matter if for debugging or not, people will
> just use it.
> It may break things, which may create rumors, which may create support
> overhead.
> 
> IMHO going with well declared constant values (i.e. in a nicely
> commented header file), which can be easily tweaked by a developer
> before recompiling the OpenVPN, are more than enough for debugging
> (check [1] for an example).
> 
> This way you clearly make the bar for shooting yourself in the foot high
> enough so that only skilled snipers can do that.
> 

Put on the agenda for community meeting to decide if we want to
deprecate hand-window compeletely and reneg-sec under < 120?

Arne

