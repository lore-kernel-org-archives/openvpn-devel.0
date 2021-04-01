Message-ID: <e1b4d7c5488de44c3b046eee386d9bec.squirrel@...2556...>
In-Reply-To: <20210401062622.GG976@...1296...>
References: <E1lRfR7-0007jN-Go@...2479...>
 <34084543aaf50252f6b2749cb0206d9e.squirrel@...2260...>
 <218595a3-086a-ae93-d4dc-bb1866c86290@...1227...>
 <6842604fe080c80b5c6d75255f695223.squirrel@...2556...>
 <20210401062622.GG976@...1296...>
Date: Thu, 1 Apr 2021 08:28:33 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 0/1] reliable: retransmit if 3 follow-up
 ACKs are received
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Thu, Apr 01, 2021 at 08:20:48AM +0200, Simon Matter wrote:
>> > Yes. But it only affects the control channel. For data channel we
>> never
>> > do retransmits.
>>
>> OK, but it still could help in case of things like VoIP UDP over OpenVPN
>> UDP with lots of small packets going over the link with low package
>> loss?
>
> No, because VoIP-over-OpenVPN would be "data channel".
>
> It would help with "control channel handshake takes very long due to
> packet
> loss".
>
> There's a different patchset floating around (I think it's a PR, actually)
> that promises to add data-channel redundancy and being able to recover
> some
> amount of packet loss without retransmit.  Which I find very interesting,
> but this has not been followed up due to "it's complex and nobody has
> time"
> reasons.
>
> gert

Thanks for the explanation!

Simon


