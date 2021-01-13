References: <CAAUX2SXTUi0psQgNxm_8Z6YfkNTdQ7Q12cS5pKfjRp9V3ohFOQ@...278...>
 <CAAUX2SXVXabk6jucwj8DUF4vAf2NtWeCer6jDU90k05ys9NxbQ@...278...>
 <a5adfb07-2958-4e4a-f99f-fbbc50cd68f8@...2181...>
 <d13f9030-7178-b3c4-a20a-4a5dd4378f1e@...2181...>
 <CAAUX2SWPkoVTCi9NbA9xzAR_M=EANVKP-O-So-Kjj7pvviZ5=Q@...278...>
 <8b79df02-bc95-6c96-806d-0e0a7309b858@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8018e3d3-3c84-9ce5-7d37-7ad9bca4d3cf@...2181...>
Date: Wed, 13 Jan 2021 17:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <8b79df02-bc95-6c96-806d-0e0a7309b858@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] 
 =?utf-8?q?=5Bovpn-dco=5Dcompilation_error_in_fun?=
 =?utf-8?b?Y3Rpb24g4oCYb3Zwbl9wZWVyX2xvb2t1cF90cmFuc3BfYWRkcuKAmQ==?=
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
To: openvpn-devel@lists.sourceforge.net, Tony He <huangya90@...277...>

Potential fix pushed to the experimental branch.

Thanks again for reporting.

On 13/01/2021 14:18, Antonio Quartulli wrote:
> It turns our this is a bug in my experimental branch :-)
> 
> The object pointed by sa6 is not large enough, hence triggering that error.
> 
> Will come up with a fix.
> 
> Thanks!
> 
> On 13/01/2021 11:17, Tony He wrote:
>> Hi Antonio,
>>
>> Yes, I'm using latest commit. Maybe it's a compiler bug. What's your
>> compiler version?
>> Here is mine.
>> tony-vm-2004% gcc --version
>> gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
>> Copyright (C) 2019 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>
>>
>>
>> Antonio Quartulli <a@...2181...> 于2021年1月13日周三 下午5:17写道：
>>
>>     Also,
>>
>>     are you sure you are compiling the latest experimental branch?
>>     HEAD is 2555e5595088991006e57a3ee447f356dffdca92
>>
>>     Regards,
>>
>>     On 13/01/2021 10:12, Antonio Quartulli wrote:
>>     > Hi Tony,
>>     >
>>     > thanks for the message.
>>     > The experimental branch is still...experimental, so I expect more
>>     things
>>     > to crash and fail miserably :-D
>>     >
>>     > In any case, feel free to send a patch if you see how to fix the
>>     issue!
>>     > It would be nice to have external contributions :-)
>>     >
>>     > This said, I am not sure this is our bug - the sin6_addr member of
>>     > struct sockaddr_in6 is of type struct sin6_addr:
>>     >
>>     >
>>     https://elixir.bootlin.com/linux/v5.4/source/include/uapi/linux/in6.h#L54
>>     <https://elixir.bootlin.com/linux/v5.4/source/include/uapi/linux/in6.h#L54>
>>     >
>>     > And I believe it is widely known that an IPv6 address is 12 bytes,
>>     not 8..
>>     >
>>     > Maybe it's a bug in the compiler?
>>     >
>>     > Best Regards,
>>     >
>>     > On 13/01/2021 10:03, Tony He wrote:
>>     >> Sorry, clicked "send" button before adding subject and CC
>>     Openvpn-dev. I
>>     >> will send a new mail.
>>     >>
>>     >> Tony He <huangya90@...277... <mailto:huangya90@...277...>
>>     <mailto:huangya90@...277... <mailto:huangya90@...277...>>> 于2021年1月13
>>     >> 日周三 下午4:57写道：
>>     >>
>>     >>     Hi Antonio,
>>     >>
>>     >>     I see you have pushed new commits to support multiple link to
>>     peers.
>>     >>     So I tried compiling, but encounter below error. My kernel
>>     version
>>     >>     is 5.4.0-54.
>>     >>
>>     >>
>>     >>
>>     >>     tony-vm-2004% make                                          
>>            
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>          
>>     >>     /project/openvpn/ovpn-dco.git/gen-compat-autoconf.sh
>>     >>     /project/openvpn/ovpn-dco.git/compat-autoconf.h              
>>          
>>     >>                                                                  
>>          
>>     >>                          
>>     >>     make -C /lib/modules/5.4.0-54-generic/build
>>     >>     M=/project/openvpn/ovpn-dco.git PWD=/project/openvpn/ovpn-dco.git
>>     >>     REVISION=2555e55 CONFIG_OVPN_DCO=m INSTALL_MOD_DIR=updates/      
>>     >>     modules                            
>>     >>     make[1]: Entering directory
>>     >>     '/usr/src/linux-headers-5.4.0-54-generic'                    
>>          
>>     >>                                                                  
>>          
>>     >>                                                    
>>     >>       CC [M]
>>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/main.o
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>       CC [M]
>>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/bind.o
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>       CC [M]
>>     >>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/crypto.o
>>            
>>     >>                                                                  
>>          
>>     >>                                                                      
>>     >>       CC [M]
>>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/ovpn.o
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>       CC [M]
>>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.o
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>     In file included from ./include/linux/bitmap.h:9,            
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./include/linux/cpumask.h:12,          
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./arch/x86/include/asm/cpumask.h:5,    
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./arch/x86/include/asm/msr.h:11,      
>>            
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>          
>>     >>                      from ./arch/x86/include/asm/processor.h:21,
>>            
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>          
>>     >>                      from ./arch/x86/include/asm/cpufeature.h:5,
>>            
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>          
>>     >>                      from
>>     ./arch/x86/include/asm/thread_info.h:53,      
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>          
>>     >>                      from ./include/linux/thread_info.h:38,      
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./arch/x86/include/asm/preempt.h:7,    
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./include/linux/preempt.h:78,          
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./include/linux/spinlock.h:51,        
>>            
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>          
>>     >>                      from ./include/linux/seqlock.h:36,          
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./include/linux/time.h:6,              
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./include/linux/ktime.h:24,            
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from ./include/linux/timer.h:6,            
>>            
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>          
>>     >>                      from ./include/linux/netdevice.h:24,        
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>                      from
>>     >>     /project/openvpn/ovpn-dco.git/linux-compat.h:20,            
>>            
>>     >>                                                                  
>>          
>>     >>                                                        
>>     >>                      from <command-line>:                        
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>     In function ‘memcmp’,                                        
>>          
>>     >>                                                                  
>>          
>>     >>                                                                  
>>          
>>     >>            
>>     >>         inlined from ‘ovpn_peer_lookup_transp_addr’ at
>>     >>   
>>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.c:457:8:    
>>     >>                                                                  
>>          
>>     >>                            
>>     >>     ./include/linux/string.h:440:4: error: call to ‘__read_overflow’
>>     >>     declared with attribute error: detected read beyond size of
>>     object
>>     >>     passed as 1st parameter                                      
>>          
>>     >>                
>>     >>       440 |    __read_overflow();
>>     >>           |    ^~~~~~~~~~~~~~~~~
>>     >>     make[3]: *** [scripts/Makefile.build:275:
>>     >>     /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.o]
>>     Error 1
>>     >>     make[2]: *** [scripts/Makefile.build:522:
>>     >>     /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco] Error 2
>>     >>     make[1]: *** [Makefile:1757: /project/openvpn/ovpn-dco.git]
>>     Error 2
>>     >>     make[1]: Leaving directory
>>     '/usr/src/linux-headers-5.4.0-54-generic'
>>     >>     make: *** [Makefile:46: all] Error 2
>>     >>
>>     >>
>>     >>     Function memcmp
>>     >>   
>>      in /usr/src/linux-headers-5.4.0-54-generic/include/linux/string.h.
>>     >>     434 __FORTIFY_INLINE int memcmp(const void *p, const void *q,
>>     >>     __kernel_size_t size)
>>     >>     435 {
>>     >>     436         size_t p_size = __builtin_object_size(p, 0);
>>     >>     437         size_t q_size = __builtin_object_size(q, 0);
>>     >>     438         if (__builtin_constant_p(size)) {
>>     >>     439                 if (p_size < size)
>>     >>     440                         __read_overflow();
>>     >>     441                 if (q_size < size)
>>     >>     442                         __read_overflow2();
>>     >>     443         }
>>     >>     444         if (p_size < size || q_size < size)
>>     >>     445                 fortify_panic(__func__);
>>     >>     446         return __underlying_memcmp(p, q, size);
>>     >>     447 }
>>     >>
>>     >>     Seems that p_size is 8 in above memcmp function because if I
>>     change
>>     >>     your code as below , then it's OK(9 causes same error).
>>     >>     456                 case AF_INET6:
>>     >>     457                         if (memcmp((void *)&sa6->sin6_addr,
>>     >>     (void *)&bind->sa.in6.sin6_addr,
>>     >>     458                                 //   sizeof(struct
>>     in6_addr)))
>>     >>     459                                         8))
>>     >>     460                                 break;
>>     >>
>>     >>     Tony
>>     >>
>>     >
>>
>>     -- 
>>     Antonio Quartulli
>>
> 

-- 
Antonio Quartulli

