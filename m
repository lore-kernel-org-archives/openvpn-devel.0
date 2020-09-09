From: "Vladislav Grishenko" <themiron@...2010...>
References: <de9db75e-98de-6a56-6f3c-6ba66f475cca@...1227...>
 <20200826165128.23117-1-themiron@...2010...>
 <e170069f-a0da-0f86-fb05-ec900e799f52@...1227...>
 <027b01d6869f$2ce27910$86a76b30$@yandex-team.ru>
 <60d933c1-5238-1d0f-91e5-b94570180531@...1227...>
In-Reply-To: <60d933c1-5238-1d0f-91e5-b94570180531@...1227...>
Date: Wed, 9 Sep 2020 19:12:56 +0500
Message-ID: <02ba01d686b3$51a11ef0$f4e35cd0$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH v2] Add DNS SRV host discovery support
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
To: 'Arne Schwabe' <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> From: Arne Schwabe
> Sent: Wednesday, September 9, 2020 5:15 PM
> > I see your point, thank you.
> > Fallback is done just to conform RFC 2782 suggestion, personally I feel=
 it's
> hardly be used with controllable client profiles when it's known that dom=
ain.tld
> does dns srv.
>=20
> Yes. And see the point in that RFC. I would rather document that for out =
fallback
> the user has to manually specify that because I don't see a good "works f=
or all"
> fallback.

Sure, I saw. RFC point of fallback was pretty valid for combined --remote f=
or seamless migration dns->srv dns.
With new --remote-srv this will be not necessary anymore, no migration here=
. Moreover, facing the coexisting with usual --remote, fallback becomes pre=
tty useless additional complexity.

>=20
> > Additional --remote-srv indeed has benefits:
> > * opens a non-conflicting syntax way to have multiple udp/tcp dns srv
> requests, as you wrote in earlier mails. This will allow to sort them all=
 by
> prio/weight.
> > * cleaner syntax for specifying custom dns srv service name, with
> > default "openvpn" and protocol (if need to limit discovery to only udp =
or tcp)
> So, in my mind syntax looks like:
> > 	--remote-srv [service] [protocol], where both args are optional, by
> > default service=3D=3Dopenvpn, protocol=3D=3Dany
>=20
> Sounds good to me!

Great, doing this way.

>=20
> > And, important thing, multiple --remote-srv still needs to be supported=
 for:
> > * custom order of protocol
> > * different service names
> > * allow to reuse --remote-random with --random-srv as well to achieve
> > dns-srv-based lb
> >
> > Is it good enough in this form?
>=20
> I don't really see the need for that but it doesn't break the normal case=
 of just
> one remote-srv, so fine with me.
>=20
> Arne
>=20

--
Best Regards, Vladislav Grishenko




