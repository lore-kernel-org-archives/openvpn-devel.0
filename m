MIME-Version: 1.0
References: <CAAUX2SXTUi0psQgNxm_8Z6YfkNTdQ7Q12cS5pKfjRp9V3ohFOQ@...278...>
 <CAAUX2SXVXabk6jucwj8DUF4vAf2NtWeCer6jDU90k05ys9NxbQ@...278...>
In-Reply-To: <CAAUX2SXVXabk6jucwj8DUF4vAf2NtWeCer6jDU90k05ys9NxbQ@...278...>
From: Tony He <huangya90@...277...>
Date: Wed, 13 Jan 2021 17:11:52 +0800
Message-ID: <CAAUX2SWgrHwo9yUJhKWGsM+5U5rLAr3hUbcv3hXu7T2vndC+kg@...278...>
Content-Type: multipart/alternative; boundary="000000000000585cd805b8c4883a"
Subject: Re: [Openvpn-devel] 
	=?utf-8?q?=5Bovpn-dco=5D_compilation_error_in_fu?=
	=?utf-8?b?bmN0aW9uIOKAmG92cG5fcGVlcl9sb29rdXBfdHJhbnNwX2FkZHLigJk=?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Antonio Quartulli <antonio@...515...>, lev@...515...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000585cd805b8c4883a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

change the subject.

Tony He <huangya90@...277...> =E4=BA=8E2021=E5=B9=B41=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:03=E5=86=99=E9=81=93=EF=BC=9A

> Sorry, clicked "send" button before adding subject and CC Openvpn-dev. I
> will send a new mail.
>
> Tony He <huangya90@...277...> =E4=BA=8E2021=E5=B9=B41=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:57=E5=86=99=E9=81=93=EF=BC=9A
>
>> Hi Antonio,
>>
>> I see you have pushed new commits to support multiple link to peers. So I
>> tried compiling, but encounter below error. My kernel version is 5.4.0-5=
4.
>>
>>
>>
>> tony-vm-2004% make
>>
>>
>> /project/openvpn/ovpn-dco.git/gen-compat-autoconf.sh
>> /project/openvpn/ovpn-dco.git/compat-autoconf.h
>>
>>
>> make -C /lib/modules/5.4.0-54-generic/build
>> M=3D/project/openvpn/ovpn-dco.git PWD=3D/project/openvpn/ovpn-dco.git
>> REVISION=3D2555e55 CONFIG_OVPN_DCO=3Dm INSTALL_MOD_DIR=3Dupdates/       =
modules
>>
>> make[1]: Entering directory '/usr/src/linux-headers-5.4.0-54-generic'
>>
>>
>>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/main.o
>>
>>
>>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/bind.o
>>
>>
>>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/crypto.o
>>
>>
>>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/ovpn.o
>>
>>
>>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.o
>>
>>
>> In file included from ./include/linux/bitmap.h:9,
>>
>>
>>                  from ./include/linux/cpumask.h:12,
>>
>>
>>                  from ./arch/x86/include/asm/cpumask.h:5,
>>
>>
>>                  from ./arch/x86/include/asm/msr.h:11,
>>
>>
>>                  from ./arch/x86/include/asm/processor.h:21,
>>
>>
>>                  from ./arch/x86/include/asm/cpufeature.h:5,
>>
>>
>>                  from ./arch/x86/include/asm/thread_info.h:53,
>>
>>
>>                  from ./include/linux/thread_info.h:38,
>>
>>
>>                  from ./arch/x86/include/asm/preempt.h:7,
>>
>>
>>                  from ./include/linux/preempt.h:78,
>>
>>
>>                  from ./include/linux/spinlock.h:51,
>>
>>
>>                  from ./include/linux/seqlock.h:36,
>>
>>
>>                  from ./include/linux/time.h:6,
>>
>>
>>                  from ./include/linux/ktime.h:24,
>>
>>
>>                  from ./include/linux/timer.h:6,
>>
>>
>>                  from ./include/linux/netdevice.h:24,
>>
>>
>>                  from /project/openvpn/ovpn-dco.git/linux-compat.h:20,
>>
>>
>>                  from <command-line>:
>>
>>
>> In function =E2=80=98memcmp=E2=80=99,
>>
>>
>>     inlined from =E2=80=98ovpn_peer_lookup_transp_addr=E2=80=99 at
>> /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.c:457:8:
>>
>>
>> ./include/linux/string.h:440:4: error: call to =E2=80=98__read_overflow=
=E2=80=99 declared
>> with attribute error: detected read beyond size of object passed as 1st
>> parameter
>>   440 |    __read_overflow();
>>       |    ^~~~~~~~~~~~~~~~~
>> make[3]: *** [scripts/Makefile.build:275:
>> /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.o] Error 1
>> make[2]: *** [scripts/Makefile.build:522:
>> /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco] Error 2
>> make[1]: *** [Makefile:1757: /project/openvpn/ovpn-dco.git] Error 2
>> make[1]: Leaving directory '/usr/src/linux-headers-5.4.0-54-generic'
>> make: *** [Makefile:46: all] Error 2
>>
>>
>> Function memcmp
>> in /usr/src/linux-headers-5.4.0-54-generic/include/linux/string.h.
>> 434 __FORTIFY_INLINE int memcmp(const void *p, const void *q,
>> __kernel_size_t size)
>> 435 {
>> 436         size_t p_size =3D __builtin_object_size(p, 0);
>> 437         size_t q_size =3D __builtin_object_size(q, 0);
>> 438         if (__builtin_constant_p(size)) {
>> 439                 if (p_size < size)
>> 440                         __read_overflow();
>> 441                 if (q_size < size)
>> 442                         __read_overflow2();
>> 443         }
>> 444         if (p_size < size || q_size < size)
>> 445                 fortify_panic(__func__);
>> 446         return __underlying_memcmp(p, q, size);
>> 447 }
>>
>> Seems that p_size is 8 in above memcmp function because if I change your
>> code as below , then it's OK(9 causes same error).
>> 456                 case AF_INET6:
>> 457                         if (memcmp((void *)&sa6->sin6_addr, (void
>> *)&bind->sa.in6.sin6_addr,
>> 458                                 //   sizeof(struct in6_addr)))
>> 459                                         8))
>> 460                                 break;
>>
>> Tony
>>
>

--000000000000585cd805b8c4883a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5jaGFuZ2UgdGhlIHN1YmplY3QuPC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+VG9ueSBI
ZSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmh1YW5neWE5MEAuLi4yNzcuLi4iPmh1YW5neWE5MEAuLi4y
NzcuLi48L2E+Jmd0OyDkuo4yMDIx5bm0MeaciDEz5pel5ZGo5LiJIOS4i+WNiDU6MDPlhpnpgZPv
vJo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQp
O3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPlNvcnJ5LCBjbGlja2VkICZxdW90O3Nl
bmQmcXVvdDsgYnV0dG9uIGJlZm9yZSBhZGRpbmcgc3ViamVjdCBhbmQgQ0MgT3BlbnZwbi1kZXYu
IEkgd2lsbCBzZW5kIGEgbmV3IG1haWwuPC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+VG9ueSBIZSAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmh1YW5neWE5MEAuLi4yNzcuLi4iIHRhcmdldD0iX2JsYW5rIj5odWFuZ3lhOTBALi4u
Mjc3Li4uPC9hPiZndDsg5LqOMjAyMeW5tDHmnIgxM+aXpeWRqOS4iSDkuIvljYg0OjU35YaZ6YGT
77yaPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj5IaSBBbnRvbmlvLDxkaXY+PGJyPjwv
ZGl2PjxkaXY+SSBzZWUgeW91IGhhdmUgcHVzaGVkIG5ldyBjb21taXRzIHRvIHN1cHBvcnTCoG11
bHRpcGxlIGxpbmsgdG8gcGVlcnMuIFNvIEkgdHJpZWQgY29tcGlsaW5nLCBidXQgZW5jb3VudGVy
IGJlbG93IGVycm9yLiBNeSBrZXJuZWwgdmVyc2lvbiBpcyA1LjQuMC01NC48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnRvbnktdm0tMjAwNCUg
bWFrZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCA8YnI+L3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRjby5naXQvZ2VuLWNvbXBhdC1hdXRv
Y29uZi5zaCAvcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdC9jb21wYXQtYXV0b2NvbmYuaCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+bWFr
ZSAtQyAvbGliL21vZHVsZXMvNS40LjAtNTQtZ2VuZXJpYy9idWlsZCBNPS9wcm9qZWN0L29wZW52
cG4vb3Zwbi1kY28uZ2l0IFBXRD0vcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdCBSRVZJU0lP
Tj0yNTU1ZTU1IENPTkZJR19PVlBOX0RDTz1tIElOU1RBTExfTU9EX0RJUj11cGRhdGVzLyDCoCDC
oCDCoCBtb2R1bGVzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
Pm1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSAmIzM5Oy91c3Ivc3JjL2xpbnV4LWhlYWRlcnMt
NS40LjAtNTQtZ2VuZXJpYyYjMzk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPsKgIENDIFtNXSDCoC9wcm9qZWN0L29wZW52cG4vb3Zwbi1kY28uZ2l0L2RyaXZl
cnMvbmV0L292cG4tZGNvL21haW4ubyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj7CoCBDQyBbTV0gwqAvcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdC9k
cml2ZXJzL25ldC9vdnBuLWRjby9iaW5kLm8gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+wqAgQ0MgW01dIMKgL3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRjby5n
aXQvZHJpdmVycy9uZXQvb3Zwbi1kY28vY3J5cHRvLm8gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgQ0MgW01dIMKgL3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRj
by5naXQvZHJpdmVycy9uZXQvb3Zwbi1kY28vb3Zwbi5vIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIENDIFtNXSDCoC9wcm9qZWN0L29wZW52cG4vb3Zw
bi1kY28uZ2l0L2RyaXZlcnMvbmV0L292cG4tZGNvL3BlZXIubyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5JbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9pbmNs
dWRlL2xpbnV4L2JpdG1hcC5oOjksIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZnJvbSAuL2luY2x1ZGUvbGludXgvY3B1bWFzay5oOjEyLCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9j
cHVtYXNrLmg6NSwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4vYXJjaC94
ODYvaW5jbHVkZS9hc20vbXNyLmg6MTEsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaDoyMSwgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUu
aDo1LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4vYXJjaC94ODYvaW5jbHVkZS9h
c20vdGhyZWFkX2luZm8uaDo1MywgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2luY2x1
ZGUvbGludXgvdGhyZWFkX2luZm8uaDozOCwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBmcm9tIC4vYXJjaC94ODYvaW5jbHVkZS9hc20vcHJlZW1wdC5oOjcsIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2luY2x1ZGUvbGludXgvcHJlZW1wdC5oOjc4LCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gLi9pbmNsdWRlL2xp
bnV4L3NwaW5sb2NrLmg6NTEsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGZyb20gLi9pbmNsdWRlL2xpbnV4L3NlcWxvY2suaDozNiwgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4vaW5jbHVkZS9saW51eC90aW1lLmg6NiwgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4vaW5jbHVkZS9s
aW51eC9rdGltZS5oOjI0LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGZyb20gLi9pbmNsdWRlL2xpbnV4L3RpbWVyLmg6NiwgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2luY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmg6
MjQsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAvcHJvamVjdC9v
cGVudnBuL292cG4tZGNvLmdpdC9saW51eC1jb21wYXQuaDoyMCwgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAm
bHQ7Y29tbWFuZC1saW5lJmd0OzogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
SW4gZnVuY3Rpb24g4oCYbWVtY21w4oCZLCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoCDCoCBpbmxpbmVkIGZyb20g4oCYb3Zwbl9w
ZWVyX2xvb2t1cF90cmFuc3BfYWRkcuKAmSBhdCAvcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdp
dC9kcml2ZXJzL25ldC9vdnBuLWRjby9wZWVyLmM6NDU3Ojg6IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPi4vaW5jbHVkZS9saW51eC9zdHJpbmcuaDo0NDA6NDogZXJyb3I6IGNhbGwg
dG8g4oCYX19yZWFkX292ZXJmbG934oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBk
ZXRlY3RlZCByZWFkIGJleW9uZCBzaXplIG9mIG9iamVjdCBwYXNzZWQgYXMgMXN0IHBhcmFtZXRl
ciDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoCA0NDAgfCDCoCDCoF9fcmVhZF9vdmVy
ZmxvdygpOzxicj7CoCDCoCDCoCB8IMKgIMKgXn5+fn5+fn5+fn5+fn5+fn48YnI+bWFrZVszXTog
KioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI3NTogL3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRj
by5naXQvZHJpdmVycy9uZXQvb3Zwbi1kY28vcGVlci5vXSBFcnJvciAxPGJyPm1ha2VbMl06ICoq
KiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MjI6IC9wcm9qZWN0L29wZW52cG4vb3Zwbi1kY28u
Z2l0L2RyaXZlcnMvbmV0L292cG4tZGNvXSBFcnJvciAyPGJyPm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6MTc1NzogL3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRjby5naXRdIEVycm9yIDI8YnI+bWFrZVsx
XTogTGVhdmluZyBkaXJlY3RvcnkgJiMzOTsvdXNyL3NyYy9saW51eC1oZWFkZXJzLTUuNC4wLTU0
LWdlbmVyaWMmIzM5Ozxicj5tYWtlOiAqKiogW01ha2VmaWxlOjQ2OiBhbGxdIEVycm9yIDI8YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5GdW5jdGlvbiBtZW1jbXAg
aW7CoC91c3Ivc3JjL2xpbnV4LWhlYWRlcnMtNS40LjAtNTQtZ2VuZXJpYy9pbmNsdWRlL2xpbnV4
L3N0cmluZy5oLjwvZGl2PjxkaXY+NDM0IF9fRk9SVElGWV9JTkxJTkUgaW50IG1lbWNtcChjb25z
dCB2b2lkICpwLCBjb25zdCB2b2lkICpxLCBfX2tlcm5lbF9zaXplX3Qgc2l6ZSk8YnI+NDM1IHs8
YnI+NDM2IMKgIMKgIMKgIMKgIHNpemVfdCBwX3NpemUgPSBfX2J1aWx0aW5fb2JqZWN0X3NpemUo
cCwgMCk7PGJyPjQzNyDCoCDCoCDCoCDCoCBzaXplX3QgcV9zaXplID0gX19idWlsdGluX29iamVj
dF9zaXplKHEsIDApOzxicj40MzggwqAgwqAgwqAgwqAgaWYgKF9fYnVpbHRpbl9jb25zdGFudF9w
KHNpemUpKSB7PGJyPjQzOSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocF9zaXplICZsdDsg
c2l6ZSk8YnI+NDQwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9fcmVhZF9v
dmVyZmxvdygpOzxicj40NDEgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHFfc2l6ZSAmbHQ7
IHNpemUpPGJyPjQ0MiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX3JlYWRf
b3ZlcmZsb3cyKCk7PGJyPjQ0MyDCoCDCoCDCoCDCoCB9PGJyPjQ0NCDCoCDCoCDCoCDCoCBpZiAo
cF9zaXplICZsdDsgc2l6ZSB8fCBxX3NpemUgJmx0OyBzaXplKTxicj40NDUgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZm9ydGlmeV9wYW5pYyhfX2Z1bmNfXyk7PGJyPjQ0NiDCoCDCoCDCoCDCoCBy
ZXR1cm4gX191bmRlcmx5aW5nX21lbWNtcChwLCBxLCBzaXplKTs8YnI+NDQ3IH08L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PlNlZW1zIHRoYXQgcF9zaXplIGlzIDggaW4gYWJvdmUgbWVtY21wIGZ1
bmN0aW9uIGJlY2F1c2UgaWYgSSBjaGFuZ2UgeW91ciBjb2RlIGFzIGJlbG93ICwgdGhlbiBpdCYj
Mzk7cyBPSyg5IGNhdXNlcyBzYW1lIGVycm9yKS48YnI+PC9kaXY+PGRpdj40NTYgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgY2FzZSBBRl9JTkVUNjo8YnI+NDU3IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmIChtZW1jbXAoKHZvaWQgKikmYW1wO3NhNi0mZ3Q7c2luNl9hZGRy
LCAodm9pZCAqKSZhbXA7YmluZC0mZ3Q7c2EuaW42LnNpbjZfYWRkciw8YnI+NDU4IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8vIMKgIHNpemVvZihzdHJ1
Y3QgaW42X2FkZHIpKSk8YnI+NDU5wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA4KSk8YnI+NDYwIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PlRvbnk8L2Rpdj48L2Rpdj4NCjwvYmxvY2txdW90ZT48L2Rpdj4NCjwvYmxvY2txdW90
ZT48L2Rpdj48L2Rpdj4NCg==

--000000000000585cd805b8c4883a--

