Message-ID: <6842604fe080c80b5c6d75255f695223.squirrel@...2556...>
In-Reply-To: <218595a3-086a-ae93-d4dc-bb1866c86290@...1227...>
References: <E1lRfR7-0007jN-Go@...2479...>
 <34084543aaf50252f6b2749cb0206d9e.squirrel@...2260...>
 <218595a3-086a-ae93-d4dc-bb1866c86290@...1227...>
Date: Thu, 1 Apr 2021 08:20:48 +0200
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
To: Arne Schwabe <arne@...1227...>
Cc: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

>
> Am 31.03.2021 um 21:39 schrieb Simon Matter:
>>> This is my second attempt at sending this patch, this time without
>>> mixing up commit message and cover letter, and from an account that
>>> (I hope) doesn't hate mailing lists.
>>>
>>> This patch changes reliable_send() to resend a packet if at least three
>>> later packets have been ACKed. This improves performance when there are
>>> small amounts of packet loss.
>>>
>>> The patch was originally written by Steffan Karger for OpenVPN-NL.
>>> I added some comments as suggested by Arne Schwabe.
>>>
>>> Steffan Karger (1):
>>>    reliable: retransmit if 3 follow-up ACKs are received
>>>
>> Hi Max,
>>
>> Just a shy question, am I right that this will work with UDP
>> connections?
>>
>> If so then I'm interested to test it.
>
> Yes. But it only affects the control channel. For data channel we never
> do retransmits.

OK, but it still could help in case of things like VoIP UDP over OpenVPN
UDP with lots of small packets going over the link with low package loss?

Simon


