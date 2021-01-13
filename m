MIME-Version: 1.0
References: <CAAUX2SXTUi0psQgNxm_8Z6YfkNTdQ7Q12cS5pKfjRp9V3ohFOQ@...278...>
In-Reply-To: <CAAUX2SXTUi0psQgNxm_8Z6YfkNTdQ7Q12cS5pKfjRp9V3ohFOQ@...278...>
From: Tony He <huangya90@...277...>
Date: Wed, 13 Jan 2021 17:03:30 +0800
Message-ID: <CAAUX2SXVXabk6jucwj8DUF4vAf2NtWeCer6jDU90k05ys9NxbQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000062bbd905b8c46a98"
Subject: Re: [Openvpn-devel] [ovpn-dco]
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

--00000000000062bbd905b8c46a98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, clicked "send" button before adding subject and CC Openvpn-dev. I
will send a new mail.

Tony He <huangya90@...277...> =E4=BA=8E2021=E5=B9=B41=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:57=E5=86=99=E9=81=93=EF=BC=9A

> Hi Antonio,
>
> I see you have pushed new commits to support multiple link to peers. So I
> tried compiling, but encounter below error. My kernel version is 5.4.0-54.
>
>
>
> tony-vm-2004% make
>
>
> /project/openvpn/ovpn-dco.git/gen-compat-autoconf.sh
> /project/openvpn/ovpn-dco.git/compat-autoconf.h
>
>
> make -C /lib/modules/5.4.0-54-generic/build
> M=3D/project/openvpn/ovpn-dco.git PWD=3D/project/openvpn/ovpn-dco.git
> REVISION=3D2555e55 CONFIG_OVPN_DCO=3Dm INSTALL_MOD_DIR=3Dupdates/       m=
odules
>
> make[1]: Entering directory '/usr/src/linux-headers-5.4.0-54-generic'
>
>
>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/main.o
>
>
>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/bind.o
>
>
>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/crypto.o
>
>
>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/ovpn.o
>
>
>   CC [M]  /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.o
>
>
> In file included from ./include/linux/bitmap.h:9,
>
>
>                  from ./include/linux/cpumask.h:12,
>
>
>                  from ./arch/x86/include/asm/cpumask.h:5,
>
>
>                  from ./arch/x86/include/asm/msr.h:11,
>
>
>                  from ./arch/x86/include/asm/processor.h:21,
>
>
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>
>
>                  from ./arch/x86/include/asm/thread_info.h:53,
>
>
>                  from ./include/linux/thread_info.h:38,
>
>
>                  from ./arch/x86/include/asm/preempt.h:7,
>
>
>                  from ./include/linux/preempt.h:78,
>
>
>                  from ./include/linux/spinlock.h:51,
>
>
>                  from ./include/linux/seqlock.h:36,
>
>
>                  from ./include/linux/time.h:6,
>
>
>                  from ./include/linux/ktime.h:24,
>
>
>                  from ./include/linux/timer.h:6,
>
>
>                  from ./include/linux/netdevice.h:24,
>
>
>                  from /project/openvpn/ovpn-dco.git/linux-compat.h:20,
>
>
>                  from <command-line>:
>
>
> In function =E2=80=98memcmp=E2=80=99,
>
>
>     inlined from =E2=80=98ovpn_peer_lookup_transp_addr=E2=80=99 at
> /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.c:457:8:
>
>
> ./include/linux/string.h:440:4: error: call to =E2=80=98__read_overflow=
=E2=80=99 declared
> with attribute error: detected read beyond size of object passed as 1st
> parameter
>   440 |    __read_overflow();
>       |    ^~~~~~~~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:275:
> /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.o] Error 1
> make[2]: *** [scripts/Makefile.build:522:
> /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco] Error 2
> make[1]: *** [Makefile:1757: /project/openvpn/ovpn-dco.git] Error 2
> make[1]: Leaving directory '/usr/src/linux-headers-5.4.0-54-generic'
> make: *** [Makefile:46: all] Error 2
>
>
> Function memcmp
> in /usr/src/linux-headers-5.4.0-54-generic/include/linux/string.h.
> 434 __FORTIFY_INLINE int memcmp(const void *p, const void *q,
> __kernel_size_t size)
> 435 {
> 436         size_t p_size =3D __builtin_object_size(p, 0);
> 437         size_t q_size =3D __builtin_object_size(q, 0);
> 438         if (__builtin_constant_p(size)) {
> 439                 if (p_size < size)
> 440                         __read_overflow();
> 441                 if (q_size < size)
> 442                         __read_overflow2();
> 443         }
> 444         if (p_size < size || q_size < size)
> 445                 fortify_panic(__func__);
> 446         return __underlying_memcmp(p, q, size);
> 447 }
>
> Seems that p_size is 8 in above memcmp function because if I change your
> code as below , then it's OK(9 causes same error).
> 456                 case AF_INET6:
> 457                         if (memcmp((void *)&sa6->sin6_addr, (void
> *)&bind->sa.in6.sin6_addr,
> 458                                 //   sizeof(struct in6_addr)))
> 459                                         8))
> 460                                 break;
>
> Tony
>

--00000000000062bbd905b8c46a98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+U29ycnksIGNsaWNrZWQgJnF1b3Q7c2VuZCZxdW90OyBidXR0b24gYmVm
b3JlIGFkZGluZyBzdWJqZWN0IGFuZCBDQyBPcGVudnBuLWRldi4gSSB3aWxsIHNlbmQgYSBuZXcg
bWFpbC48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNs
YXNzPSJnbWFpbF9hdHRyIj5Ub255IEhlICZsdDs8YSBocmVmPSJtYWlsdG86aHVhbmd5YTkwQC4u
LjI3Ny4uLiI+aHVhbmd5YTkwQC4uLjI3Ny4uLjwvYT4mZ3Q7IOS6jjIwMjHlubQx5pyIMTPml6Xl
kajkuIkg5LiL5Y2INDo1N+WGmemBk++8mjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+
SGkgQW50b25pbyw8ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgc2VlIHlvdSBoYXZlIHB1c2hlZCBuZXcg
Y29tbWl0cyB0byBzdXBwb3J0wqBtdWx0aXBsZSBsaW5rIHRvIHBlZXJzLiBTbyBJIHRyaWVkIGNv
bXBpbGluZywgYnV0IGVuY291bnRlciBiZWxvdyBlcnJvci4gTXkga2VybmVsIHZlcnNpb24gaXMg
NS40LjAtNTQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj50b255LXZtLTIwMDQlIG1ha2UgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPi9wcm9qZWN0L29wZW52cG4vb3Zwbi1k
Y28uZ2l0L2dlbi1jb21wYXQtYXV0b2NvbmYuc2ggL3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRjby5n
aXQvY29tcGF0LWF1dG9jb25mLmggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgPGJyPm1ha2UgLUMgL2xpYi9tb2R1bGVzLzUuNC4wLTU0LWdlbmVyaWMv
YnVpbGQgTT0vcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdCBQV0Q9L3Byb2plY3Qvb3BlbnZw
bi9vdnBuLWRjby5naXQgUkVWSVNJT049MjU1NWU1NSBDT05GSUdfT1ZQTl9EQ089bSBJTlNUQUxM
X01PRF9ESVI9dXBkYXRlcy8gwqAgwqAgwqAgbW9kdWxlcyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj5tYWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkgJiMzOTsv
dXNyL3NyYy9saW51eC1oZWFkZXJzLTUuNC4wLTU0LWdlbmVyaWMmIzM5OyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoCBDQyBbTV0gwqAvcHJvamVjdC9vcGVu
dnBuL292cG4tZGNvLmdpdC9kcml2ZXJzL25ldC9vdnBuLWRjby9tYWluLm8gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgQ0MgW01dIMKgL3Byb2plY3Qv
b3BlbnZwbi9vdnBuLWRjby5naXQvZHJpdmVycy9uZXQvb3Zwbi1kY28vYmluZC5vIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIENDIFtNXSDCoC9wcm9q
ZWN0L29wZW52cG4vb3Zwbi1kY28uZ2l0L2RyaXZlcnMvbmV0L292cG4tZGNvL2NyeXB0by5vIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIENDIFtNXSDCoC9w
cm9qZWN0L29wZW52cG4vb3Zwbi1kY28uZ2l0L2RyaXZlcnMvbmV0L292cG4tZGNvL292cG4ubyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoCBDQyBbTV0g
wqAvcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdC9kcml2ZXJzL25ldC9vdnBuLWRjby9wZWVy
Lm8gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+SW4gZmls
ZSBpbmNsdWRlZCBmcm9tIC4vaW5jbHVkZS9saW51eC9iaXRtYXAuaDo5LCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gLi9pbmNsdWRlL2xpbnV4L2NwdW1h
c2suaDoxMiwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4v
YXJjaC94ODYvaW5jbHVkZS9hc20vY3B1bWFzay5oOjUsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oOjExLCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4vYXJjaC94ODYvaW5jbHVkZS9hc20vcHJv
Y2Vzc29yLmg6MjEsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gLi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9jcHVmZWF0dXJlLmg6NSwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJv
bSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmg6NTMsIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGZyb20gLi9pbmNsdWRlL2xpbnV4L3RocmVhZF9pbmZvLmg6MzgsIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL3By
ZWVtcHQuaDo3LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gLi9pbmNsdWRl
L2xpbnV4L3ByZWVtcHQuaDo3OCwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBmcm9tIC4vaW5jbHVkZS9saW51eC9zcGlubG9jay5oOjUxLCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4vaW5jbHVkZS9saW51eC9zZXFsb2NrLmg6MzYs
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2luY2x1ZGUv
bGludXgvdGltZS5oOjYsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZnJvbSAuL2luY2x1ZGUvbGludXgva3RpbWUuaDoyNCwgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4vaW5jbHVkZS9saW51eC90aW1lci5oOjYs
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gLi9pbmNs
dWRlL2xpbnV4L25ldGRldmljZS5oOjI0LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGZyb20gL3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRjby5naXQvbGludXgtY29tcGF0Lmg6
MjAsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZyb20gJmx0O2NvbW1hbmQtbGluZSZndDs6IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPkluIGZ1bmN0aW9uIOKAmG1lbWNtcOKAmSwgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAg
aW5saW5lZCBmcm9tIOKAmG92cG5fcGVlcl9sb29rdXBfdHJhbnNwX2FkZHLigJkgYXQgL3Byb2pl
Y3Qvb3BlbnZwbi9vdnBuLWRjby5naXQvZHJpdmVycy9uZXQvb3Zwbi1kY28vcGVlci5jOjQ1Nzo4
OiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4uL2luY2x1ZGUvbGludXgvc3RyaW5n
Lmg6NDQwOjQ6IGVycm9yOiBjYWxsIHRvIOKAmF9fcmVhZF9vdmVyZmxvd+KAmSBkZWNsYXJlZCB3
aXRoIGF0dHJpYnV0ZSBlcnJvcjogZGV0ZWN0ZWQgcmVhZCBiZXlvbmQgc2l6ZSBvZiBvYmplY3Qg
cGFzc2VkIGFzIDFzdCBwYXJhbWV0ZXIgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAg
NDQwIHwgwqAgwqBfX3JlYWRfb3ZlcmZsb3coKTs8YnI+wqAgwqAgwqAgfCDCoCDCoF5+fn5+fn5+
fn5+fn5+fn5+PGJyPm1ha2VbM106ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNzU6IC9w
cm9qZWN0L29wZW52cG4vb3Zwbi1kY28uZ2l0L2RyaXZlcnMvbmV0L292cG4tZGNvL3BlZXIub10g
RXJyb3IgMTxicj5tYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTIyOiAvcHJv
amVjdC9vcGVudnBuL292cG4tZGNvLmdpdC9kcml2ZXJzL25ldC9vdnBuLWRjb10gRXJyb3IgMjxi
cj5tYWtlWzFdOiAqKiogW01ha2VmaWxlOjE3NTc6IC9wcm9qZWN0L29wZW52cG4vb3Zwbi1kY28u
Z2l0XSBFcnJvciAyPGJyPm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICYjMzk7L3Vzci9zcmMv
bGludXgtaGVhZGVycy01LjQuMC01NC1nZW5lcmljJiMzOTs8YnI+bWFrZTogKioqIFtNYWtlZmls
ZTo0NjogYWxsXSBFcnJvciAyPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+RnVuY3Rpb24gbWVtY21wIGluwqAvdXNyL3NyYy9saW51eC1oZWFkZXJzLTUuNC4wLTU0
LWdlbmVyaWMvaW5jbHVkZS9saW51eC9zdHJpbmcuaC48L2Rpdj48ZGl2PjQzNCBfX0ZPUlRJRllf
SU5MSU5FIGludCBtZW1jbXAoY29uc3Qgdm9pZCAqcCwgY29uc3Qgdm9pZCAqcSwgX19rZXJuZWxf
c2l6ZV90IHNpemUpPGJyPjQzNSB7PGJyPjQzNiDCoCDCoCDCoCDCoCBzaXplX3QgcF9zaXplID0g
X19idWlsdGluX29iamVjdF9zaXplKHAsIDApOzxicj40MzcgwqAgwqAgwqAgwqAgc2l6ZV90IHFf
c2l6ZSA9IF9fYnVpbHRpbl9vYmplY3Rfc2l6ZShxLCAwKTs8YnI+NDM4IMKgIMKgIMKgIMKgIGlm
IChfX2J1aWx0aW5fY29uc3RhbnRfcChzaXplKSkgezxicj40MzkgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgaWYgKHBfc2l6ZSAmbHQ7IHNpemUpPGJyPjQ0MCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBfX3JlYWRfb3ZlcmZsb3coKTs8YnI+NDQxIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGlmIChxX3NpemUgJmx0OyBzaXplKTxicj40NDIgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgX19yZWFkX292ZXJmbG93MigpOzxicj40NDMgwqAgwqAgwqAgwqAgfTxi
cj40NDQgwqAgwqAgwqAgwqAgaWYgKHBfc2l6ZSAmbHQ7IHNpemUgfHwgcV9zaXplICZsdDsgc2l6
ZSk8YnI+NDQ1IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvcnRpZnlfcGFuaWMoX19mdW5jX18p
Ozxicj40NDYgwqAgwqAgwqAgwqAgcmV0dXJuIF9fdW5kZXJseWluZ19tZW1jbXAocCwgcSwgc2l6
ZSk7PGJyPjQ0NyB9PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5TZWVtcyB0aGF0IHBfc2l6ZSBp
cyA4IGluIGFib3ZlIG1lbWNtcCBmdW5jdGlvbiBiZWNhdXNlIGlmIEkgY2hhbmdlIHlvdXIgY29k
ZSBhcyBiZWxvdyAsIHRoZW4gaXQmIzM5O3MgT0soOSBjYXVzZXMgc2FtZSBlcnJvcikuPGJyPjwv
ZGl2PjxkaXY+NDU2IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhc2UgQUZfSU5FVDY6PGJyPjQ1
NyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAobWVtY21wKCh2b2lkICop
JmFtcDtzYTYtJmd0O3NpbjZfYWRkciwgKHZvaWQgKikmYW1wO2JpbmQtJmd0O3NhLmluNi5zaW42
X2FkZHIsPGJyPjQ1OCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAvLyDCoCBzaXplb2Yoc3RydWN0IGluNl9hZGRyKSkpPGJyPjQ1OcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOCkpPGJyPjQ2
MCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8
YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ub255PC9kaXY+PC9kaXY+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+DQo=

--00000000000062bbd905b8c46a98--

