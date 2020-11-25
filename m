MIME-Version: 1.0
References: <CAAUX2SVLbNnUAAk3VnupLkoNKWN9_BkVvNgBucgrJyKnJr2_JA@...278...>
 <CAAUX2SVKdb+ft_a4VTSL-M0WAO=RsemL-tLNbm8A+4p0AuCokA@...278...>
 <58d109fa-5be9-8e3f-907d-39e701e5a9e9@...2181...>
In-Reply-To: <58d109fa-5be9-8e3f-907d-39e701e5a9e9@...2181...>
From: Tony He <huangya90@...277...>
Date: Wed, 25 Nov 2020 10:17:31 +0800
Message-ID: <CAAUX2SXsYeD=RaCGm9Pwaqm9Wz4tRWUrE+berokrNWdVNc0hmA@...278...>
Content-Type: multipart/alternative; boundary="0000000000004d9c3b05b4e50862"
Subject: Re: [Openvpn-devel] [ovpn-dco] Kernel NULL point derefence
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000004d9c3b05b4e50862
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

Yeah, this patch fixes this issue.

Tony

Antonio Quartulli <a@...2181...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:44=E5=86=99=E9=81=93=EF=BC=9A

> Hi Tony,
>
> Thanks a lot for all your tests.
> The faulty commit is:
>
> commit ba109be633fd802b856d6a125f47e2d0ff7ad749
> Author: Antonio Quartulli <antonio@...515...>
> Date:   Sun Nov 22 16:13:17 2020 +0100
>
>     ovpn-dco: avoid potential out of bound access in aead_decrypt()
>
>
> I have just pushed a fix to master to address the bug.
> Could you please give it a go?
>
> Thanks a lot!
>
> On 24/11/2020 08:38, Tony He wrote:
> > Hi Antonio,
> >
> > Did more test. Just FYI.
> >
> > ba109be633f bad.
> > 6eb6292a9d3 ?
> > 0989291e816 good
> >
> > Tony
> >
> > Tony He <huangya90@...277... <mailto:huangya90@...277...>> =E4=BA=8E202=
0=E5=B9=B411=E6=9C=88
> > 24=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:19=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> >     Hi Antonio,
> >
> >     I'm using the latest commit 4b104be to test and encountered
> >     following issue. I saw multi times in both peers. I never
> >     encountered this issue  before commit c56b9d0. Can you reproduce?
> >
> >     [  708.790419] ovpn_dco: module verification failed: signature
> >     and/or required key missing - tainting kernel
> >
> >
> >     [  708.790885] OpenVPN data channel offload (ovpn-dco) 4b104be-dirty
> >     -- (C) 2020 OpenVPN, Inc.
> >
> >
> >     [  899.304454] BUG: kernel NULL pointer dereference, address:
> >     0000000000000008
> >
> >
> >     [  899.305245] #PF: supervisor read access in kernel mode
> >
> >
> >
> >     [  899.306044] #PF: error_code(0x0000) - not-present page
> >
> >
> >
> >     [  899.306825] PGD 0 P4D 0
> >
> >
> >
> >     [  899.307597] Oops: 0000 [#1] SMP PTI
> >
> >
> >
> >     [  899.308335] CPU: 1 PID: 34 Comm: kworker/1:1 Tainted: G
> >     OE     5.4.0-54-generic #60-Ubuntu
> >
> >
> >     [  899.309922] Hardware name: innotek GmbH VirtualBox/VirtualBox,
> >     BIOS VirtualBox 12/01/2006
> >
> >
> >     [  899.310887] Workqueue: ovpn-crypto-wq-tun0 ovpn_decrypt_work
> >     [ovpn_dco]
> >
> >
> >     [  899.311762] RIP: 0010:gcmaes_crypt_by_sg.constprop.0+0x244/0x6c0
> >     [aesni_intel]
> >
> >
> >     [  899.312518] Code: ac f8 48 83 f8 01 19 c0 f7 d0 83 e0 b6 eb 87 4c
> >     8b 74 24 40 48 8d 7c 24 60 49 8b 76 40 41 8b 56 30 e8 10 eb ac f8 49
> >     8b 76 48 <44> 8b 60 08 49 89 c5 49 39 76 40 0f 84 7d 02 00 00 41 8b
> >     56 30
> >      48
> >
> >
> >
> >     [  899.315985] RSP: 0018:ffff9ed680127800 EFLAGS: 00010246
> >
> >
> >
> >     [  899.316843] RAX: 0000000000000000 RBX: 0000000000000030 RCX:
> >     ffffe78440adf700
> >
> >
> >     [  899.317489] RDX: 0000000000000008 RSI: ffff9ed680127bb0 RDI:
> >     ffff9ed680127bb0
> >
> >
> >     [  899.318143] RBP: ffff9ed680127aa0 R08: ffff9ed680127ab0 R09:
> >     ffff8c8f7c9b1460
> >
> >
> >     [  899.318777] R10: ffff9ed680127b88 R11: 0000000000000b6a R12:
> >     0000000000000008
> >
> >
> >     [  899.319581] R13: 0000000000000040 R14: ffff8c8f6ba4c590 R15:
> >     ffff8c8f6b7dcb6a
> >
> >
> >     [  899.320263] FS:  0000000000000000(0000) GS:ffff8c8f7eb00000(0000)
> >     knlGS:0000000000000000
> >
> >
> >     [  899.320841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >
> >
> >
> >     [  899.321486] CR2: 0000000000000008 CR3: 000000002d606003 CR4:
> >     00000000000606e0
> >
> >
> >     [  899.322060] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> >     0000000000000000
> >
> >
> >     [  899.322685] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> >     0000000000000400
> >
> >
> >     [  899.323232] Call Trace:
> >
> >
> >
> >     [  899.323780]  ? check_preempt_wakeup+0xfd/0x210
> >
> >
> >
> >     [  899.324320]  ? check_preempt_curr+0x7a/0x90
> >
> >
> >
> >     [  899.324853]  ? ttwu_do_wakeup+0x1e/0x150
> >
> >
> >
> >     [  899.325360]  ? ttwu_do_activate+0x5b/0x70
> >
> >
> >
> >     [  899.325825]  ? try_to_wake_up+0x224/0x6a0
> >
> >
> >
> >     [  899.326303]  ? alloc_pages_current+0x87/0xe0
> >
> >
> >
> >     [  899.326760]  ? __update_load_avg_cfs_rq+0x212/0x2f0
> >
> >
> >
> >     [  899.327216]  ? __update_load_avg_cfs_rq+0x212/0x2f0
> >
> >
> >
> >     [  899.327664]  ? sched_clock_cpu+0x11/0xb0
> >
> >
> >
> >     [  899.328113]  ? update_blocked_averages+0x11c/0x590
> >     [  899.328560]  ? update_group_capacity+0x2c/0x1d0
> >     [  899.329007]  generic_gcmaes_decrypt+0x5b/0x80 [aesni_intel]
> >     [  899.329466]  crypto_aead_decrypt+0x46/0x80
> >     [  899.329905]  simd_aead_decrypt+0xa8/0xc0 [crypto_simd]
> >     [  899.330456]  crypto_aead_decrypt+0x46/0x80
> >     [  899.330884]  ovpn_aead_decrypt+0x268/0x3d0 [ovpn_dco]
> >     [  899.331314]  ? __update_load_avg_cfs_rq+0x212/0x2f0
> >     [  899.331734]  ? sched_clock_cpu+0x11/0xb0
> >     [  899.332218]  ? x2apic_send_IPI+0x4a/0x50
> >     [  899.332743]  ? native_send_call_func_single_ipi+0x1e/0x20
> >     [  899.333122]  ? generic_exec_single+0x6e/0xd0
> >     [  899.333523]  ? poke_int3_handler+0x80/0x80
> >     [  899.333880]  ? smp_call_function_single+0xd1/0x110
> >     [  899.334326]  ? poke_int3_handler+0x80/0x80
> >     [  899.334696]  ? flush_tlb_mm_range+0xa1/0xe0
> >     [  899.335042]  ? udp4_lib_lookup2+0x133/0x2d0
> >     [  899.335366]  ? cpumask_next_and+0x1e/0x20
> >     [  899.335685]  ? smp_call_function_many+0x23b/0x270
> >     [  899.336165]  ? do_sync_core+0x1d/0x20
> >     [  899.336494]  ? text_poke_bp_batch+0x106/0x160
> >     [  899.336886]  ? arch_jump_label_transform_apply+0x3e/0x50
> >     [  899.337209]  ? __jump_label_update+0x115/0x120
> >     [  899.337505]  ovpn_decrypt_work+0x1c1/0x600 [ovpn_dco]
> >     [  899.337803]  process_one_work+0x1eb/0x3b0
> >     [  899.338113]  worker_thread+0x4d/0x400
> >     [  899.338405]  kthread+0x104/0x140
> >     [  899.338687]  ? process_one_work+0x3b0/0x3b0
> >     [  899.338970]  ? kthread_park+0x90/0x90
> >     [  899.339255]  ret_from_fork+0x35/0x40
> >     [  899.339538] Modules linked in: ovpn_dco(OE) ip6_udp_tunnel
> >     udp_tunnel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> >     intel_rapl_msr intel_rapl_common rapl input_leds serio_raw joydev
> >     snd_intel8x0 snd_ac97
> >     _codec ac97_bus snd_pcm snd_timer vboxguest(O) snd soundcore mac_hid
> >     sch_fq_codel ip_tables x_tables autofs4 btrfs zstd_compress raid10
> >     raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx
> >     xor raid
> >     6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid hid
> >     crct10dif_pclmul crc32_pclmul ghash_clmulni_intel vboxvideo
> >     drm_vram_helper ttm aesni_intel crypto_simd cryptd glue_helper
> >     drm_kms_helper syscop
> >     yarea sysfillrect sysimgblt fb_sys_fops psmouse ahci libahci
> >     i2c_piix4 drm pata_acpi e1000 video
> >     [  899.342316] CR2: 0000000000000008
> >     [  899.342686] ---[ end trace dd4dab57d5473bc0 ]---
> >     [  899.343082] RIP: 0010:gcmaes_crypt_by_sg.constprop.0+0x244/0x6c0
> >     [aesni_intel]
> >     [  899.343451] Code: ac f8 48 83 f8 01 19 c0 f7 d0 83 e0 b6 eb 87 4c
> >     8b 74 24 40 48 8d 7c 24 60 49 8b 76 40 41 8b 56 30 e8 10 eb ac f8 49
> >     8b 76 48 <44> 8b 60 08 49 89 c5 49 39 76 40 0f 84 7d 02 00 00 41 8b
> >     56 30
> >      48
> >     [  899.344605] RSP: 0018:ffff9ed680127800 EFLAGS: 00010246
> >     [  899.344989] RAX: 0000000000000000 RBX: 0000000000000030 RCX:
> >     ffffe78440adf700
> >     [  899.345381] RDX: 0000000000000008 RSI: ffff9ed680127bb0 RDI:
> >     ffff9ed680127bb0
> >     [  899.345772] RBP: ffff9ed680127aa0 R08: ffff9ed680127ab0 R09:
> >     ffff8c8f7c9b1460
> >     [  899.346213] R10: ffff9ed680127b88 R11: 0000000000000b6a R12:
> >     0000000000000008
> >     [  899.346624] R13: 0000000000000040 R14: ffff8c8f6ba4c590 R15:
> >     ffff8c8f6b7dcb6a
> >     [  899.347153] FS:  0000000000000000(0000) GS:ffff8c8f7eb00000(0000)
> >     knlGS:0000000000000000
> >     [  899.347550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     [  899.347948] CR2: 0000000000000008 CR3: 000000002d606003 CR4:
> >     00000000000606e0
> >     [  899.348382] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> >     0000000000000000
> >     [  899.348798] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> >     0000000000000400
> >
> >     Tony
> >
>
> --
> Antonio Quartulli
>

--0000000000004d9c3b05b4e50862
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgQW50b25pbyw8ZGl2Pjxicj48L2Rpdj48ZGl2PlllYWgsIHRoaXMg
cGF0Y2ggZml4ZXMgdGhpcyBpc3N1ZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRvbnk8L2Rp
dj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNz
PSJnbWFpbF9hdHRyIj5BbnRvbmlvIFF1YXJ0dWxsaSAmbHQ7YUAuLi4yMTgxLi4uJmd0OyDkuo4y
MDIw5bm0MTHmnIgyNOaXpeWRqOS6jCDkuIvljYgzOjQ05YaZ6YGT77yaPGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij5IaSBUb255LDxicj4NCjxicj4NClRoYW5rcyBhIGxvdCBmb3IgYWxsIHlvdXIgdGVzdHMuPGJy
Pg0KVGhlIGZhdWx0eSBjb21taXQgaXM6PGJyPg0KPGJyPg0KY29tbWl0IGJhMTA5YmU2MzNmZDgw
MmI4NTZkNmExMjVmNDdlMmQwZmY3YWQ3NDk8YnI+DQpBdXRob3I6IEFudG9uaW8gUXVhcnR1bGxp
ICZsdDs8YSBocmVmPSJtYWlsdG86YW50b25pb0AuLi41MTUuLi4iIHRhcmdldD0iX2JsYW5rIj5h
bnRvbmlvQC4uLjUxNS4uLjwvYT4mZ3Q7PGJyPg0KRGF0ZTrCoCDCoFN1biBOb3YgMjIgMTY6MTM6
MTcgMjAyMCArMDEwMDxicj4NCjxicj4NCsKgIMKgIG92cG4tZGNvOiBhdm9pZCBwb3RlbnRpYWwg
b3V0IG9mIGJvdW5kIGFjY2VzcyBpbiBhZWFkX2RlY3J5cHQoKTxicj4NCjxicj4NCjxicj4NCkkg
aGF2ZSBqdXN0IHB1c2hlZCBhIGZpeCB0byBtYXN0ZXIgdG8gYWRkcmVzcyB0aGUgYnVnLjxicj4N
CkNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBpdCBhIGdvPzxicj4NCjxicj4NClRoYW5rcyBhIGxvdCE8
YnI+DQo8YnI+DQpPbiAyNC8xMS8yMDIwIDA4OjM4LCBUb255IEhlIHdyb3RlOjxicj4NCiZndDsg
SGkgQW50b25pbyw8YnI+DQomZ3Q7IDxicj4NCiZndDsgRGlkIG1vcmUgdGVzdC4gSnVzdCBGWUku
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGJhMTA5YmU2MzNmIGJhZC48YnI+DQomZ3Q7IDZlYjYyOTJh
OWQzID88YnI+DQomZ3Q7IDA5ODkyOTFlODE2IGdvb2Q8YnI+DQomZ3Q7IDxicj4NCiZndDsgVG9u
eTxicj4NCiZndDsgPGJyPg0KJmd0OyBUb255IEhlICZsdDs8YSBocmVmPSJtYWlsdG86aHVhbmd5
YTkwQC4uLjI3Ny4uLiIgdGFyZ2V0PSJfYmxhbmsiPmh1YW5neWE5MEAuLi4yNzcuLi48L2E+ICZs
dDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmh1YW5neWE5MEAuLi4yNzcuLi4iIHRhcmdldD0iX2Js
YW5rIj5odWFuZ3lhOTBALi4uMjc3Li4uPC9hPiZndDsmZ3Q7IOS6jjIwMjDlubQxMeaciDxicj4N
CiZndDsgMjTml6Xlkajkuowg5LiK5Y2IOToxOeWGmemBk++8mjxicj4NCiZndDsgPGJyPg0KJmd0
O8KgIMKgIMKgSGkgQW50b25pbyw8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoEkmIzM5O20g
dXNpbmcgdGhlIGxhdGVzdMKgY29tbWl0IDRiMTA0YmUgdG8gdGVzdCBhbmQgZW5jb3VudGVyZWQ8
YnI+DQomZ3Q7wqAgwqAgwqBmb2xsb3dpbmcgaXNzdWUuIEkgc2F3IG11bHRpIHRpbWVzIGluIGJv
dGggcGVlcnMuIEkgbmV2ZXI8YnI+DQomZ3Q7wqAgwqAgwqBlbmNvdW50ZXJlZCB0aGlzIGlzc3Vl
wqAgYmVmb3JlIGNvbW1pdCBjNTZiOWQwLiBDYW4geW91IHJlcHJvZHVjZT88YnI+DQomZ3Q7IDxi
cj4NCiZndDvCoCDCoCDCoFsgwqA3MDguNzkwNDE5XSBvdnBuX2RjbzogbW9kdWxlIHZlcmlmaWNh
dGlvbiBmYWlsZWQ6IHNpZ25hdHVyZTxicj4NCiZndDvCoCDCoCDCoGFuZC9vciByZXF1aXJlZCBr
ZXkgbWlzc2luZyAtIHRhaW50aW5nIGtlcm5lbCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAg
wqAgwqBbIMKgNzA4Ljc5MDg4NV0gT3BlblZQTiBkYXRhIGNoYW5uZWwgb2ZmbG9hZCAob3Zwbi1k
Y28pIDRiMTA0YmUtZGlydHk8YnI+DQomZ3Q7wqAgwqAgwqAtLSAoQykgMjAyMCBPcGVuVlBOLCBJ
bmMuIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDC
oFsgwqA4OTkuMzA0NDU0XSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFk
ZHJlc3M6PGJyPg0KJmd0O8KgIMKgIMKgMDAwMDAwMDAwMDAwMDAwOCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAg
wqAgwqBbIMKgODk5LjMwNTI0NV0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5l
bCBtb2RlIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKg
IMKgPGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zMDYwNDRdICNQRjogZXJyb3JfY29kZSgweDAw
MDApIC0gbm90LXByZXNlbnQgcGFnZSDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKg
IMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
wqAgwqAgwqDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzA2ODI1XSBQR0Qg
MCBQNEQgMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZn
dDvCoCDCoCDCoFsgwqA4OTkuMzA3NTk3XSBPb3BzOiAwMDAwIFsjMV0gU01QIFBUSSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKg
IMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzA4MzM1XSBDUFU6IDEg
UElEOiAzNCBDb21tOiBrd29ya2VyLzE6MSBUYWludGVkOiBHIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgIMKgT0UgwqAgwqAgNS40LjAtNTQtZ2VuZXJpYyAjNjAtVWJ1bnR1IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKg
IMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzA5OTIyXSBIYXJkd2Fy
ZSBuYW1lOiBpbm5vdGVrIEdtYkggVmlydHVhbEJveC9WaXJ0dWFsQm94LDxicj4NCiZndDvCoCDC
oCDCoEJJT1MgVmlydHVhbEJveCAxMi8wMS8yMDA2IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAg
wqDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzEwODg3XSBXb3JrcXVldWU6
IG92cG4tY3J5cHRvLXdxLXR1bjAgb3Zwbl9kZWNyeXB0X3dvcms8YnI+DQomZ3Q7wqAgwqAgwqBb
b3Zwbl9kY29dIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAg
wqAgwqDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzExNzYyXSBSSVA6
IDAwMTA6Z2NtYWVzX2NyeXB0X2J5X3NnLmNvbnN0cHJvcC4wKzB4MjQ0LzB4NmMwPGJyPg0KJmd0
O8KgIMKgIMKgW2Flc25pX2ludGVsXSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvC
oCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMxMjUxOF0g
Q29kZTogYWMgZjggNDggODMgZjggMDEgMTkgYzAgZjcgZDAgODMgZTAgYjYgZWIgODcgNGM8YnI+
DQomZ3Q7wqAgwqAgwqA4YiA3NCAyNCA0MCA0OCA4ZCA3YyAyNCA2MCA0OSA4YiA3NiA0MCA0MSA4
YiA1NiAzMCBlOCAxMCBlYiBhYyBmOCA0OTxicj4NCiZndDvCoCDCoCDCoDhiIDc2IDQ4ICZsdDs0
NCZndDsgOGIgNjAgMDggNDkgODkgYzUgNDkgMzkgNzYgNDAgMGYgODQgN2QgMDIgMDAgMDAgNDEg
OGI8YnI+DQomZ3Q7wqAgwqAgwqA1NiAzMDxicj4NCiZndDvCoCDCoCDCoMKgNDggwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKg
wqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMxNTk4NV0gUlNQOiAwMDE4OmZm
ZmY5ZWQ2ODAxMjc4MDAgRUZMQUdTOiAwMDAxMDI0NiDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvC
oCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzE2ODQz
XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDMwIFJDWDo8YnI+DQom
Z3Q7wqAgwqAgwqBmZmZmZTc4NDQwYWRmNzAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzE3
NDg5XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDggUlNJOiBmZmZmOWVkNjgwMTI3YmIwIFJESTo8YnI+
DQomZ3Q7wqAgwqAgwqBmZmZmOWVkNjgwMTI3YmIwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTku
MzE4MTQzXSBSQlA6IGZmZmY5ZWQ2ODAxMjdhYTAgUjA4OiBmZmZmOWVkNjgwMTI3YWIwIFIwOTo8
YnI+DQomZ3Q7wqAgwqAgwqBmZmZmOGM4ZjdjOWIxNDYwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
Pg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4
OTkuMzE4Nzc3XSBSMTA6IGZmZmY5ZWQ2ODAxMjdiODggUjExOiAwMDAwMDAwMDAwMDAwYjZhIFIx
Mjo8YnI+DQomZ3Q7wqAgwqAgwqAwMDAwMDAwMDAwMDAwMDA4IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsg
wqA4OTkuMzE5NTgxXSBSMTM6IDAwMDAwMDAwMDAwMDAwNDAgUjE0OiBmZmZmOGM4ZjZiYTRjNTkw
IFIxNTo8YnI+DQomZ3Q7wqAgwqAgwqBmZmZmOGM4ZjZiN2RjYjZhIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDC
oFsgwqA4OTkuMzIwMjYzXSBGUzogwqAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4Yzhm
N2ViMDAwMDAoMDAwMCk8YnI+DQomZ3Q7wqAgwqAgwqBrbmxHUzowMDAwMDAwMDAwMDAwMDAwIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDC
oFsgwqA4OTkuMzIwODQxXSBDUzogwqAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMyDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4N
CiZndDvCoCDCoCDCoFsgwqA4OTkuMzIxNDg2XSBDUjI6IDAwMDAwMDAwMDAwMDAwMDggQ1IzOiAw
MDAwMDAwMDJkNjA2MDAzIENSNDo8YnI+DQomZ3Q7wqAgwqAgwqAwMDAwMDAwMDAwMDYwNmUwIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzIyMDYwXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIx
OiAwMDAwMDAwMDAwMDAwMDAwIERSMjo8YnI+DQomZ3Q7wqAgwqAgwqAwMDAwMDAwMDAwMDAwMDAw
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDC
oDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzIyNjg1XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAg
RFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzo8YnI+DQomZ3Q7wqAgwqAgwqAwMDAwMDAwMDAwMDAw
NDAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzIzMjMyXSBDYWxsIFRyYWNlOiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4
OTkuMzIzNzgwXSDCoD8gY2hlY2tfcHJlZW1wdF93YWtldXArMHhmZC8weDIxMCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzI0MzIwXSDCoD8gY2hlY2tfcHJlZW1wdF9jdXJyKzB4
N2EvMHg5MCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDC
oMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8Kg
IMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQom
Z3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzI0ODUzXSDCoD8g
dHR3dV9kb193YWtldXArMHgxZS8weDE1MCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDC
oCDCoFsgwqA4OTkuMzI1MzYwXSDCoD8gdHR3dV9kb19hY3RpdmF0ZSsweDViLzB4NzAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKg
wqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMyNTgyNV0gwqA/IHRyeV90b193YWtl
X3VwKzB4MjI0LzB4NmEwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4z
MjYzMDNdIMKgPyBhbGxvY19wYWdlc19jdXJyZW50KzB4ODcvMHhlMCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoDxicj4N
CiZndDvCoCDCoCDCoFsgwqA4OTkuMzI2NzYwXSDCoD8gX191cGRhdGVfbG9hZF9hdmdfY2ZzX3Jx
KzB4MjEyLzB4MmYwIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDC
oCDCoMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zMjcyMTZdIMKgPyBfX3VwZGF0
ZV9sb2FkX2F2Z19jZnNfcnErMHgyMTIvMHgyZjAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQom
Z3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMy
NzY2NF0gwqA/IHNjaGVkX2Nsb2NrX2NwdSsweDExLzB4YjAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMyODExM10gwqA/IHVwZGF0ZV9ibG9ja2VkX2F2ZXJhZ2Vz
KzB4MTFjLzB4NTkwPGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zMjg1NjBdIMKgPyB1cGRhdGVf
Z3JvdXBfY2FwYWNpdHkrMHgyYy8weDFkMDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzI5MDA3
XSDCoGdlbmVyaWNfZ2NtYWVzX2RlY3J5cHQrMHg1Yi8weDgwIFthZXNuaV9pbnRlbF08YnI+DQom
Z3Q7wqAgwqAgwqBbIMKgODk5LjMyOTQ2Nl0gwqBjcnlwdG9fYWVhZF9kZWNyeXB0KzB4NDYvMHg4
MDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzI5OTA1XSDCoHNpbWRfYWVhZF9kZWNyeXB0KzB4
YTgvMHhjMCBbY3J5cHRvX3NpbWRdPGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zMzA0NTZdIMKg
Y3J5cHRvX2FlYWRfZGVjcnlwdCsweDQ2LzB4ODA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMz
MDg4NF0gwqBvdnBuX2FlYWRfZGVjcnlwdCsweDI2OC8weDNkMCBbb3Zwbl9kY29dPGJyPg0KJmd0
O8KgIMKgIMKgWyDCoDg5OS4zMzEzMTRdIMKgPyBfX3VwZGF0ZV9sb2FkX2F2Z19jZnNfcnErMHgy
MTIvMHgyZjA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzMTczNF0gwqA/IHNjaGVkX2Nsb2Nr
X2NwdSsweDExLzB4YjA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzMjIxOF0gwqA/IHgyYXBp
Y19zZW5kX0lQSSsweDRhLzB4NTA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzMjc0M10gwqA/
IG5hdGl2ZV9zZW5kX2NhbGxfZnVuY19zaW5nbGVfaXBpKzB4MWUvMHgyMDxicj4NCiZndDvCoCDC
oCDCoFsgwqA4OTkuMzMzMTIyXSDCoD8gZ2VuZXJpY19leGVjX3NpbmdsZSsweDZlLzB4ZDA8YnI+
DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzMzUyM10gwqA/IHBva2VfaW50M19oYW5kbGVyKzB4ODAv
MHg4MDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzMzODgwXSDCoD8gc21wX2NhbGxfZnVuY3Rp
b25fc2luZ2xlKzB4ZDEvMHgxMTA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzNDMyNl0gwqA/
IHBva2VfaW50M19oYW5kbGVyKzB4ODAvMHg4MDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzM0
Njk2XSDCoD8gZmx1c2hfdGxiX21tX3JhbmdlKzB4YTEvMHhlMDxicj4NCiZndDvCoCDCoCDCoFsg
wqA4OTkuMzM1MDQyXSDCoD8gdWRwNF9saWJfbG9va3VwMisweDEzMy8weDJkMDxicj4NCiZndDvC
oCDCoCDCoFsgwqA4OTkuMzM1MzY2XSDCoD8gY3B1bWFza19uZXh0X2FuZCsweDFlLzB4MjA8YnI+
DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzNTY4NV0gwqA/IHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkr
MHgyM2IvMHgyNzA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzNjE2NV0gwqA/IGRvX3N5bmNf
Y29yZSsweDFkLzB4MjA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzNjQ5NF0gwqA/IHRleHRf
cG9rZV9icF9iYXRjaCsweDEwNi8weDE2MDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzM2ODg2
XSDCoD8gYXJjaF9qdW1wX2xhYmVsX3RyYW5zZm9ybV9hcHBseSsweDNlLzB4NTA8YnI+DQomZ3Q7
wqAgwqAgwqBbIMKgODk5LjMzNzIwOV0gwqA/IF9fanVtcF9sYWJlbF91cGRhdGUrMHgxMTUvMHgx
MjA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMzNzUwNV0gwqBvdnBuX2RlY3J5cHRfd29yaysw
eDFjMS8weDYwMCBbb3Zwbl9kY29dPGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zMzc4MDNdIMKg
cHJvY2Vzc19vbmVfd29yaysweDFlYi8weDNiMDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzM4
MTEzXSDCoHdvcmtlcl90aHJlYWQrMHg0ZC8weDQwMDxicj4NCiZndDvCoCDCoCDCoFsgwqA4OTku
MzM4NDA1XSDCoGt0aHJlYWQrMHgxMDQvMHgxNDA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjMz
ODY4N10gwqA/IHByb2Nlc3Nfb25lX3dvcmsrMHgzYjAvMHgzYjA8YnI+DQomZ3Q7wqAgwqAgwqBb
IMKgODk5LjMzODk3MF0gwqA/IGt0aHJlYWRfcGFyaysweDkwLzB4OTA8YnI+DQomZ3Q7wqAgwqAg
wqBbIMKgODk5LjMzOTI1NV0gwqByZXRfZnJvbV9mb3JrKzB4MzUvMHg0MDxicj4NCiZndDvCoCDC
oCDCoFsgwqA4OTkuMzM5NTM4XSBNb2R1bGVzIGxpbmtlZCBpbjogb3Zwbl9kY28oT0UpIGlwNl91
ZHBfdHVubmVsPGJyPg0KJmd0O8KgIMKgIMKgdWRwX3R1bm5lbCBkbV9tdWx0aXBhdGggc2NzaV9k
aF9yZGFjIHNjc2lfZGhfZW1jIHNjc2lfZGhfYWx1YTxicj4NCiZndDvCoCDCoCDCoGludGVsX3Jh
cGxfbXNyIGludGVsX3JhcGxfY29tbW9uIHJhcGwgaW5wdXRfbGVkcyBzZXJpb19yYXcgam95ZGV2
PGJyPg0KJmd0O8KgIMKgIMKgc25kX2ludGVsOHgwIHNuZF9hYzk3PGJyPg0KJmd0O8KgIMKgIMKg
X2NvZGVjIGFjOTdfYnVzIHNuZF9wY20gc25kX3RpbWVyIHZib3hndWVzdChPKSBzbmQgc291bmRj
b3JlIG1hY19oaWQ8YnI+DQomZ3Q7wqAgwqAgwqBzY2hfZnFfY29kZWwgaXBfdGFibGVzIHhfdGFi
bGVzIGF1dG9mczQgYnRyZnMgenN0ZF9jb21wcmVzcyByYWlkMTA8YnI+DQomZ3Q7wqAgwqAgwqBy
YWlkNDU2IGFzeW5jX3JhaWQ2X3JlY292IGFzeW5jX21lbWNweSBhc3luY19wcSBhc3luY194b3Ig
YXN5bmNfdHg8YnI+DQomZ3Q7wqAgwqAgwqB4b3IgcmFpZDxicj4NCiZndDvCoCDCoCDCoDZfcHEg
bGliY3JjMzJjIHJhaWQxIHJhaWQwIG11bHRpcGF0aCBsaW5lYXIgaGlkX2dlbmVyaWMgdXNiaGlk
IGhpZDxicj4NCiZndDvCoCDCoCDCoGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNsbXVsIGdoYXNo
X2NsbXVsbmlfaW50ZWwgdmJveHZpZGVvPGJyPg0KJmd0O8KgIMKgIMKgZHJtX3ZyYW1faGVscGVy
IHR0bSBhZXNuaV9pbnRlbCBjcnlwdG9fc2ltZCBjcnlwdGQgZ2x1ZV9oZWxwZXI8YnI+DQomZ3Q7
wqAgwqAgwqBkcm1fa21zX2hlbHBlciBzeXNjb3A8YnI+DQomZ3Q7wqAgwqAgwqB5YXJlYSBzeXNm
aWxscmVjdCBzeXNpbWdibHQgZmJfc3lzX2ZvcHMgcHNtb3VzZSBhaGNpIGxpYmFoY2k8YnI+DQom
Z3Q7wqAgwqAgwqBpMmNfcGlpeDQgZHJtIHBhdGFfYWNwaSBlMTAwMCB2aWRlbzxicj4NCiZndDvC
oCDCoCDCoFsgwqA4OTkuMzQyMzE2XSBDUjI6IDAwMDAwMDAwMDAwMDAwMDg8YnI+DQomZ3Q7wqAg
wqAgwqBbIMKgODk5LjM0MjY4Nl0gLS0tWyBlbmQgdHJhY2UgZGQ0ZGFiNTdkNTQ3M2JjMCBdLS0t
PGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zNDMwODJdIFJJUDogMDAxMDpnY21hZXNfY3J5cHRf
Ynlfc2cuY29uc3Rwcm9wLjArMHgyNDQvMHg2YzA8YnI+DQomZ3Q7wqAgwqAgwqBbYWVzbmlfaW50
ZWxdPGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zNDM0NTFdIENvZGU6IGFjIGY4IDQ4IDgzIGY4
IDAxIDE5IGMwIGY3IGQwIDgzIGUwIGI2IGViIDg3IDRjPGJyPg0KJmd0O8KgIMKgIMKgOGIgNzQg
MjQgNDAgNDggOGQgN2MgMjQgNjAgNDkgOGIgNzYgNDAgNDEgOGIgNTYgMzAgZTggMTAgZWIgYWMg
ZjggNDk8YnI+DQomZ3Q7wqAgwqAgwqA4YiA3NiA0OCAmbHQ7NDQmZ3Q7IDhiIDYwIDA4IDQ5IDg5
IGM1IDQ5IDM5IDc2IDQwIDBmIDg0IDdkIDAyIDAwIDAwIDQxIDhiPGJyPg0KJmd0O8KgIMKgIMKg
NTYgMzA8YnI+DQomZ3Q7wqAgwqAgwqDCoDQ4PGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zNDQ2
MDVdIFJTUDogMDAxODpmZmZmOWVkNjgwMTI3ODAwIEVGTEFHUzogMDAwMTAyNDY8YnI+DQomZ3Q7
wqAgwqAgwqBbIMKgODk5LjM0NDk4OV0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAw
MDAwMDAwMDAzMCBSQ1g6PGJyPg0KJmd0O8KgIMKgIMKgZmZmZmU3ODQ0MGFkZjcwMDxicj4NCiZn
dDvCoCDCoCDCoFsgwqA4OTkuMzQ1MzgxXSBSRFg6IDAwMDAwMDAwMDAwMDAwMDggUlNJOiBmZmZm
OWVkNjgwMTI3YmIwIFJESTo8YnI+DQomZ3Q7wqAgwqAgwqBmZmZmOWVkNjgwMTI3YmIwPGJyPg0K
Jmd0O8KgIMKgIMKgWyDCoDg5OS4zNDU3NzJdIFJCUDogZmZmZjllZDY4MDEyN2FhMCBSMDg6IGZm
ZmY5ZWQ2ODAxMjdhYjAgUjA5Ojxicj4NCiZndDvCoCDCoCDCoGZmZmY4YzhmN2M5YjE0NjA8YnI+
DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjM0NjIxM10gUjEwOiBmZmZmOWVkNjgwMTI3Yjg4IFIxMTog
MDAwMDAwMDAwMDAwMGI2YSBSMTI6PGJyPg0KJmd0O8KgIMKgIMKgMDAwMDAwMDAwMDAwMDAwODxi
cj4NCiZndDvCoCDCoCDCoFsgwqA4OTkuMzQ2NjI0XSBSMTM6IDAwMDAwMDAwMDAwMDAwNDAgUjE0
OiBmZmZmOGM4ZjZiYTRjNTkwIFIxNTo8YnI+DQomZ3Q7wqAgwqAgwqBmZmZmOGM4ZjZiN2RjYjZh
PGJyPg0KJmd0O8KgIMKgIMKgWyDCoDg5OS4zNDcxNTNdIEZTOiDCoDAwMDAwMDAwMDAwMDAwMDAo
MDAwMCkgR1M6ZmZmZjhjOGY3ZWIwMDAwMCgwMDAwKTxicj4NCiZndDvCoCDCoCDCoGtubEdTOjAw
MDAwMDAwMDAwMDAwMDA8YnI+DQomZ3Q7wqAgwqAgwqBbIMKgODk5LjM0NzU1MF0gQ1M6IMKgMDAx
MCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzM8YnI+DQomZ3Q7wqAgwqAg
wqBbIMKgODk5LjM0Nzk0OF0gQ1IyOiAwMDAwMDAwMDAwMDAwMDA4IENSMzogMDAwMDAwMDAyZDYw
NjAwMyBDUjQ6PGJyPg0KJmd0O8KgIMKgIMKgMDAwMDAwMDAwMDA2MDZlMDxicj4NCiZndDvCoCDC
oCDCoFsgwqA4OTkuMzQ4MzgyXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAw
MDAwMDAwIERSMjo8YnI+DQomZ3Q7wqAgwqAgwqAwMDAwMDAwMDAwMDAwMDAwPGJyPg0KJmd0O8Kg
IMKgIMKgWyDCoDg5OS4zNDg3OThdIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAw
ZmZmZTBmZjAgRFI3Ojxicj4NCiZndDvCoCDCoCDCoDAwMDAwMDAwMDAwMDA0MDA8YnI+DQomZ3Q7
IDxicj4NCiZndDvCoCDCoCDCoFRvbnk8YnI+DQomZ3Q7IDxicj4NCjxicj4NCi0tIDxicj4NCkFu
dG9uaW8gUXVhcnR1bGxpPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2Pg0K

--0000000000004d9c3b05b4e50862--

