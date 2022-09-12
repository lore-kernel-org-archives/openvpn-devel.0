Date: Mon, 12 Sep 2022 14:36:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yx8n4/VLK8TPU8N2@...1296...>
References: <Yx8lzUfCcOiSytek@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pJPnidFcyKvYWc6z"
Content-Disposition: inline
In-Reply-To: <Yx8lzUfCcOiSytek@...1296...>
Subject: Re: [Openvpn-devel] more crashes with FreeBSD DCO...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kprovost@...2661...
Cc: openvpn-devel@lists.sourceforge.net

--pJPnidFcyKvYWc6z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 12, 2022 at 02:27:57PM +0200, Gert Doering wrote:
> trying to load my newly-instrumented if_ovpn.ko, I kldunload'ed the
> existing one - without shutting down *all* OpenVPN instances first.
>=20
> *Boom*...
>=20
> Console attached.

Ah, nice, dmesg has all the info in text format, no need to send PNGs
to the list :-)


-------------------- snip ----------------
ovpn3: changing name to 'tun11'
tun8: link state changed to DOWN
ovpn4: changing name to 'tun4'
tun4: link state changed to UP
tun4: promiscuous mode enabled

Warning: memory type ovpn leaked memory on destroy (1 allocations, 2048 byt=
es leaked).


Fatal trap 12: page fault while in kernel mode
cpuid =3D 3; apic id =3D 06
fault virtual address   =3D 0xffffffff82f81d70
fault code              =3D supervisor read instruction, page not present
instruction pointer     =3D 0x20:0xffffffff82f81d70
stack pointer           =3D 0x28:0xfffffe000859edf8
frame pointer           =3D 0x28:0xfffffe000859ee40
code segment            =3D base 0x0, limit 0xfffff, type 0x1b
                        =3D DPL 0, pres 1, long 1, def32 0, gran 1
processor eflags        =3D interrupt enabled, resume, IOPL =3D 0
current process         =3D 0 (softirq_3)
trap number             =3D 12
panic: page fault
cpuid =3D 3
time =3D 1662985342
KDB: stack backtrace:
db_trace_self_wrapper() at db_trace_self_wrapper+0x2b/frame 0xfffffe000859e=
bb0
vpanic() at vpanic+0x151/frame 0xfffffe000859ec00
panic() at panic+0x43/frame 0xfffffe000859ec60
trap_fatal() at trap_fatal+0x387/frame 0xfffffe000859ecc0
trap_pfault() at trap_pfault+0xab/frame 0xfffffe000859ed20
calltrap() at calltrap+0x8/frame 0xfffffe000859ed20
--- trap 0xc, rip =3D 0xffffffff82f81d70, rsp =3D 0xfffffe000859edf8, rbp =
=3D 0xfffffe000859ee40 ---
__stop_set_sysinit_set() at __stop_set_sysinit_set+0x5350/frame 0xfffffe000=
859ee40
gtaskqueue_run_locked() at gtaskqueue_run_locked+0xa7/frame 0xfffffe000859e=
ec0
gtaskqueue_thread_loop() at gtaskqueue_thread_loop+0xc2/frame 0xfffffe00085=
9eef0
fork_exit() at fork_exit+0x80/frame 0xfffffe000859ef30
fork_trampoline() at fork_trampoline+0xe/frame 0xfffffe000859ef30
--- trap 0, rip =3D 0, rsp =3D 0, rbp =3D 0 ---
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

--pJPnidFcyKvYWc6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjHyfjAAoJEB2Cnv7KVigSeKML/2ZzFGqUvQxiulDwO2PFyUl3
gRo3q6hlEGehFVJIYgGj4P0M3LFdCi/iiYeq604jKz3VZnmlLs49vK9GTxWch5ed
WzpTwHUZipPsiVG4UcNF5jQgp1yWOwd2zxbC6qXTM9gPBNgbKQWQvb4LuCq3a57Z
IEeShv2izgqNmKPvqIbD72sNcF7LPi586uOypBRuZdvFC36+q8dPJhNVBjYIz5FN
lMhhwnnj7P0D7coXlrwfqum0ysH8EIXu8x3A0THu+oxvDIOFHUUAELHsOK/YJQ1m
I502zQ9QQsjZhhbUkg6UwPRHp3oXmbC89IdAMOpfeFFW5YpHGKAU8Rk0sraf2HPw
3AI+i48X7m9kKOmWAnkVVLgRYrDCv3vWkWUQ4qdcKrcj3+dkyXqJjrQtsZauqguG
ibrNYN5XGoU4IeWdIKwxumtrBmiRYnu5Ns4OZHFwwE72czzoVRD2k/moZJpZhJeM
vQHti8wMlmh3FSgEyIv/TWhh0Kca345nrD9XgLfN9w==
=ntS1
-----END PGP SIGNATURE-----

--pJPnidFcyKvYWc6z--

