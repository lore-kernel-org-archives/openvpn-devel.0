Message-ID: <4E953AAC.7070600@...515...>
Date: Wed, 12 Oct 2011 09:58:52 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <000001cc8890$9d6d35b0$d847a110$@net>	<CADKk8=uwCojh_xxuQMXGHNQNnFbFfWf0Tdp0wp9ikxHsu43vEQ@...278...>
	<4E953753.3090702@...1147...>
In-Reply-To: <4E953753.3090702@...1147...>
Subject: Re: [Openvpn-devel] VPN Connects but can't route to destinations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: Richard Francis <rfransix@...164...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

You can also use #openvpn channel on irc.freenode.net.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> Hi *,
>
> please do not use the 'openvpn-devel' mailing list for this. That=20
> mailing list is intended for developers working on patches, bugs and new=
=20
> versions of OpenVPN.
>
> Setup questions (like the one Richard is asking) are best sent to the=20
> openvpn-users@lists.sourceforge.net mailing list, or ask a question on=20
> the OpenVPN forum at https://forums.openvpn.net/
>
> thanks,
>
> JJK
>
> anjini shukla wrote:
>> You need to set up IP masquerading, it is simple for linux machines:
>> iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
>> for windows you require to set up ICS which can be done using windows UI
>>
>> On Tue, Oct 11, 2011 at 8:39 PM, Richard Francis <rfransix@...164...=20
>> <mailto:rfransix@...164...>> wrote:
>>
>>=20=20=20=20=20=20
>>
>>     Hi,
>>
>>=20=20=20=20=20=20
>>
>>     I=92ve configured an openvpn TAP-Win32 Adapter V9 with an ip address
>>     of 12.0.0.2, subnet mask of 255.0.0.0, DHCP of 12.0.0.0, and DNS
>>     of 10.0.0.222.
>>
>>=20=20=20=20=20=20
>>
>>     After I connect, I can only ping 10.0.0.222, nothing else on the
>>     10.x.x.x network.
>>
>>=20=20=20=20=20=20
>>
>>     And to get to .222, I had to, route add 10.0.0.0 MASK 255.0.0.0
>>     12.0.0.2 METRIC 30 to get there.
>>
>>=20=20=20=20=20=20
>>
>>     What am I missing?
>>
>
> -------------------------------------------------------------------------=
-----
> All the data continuously generated in your IT infrastructure contains a
> definitive record of customers, application performance, security
> threats, fraudulent activity and more. Splunk takes this data and makes
> sense of it. Business sense. IT sense. Common sense.
> http://p.sf.net/sfu/splunk-d2d-oct
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


