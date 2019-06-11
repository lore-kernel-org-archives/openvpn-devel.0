MIME-Version: 1.0
References: <CAGyAFMWpLKixwrmOqLy-OZ86h-zXwgPMyJQ3HqV8O3GQRGE1UA@...278...>
 <193E6898-A1C8-4319-8847-866E3CEB3E97@...2293...>
In-Reply-To: <193E6898-A1C8-4319-8847-866E3CEB3E97@...2293...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 11 Jun 2019 17:55:43 -0400
Message-ID: <CAKuzo_ihkXkr_-2+VQ5bSaoi-MrEM+u051_WNoMtdhVdubOhAw@...278...>
Subject: Re: [Openvpn-devel] Preliminary Wintun support in OpenVPN2
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
To: Lev Stipakov <lstipakov@...277...>
Cc: Simon Rozman <simon@...2293...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Copying devel list as there is good info in here..

On Tue, Jun 11, 2019 at 4:24 PM Simon Rozman <simon@...2293...> wrote:
>
> Hi,
>
>
>
> I've taken Jason out of the loop =E2=80=93 he's hostile and competitive, =
and I do not approve his attitude towards OpenVPN and other nice people try=
ing to use our technology. Once you get to know him, he is a nice guy under=
 immense time pressure.
>
>
>
> Allowing any unprivileged process to access Wintun data pipe would be a s=
ecurity vulnerability indeed. Anyone can derive data pipe name from LUID an=
d then write/read IP packets to Windows networking stack. However, mind tha=
t the SDDL string set via NDIS_DEVICE_OBJECT_ATTRIBUTES is called default S=
DDL. I believe, I have read somewhere that there is a way you can set your =
own SDDL via registry. Never researched it myself, but there might be a way=
 you can use stock Wintun binary with some registry tweaks to allow desired=
 ACL for the data pipe.

A quick comment:

IMO, we should use the interactive service to open the pipe and pass
the handle to OpenVPN.exe. This avoids allowing arbitrary users to
access the pipe or requiring users to start OpenVPN as admin which is
not a safe practice. As the service only starts a well-defined
executable present at a location read from HKLM\... and can pass a
duplicated handle targeted for the process, such an approach looks
safe to me. And, it should be fairly easy to implement.

I'll try to find some time to test OpenVPN + wintun. Thanks for the patch.



> Maximum 256 packets limitation no longer applies. This was a leftover fro=
m the time we had 256 preallocated NBLs we copied packets into on write. As=
 we no longer copy data on write, we no longer have those 256 preallocated =
NBLs. The most recent exchange buffer limitations are:
>
> minimum 16+0xeff0=3D0xf000 bytes when reading
> minimum 16+20 bytes when writing (one Wintun packet header with an empty =
IPv4 packet)
> maximum 0xf00000 bytes when reading or writing
> all packets must be <=3D16+0xeff0=3D0xf000 bytes (16 bytes for Wintun pac=
ket header with maximum 0xeff0 IPv4/v6 packet).
>
> Thus, you can pack any number of packets into an exchange buffer, just us=
e something in the 0xf000-0xf00000 range for the exchange buffer size. And =
each packet must contain <=3D0xeff0 sized IP packet. With Wintun 0.2 we are=
 rejecting entire exchange buffer in case any packet is violating any of ab=
ove rules. Or, if it is not IPv4 nor IPv6 etc. See TunGetIrpBuffer() and Tu=
nWriteFromIrp() with majority of exchange buffer checks should you receive =
ERROR_INVALID_USER_BUFFER.
>
> You mean I/O completion ports? Never used or studied it. I understand it =
should be done on the userspace side. Mind that you must retain the order o=
f TCP packets. Should you have more parallel reads/writes racing with each =
other, the packets might get reordered. One approach we still have to imple=
ment and test with WireGuard client is to use overlapped I/O and double buf=
fering.
>
>
>
> In case you have any further questions, do not hesitate to ask. I hope we=
 meet on OpenVPN hackathon in Trento. I have reserved the date on my calend=
ar and waiting for Antonio to send the accommodation recommendation.
>
>
>
> Best regards,
>
> Simon
>
>
>
> From: Lev Stipakov <lstipakov@...277...>
> Date: Tuesday, 11 June 2019 at 19:26
> To: Jason Donenfeld <Jason@...2390...>, Simon Rozman <simon@...2293...>, =
Selva Nair <selva.nair@...277...>
> Subject: Preliminary Wintun support in OpenVPN2
>
>
>
> Hi guys,
>
>
>
> I have implemented preliminary Wintun support in openvpn2:
>
>
>
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18490=
.html
>
>
>
> It would be great if you could provide some feedback on it. Latest binari=
es could be found here: https://ci.appveyor.com/api/buildjobs/w20knnbut89uo=
euw/artifacts/msvc%2Fimage%2Fbin.zip
>
>
>
> I would like to ask a few questions about Wintun to Jason / Simon:
>
>
>
> 1) At the moment Wintun device can be opened by either privileged or loca=
l system account. This breaks "run as non admin" scenario for OpenVPN commu=
nity client - while we do have a component running under system account (in=
teractive service), it is used to set up IP address, routing etc and not fo=
r opening tun device, which is performed by main openvpn process, which cou=
ld well be run under non-privileged account. Would you consider allowing no=
n-privileged processes open tun device, as it is done by tap-windows6? Alte=
rnatively we were thinking to use the same approach we use in openvpn3 linu=
x client - to open tun under privileged process and pass handle back to unp=
rivileged one. Have to look if it is doable on Windows.
>
>
>
> 2) I am not quite sure what buffer size to use when reading from Wintun. =
In my patch I used something close to 1500 * 256 and it seems to work fine,=
 but 256 is the maximum amount of packets with MTU 0xF000 (default) and wit=
h smaller MTUs (say 1500) there could be even more packets. The maximum buf=
fer size is 15 megabytes - is this really what should be allocated?
>
>
>
> 3) Did you consider implementing scatter / gather IO for Wintun?
>
>
>
> A comment about performance. According to my measurements, openvpn2 with =
Wintun is 27% faster comparison to tap-windows6, but I think we (openvpn) c=
an go even faster with Wintun. WSASend, which we use to send data to link, =
allows multiple send buffers. We do not use this functionality since with t=
ap-windows6 we process packets one by one. In my tests Wintun read returns =
about 100 IP packets and I think that decreasing amount of WSASend calls by=
 factor of 100 would give us noticeable performance boost.
>
>
>
> --
>
> -Lev

Selva

