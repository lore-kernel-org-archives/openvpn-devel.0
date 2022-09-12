From: Kristof Provost <kprovost@...2661...>
Date: Mon, 12 Sep 2022 15:41:45 +0200
Message-ID: <F8FECA50-5958-471F-A3CF-F5B0498DE272@...2661...>
In-Reply-To: <Yx8p6LeIUVUeFPMD@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
 <YvVwcBtzGagtUgOA@...1296...>
 <8E0AADE4-350B-46A5-B4BD-5E97ADA642F4@...2661...>
 <YveWP9xh9XwsjwPY@...1296...> <Yve0gy+SuH+7unUj@...1296...>
 <7CB2FF09-EE1D-427E-BBD1-4128EAE1ED4A@...2661...>
 <Yx8hkCs4tOK5+dBl@...1296...> <Yx8p6LeIUVUeFPMD@...1296...>
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

On 12 Sep 2022, at 14:45, Gert Doering wrote:
> Hi,
>
> On Mon, Sep 12, 2022 at 02:09:52PM +0200, Gert Doering wrote:
>> So, observation suggests "it's happening inside the DCO module".  I'll
>> go instrument my kernel with printf()'s now... and will report if I find
>> anything useful.
>
> ok... so at the beginning of ovpn_transmit_to_peer(), I have
>
> ping -s 1460
> Sep 12 14:36:34 fbsd14 kernel: GERT: ovpn_transmit_to_peer, tunnel_len=3D=
1488
>
> ping -s 1461
> Sep 12 14:36:43 fbsd14 kernel: GERT: ovpn_transmit_to_peer, tunnel_len=3D=
1489
>
> -> check!
>
> ... and then there is code that deals with rounding up...?!
>
> --------------- snip --------------
> printf( "GERT: ovpn_transmit_to_peer, real_len=3D%d\n", (int) real_len );
>
>         ovpn_hdr_len =3D sizeof(struct ovpn_wire_header);
>         if (key->encrypt->cipher =3D=3D OVPN_CIPHER_ALG_NONE)
>                 ovpn_hdr_len -=3D 16; /* No auth tag. */
>         else {
>                 /* Round up the len to a multiple of our block size. */
>                 len =3D roundup2(real_len, AES_BLOCK_LEN);
>
>                 /* Now extend the mbuf. */
>                 m_append(m, len - real_len, EMPTY_BUFFER);
>         }
>
> printf( "GERT: ovpn_transmit_to_peer, len=3D%d\n", (int) len );
> --------------- snip --------------
>
> and after this block:
>
> Sep 12 14:40:40 fbsd14 kernel: GERT: ovpn_transmit_to_peer, tunnel_len=3D=
1489
> Sep 12 14:40:40 fbsd14 kernel: GERT: ovpn_transmit_to_peer, real_len=3D14=
89
> Sep 12 14:40:40 fbsd14 kernel: GERT: ovpn_transmit_to_peer, len=3D1504
>
> Wohoo, 1504!  +16!
>
>
> Now, I have no idea about crypto, *and* I have no idea about OpenVPN
> wire format (Arne is the resident expert on this), but Arne tells me
> "there is no padding needed"
>
> 14:00 <@cron2__> is there padding with AES-GCM?
> 14:04 <@plaisthos> cron2__: no. AES-GCM is basically CTR and a stream cip=
her
>
> ... so, not sure what that code does.
>
> If I just kill it :-)
>
>                 /* Round up the len to a multiple of our block size. */
>                 // len =3D roundup2(real_len, AES_BLOCK_LEN);
>
> I can ping just fine...
>
> gert@...2695...:/usr/obj $ SU ping -s 1461 10.194.0.1
> PING 10.194.0.1 (10.194.0.1): 1461 data bytes
> 1469 bytes from 10.194.0.1: icmp_seq=3D0 ttl=3D64 time=3D124.774 ms
> 1469 bytes from 10.194.0.1: icmp_seq=3D1 ttl=3D64 time=3D124.930 ms
>
> and with double fragmentation too...
>
> gert@...2695...:/usr/obj $ SU ping -s 3000 10.194.0.1
> PING 10.194.0.1 (10.194.0.1): 3000 data bytes
> 3008 bytes from 10.194.0.1: icmp_seq=3D0 ttl=3D64 time=3D126.363 ms
> 3008 bytes from 10.194.0.1: icmp_seq=3D1 ttl=3D64 time=3D126.642 ms
> 3008 bytes from 10.194.0.1: icmp_seq=3D2 ttl=3D64 time=3D126.200 ms
>
>
> Now, I'm not submitting a patch for that, because usually there is
> a good reason for rounding up and doing blocks and all that - so, I
> found the offending lines, but do not feel qualified for a correct
> fix.
>
The offending code is almost certainly wrong.
I know the guy who wrote them and =E2=80=A6 he means well ;)

I think I was confused about what was needed in packet size. I=E2=80=99ll t=
ry to test your patch in the next couple of days.

Kristof

