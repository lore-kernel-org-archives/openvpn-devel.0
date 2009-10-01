From: Marcel =?iso-8859-1?q?Pennewi=DF?= <mailinglists@...1145...>
Date: Thu, 1 Oct 2009 20:22:30 +0200
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
	<200910011141.52317.mailinglists@...1145...>
	<7bb795fd0910010314m5db10bedx448cf3b3a502fe82@...278...>
In-Reply-To: <7bb795fd0910010314m5db10bedx448cf3b3a502fe82@...278...>
MIME-Version: 1.0
Message-Id: <200910012022.30820.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 01 October 2009 12:14:14 JuanJo Ciarlante wrote:
> Could you please show a diff between config.h from stock
> and patched build?

the problem seems to be caused by 
./configure ... --disable-iproute2.

if i enable iproute2:
./configure ... --enable-iproute2
the build of openvpn works.

But if the first client connects the openvpn server generate a segfault (with 
tcp-server and tcp6-server as option).
The last lines via strace - maybe they could help you:

[    2b82cc06da13] epoll_wait(6, {{EPOLLIN, {u32=2, u64=2}}}, 1028, 10000) = 1
[    2b82cbd8e840] 
read(5, "\377\377\377\377\377\377\0\377Gs\311\210\10\6\0\1\10\0\6\4\0\1\0\377Gs\311\210\300\250*s\0"..., 
1532) = 42
[    2b82cc06da13] epoll_wait(6, {{EPOLLIN, {u32=2, u64=2}}}, 1028, 10000) = 1
[    2b82cbd8e840] 
read(5, "\377\377\377\377\377\377\0\377Gs\311\210\10\6\0\1\10\0\6\4\0\1\0\377Gs\311\210\300\250*s\0"..., 
1532) = 42
[    2b82cc06da13] epoll_wait(6, {{EPOLLIN, {u32=2, u64=2}}}, 1028, 10000) = 1
[    2b82cbd8e840] 
read(5, "\377\377\377\377\377\377\0\377Gs\311\210\10\6\0\1\10\0\6\4\0\1\0\377Gs\311\210\300\250*s\0"..., 
1532) = 42
[    2b82cc06da13] epoll_wait(6, {{EPOLLIN, {u32=1, u64=1}}}, 1028, 10000) = 1
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 72, 
MSG_NOSIGNAL, NULL, 0) = 72
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 61, 
MSG_NOSIGNAL, NULL, 0) = 61
[    2b82cc06a2ea] mmap(NULL, 266240, PROT_READ|PROT_WRITE, MAP_PRIVATE|
MAP_ANONYMOUS, -1, 0) = 0x2b82cb190000
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 64, 
MSG_NOSIGNAL, NULL, 0) = 64
[    2b82cc06602a] brk(0x6dd000)        = 0x6dd000
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 100, 
MSG_NOSIGNAL, NULL, 0) = 100
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 108, 
MSG_NOSIGNAL, NULL, 0) = 108
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 76, 
MSG_NOSIGNAL, NULL, 0) = 76
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 86, 
MSG_NOSIGNAL, NULL, 0) = 86
[    2b82cbd8eac0] accept(4, {sa_family=AF_INET6, sin6_port=htons(55430), 
inet_pton(AF_INET6, "::ffff:141.xx.xx.xxx", &sin6_addr), sin6_flowinfo=0, 
sin6_scope_id=0}, [30146066212978716]) = 7
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 105, 
MSG_NOSIGNAL, NULL, 0) = 105
[    2b82cc06e20a] getsockopt(7, SOL_SOCKET, SO_SNDBUF, [17180000256], [4]) = 
0
[    2b82cc06e20a] getsockopt(7, SOL_SOCKET, SO_RCVBUF, [30146066213109760], 
[4]) = 0
[    2b82cc06e68a] setsockopt(7, SOL_SOCKET, SO_SNDBUF, [65536], 4) = 0
[    2b82cc06e68a] setsockopt(7, SOL_SOCKET, SO_RCVBUF, [65536], 4) = 0
[    2b82cc06e20a] getsockopt(7, SOL_SOCKET, SO_SNDBUF, [17180000256], [4]) = 
0
[    2b82cc06e20a] getsockopt(7, SOL_SOCKET, SO_RCVBUF, [30146066213109760], 
[4]) = 0
[    2b82cc06e4b5] sendto(3, "<29>Oct  1 20:24:45 openvpn[15698"..., 90, 
MSG_NOSIGNAL, NULL, 0) = 90
[    2b82cbd8ea1b] fcntl(7, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
[    2b82cbd8ea1b] fcntl(7, F_SETFD, FD_CLOEXEC) = 0
[    2b82cc06e68a] setsockopt(7, SOL_IP, IP_RECVERR, [1], 4) = 0
[    2b82cc017fd0] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 15698 detached


Oct  1 20:09:45 larissa openvpn[15446]: segfault at 0000000000000002 rip 
00002b07e075bfd0 rsp 00007fffcb1f79b8 error 4

Marcel


