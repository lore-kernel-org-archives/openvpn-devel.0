Message-ID: <82bd7803ae854e39f170a11e84446e70.squirrel@...2556...>
In-Reply-To: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
Date: Wed, 31 Mar 2021 07:21:37 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
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
Content-Transfer-Encoding: quoted-printable
To: Tony He <huangya90@...277...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

> Hi Antonio,
>
> As you know I am porting opvn-dco to my router whose kernel is V4.14.76.
> After solving AF_NETLINK group issue we discussed
> yesterday.  It finally works. But I encounter another issue :-( .  When
> testing the performance with iperf3, disconnection occurs
> and recovers after a few seconds and then again.

Just a guess, could it have something to do with missing entropy?

Maybe for such tests a passthrough mode in the kernel module without
encryption could help to debug. Or, as a second option, a non encryption
mode in OpenVPN to test. I think this is or was available.

Simon


