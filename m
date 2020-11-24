References: <CAAUX2SVLbNnUAAk3VnupLkoNKWN9_BkVvNgBucgrJyKnJr2_JA@...278...>
 <CAAUX2SVKdb+ft_a4VTSL-M0WAO=RsemL-tLNbm8A+4p0AuCokA@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <58d109fa-5be9-8e3f-907d-39e701e5a9e9@...2181...>
Date: Tue, 24 Nov 2020 08:43:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SVKdb+ft_a4VTSL-M0WAO=RsemL-tLNbm8A+4p0AuCokA@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] Kernel NULL point derefence
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>, openvpn-devel@lists.sourceforge.net

Hi Tony,

Thanks a lot for all your tests.
The faulty commit is:

commit ba109be633fd802b856d6a125f47e2d0ff7ad749
Author: Antonio Quartulli <antonio@...515...>
Date:   Sun Nov 22 16:13:17 2020 +0100

    ovpn-dco: avoid potential out of bound access in aead_decrypt()


I have just pushed a fix to master to address the bug.
Could you please give it a go?

Thanks a lot!

On 24/11/2020 08:38, Tony He wrote:
> Hi Antonio,
> 
> Did more test. Just FYI.
> 
> ba109be633f bad.
> 6eb6292a9d3 ?
> 0989291e816 good
> 
> Tony
> 
> Tony He <huangya90@...277... <mailto:huangya90@...277...>> 于2020年11月
> 24日周二 上午9:19写道：
> 
>     Hi Antonio,
> 
>     I'm using the latest commit 4b104be to test and encountered
>     following issue. I saw multi times in both peers. I never
>     encountered this issue  before commit c56b9d0. Can you reproduce?
> 
>     [  708.790419] ovpn_dco: module verification failed: signature
>     and/or required key missing - tainting kernel                      
>                                                                        
>                
>     [  708.790885] OpenVPN data channel offload (ovpn-dco) 4b104be-dirty
>     -- (C) 2020 OpenVPN, Inc.                                          
>                                                                        
>          
>     [  899.304454] BUG: kernel NULL pointer dereference, address:
>     0000000000000008                                                    
>                                                                        
>                
>     [  899.305245] #PF: supervisor read access in kernel mode          
>                                                                        
>                                                                        
>            
>     [  899.306044] #PF: error_code(0x0000) - not-present page          
>                                                                        
>                                                                        
>            
>     [  899.306825] PGD 0 P4D 0                                          
>                                                                        
>                                                                        
>          
>     [  899.307597] Oops: 0000 [#1] SMP PTI                              
>                                                                        
>                                                                        
>          
>     [  899.308335] CPU: 1 PID: 34 Comm: kworker/1:1 Tainted: G          
>     OE     5.4.0-54-generic #60-Ubuntu                                  
>                                                                        
>          
>     [  899.309922] Hardware name: innotek GmbH VirtualBox/VirtualBox,
>     BIOS VirtualBox 12/01/2006                                          
>                                                                        
>            
>     [  899.310887] Workqueue: ovpn-crypto-wq-tun0 ovpn_decrypt_work
>     [ovpn_dco]                                                          
>                                                                        
>              
>     [  899.311762] RIP: 0010:gcmaes_crypt_by_sg.constprop.0+0x244/0x6c0
>     [aesni_intel]                                                      
>                                                                        
>            
>     [  899.312518] Code: ac f8 48 83 f8 01 19 c0 f7 d0 83 e0 b6 eb 87 4c
>     8b 74 24 40 48 8d 7c 24 60 49 8b 76 40 41 8b 56 30 e8 10 eb ac f8 49
>     8b 76 48 <44> 8b 60 08 49 89 c5 49 39 76 40 0f 84 7d 02 00 00 41 8b
>     56 30
>      48                                                                
>                                                                        
>                                                                        
>            
>     [  899.315985] RSP: 0018:ffff9ed680127800 EFLAGS: 00010246          
>                                                                        
>                                                                        
>          
>     [  899.316843] RAX: 0000000000000000 RBX: 0000000000000030 RCX:
>     ffffe78440adf700                                                    
>                                                                        
>              
>     [  899.317489] RDX: 0000000000000008 RSI: ffff9ed680127bb0 RDI:
>     ffff9ed680127bb0                                                    
>                                                                        
>              
>     [  899.318143] RBP: ffff9ed680127aa0 R08: ffff9ed680127ab0 R09:
>     ffff8c8f7c9b1460                                                    
>                                                                        
>              
>     [  899.318777] R10: ffff9ed680127b88 R11: 0000000000000b6a R12:
>     0000000000000008                                                    
>                                                                        
>              
>     [  899.319581] R13: 0000000000000040 R14: ffff8c8f6ba4c590 R15:
>     ffff8c8f6b7dcb6a                                                    
>                                                                        
>              
>     [  899.320263] FS:  0000000000000000(0000) GS:ffff8c8f7eb00000(0000)
>     knlGS:0000000000000000                                              
>                                                                        
>          
>     [  899.320841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033    
>                                                                        
>                                                                        
>          
>     [  899.321486] CR2: 0000000000000008 CR3: 000000002d606003 CR4:
>     00000000000606e0                                                    
>                                                                        
>              
>     [  899.322060] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>     0000000000000000                                                    
>                                                                        
>              
>     [  899.322685] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>     0000000000000400                                                    
>                                                                        
>              
>     [  899.323232] Call Trace:                                          
>                                                                        
>                                                                        
>          
>     [  899.323780]  ? check_preempt_wakeup+0xfd/0x210                  
>                                                                        
>                                                                        
>            
>     [  899.324320]  ? check_preempt_curr+0x7a/0x90                      
>                                                                        
>                                                                        
>          
>     [  899.324853]  ? ttwu_do_wakeup+0x1e/0x150                        
>                                                                        
>                                                                        
>            
>     [  899.325360]  ? ttwu_do_activate+0x5b/0x70                        
>                                                                        
>                                                                        
>          
>     [  899.325825]  ? try_to_wake_up+0x224/0x6a0                        
>                                                                        
>                                                                        
>          
>     [  899.326303]  ? alloc_pages_current+0x87/0xe0                    
>                                                                        
>                                                                        
>            
>     [  899.326760]  ? __update_load_avg_cfs_rq+0x212/0x2f0              
>                                                                        
>                                                                        
>          
>     [  899.327216]  ? __update_load_avg_cfs_rq+0x212/0x2f0              
>                                                                        
>                                                                        
>          
>     [  899.327664]  ? sched_clock_cpu+0x11/0xb0                        
>                                                                        
>                                                                        
>            
>     [  899.328113]  ? update_blocked_averages+0x11c/0x590
>     [  899.328560]  ? update_group_capacity+0x2c/0x1d0
>     [  899.329007]  generic_gcmaes_decrypt+0x5b/0x80 [aesni_intel]
>     [  899.329466]  crypto_aead_decrypt+0x46/0x80
>     [  899.329905]  simd_aead_decrypt+0xa8/0xc0 [crypto_simd]
>     [  899.330456]  crypto_aead_decrypt+0x46/0x80
>     [  899.330884]  ovpn_aead_decrypt+0x268/0x3d0 [ovpn_dco]
>     [  899.331314]  ? __update_load_avg_cfs_rq+0x212/0x2f0
>     [  899.331734]  ? sched_clock_cpu+0x11/0xb0
>     [  899.332218]  ? x2apic_send_IPI+0x4a/0x50
>     [  899.332743]  ? native_send_call_func_single_ipi+0x1e/0x20
>     [  899.333122]  ? generic_exec_single+0x6e/0xd0
>     [  899.333523]  ? poke_int3_handler+0x80/0x80
>     [  899.333880]  ? smp_call_function_single+0xd1/0x110
>     [  899.334326]  ? poke_int3_handler+0x80/0x80
>     [  899.334696]  ? flush_tlb_mm_range+0xa1/0xe0
>     [  899.335042]  ? udp4_lib_lookup2+0x133/0x2d0
>     [  899.335366]  ? cpumask_next_and+0x1e/0x20
>     [  899.335685]  ? smp_call_function_many+0x23b/0x270
>     [  899.336165]  ? do_sync_core+0x1d/0x20
>     [  899.336494]  ? text_poke_bp_batch+0x106/0x160
>     [  899.336886]  ? arch_jump_label_transform_apply+0x3e/0x50
>     [  899.337209]  ? __jump_label_update+0x115/0x120
>     [  899.337505]  ovpn_decrypt_work+0x1c1/0x600 [ovpn_dco]
>     [  899.337803]  process_one_work+0x1eb/0x3b0
>     [  899.338113]  worker_thread+0x4d/0x400
>     [  899.338405]  kthread+0x104/0x140
>     [  899.338687]  ? process_one_work+0x3b0/0x3b0
>     [  899.338970]  ? kthread_park+0x90/0x90
>     [  899.339255]  ret_from_fork+0x35/0x40
>     [  899.339538] Modules linked in: ovpn_dco(OE) ip6_udp_tunnel
>     udp_tunnel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
>     intel_rapl_msr intel_rapl_common rapl input_leds serio_raw joydev
>     snd_intel8x0 snd_ac97
>     _codec ac97_bus snd_pcm snd_timer vboxguest(O) snd soundcore mac_hid
>     sch_fq_codel ip_tables x_tables autofs4 btrfs zstd_compress raid10
>     raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx
>     xor raid
>     6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid hid
>     crct10dif_pclmul crc32_pclmul ghash_clmulni_intel vboxvideo
>     drm_vram_helper ttm aesni_intel crypto_simd cryptd glue_helper
>     drm_kms_helper syscop
>     yarea sysfillrect sysimgblt fb_sys_fops psmouse ahci libahci
>     i2c_piix4 drm pata_acpi e1000 video
>     [  899.342316] CR2: 0000000000000008
>     [  899.342686] ---[ end trace dd4dab57d5473bc0 ]---
>     [  899.343082] RIP: 0010:gcmaes_crypt_by_sg.constprop.0+0x244/0x6c0
>     [aesni_intel]
>     [  899.343451] Code: ac f8 48 83 f8 01 19 c0 f7 d0 83 e0 b6 eb 87 4c
>     8b 74 24 40 48 8d 7c 24 60 49 8b 76 40 41 8b 56 30 e8 10 eb ac f8 49
>     8b 76 48 <44> 8b 60 08 49 89 c5 49 39 76 40 0f 84 7d 02 00 00 41 8b
>     56 30
>      48
>     [  899.344605] RSP: 0018:ffff9ed680127800 EFLAGS: 00010246
>     [  899.344989] RAX: 0000000000000000 RBX: 0000000000000030 RCX:
>     ffffe78440adf700
>     [  899.345381] RDX: 0000000000000008 RSI: ffff9ed680127bb0 RDI:
>     ffff9ed680127bb0
>     [  899.345772] RBP: ffff9ed680127aa0 R08: ffff9ed680127ab0 R09:
>     ffff8c8f7c9b1460
>     [  899.346213] R10: ffff9ed680127b88 R11: 0000000000000b6a R12:
>     0000000000000008
>     [  899.346624] R13: 0000000000000040 R14: ffff8c8f6ba4c590 R15:
>     ffff8c8f6b7dcb6a
>     [  899.347153] FS:  0000000000000000(0000) GS:ffff8c8f7eb00000(0000)
>     knlGS:0000000000000000
>     [  899.347550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [  899.347948] CR2: 0000000000000008 CR3: 000000002d606003 CR4:
>     00000000000606e0
>     [  899.348382] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>     0000000000000000
>     [  899.348798] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>     0000000000000400
> 
>     Tony
> 

-- 
Antonio Quartulli

