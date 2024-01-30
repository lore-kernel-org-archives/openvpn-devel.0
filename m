MIME-Version: 1.0
References: <CAAUX2SWqB=3zUqqxcXBEN-p6mq2ea8i-gjy-AX3aBXJzrE-QMA@...278...>
 <ed69cd1c-8817-44c3-a8f9-af1ccb2379be@...2181...>
In-Reply-To: <ed69cd1c-8817-44c3-a8f9-af1ccb2379be@...2181...>
From: Tony He <huangya90@...277...>
Date: Tue, 30 Jan 2024 19:16:51 +0800
Message-ID: <CAAUX2SUkXNsntKVJFO7RzdLJJbdZ9P-z6sD+wrqj21y-k5-GaQ@...278...>
Subject: Re: [Openvpn-devel] [ovpn-dco] Can ovpn-dco use all cpu cores?
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Antonio,

I think I need to test another platform. It may give us more information.
I will choose one arm board to have a try when I'm free.

Tony

Antonio Quartulli <a@...2181...> =E4=BA=8E2024=E5=B9=B41=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=BA=8C 19:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 29/01/2024 05:25, Tony He wrote:
> > Hi Antonio,
> >
> > I'm using ovpn-dco which is backported to v4.14 based on your latest
> > code. My topology is:
> >
> > LAN PC -- openwrt router running openvpn server -- WAN PC running openv=
pn client
> > Router is with two mips64 cores.
> >
> > I use the iperf3 to test speed between LAN PC and WAN PC.
> > The result is sometime the performance is good(~280Mbps=EF=BC=89 while
> > sometimes is bad(~140Mbps).
> >   When the performance is bad, one of two CPUs is 100% idle. When the
> > performance is good, two CPUs are busy. However=EF=BC=8C I don't see th=
e issue
> > when ipsec is tested in the same test env. Two cores are always used
> > for ipsec. So , can ovpn-dco use all cpu cores to get max performance?
>
> ovpn-dco uses more than core in order to perform different operations,
> but more parallelism on traffic processing can definitely be implemented
> (patches are welcome ;)).
>
> Now it's hard to tell if what you are seeing is the result of this
> implementation detail or something else, especially because in some
> cases you get higher throughput.
>
>
> Cheers,
>
> --
> Antonio Quartulli

