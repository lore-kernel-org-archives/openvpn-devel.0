MIME-Version: 1.0
In-Reply-To: <20120408105646.GN1359@...1296...>
References: <CAOazyz1Uy_SxZCjdQ5oA1SAS+yjNC3i23BgMPDBr_gSFD+h_Rg@...278...>
	<20120408105646.GN1359@...1296...>
Date: Sun, 8 Apr 2012 14:01:55 +0300
Message-ID: <CAOazyz0BVcVXeUyMbzEjL1bBoj36d77+X1w0DxsZoENRz=BRdw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC] tun cleanups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Sun, Apr 8, 2012 at 1:56 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, Apr 08, 2012 at 01:43:12PM +0300, Alon Bar-Lev wrote:
>> What I am asking is for people that wishes to work with me on this
>> (not the ACK/NACK approach) to allow perfecting this *BEFORE* merge.
>
> I would actually ask for "no more cleanup changes to tun.c before 2.3" -
> I have cleaned up and *tested* all non-Linux-platforms in the previous
> months and everything is working well now (not looking very pretty, I'm
> the first to agree on this), but *working* *now*.
>

Did I wrote or implied that this is going to 2.3?

> If we start to break tun.c into pieces now, this will need extensive test=
ing
> on all platforms. =C2=A0Since I seem to be the only developer who does fu=
ll
> testing of tun/tap, ipv4/ipv6 on FreeBSD, NetBSD and OpenBSD, and I do not
> have much time right now (conferences and second child due in two months),
> I don't see enough testing capacity for this.
>
> What I would really like to see is "get out 2.3 with the (big) improvemen=
ts
> we have right now, and start with 2.4 right after". =C2=A0The next massiv=
e code
> refactoring should go into 2.4
>
> We need more user feedback to see which bits of the IPv6 implementation a=
re
> incomplete and need to be implemented next - and without exposure, we won=
't
> get that.

The IPv6 is one of the reason the code is so messy.
Please help clean it up.
For example, there is no reason not to use iovec in all cases as far
as I understand.

>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...

