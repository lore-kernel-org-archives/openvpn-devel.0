From: Kristof Provost <kprovost@...2661...>
Date: Mon, 12 Sep 2022 14:43:09 +0200
Message-ID: <F65A9C36-1FA7-44E2-8A13-8573DD3FEAA7@...2661...>
In-Reply-To: <Yx8hkCs4tOK5+dBl@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
 <YvVwcBtzGagtUgOA@...1296...>
 <8E0AADE4-350B-46A5-B4BD-5E97ADA642F4@...2661...>
 <YveWP9xh9XwsjwPY@...1296...> <Yve0gy+SuH+7unUj@...1296...>
 <7CB2FF09-EE1D-427E-BBD1-4128EAE1ED4A@...2661...>
 <Yx8hkCs4tOK5+dBl@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] big packet loss with FreeBSD DCO
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

On 12 Sep 2022, at 14:09, Gert Doering wrote:
> it *does* bump the outside packet length up by +16 bytes ("bad length 151=
2" ->
> "1528").  Smells cipher algorithm padding or so - but why 16?  And why pad
> at all (AES-256-GCM used, so I think we should not pad)?
>
I would still expect padding. AES will operate on 16 byte blocks, so no mat=
ter the block chaining mode we=E2=80=99re going to have that multiple-of-16=
-bytes thing.

> Sep 12 08:01:59 phillip tun-udp-p2mp[52730]: freebsd-14-amd64/194.97.140.=
5:14894 tun packet too large on write (tried=3D1504,max=3D1500)
>
> this is the "I have received a packet from the network, decrypted it, and
> tried to send it onwards towards the tun interface, and it was too large".
>
> So my guess is that "something" gets confused on the sending side DCO, and
> corrupts the payload size (-> so '-s 1461' becomes '-s 1476' =3D 16 byte
> increase instead of +1, resulting in 'ip packet size 1504' on the receivi=
ng
> end).  The t_client server is running a slightly older master, which
> enforces the "mtu is 1500, so no bigger packets", newer openvpn are
> are somewhat more permissive on incoming baby giants.
>
That=E2=80=99s very interesting information. You may be closing in on the c=
ause.
What version do you run on the t_client server? Perhaps that will help me t=
o reproduce it.

> So, observation suggests "it's happening inside the DCO module".  I'll
> go instrument my kernel with printf()'s now... and will report if I find
> anything useful.
>
Thanks!

I=E2=80=99m on my way to Vienna for EuroBSDCon now, so I will be distracted=
 until early next week, but when I=E2=80=99m back I should be able to dig i=
nto this as well.

Best regards,
Kristof

