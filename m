Date: Mon, 12 Sep 2022 15:32:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yx80+3Yqzz2S11YR@...1296...>
References: <Yx8lzUfCcOiSytek@...1296...> <Yx8n4/VLK8TPU8N2@...1296...>
 <83F9EF68-40E1-4F6F-B2E8-4B5B6919EE01@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vgu2r5QHXdwSxYJf"
Content-Disposition: inline
In-Reply-To: <83F9EF68-40E1-4F6F-B2E8-4B5B6919EE01@...2661...>
Subject: Re: [Openvpn-devel] more crashes with FreeBSD DCO...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--vgu2r5QHXdwSxYJf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 12, 2022 at 03:06:47PM +0200, Kristof Provost via Openvpn-devel=
 wrote:
> Can you reproduce the panic?

Yes, very easy.

Start a handful of OpenVPN instances, some with DCO

gert@...2695...:~/t_server.git $ SU /root/t_server/start
starting tun-tcp-p2mp/server.conf...
starting tun-udp-p2mp/server.conf...
starting tun-udp-p2mp-topology-subnet/server.conf...
starting tap-udp-p2mp/server.conf...
starting tun-udp-p2mp-112-mask/server.conf...
starting tun-udp-p2mp-fragment/server.conf...
starting tun-udp-p2p/server.conf...
starting tun-udp-p2mp-hash-defscript/server.conf...
starting tap-tcp-p2p/server.conf...
starting tun-udp-p2p-tls-sha256/server.conf...

(I think 4 of them are using DCO, the others regular tuntap)

... then unload the module

gert@...2695...:/usr/obj $ SU kldunload if_ovpn
gert@...2695...:/usr/obj $=20

and it freezes right after the prompt reappears.

Kernel says:

tun0: link state changed to DOWN
tun0: link state changed to UP
ovpn0: changing name to 'tun1'
[fib_algo] inet.0 (bsearch4#589) rebuild_fd_flm: switching algo to radix4_l=
ockless
ovpn1: changing name to 'tun2'
tap9: Ethernet address: 58:9c:fc:10:e1:05
tap9: link state changed to UP
tun3: link state changed to UP
tun4: link state changed to UP
ovpn2: changing name to 'tun5'
tun6: link state changed to UP
tap99: Ethernet address: 58:9c:fc:10:ff:d7
tap99: link state changed to UP
ovpn3: changing name to 'tun11'
Warning: memory type ovpn leaked memory on destroy (1 allocations, 2048 byt=
es leaked).

Fatal trap 12: page fault while in kernel mode
cpuid =3D 2; apic id =3D 04
fault virtual address   =3D 0xffffffff83180db0
fault code              =3D supervisor read instruction, page not present
instruction pointer     =3D 0x20:0xffffffff83180db0
stack pointer           =3D 0x28:0xfffffe00085a3df8
frame pointer           =3D 0x28:0xfffffe00085a3e40
code segment            =3D base 0x0, limit 0xfffff, type 0x1b
                        =3D DPL 0, pres 1, long 1, def32 0, gran 1
processor eflags        =3D interrupt enabled, resume, IOPL =3D 0
current process         =3D 0 (softirq_2)
trap number             =3D 12
panic: page fault
cpuid =3D 2
time =3D 1662989293
KDB: stack backtrace:
db_trace_self_wrapper() at db_trace_self_wrapper+0x2b/frame 0xfffffe00085a3=
bb0
vpanic() at vpanic+0x151/frame 0xfffffe00085a3c00
panic() at panic+0x43/frame 0xfffffe00085a3c60
trap_fatal() at trap_fatal+0x387/frame 0xfffffe00085a3cc0
trap_pfault() at trap_pfault+0xab/frame 0xfffffe00085a3d20
calltrap() at calltrap+0x8/frame 0xfffffe00085a3d20
--- trap 0xc, rip =3D 0xffffffff83180db0, rsp =3D 0xfffffe00085a3df8, rbp =
=3D 0xfffffe00085a3e40 ---
__stop_set_sysinit_set() at __stop_set_sysinit_set+0x4390/frame 0xfffffe000=
85a3e40
gtaskqueue_run_locked() at gtaskqueue_run_locked+0xa7/frame 0xfffffe00085a3=
ec0
gtaskqueue_thread_loop() at gtaskqueue_thread_loop+0xc2/frame 0xfffffe00085=
a3ef0
fork_exit() at fork_exit+0x80/frame 0xfffffe00085a3f30
fork_trampoline() at fork_trampoline+0xe/frame 0xfffffe00085a3f30
--- trap 0x106000d1, rip =3D 0x110c0000025010f4, rsp =3D 0x118a0000025d116a=
, rbp =3D 0xf7c0000022f ---
KDB: enter: panic
---<<BOOT>>---


gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vgu2r5QHXdwSxYJf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjHzT7AAoJEB2Cnv7KVigS3VIMAIx8RL5XNM5os5IAW9AFJsYP
H4n7PB6MHJwiiMQi5QXaH4UT++3CE5fe7FyG0QhlI6ofnLoLdg96OvDK8ixf9uhV
/Uis3eSLZGtVTdoagMPUiHs+hgxvsgsQCG6GjYjOL/wcCPhwX8S4kw4Mwy/TkXR7
k3Hv95e6u03tUyeLl+Zok0pEE5ia6nph7TU6oMcT0qAga0mbqBSpoA9ii7SFXQ3v
HLRVzrACtb8WY5rgYiNjyYh0bxfeVF+W5e1vOuSSOH0jH2Bnn9BHSuW8rRBqAN18
E3hQtgVPCavwuuQSiBlnxPigbwh/YP3mW6JS7rOoxAhfRuWHATkQAtvZVMeTkusb
Ij+vgKUuEWj5tFFG7vXL0uttPkXCRF+kQ5kF8ANBvLUdQltJ74xFRJPZT1UVvghR
TFu+EPh74ha19RyeqZVqDq8HvPuiTP/bRiIrTw+LXWtLHjfrOXJ5ymqNO7qfvjaW
cWlDQ231cuTMFsDJ/2gST2UuTt2zpXlIT2dfHem7pQ==
=DmNI
-----END PGP SIGNATURE-----

--vgu2r5QHXdwSxYJf--

