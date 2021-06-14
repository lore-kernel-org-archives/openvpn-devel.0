References: <f40e6882-da83-ae0a-2230-ab1cbbe3d0c1@...2181...>
 <50df7743-5541-40dd-c2ea-f81e3ad9c29c@...1227...>
 <3ba00502-4919-b866-451f-0ae215e6a170@...2181...>
 <5a4c873d-5bc0-2852-0e9f-612031796919@...1227...>
 <24f1514f-c203-aebe-9e88-131cb7a6f594@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <835f099d-56ad-ee13-9c2b-431514402a71@...1227...>
Date: Mon, 14 Jun 2021 15:58:58 +0200
MIME-Version: 1.0
In-Reply-To: <24f1514f-c203-aebe-9e88-131cb7a6f594@...2181...>
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
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

> 
> Ok, after clarifying in chat, I understood that the time needed by a
> peer to elect a key as "usable" is defined by auth_deferred_expire_window().
> 
> If reneg-sec is smaller than hand-window (which is 60s by default) then
> we can have this particular situation.
> 
> Now, we are assuming that hand-window is always the same on both peers
> (client and server), but actually this value may also be customized and
> mess everything up.
> 
> Changing hand-window on one peer only is not a good idea in any case.
> 
> At this point I'd ask, why not re-moving/ignoring --hand-window entirely
> and live with the 60s default?


That is one of the many question why so many protocol things in OpenVPN
are finetunable in the first place. We can certainly add warnings when
setting these saying that this option should be only used for debugging.
And do the same for reneg-sec when set < 120 (or more accurately
2*hand-window)

Arne

