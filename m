From: Kristof Provost <kprovost@...2661...>
Date: Mon, 12 Sep 2022 15:06:47 +0200
Message-ID: <83F9EF68-40E1-4F6F-B2E8-4B5B6919EE01@...2661...>
In-Reply-To: <Yx8n4/VLK8TPU8N2@...1296...>
References: <Yx8lzUfCcOiSytek@...1296...> <Yx8n4/VLK8TPU8N2@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] more crashes with FreeBSD DCO...
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

On 12 Sep 2022, at 14:36, Gert Doering wrote:
> On Mon, Sep 12, 2022 at 02:27:57PM +0200, Gert Doering wrote:
>> trying to load my newly-instrumented if_ovpn.ko, I kldunload'ed the
>> existing one - without shutting down *all* OpenVPN instances first.
>>
>> *Boom*...
>>
>> Console attached.
>
> Ah, nice, dmesg has all the info in text format, no need to send PNGs
> to the list :-)
>
>
> -------------------- snip ----------------
> ovpn3: changing name to 'tun11'
> tun8: link state changed to DOWN
> ovpn4: changing name to 'tun4'
> tun4: link state changed to UP
> tun4: promiscuous mode enabled
>
> Warning: memory type ovpn leaked memory on destroy (1 allocations, 2048 b=
ytes leaked).
>
>
> Fatal trap 12: page fault while in kernel mode
> cpuid =3D 3; apic id =3D 06
> fault virtual address   =3D 0xffffffff82f81d70
> fault code              =3D supervisor read instruction, page not present
> instruction pointer     =3D 0x20:0xffffffff82f81d70
> stack pointer           =3D 0x28:0xfffffe000859edf8
> frame pointer           =3D 0x28:0xfffffe000859ee40
> code segment            =3D base 0x0, limit 0xfffff, type 0x1b
>                         =3D DPL 0, pres 1, long 1, def32 0, gran 1
> processor eflags        =3D interrupt enabled, resume, IOPL =3D 0
> current process         =3D 0 (softirq_3)
> trap number             =3D 12
> panic: page fault
> cpuid =3D 3
> time =3D 1662985342
> KDB: stack backtrace:
> db_trace_self_wrapper() at db_trace_self_wrapper+0x2b/frame 0xfffffe00085=
9ebb0
> vpanic() at vpanic+0x151/frame 0xfffffe000859ec00
> panic() at panic+0x43/frame 0xfffffe000859ec60
> trap_fatal() at trap_fatal+0x387/frame 0xfffffe000859ecc0
> trap_pfault() at trap_pfault+0xab/frame 0xfffffe000859ed20
> calltrap() at calltrap+0x8/frame 0xfffffe000859ed20
> --- trap 0xc, rip =3D 0xffffffff82f81d70, rsp =3D 0xfffffe000859edf8, rbp=
 =3D 0xfffffe000859ee40 ---
> __stop_set_sysinit_set() at __stop_set_sysinit_set+0x5350/frame 0xfffffe0=
00859ee40
> gtaskqueue_run_locked() at gtaskqueue_run_locked+0xa7/frame 0xfffffe00085=
9eec0
> gtaskqueue_thread_loop() at gtaskqueue_thread_loop+0xc2/frame 0xfffffe000=
859eef0
> fork_exit() at fork_exit+0x80/frame 0xfffffe000859ef30
> fork_trampoline() at fork_trampoline+0xe/frame 0xfffffe000859ef30
> --- trap 0, rip =3D 0, rsp =3D 0, rbp =3D 0 ---
> KDB: enter: panic
> ---<<BOOT>>---
>
I can reproduce the memory leak, but not the panic. I=E2=80=99m also entire=
ly unclear how if_ovpn would trigger anything in gtaskqueue*. It doesn=E2=
=80=99t use any task queues, only callouts (for pings and idle timeout).

Can you reproduce the panic?

Kristof

