MIME-Version: 1.0
In-Reply-To: <CAKuzo_jDCHm=VLc2wuKYJaf48Duy_4dHnbvHx4StVV6PjDausw@...278...>
References: <OpenVPN/openvpn-gui/issues/9@...1714...>
 <OpenVPN/openvpn-gui/issues/9/403117394@...1714...>
 <CAKuzo_jDCHm=VLc2wuKYJaf48Duy_4dHnbvHx4StVV6PjDausw@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 6 Jul 2018 15:38:07 -0400
Message-ID: <CAEsd45Q87G=UTjt-PE29a41MFQU90_NJxmmux9=ZS=S7j=9E9A@...278...>
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] UI showing green
 connected status despite not beeing able to create a route (#9)
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
To: Selva Nair <selva.nair@...277...>
Cc: OpenVPN/openvpn-gui <reply+003cc04f98905c5e675d15f3068c3450eb0294652810b25392cf0000000117577b8f92a169ce076aec9b@...1858...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Jul 6, 2018 at 3:24 PM, Selva Nair <selva.nair@...277...> wrote:
>
> Hi,
>
> Copying the devel list as a reminder that "we" have been asking for this change for a long time :)
>
> On Fri, Jul 6, 2018 at 2:48 PM, Gert Doering <notifications@...1714...> wrote:
>>
>> Hi,
>>
>> On Fri, Jul 06, 2018 at 08:25:02AM -0700, Selva Nair wrote:
>> > Can we do something about this in openvpn core, so that the GUI can be report route errors?
>>
>> Currently when we get CONNECTED,SUCCESS we turn the icon green. If we get
>>
>> CONENCTED,ERROR we keep it amber and the state as "connecting.." even if
>>
>> the initialization sequence completes.
>> >
>> > So route errors can still be treated as non-fatal but we want to get CONNECTED,ERROR in such cases.

+1 to routing errors causing CONNECTED,ERROR (I didn't even know that
was possible). This confuses many Tunnelblick users.

I'd be happy for routing errors to cause a FATAL error as long as the
errors weren't caused by "route already exists" or something like
that. But I assume that's too much trouble.


Best regards,

Jon

