MIME-Version: 1.0
References: <CAOh3LPMK7T2gduJXrKaQRDvPZdjCiBJtCqXWiFT0xj4TAaj2LA.ref@...278...>
 <CAOh3LPMK7T2gduJXrKaQRDvPZdjCiBJtCqXWiFT0xj4TAaj2LA@...278...>
 <ad04ec91-f397-4048-b65c-a96a3b48000c@...1227...>
In-Reply-To: <ad04ec91-f397-4048-b65c-a96a3b48000c@...1227...>
From: Jon Chiappetta <root@...2904...>
Date: Fri, 8 Aug 2025 10:04:26 -0400
Message-ID: <CAOh3LPPeoxWRP3MVfR03+Cc=2Qc2tG=CM8mOkA9y31_=LTPL_Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000ebd982063bdb0dcb"
Subject: Re: [Openvpn-devel] Bulk mode - Feature request - Patch diff
 [updated]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000ebd982063bdb0dcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arne,

You are correct, I didn't do a very good job of explaining the code in my
blog post, I usually keep those short with more screen captures because I
figure that not many people would actually take the time to read through it
there. Also, I didn't really add many comments either but I did try to copy
the present style of the code to try and make it match and be more
consistent throughout, even if not perfect yet. I'm still testing out the
change myself in my own home setup here to see if I run into any bad edge
cases along the way.

I can always try to explain the different code parts as I am indeed
modifying the core parts of the read and write operations for tun and tcp
so it's a big change to make to the code base. Basically this change is
important to me in particular because of my setup and requirements in
specific. I have WiFi LAN clients which all assume a 1500 byte MTU on their
side and I have a router WAN client which enforces a 1500 byte MTU on the
internet's side. In the middle of my core network is a VPN box and almost
every VPN software will operate in UDP mode with a sub-1500 MTU in the
middle of this network pipeline. This is not a good design to have in
general as I don't want to waste cycles fragmenting and/or compressing the
data into smaller sized UDP packets. With the code change I am presenting,
I am able to specify a true 1500 byte VPN MTU interface with the exact
matching 1500 byte read calls to the TUN interface itself (the code base
had to be modified to allow for this because it was adding onto the
payload_size used in the read call which I didn't want as I am operating on
exact multiples of 1500 bytes in specific).

With this change, my network pipeline is a true 1500 byte MTU which matches
all the way from the client side to the vpn link to the internet side and
to the server side (end to end to end to end). In addition, I also added
the ability to batch together multiple 1500 byte read calls (specifically 6
x 1500 bytes into 9000 bytes) into one single encrypt sign call and one
single TCP write call. This allows the encryption method to operate only
once on a much larger payload size as well as allow the linux kernel to
efficiently transfer the data with order and delivery guaranteed as fast as
possible. The code base had to be modified to allow for all of this as well
as it was preventing me from performing this much larger sized ssl sign and
encrypt + tcp read and write (the code base assumes you are operating on
only 1 tun read call worth of data at a time everywhere).

This is exactly why I prefer using TCP to tunnel encrypted network data as
my solution provided can properly set a full sized 1500 byte MTU as well as
perform an exact matching read call of 1500 bytes to get the full amount of
data from the interface and then bulk it together to efficiently encrypt it
and then use the magic of TCP to transfer that data all at once as quickly
as possible without any need for fragmentation or compression. I don't
think any other VPN product on the market offers that kind of functionality
as far as I am aware as most other VPN products use a smaller sized MTU as
well as the packet size limitations of UDP. I believe that this could be a
distinguishing feature for OpenVPN as well as automatically solve some of
the issues that folks run into when inserting a VPN appliance into the
middle of their network setups.

I've been running this change on my own setup to at least make sure it
works and it seems to be running pretty nicely so far. I haven't
experienced any fragmentation or performance issues as any sized data that
comes off the clients LAN side is fully taken care of now through the VPN
side and onto the WAN and server side.

If this is something you are not interested in I can understand that, I can
stop posting here and the most I can do is at least submit a pull request
in case anyone in the future is indeed interested in such work. It'd be
nice to contribute to a good quality open source project that I have used
for many many years and something which may help solve other community
member's issues with regards to the small sized MTU + UDP problem which
does exist in practice and really hampers connections along the way in a
network design.

I also don't mind explaining my code parts if you actually want, I just
need to take time to write them out and describe what they are doing and
why. As you can see, I am trying to achieve a very specific and exact
design goal that the code base wasn't originally allowing for, so I had to
make some modifications to be able to accomplish it.

Thanks,
Jon C




On Fri, Aug 8, 2025 at 5:53=E2=80=AFAM Arne Schwabe <arne@...1227...> wrote:

> Am 07.08.25 um 20:29 schrieb Jon Chiappetta via Openvpn-devel:
> > Thanks to Gert's help on this, I was able to finally configure and
> > compile and run and test the bulk mode changes against the latest git
> > source code to ensure everything still works correctly.
> >
> > I also fixed up some other issues like properly freeing the extra buffer
> > allocations and removing the unneeded batched data prefixes and
> > converting a remaining while loop to a max limited for loop and properly
> > resetting the outgoing tun buffer pointer at the end of the write method
> > when finished.
>
>
> It would still good to explain what you are trying to achieve here and
> what the idea behind the patch is to be able to review and understand
> your patch.
>
> The patch itself basically has no comments at all, so it is very hard to
> decipher for me from the patch what it is trying to to do. Eg there is a
> variable flag_ciph that fiddles with encryption of packets.
>
> You are talking and describing this bulk mode as if it was obvious but
> it is not. The description on your blog says:
>
>  > [...] read 8192 bytes off of the client=E2=80=99s TCP sockets directly=
 and
>  > proxy them in one write call over TCP directly to the VPN server
>  > without needing a tunnel interface with a small sized MTU which
>  > bottlenecks reads+writes to <1500 bytes per function call.
>
> It also not helping as you talking about TCP write/reads, where I can
> see some improvement by cutting down the number of reads/writes. But the
> second part then talks about not using a tunnel with a small sized MTU.
> But if you use a larger sized TUN interface with a larger MTU, then you
> already have larger reads/writes to the TCP socket.
>
> Also your speedtest showing 562 is meaningless without having any
> comparison without your patch.
>
> Arne
>

--000000000000ebd982063bdb0dcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne,<div><br></div><div>You are correct, I didn&#39;t =
do a very good job of explaining the code in my blog post, I usually keep t=
hose short with more screen captures because I figure that not many people =
would actually take the time to read through it there. Also, I didn&#39;t r=
eally add many comments either but I did try to copy the present style of t=
he code to try and make it match and be more consistent throughout, even if=
 not perfect yet. I&#39;m still testing out the change myself in my own hom=
e setup here to see if I run into any bad edge cases along the=C2=A0way.=C2=
=A0</div><div><br></div><div>I can always try to explain the different code=
 parts as I am indeed modifying the core parts of the read and write operat=
ions for tun and tcp so it&#39;s a big change to make to the code base. Bas=
ically this change is important to me in particular because of my setup and=
 requirements in specific. I have WiFi LAN clients which all assume a 1500 =
byte MTU on their side and I have a router WAN client which enforces a 1500=
 byte MTU on the internet&#39;s side. In the middle of my core network is a=
 VPN box and almost every VPN software will operate in UDP mode with a sub-=
1500 MTU in the middle of this network pipeline. This is not a good design =
to have in general as I don&#39;t want to waste cycles fragmenting and/or c=
ompressing the data into smaller sized UDP packets. With the code change I =
am presenting, I am able to specify a true 1500 byte VPN MTU interface with=
 the exact matching 1500 byte read calls to the TUN interface itself (the c=
ode base had to be modified to allow for this because it was adding=C2=A0on=
to the payload_size used in the read call which I didn&#39;t want as I am o=
perating on exact multiples of 1500 bytes in specific).=C2=A0</div><div><br=
></div><div>With this change, my network pipeline is a true 1500 byte MTU w=
hich matches all the way from the client side to the vpn link to the intern=
et side and to the server side (end to end to end to end). In addition, I a=
lso added the ability to batch together multiple 1500 byte read calls (spec=
ifically 6 x 1500 bytes into 9000 bytes) into one single encrypt sign call =
and one single TCP write call. This allows the encryption method to operate=
 only once on a much larger payload size as well as allow the linux kernel =
to efficiently transfer the data with order and delivery guaranteed as fast=
 as possible. The code base had to be modified to allow for all of this as =
well as it was preventing me from performing this much larger sized ssl sig=
n and encrypt + tcp read and write (the code base assumes you are operating=
 on only 1 tun read call worth of data at a time everywhere).=C2=A0</div><d=
iv><br></div><div>This is exactly why I prefer using TCP to tunnel encrypte=
d network data as my solution provided can properly set a full sized 1500 b=
yte MTU as well as perform an exact matching read call of 1500 bytes to get=
 the full amount of data from the interface and then bulk it together to ef=
ficiently encrypt it and then use the magic of TCP to transfer that data al=
l at once as quickly as possible without any need for fragmentation or comp=
ression. I don&#39;t think any other VPN product on the market offers that =
kind of functionality as far as I am aware as most other=C2=A0VPN products =
use a smaller sized MTU as well as the packet size limitations of UDP. I be=
lieve that this could be a distinguishing feature for OpenVPN as well as au=
tomatically solve some of the issues that folks run into when inserting a V=
PN appliance into the middle of their network setups.=C2=A0</div><div><br><=
/div><div>I&#39;ve been running this change on my own setup to at least mak=
e sure it works and it seems to be running pretty nicely so far. I haven&#3=
9;t experienced any fragmentation or performance issues as any sized data t=
hat comes off the clients LAN side is fully taken care of now through the V=
PN side and onto the WAN and server side.=C2=A0</div><div><br></div><div>If=
 this is something you are not interested in I can understand that, I can s=
top posting here and the most I can do is at least submit a pull request in=
 case anyone in the future is indeed interested in such work. It&#39;d be n=
ice to contribute to a good quality open source project that I have used fo=
r many many years and something which may help solve other community member=
&#39;s issues with regards to the small sized MTU=C2=A0+ UDP problem which =
does exist in practice and really hampers connections along the way in a ne=
twork design.=C2=A0</div><div><br></div><div>I also don&#39;t mind explaini=
ng my code parts if you actually want, I just need to take time to write th=
em out and describe what they are doing and why. As you can see, I am tryin=
g to achieve=C2=A0a very specific and exact design goal that the code base =
wasn&#39;t originally allowing for, so I had to make some modifications to =
be able to accomplish it.=C2=A0</div><div><br></div><div>Thanks,</div><div>=
Jon C</div><div><br></div><div><br></div><div><br></div></div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Fri, Aug 8, 2025 at 5:53=E2=80=AFAM Arne Schwabe &lt;<a href=3D"mailt=
o:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>Am 07.08.25 um 20:29 schrieb Jon Chiappetta via Openvpn-devel:<br>
&gt; Thanks to Gert&#39;s help on this, I was able to finally configure and=
 <br>
&gt; compile and run and test the bulk mode changes against the latest git =
<br>
&gt; source code to ensure everything still works correctly.<br>
&gt; <br>
&gt; I also fixed up some=C2=A0other issues like properly freeing the extra=
 buffer <br>
&gt; allocations and removing the unneeded batched data prefixes and <br>
&gt; converting a remaining while loop to a max limited for loop and proper=
ly <br>
&gt; resetting the outgoing tun buffer pointer at the end of the write meth=
od <br>
&gt; when finished.<br>
<br>
<br>
It would still good to explain what you are trying to achieve here and <br>
what the idea behind the patch is to be able to review and understand <br>
your patch.<br>
<br>
The patch itself basically has no comments at all, so it is very hard to <b=
r>
decipher for me from the patch what it is trying to to do. Eg there is a <b=
r>
variable flag_ciph that fiddles with encryption of packets.<br>
<br>
You are talking and describing this bulk mode as if it was obvious but <br>
it is not. The description on your blog says:<br>
<br>
=C2=A0&gt; [...] read 8192 bytes off of the client=E2=80=99s TCP sockets di=
rectly and<br>
=C2=A0&gt; proxy them in one write call over TCP directly to the VPN server=
<br>
=C2=A0&gt; without needing a tunnel interface with a small sized MTU which<=
br>
=C2=A0&gt; bottlenecks reads+writes to &lt;1500 bytes per function call.<br>
<br>
It also not helping as you talking about TCP write/reads, where I can <br>
see some improvement by cutting down the number of reads/writes. But the <b=
r>
second part then talks about not using a tunnel with a small sized MTU.<br>
But if you use a larger sized TUN interface with a larger MTU, then you <br>
already have larger reads/writes to the TCP socket.<br>
<br>
Also your speedtest showing 562 is meaningless without having any <br>
comparison without your patch.<br>
<br>
Arne<br>
</blockquote></div>

--000000000000ebd982063bdb0dcb--

