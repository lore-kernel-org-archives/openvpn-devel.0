MIME-Version: 1.0
Date: Sun, 4 Sep 2011 04:27:16 +0800
Message-ID: <CANvbpLQFkb6W9BeUjrsF3nb=JnjgruUMMTPSncKQtQjBT1d_nQ@...278...>
From: Yang Zhe <yangzhe1990@...277...>
Subject: [Openvpn-devel] Does OpenVPN get IP_PKTINFO in the correct manner?
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
To: openvpn-devel@lists.sourceforge.net

Let's say openvpn 2.2.0

In function link_socket_read_udp_posix_recvmsg() writes:

     struct cmsghdr *cmsg;
     fromlen =3D mesg.msg_namelen;
     cmsg =3D CMSG_FIRSTHDR (&mesg);
     if (cmsg !=3D NULL
         && CMSG_NXTHDR (&mesg, cmsg) =3D=3D NULL
#ifdef IP_PKTINFO
         && cmsg->cmsg_level =3D=3D SOL_IP
         && cmsg->cmsg_type =3D=3D IP_PKTINFO
#elif defined(IP_RECVDSTADDR)
         && cmsg->cmsg_level =3D=3D IPPROTO_IP
         && cmsg->cmsg_type =3D=3D IP_RECVDSTADDR
#else
#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix
syshead.h)
#endif
         && cmsg->cmsg_len >=3D sizeof (struct openvpn_in4_pktinfo))
       {
#ifdef IP_PKTINFO
         struct in_pktinfo *pkti =3D (struct in_pktinfo *) CMSG_DATA (cmsg);
         from->pi.in4.ipi_ifindex =3D pkti->ipi_ifindex;
         from->pi.in4.ipi_spec_dst =3D pkti->ipi_spec_dst;
#elif defined(IP_RECVDSTADDR)
         from->pi.in4 =3D *(struct in_addr*) CMSG_DATA (cmsg);
#else
#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix
syshead.h)
#endif
       }

I looked up manpages and other web resources, normally they iterated in the
cmsghdr list then find the required information by

for (cmsg =3D CMSG_FIRSTHDR(&mesg); cmsg; cmsg =3D CMSG_NXTHDR(&mesg, cmsg))
  if (cmsg->cmsg_level =3D=3D SOL_IP && cmsg->cmsg_type =3D=3D IP_PKTINFO
      && ... ) {
  }

In the openvpn's code, it only examine the FIRSTHDR, and assuming CMSG_NXTH=
DR =3D
NULL, which is odd.

Anybody get "--multihome" worked?

--=20
Sincerely,
=C2=A0 =C2=A0 Yang Zhe

