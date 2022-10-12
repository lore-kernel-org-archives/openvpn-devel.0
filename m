From: Kristof Provost <kp@...1376...>
Date: Wed, 12 Oct 2022 17:17:38 +0200
Message-ID: <C8B6F43B-6575-4332-B11B-FEAAD54DD512@...1376...>
In-Reply-To: <Y0bRartX32suvWIb@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
 <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
 <Yz72rrCsJCjBgE4T@...1296...>
 <3B9F182D-0936-4799-B1B0-D269DBB3C2E6@...1376...>
 <Yz/35K6JddVNg9F9@...1296...> <Y0W/3bWLuTuYZvxs@...1296...>
 <Y0ZhI7jZ0/aXQ4l0@...1296...> <Y0bRartX32suvWIb@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

I=E2=80=99m still travelling today (and am due for my 5G chip update tomorr=
ow), so it=E2=80=99ll be another day or two before I can look at this in an=
y detail, but at first glance this looks sane.

Best regards,
Kristof

On 12 Oct 2022, at 15:38, Gert Doering wrote:
> Hi,
>
> people have alreadycomplained at me that I write so long e-mails today,
> so I can write more...
>
> On Wed, Oct 12, 2022 at 08:39:31AM +0200, Gert Doering wrote:
>> Factor 1: single-peer (client or p2p) vs. multi-peer
>>
>>  single-peer -> DCO has only 1 peer, all packets that go into the
>>                 tun/dco interface are sent out to the single peer
>>                 ("dumb pipe mode") - exactly like tun(4) behaves
>>
>>                 If a subnet is configured on the interface, packets to
>>                 ALL IPs (!=3D local) in that subnet are sent to the other
>>                 side.  No next-hop lookup is done.
>
> This is "sort of" handled in if_ovpn.c today
>
> ovpn_route_peer(struct ovpn_softc *sc, struct mbuf **m0,
>     const struct sockaddr *dst)
> {
> ...
>         /* Shortcut if we're a client (or are a server and have only one =
client). */
>         if (sc->peercount =3D=3D 1)
>                 return (ovpn_find_only_peer(sc));
>
>
> ... so this works for the client, but has one interesting drawback on the
> server - if there is only a single client connected, the server will send
> ALL to-be-tunneled packets to that client.  As soon as client #2 connects,
> packets are properly sorted.
>
> [..]
>> Factor 2: IFF_POINTOPOINT vs. IFF_BROADCAST
>>
>>  This seems to be a *BSD-specific thing, aka "there is nothing in the
>>  Linux specific code that seems to bother with this".
>
> I've whacked at if_ovpn.c and dco_freebsd.c a bit now, and I seem
> to have working code for both ends.  I am not a FreeBSD kernel coder,
> so I have no idea how many behavioural standards I am violating,
> but it makes "real subnet mode in OpenVPN" work for me, with DCO.
>
> Kernel patch attached, OpenVPN patches will follow soonish (outside
> of this e-mail thread).
>
> gert
> --=20
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doub=
ted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mist=
ress
>
> Gert Doering - Munich, Germany                             gert@...1296...

