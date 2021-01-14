MIME-Version: 1.0
References: <CAAUX2SXTUi0psQgNxm_8Z6YfkNTdQ7Q12cS5pKfjRp9V3ohFOQ@...278...>
 <CAAUX2SXVXabk6jucwj8DUF4vAf2NtWeCer6jDU90k05ys9NxbQ@...278...>
 <a5adfb07-2958-4e4a-f99f-fbbc50cd68f8@...2181...>
 <d13f9030-7178-b3c4-a20a-4a5dd4378f1e@...2181...>
 <CAAUX2SWPkoVTCi9NbA9xzAR_M=EANVKP-O-So-Kjj7pvviZ5=Q@...278...>
 <8b79df02-bc95-6c96-806d-0e0a7309b858@...2181...>
 <8018e3d3-3c84-9ce5-7d37-7ad9bca4d3cf@...2181...>
In-Reply-To: <8018e3d3-3c84-9ce5-7d37-7ad9bca4d3cf@...2181...>
From: Tony He <huangya90@...277...>
Date: Thu, 14 Jan 2021 08:44:03 +0800
Message-ID: <CAAUX2SU1XqSw2E6RFsRzv6uK2rXmY92toetbzxo01ZzBaCV6uQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001509e605b8d18ec0"
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001509e605b8d18ec0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yes. Confirmed this issue has been fixed.

Antonio Quartulli <a@...2181...> =E4=BA=8E2021=E5=B9=B41=E6=9C=8814=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:12=E5=86=99=E9=81=93=EF=BC=9A

> Potential fix pushed to the experimental branch.
>
> Thanks again for reporting.
>
> On 13/01/2021 14:18, Antonio Quartulli wrote:
> > It turns our this is a bug in my experimental branch :-)
> >
> > The object pointed by sa6 is not large enough, hence triggering that
> error.
> >
> > Will come up with a fix.
> >
> > Thanks!
> >
> > On 13/01/2021 11:17, Tony He wrote:
> >> Hi Antonio,
> >>
> >> Yes, I'm using latest commit. Maybe it's a compiler bug. What's your
> >> compiler version?
> >> Here is mine.
> >> tony-vm-2004% gcc --version
> >> gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
> >> Copyright (C) 2019 Free Software Foundation, Inc.
> >> This is free software; see the source for copying conditions.  There is
> NO
> >> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
> >>
> >>
> >>
> >> Antonio Quartulli <a@...2181...> =E4=BA=8E2021=E5=B9=B41=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:17=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>     Also,
> >>
> >>     are you sure you are compiling the latest experimental branch?
> >>     HEAD is 2555e5595088991006e57a3ee447f356dffdca92
> >>
> >>     Regards,
> >>
> >>     On 13/01/2021 10:12, Antonio Quartulli wrote:
> >>     > Hi Tony,
> >>     >
> >>     > thanks for the message.
> >>     > The experimental branch is still...experimental, so I expect more
> >>     things
> >>     > to crash and fail miserably :-D
> >>     >
> >>     > In any case, feel free to send a patch if you see how to fix the
> >>     issue!
> >>     > It would be nice to have external contributions :-)
> >>     >
> >>     > This said, I am not sure this is our bug - the sin6_addr member =
of
> >>     > struct sockaddr_in6 is of type struct sin6_addr:
> >>     >
> >>     >
> >>
> https://elixir.bootlin.com/linux/v5.4/source/include/uapi/linux/in6.h#L54
> >>     <
> https://elixir.bootlin.com/linux/v5.4/source/include/uapi/linux/in6.h#L54>
> >>     >
> >>     > And I believe it is widely known that an IPv6 address is 12 byte=
s,
> >>     not 8..
> >>     >
> >>     > Maybe it's a bug in the compiler?
> >>     >
> >>     > Best Regards,
> >>     >
> >>     > On 13/01/2021 10:03, Tony He wrote:
> >>     >> Sorry, clicked "send" button before adding subject and CC
> >>     Openvpn-dev. I
> >>     >> will send a new mail.
> >>     >>
> >>     >> Tony He <huangya90@...277... <mailto:huangya90@...277...>
> >>     <mailto:huangya90@...277... <mailto:huangya90@...277...>>>
> =E4=BA=8E2021=E5=B9=B41=E6=9C=8813
> >>     >> =E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:57=E5=86=99=E9=
=81=93=EF=BC=9A
> >>     >>
> >>     >>     Hi Antonio,
> >>     >>
> >>     >>     I see you have pushed new commits to support multiple link =
to
> >>     peers.
> >>     >>     So I tried compiling, but encounter below error. My kernel
> >>     version
> >>     >>     is 5.4.0-54.
> >>     >>
> >>     >>
> >>     >>
> >>     >>     tony-vm-2004% make
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>     /project/openvpn/ovpn-dco.git/gen-compat-autoconf.sh
> >>     >>     /project/openvpn/ovpn-dco.git/compat-autoconf.h
> >>
> >>     >>
> >>
> >>     >>
> >>     >>     make -C /lib/modules/5.4.0-54-generic/build
> >>     >>     M=3D/project/openvpn/ovpn-dco.git
> PWD=3D/project/openvpn/ovpn-dco.git
> >>     >>     REVISION=3D2555e55 CONFIG_OVPN_DCO=3Dm INSTALL_MOD_DIR=3Dup=
dates/
>
> >>     >>     modules
> >>     >>     make[1]: Entering directory
> >>     >>     '/usr/src/linux-headers-5.4.0-54-generic'
> >>
> >>     >>
> >>
> >>     >>
> >>     >>       CC [M]
> >>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/main.o
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>       CC [M]
> >>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/bind.o
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>       CC [M]
> >>     >>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/crypto.o
> >>
> >>     >>
> >>
> >>     >>
>
> >>     >>       CC [M]
> >>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/ovpn.o
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>       CC [M]
> >>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.o
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>     In file included from ./include/linux/bitmap.h:9,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/cpumask.h:12,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./arch/x86/include/asm/cpumask.h:5,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./arch/x86/include/asm/msr.h:11,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./arch/x86/include/asm/processor.h:21,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./arch/x86/include/asm/cpufeature.h:5,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from
> >>     ./arch/x86/include/asm/thread_info.h:53,
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/thread_info.h:38,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./arch/x86/include/asm/preempt.h:7,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/preempt.h:78,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/spinlock.h:51,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/seqlock.h:36,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/time.h:6,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/ktime.h:24,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/timer.h:6,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from ./include/linux/netdevice.h:24,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from
> >>     >>     /project/openvpn/ovpn-dco.git/linux-compat.h:20,
> >>
> >>     >>
> >>
> >>     >>
> >>     >>                      from <command-line>:
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>     In function =E2=80=98memcmp=E2=80=99,
> >>
> >>     >>
> >>
> >>     >>
> >>
> >>     >>
> >>     >>         inlined from =E2=80=98ovpn_peer_lookup_transp_addr=E2=
=80=99 at
> >>     >>
> >>      /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.c:457:8:
>
> >>     >>
> >>
> >>     >>
> >>     >>     ./include/linux/string.h:440:4: error: call to
> =E2=80=98__read_overflow=E2=80=99
> >>     >>     declared with attribute error: detected read beyond size of
> >>     object
> >>     >>     passed as 1st parameter
> >>
> >>     >>
> >>     >>       440 |    __read_overflow();
> >>     >>           |    ^~~~~~~~~~~~~~~~~
> >>     >>     make[3]: *** [scripts/Makefile.build:275:
> >>     >>     /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco/peer.o]
> >>     Error 1
> >>     >>     make[2]: *** [scripts/Makefile.build:522:
> >>     >>     /project/openvpn/ovpn-dco.git/drivers/net/ovpn-dco] Error 2
> >>     >>     make[1]: *** [Makefile:1757: /project/openvpn/ovpn-dco.git]
> >>     Error 2
> >>     >>     make[1]: Leaving directory
> >>     '/usr/src/linux-headers-5.4.0-54-generic'
> >>     >>     make: *** [Makefile:46: all] Error 2
> >>     >>
> >>     >>
> >>     >>     Function memcmp
> >>     >>
> >>      in /usr/src/linux-headers-5.4.0-54-generic/include/linux/string.h.
> >>     >>     434 __FORTIFY_INLINE int memcmp(const void *p, const void *=
q,
> >>     >>     __kernel_size_t size)
> >>     >>     435 {
> >>     >>     436         size_t p_size =3D __builtin_object_size(p, 0);
> >>     >>     437         size_t q_size =3D __builtin_object_size(q, 0);
> >>     >>     438         if (__builtin_constant_p(size)) {
> >>     >>     439                 if (p_size < size)
> >>     >>     440                         __read_overflow();
> >>     >>     441                 if (q_size < size)
> >>     >>     442                         __read_overflow2();
> >>     >>     443         }
> >>     >>     444         if (p_size < size || q_size < size)
> >>     >>     445                 fortify_panic(__func__);
> >>     >>     446         return __underlying_memcmp(p, q, size);
> >>     >>     447 }
> >>     >>
> >>     >>     Seems that p_size is 8 in above memcmp function because if I
> >>     change
> >>     >>     your code as below , then it's OK(9 causes same error).
> >>     >>     456                 case AF_INET6:
> >>     >>     457                         if (memcmp((void
> *)&sa6->sin6_addr,
> >>     >>     (void *)&bind->sa.in6.sin6_addr,
> >>     >>     458                                 //   sizeof(struct
> >>     in6_addr)))
> >>     >>     459                                         8))
> >>     >>     460                                 break;
> >>     >>
> >>     >>     Tony
> >>     >>
> >>     >
> >>
> >>     --
> >>     Antonio Quartulli
> >>
> >
>
> --
> Antonio Quartulli
>

--0000000000001509e605b8d18ec0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+eWVzLiBDb25maXJtZWQgdGhpcyBpc3N1ZSBoYXMgYmVlbiBmaXhlZC48
L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5BbnRvbmlvIFF1YXJ0dWxsaSAmbHQ7YUAuLi4yMTgxLi4uJmd0OyDkuo4yMDIx
5bm0MeaciDE05pel5ZGo5ZubIOS4iuWNiDEyOjEy5YaZ6YGT77yaPGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5Q
b3RlbnRpYWwgZml4IHB1c2hlZCB0byB0aGUgZXhwZXJpbWVudGFsIGJyYW5jaC48YnI+DQo8YnI+
DQpUaGFua3MgYWdhaW4gZm9yIHJlcG9ydGluZy48YnI+DQo8YnI+DQpPbiAxMy8wMS8yMDIxIDE0
OjE4LCBBbnRvbmlvIFF1YXJ0dWxsaSB3cm90ZTo8YnI+DQomZ3Q7IEl0IHR1cm5zIG91ciB0aGlz
IGlzIGEgYnVnIGluIG15IGV4cGVyaW1lbnRhbCBicmFuY2ggOi0pPGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IFRoZSBvYmplY3QgcG9pbnRlZCBieSBzYTYgaXMgbm90IGxhcmdlIGVub3VnaCwgaGVuY2Ug
dHJpZ2dlcmluZyB0aGF0IGVycm9yLjxicj4NCiZndDsgPGJyPg0KJmd0OyBXaWxsIGNvbWUgdXAg
d2l0aCBhIGZpeC48YnI+DQomZ3Q7IDxicj4NCiZndDsgVGhhbmtzITxicj4NCiZndDsgPGJyPg0K
Jmd0OyBPbiAxMy8wMS8yMDIxIDExOjE3LCBUb255IEhlIHdyb3RlOjxicj4NCiZndDsmZ3Q7IEhp
IEFudG9uaW8sPGJyPg0KJmd0OyZndDs8YnI+DQomZ3Q7Jmd0OyBZZXMsIEkmIzM5O20gdXNpbmcg
bGF0ZXN0IGNvbW1pdC4gTWF5YmUgaXQmIzM5O3MgYSBjb21waWxlciBidWcuIFdoYXQmIzM5O3Mg
eW91cjxicj4NCiZndDsmZ3Q7IGNvbXBpbGVyIHZlcnNpb24/PGJyPg0KJmd0OyZndDsgSGVyZSBp
cyBtaW5lLjxicj4NCiZndDsmZ3Q7IHRvbnktdm0tMjAwNCUgZ2NjIC0tdmVyc2lvbjxicj4NCiZn
dDsmZ3Q7IGdjYyAoVWJ1bnR1IDkuMy4wLTE3dWJ1bnR1MX4yMC4wNCkgOS4zLjA8YnI+DQomZ3Q7
Jmd0OyBDb3B5cmlnaHQgKEMpIDIwMTkgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuPGJy
Pg0KJmd0OyZndDsgVGhpcyBpcyBmcmVlIHNvZnR3YXJlOyBzZWUgdGhlIHNvdXJjZSBmb3IgY29w
eWluZyBjb25kaXRpb25zLsKgIFRoZXJlIGlzIE5PPGJyPg0KJmd0OyZndDsgd2FycmFudHk7IG5v
dCBldmVuIGZvciBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBV
UlBPU0UuPGJyPg0KJmd0OyZndDs8YnI+DQomZ3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7PGJyPg0KJmd0
OyZndDsgQW50b25pbyBRdWFydHVsbGkgJmx0O2FALi4uMjE4MS4uLiZndDsg5LqOMjAyMeW5tDHm
nIgxM+aXpeWRqOS4iSDkuIvljYg1OjE35YaZ6YGT77yaPGJyPg0KJmd0OyZndDs8YnI+DQomZ3Q7
Jmd0O8KgIMKgIMKgQWxzbyw8YnI+DQomZ3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7wqAgwqAgwqBhcmUg
eW91IHN1cmUgeW91IGFyZSBjb21waWxpbmcgdGhlIGxhdGVzdCBleHBlcmltZW50YWwgYnJhbmNo
Pzxicj4NCiZndDsmZ3Q7wqAgwqAgwqBIRUFEIGlzIDI1NTVlNTU5NTA4ODk5MTAwNmU1N2EzZWU0
NDdmMzU2ZGZmZGNhOTI8YnI+DQomZ3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7wqAgwqAgwqBSZWdhcmRz
LDxicj4NCiZndDsmZ3Q7PGJyPg0KJmd0OyZndDvCoCDCoCDCoE9uIDEzLzAxLzIwMjEgMTA6MTIs
IEFudG9uaW8gUXVhcnR1bGxpIHdyb3RlOjxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7IEhpIFRv
bnksPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyB0
aGFua3MgZm9yIHRoZSBtZXNzYWdlLjxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7IFRoZSBleHBl
cmltZW50YWwgYnJhbmNoIGlzIHN0aWxsLi4uZXhwZXJpbWVudGFsLCBzbyBJIGV4cGVjdCBtb3Jl
PGJyPg0KJmd0OyZndDvCoCDCoCDCoHRoaW5nczxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7IHRv
IGNyYXNoIGFuZCBmYWlsIG1pc2VyYWJseSA6LUQ8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0Ozxi
cj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7IEluIGFueSBjYXNlLCBmZWVsIGZyZWUgdG8gc2VuZCBh
IHBhdGNoIGlmIHlvdSBzZWUgaG93IHRvIGZpeCB0aGU8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgaXNz
dWUhPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsgSXQgd291bGQgYmUgbmljZSB0byBoYXZlIGV4
dGVybmFsIGNvbnRyaWJ1dGlvbnMgOi0pPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDs8YnI+DQom
Z3Q7Jmd0O8KgIMKgIMKgJmd0OyBUaGlzIHNhaWQsIEkgYW0gbm90IHN1cmUgdGhpcyBpcyBvdXIg
YnVnIC0gdGhlIHNpbjZfYWRkciBtZW1iZXIgb2Y8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyBz
dHJ1Y3Qgc29ja2FkZHJfaW42IGlzIG9mIHR5cGUgc3RydWN0IHNpbjZfYWRkcjo8YnI+DQomZ3Q7
Jmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0OyZndDvC
oCDCoCDCoDxhIGhyZWY9Imh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjQvc291
cmNlL2luY2x1ZGUvdWFwaS9saW51eC9pbjYuaCNMNTQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjQvc291cmNlL2lu
Y2x1ZGUvdWFwaS9saW51eC9pbjYuaCNMNTQ8L2E+PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZsdDs8
YSBocmVmPSJodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS40L3NvdXJjZS9pbmNs
dWRlL3VhcGkvbGludXgvaW42LmgjTDU0IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5r
Ij5odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS40L3NvdXJjZS9pbmNsdWRlL3Vh
cGkvbGludXgvaW42LmgjTDU0PC9hPiZndDs8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0Ozxicj4N
CiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7IEFuZCBJIGJlbGlldmUgaXQgaXMgd2lkZWx5IGtub3duIHRo
YXQgYW4gSVB2NiBhZGRyZXNzIGlzIDEyIGJ5dGVzLDxicj4NCiZndDsmZ3Q7wqAgwqAgwqBub3Qg
OC4uPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyBN
YXliZSBpdCYjMzk7cyBhIGJ1ZyBpbiB0aGUgY29tcGlsZXI/PGJyPg0KJmd0OyZndDvCoCDCoCDC
oCZndDs8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyBCZXN0IFJlZ2FyZHMsPGJyPg0KJmd0OyZn
dDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyBPbiAxMy8wMS8yMDIxIDEw
OjAzLCBUb255IEhlIHdyb3RlOjxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0OyBTb3JyeSwg
Y2xpY2tlZCAmcXVvdDtzZW5kJnF1b3Q7IGJ1dHRvbiBiZWZvcmUgYWRkaW5nIHN1YmplY3QgYW5k
IENDPGJyPg0KJmd0OyZndDvCoCDCoCDCoE9wZW52cG4tZGV2LiBJPGJyPg0KJmd0OyZndDvCoCDC
oCDCoCZndDsmZ3Q7IHdpbGwgc2VuZCBhIG5ldyBtYWlsLjxicj4NCiZndDsmZ3Q7wqAgwqAgwqAm
Z3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0OyBUb255IEhlICZsdDs8YSBocmVm
PSJtYWlsdG86aHVhbmd5YTkwQC4uLjI3Ny4uLiIgdGFyZ2V0PSJfYmxhbmsiPmh1YW5neWE5MEAu
Li4yNzcuLi48L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmh1YW5neWE5MEAuLi4yNzcu
Li4iIHRhcmdldD0iX2JsYW5rIj5odWFuZ3lhOTBALi4uMjc3Li4uPC9hPiZndDs8YnI+DQomZ3Q7
Jmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86aHVhbmd5YTkwQC4uLjI3Ny4u
LiIgdGFyZ2V0PSJfYmxhbmsiPmh1YW5neWE5MEAuLi4yNzcuLi48L2E+ICZsdDttYWlsdG86PGEg
aHJlZj0ibWFpbHRvOmh1YW5neWE5MEAuLi4yNzcuLi4iIHRhcmdldD0iX2JsYW5rIj5odWFuZ3lh
OTBALi4uMjc3Li4uPC9hPiZndDsmZ3Q7Jmd0OyDkuo4yMDIx5bm0MeaciDEzPGJyPg0KJmd0OyZn
dDvCoCDCoCDCoCZndDsmZ3Q7IOaXpeWRqOS4iSDkuIvljYg0OjU35YaZ6YGT77yaPGJyPg0KJmd0
OyZndDvCoCDCoCDCoCZndDsmZ3Q7PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAg
wqBIaSBBbnRvbmlvLDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7
wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgSSBzZWUgeW91IGhhdmUgcHVzaGVkIG5ldyBjb21taXRz
IHRvIHN1cHBvcnTCoG11bHRpcGxlIGxpbmsgdG88YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgcGVlcnMu
PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqBTbyBJIHRyaWVkIGNvbXBpbGlu
ZywgYnV0IGVuY291bnRlciBiZWxvdyBlcnJvci4gTXkga2VybmVsPGJyPg0KJmd0OyZndDvCoCDC
oCDCoHZlcnNpb248YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoGlzIDUuNC4w
LTU0Ljxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7wqAgwqAgwqAm
Z3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0Ozxicj4NCiZndDsmZ3Q7wqAgwqAg
wqAmZ3Q7Jmd0O8KgIMKgIMKgdG9ueS12bS0yMDA0JSBtYWtlIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvC
oCDCoCDCoMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDC
oCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+
DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvC
oCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAvcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdC9nZW4t
Y29tcGF0LWF1dG9jb25mLnNoPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAv
cHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdC9jb21wYXQtYXV0b2NvbmYuaCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAg
wqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZn
dDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvC
oCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqBtYWtlIC1DIC9saWIvbW9kdWxlcy81LjQuMC01NC1nZW5l
cmljL2J1aWxkPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqBNPS9wcm9qZWN0
L29wZW52cG4vb3Zwbi1kY28uZ2l0IFBXRD0vcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdDxi
cj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgUkVWSVNJT049MjU1NWU1NSBDT05G
SUdfT1ZQTl9EQ089bSBJTlNUQUxMX01PRF9ESVI9dXBkYXRlcy8gwqAgwqAgwqA8YnI+DQomZ3Q7
Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoG1vZHVsZXMgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDC
oG1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeTxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0
O8KgIMKgIMKgJiMzOTsvdXNyL3NyYy9saW51eC1oZWFkZXJzLTUuNC4wLTU0LWdlbmVyaWMmIzM5
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDC
oCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQom
Z3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZn
dDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCBDQyBbTV08YnI+DQomZ3Q7Jmd0O8KgIMKgIMKg
wqAvcHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdC9kcml2ZXJzL25ldC9vdnBuLWRjby9tYWlu
Lm88YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0
OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAg
wqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZn
dDvCoCDCoCDCoMKgIENDIFtNXTxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoC9wcm9qZWN0L29wZW52
cG4vb3Zwbi1kY28uZ2l0L2RyaXZlcnMvbmV0L292cG4tZGNvL2JpbmQubzxicj4NCiZndDsmZ3Q7
wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0
OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAg
wqDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgQ0Mg
W01dPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoC9wcm9qZWN0L29wZW52
cG4vb3Zwbi1kY28uZ2l0L2RyaXZlcnMvbmV0L292cG4tZGNvL2NyeXB0by5vPGJyPg0KJmd0OyZn
dDvCoCDCoCDCoMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAg
wqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAg
wqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0
OyZndDvCoCDCoCDCoMKgIENDIFtNXTxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoC9wcm9qZWN0L29w
ZW52cG4vb3Zwbi1kY28uZ2l0L2RyaXZlcnMvbmV0L292cG4tZGNvL292cG4ubzxicj4NCiZndDsm
Z3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKg
Jmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAg
wqAgwqDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAg
Q0MgW01dPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgL3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRjby5n
aXQvZHJpdmVycy9uZXQvb3Zwbi1kY28vcGVlci5vPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsm
Z3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsm
Z3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKg
wqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKg
PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqBJbiBmaWxlIGluY2x1ZGVkIGZy
b20gLi9pbmNsdWRlL2xpbnV4L2JpdG1hcC5oOjksIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAg
wqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAg
wqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8
YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgPGJyPg0KJmd0
OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZy
b20gLi9pbmNsdWRlL2xpbnV4L2NwdW1hc2suaDoxMiwgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDC
oMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDC
oMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxi
cj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7
Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJv
bSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdW1hc2suaDo1LCDCoCDCoDxicj4NCiZndDsmZ3Q7
wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAg
wqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0K
Jmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7
wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4v
YXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmg6MTEsIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDC
oCDCoMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDC
oCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQom
Z3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDC
oCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gLi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaDoyMSw8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAg
wqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJy
Pg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7
wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0
OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2NwdWZlYXR1cmUuaDo1LDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDC
oDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7
Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDC
oCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8Kg
IMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tPGJyPg0KJmd0OyZndDvCoCDCoCDC
oC4vYXJjaC94ODYvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaDo1MywgwqAgwqAgwqA8YnI+DQom
Z3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDC
oCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0
O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2luY2x1ZGUvbGludXgvdGhyZWFkX2luZm8u
aDozOCwgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0
O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZn
dDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZn
dDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKg
IMKgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ByZWVtcHQu
aDo3LCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAg
wqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZn
dDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZn
dDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDC
oCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBmcm9tIC4vaW5jbHVkZS9saW51eC9wcmVlbXB0Lmg6NzgsIMKgIMKg
IMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDC
oCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0
O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0
O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKg
IMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZyb20gLi9pbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6NTEsIMKgIMKg
IMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDC
oCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0
O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0
O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKg
IMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZyb20gLi9pbmNsdWRlL2xpbnV4L3NlcWxvY2suaDozNiwgwqAgwqAgwqAg
wqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKg
Jmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
Jmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAg
wqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAg
wqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAg
wqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZnJvbSAuL2luY2x1ZGUvbGludXgvdGltZS5oOjYsIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDC
oCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8Kg
IMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8Kg
IMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKg
IMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZyb20gLi9pbmNsdWRlL2xpbnV4L2t0aW1lLmg6MjQsIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDC
oCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8Kg
IMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8Kg
IMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKg
IMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZyb20gLi9pbmNsdWRlL2xpbnV4L3RpbWVyLmg6NiwgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKg
IMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
Pg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7
wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7
wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAg
wqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZnJvbSAuL2luY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmg6MjQsIMKgIMKgIMKg
IMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZn
dDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZn
dDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKg
IMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKg
IMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKg
IMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGZyb208YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoC9wcm9q
ZWN0L29wZW52cG4vb3Zwbi1kY28uZ2l0L2xpbnV4LWNvbXBhdC5oOjIwLCDCoCDCoCDCoCDCoCDC
oCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAg
wqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvC
oCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7
wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gJmx0O2NvbW1hbmQtbGluZSZn
dDs6IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDC
oCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDC
oDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7
Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDC
oCDCoCZndDsmZ3Q7wqAgwqAgwqBJbiBmdW5jdGlvbiDigJhtZW1jbXDigJksIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
OyZndDvCoCDCoCDCoMKgIMKgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAg
wqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAg
wqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8
YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgPGJyPg0KJmd0
OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCBpbmxpbmVkIGZyb20g4oCYb3Zwbl9w
ZWVyX2xvb2t1cF90cmFuc3BfYWRkcuKAmSBhdDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0
O8KgIMKgPGJyPg0KJmd0OyZndDvCoCDCoCDCoMKgL3Byb2plY3Qvb3BlbnZwbi9vdnBuLWRjby5n
aXQvZHJpdmVycy9uZXQvb3Zwbi1kY28vcGVlci5jOjQ1Nzo4OiDCoCDCoDxicj4NCiZndDsmZ3Q7
wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0
OyZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0
OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAuL2luY2x1ZGUvbGludXgvc3RyaW5nLmg6NDQw
OjQ6IGVycm9yOiBjYWxsIHRvIOKAmF9fcmVhZF9vdmVyZmxvd+KAmTxicj4NCiZndDsmZ3Q7wqAg
wqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6IGRldGVj
dGVkIHJlYWQgYmV5b25kIHNpemUgb2Y8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgb2JqZWN0PGJyPg0K
Jmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqBwYXNzZWQgYXMgMXN0IHBhcmFtZXRlciDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj4NCiZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0
O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvC
oCDCoCDCoMKgIDQ0MCB8IMKgIMKgX19yZWFkX292ZXJmbG93KCk7PGJyPg0KJmd0OyZndDvCoCDC
oCDCoCZndDsmZ3Q7wqAgwqAgwqDCoCDCoCDCoCB8IMKgIMKgXn5+fn5+fn5+fn5+fn5+fn48YnI+
DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoG1ha2VbM106ICoqKiBbc2NyaXB0cy9N
YWtlZmlsZS5idWlsZDoyNzU6PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAv
cHJvamVjdC9vcGVudnBuL292cG4tZGNvLmdpdC9kcml2ZXJzL25ldC9vdnBuLWRjby9wZWVyLm9d
PGJyPg0KJmd0OyZndDvCoCDCoCDCoEVycm9yIDE8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZn
dDvCoCDCoCDCoG1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MjI6PGJyPg0K
Jmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqAvcHJvamVjdC9vcGVudnBuL292cG4tZGNv
LmdpdC9kcml2ZXJzL25ldC9vdnBuLWRjb10gRXJyb3IgMjxicj4NCiZndDsmZ3Q7wqAgwqAgwqAm
Z3Q7Jmd0O8KgIMKgIMKgbWFrZVsxXTogKioqIFtNYWtlZmlsZToxNzU3OiAvcHJvamVjdC9vcGVu
dnBuL292cG4tZGNvLmdpdF08YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgRXJyb3IgMjxicj4NCiZndDsm
Z3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rvcnk8YnI+
DQomZ3Q7Jmd0O8KgIMKgIMKgJiMzOTsvdXNyL3NyYy9saW51eC1oZWFkZXJzLTUuNC4wLTU0LWdl
bmVyaWMmIzM5Ozxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgbWFrZTogKioq
IFtNYWtlZmlsZTo0NjogYWxsXSBFcnJvciAyPGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7
PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsm
Z3Q7wqAgwqAgwqBGdW5jdGlvbiBtZW1jbXA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvC
oCDCoDxicj4NCiZndDsmZ3Q7wqAgwqAgwqDCoGluwqAvdXNyL3NyYy9saW51eC1oZWFkZXJzLTUu
NC4wLTU0LWdlbmVyaWMvaW5jbHVkZS9saW51eC9zdHJpbmcuaC48YnI+DQomZ3Q7Jmd0O8KgIMKg
IMKgJmd0OyZndDvCoCDCoCDCoDQzNCBfX0ZPUlRJRllfSU5MSU5FIGludCBtZW1jbXAoY29uc3Qg
dm9pZCAqcCwgY29uc3Qgdm9pZCAqcSw8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDC
oCDCoF9fa2VybmVsX3NpemVfdCBzaXplKTxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8Kg
IMKgIMKgNDM1IHs8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoDQzNiDCoCDC
oCDCoCDCoCBzaXplX3QgcF9zaXplID0gX19idWlsdGluX29iamVjdF9zaXplKHAsIDApOzxicj4N
CiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgNDM3IMKgIMKgIMKgIMKgIHNpemVfdCBx
X3NpemUgPSBfX2J1aWx0aW5fb2JqZWN0X3NpemUocSwgMCk7PGJyPg0KJmd0OyZndDvCoCDCoCDC
oCZndDsmZ3Q7wqAgwqAgwqA0MzggwqAgwqAgwqAgwqAgaWYgKF9fYnVpbHRpbl9jb25zdGFudF9w
KHNpemUpKSB7PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqA0MzkgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgaWYgKHBfc2l6ZSAmbHQ7IHNpemUpPGJyPg0KJmd0OyZndDvCoCDC
oCDCoCZndDsmZ3Q7wqAgwqAgwqA0NDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgX19yZWFkX292ZXJmbG93KCk7PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAg
wqA0NDEgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHFfc2l6ZSAmbHQ7IHNpemUpPGJyPg0K
Jmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqA0NDIgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgX19yZWFkX292ZXJmbG93MigpOzxicj4NCiZndDsmZ3Q7wqAgwqAgwqAm
Z3Q7Jmd0O8KgIMKgIMKgNDQzIMKgIMKgIMKgIMKgIH08YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0
OyZndDvCoCDCoCDCoDQ0NCDCoCDCoCDCoCDCoCBpZiAocF9zaXplICZsdDsgc2l6ZSB8fCBxX3Np
emUgJmx0OyBzaXplKTxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgNDQ1IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvcnRpZnlfcGFuaWMoX19mdW5jX18pOzxicj4NCiZndDsm
Z3Q7wqAgwqAgwqAmZ3Q7Jmd0O8KgIMKgIMKgNDQ2IMKgIMKgIMKgIMKgIHJldHVybiBfX3VuZGVy
bHlpbmdfbWVtY21wKHAsIHEsIHNpemUpOzxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0O8Kg
IMKgIMKgNDQ3IH08YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDs8YnI+DQomZ3Q7Jmd0O8Kg
IMKgIMKgJmd0OyZndDvCoCDCoCDCoFNlZW1zIHRoYXQgcF9zaXplIGlzIDggaW4gYWJvdmUgbWVt
Y21wIGZ1bmN0aW9uIGJlY2F1c2UgaWYgSTxicj4NCiZndDsmZ3Q7wqAgwqAgwqBjaGFuZ2U8YnI+
DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoHlvdXIgY29kZSBhcyBiZWxvdyAsIHRo
ZW4gaXQmIzM5O3MgT0soOSBjYXVzZXMgc2FtZSBlcnJvcikuPGJyPg0KJmd0OyZndDvCoCDCoCDC
oCZndDsmZ3Q7wqAgwqAgwqA0NTYgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2FzZSBBRl9JTkVU
Njo8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoDQ1NyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAobWVtY21wKCh2b2lkICopJmFtcDtzYTYtJmd0O3Np
bjZfYWRkciw8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoCh2b2lkICopJmFt
cDtiaW5kLSZndDtzYS5pbjYuc2luNl9hZGRyLDxicj4NCiZndDsmZ3Q7wqAgwqAgwqAmZ3Q7Jmd0
O8KgIMKgIMKgNDU4IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIC8vIMKgIHNpemVvZihzdHJ1Y3Q8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgaW42X2FkZHIpKSk8
YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgJmd0OyZndDvCoCDCoCDCoDQ1OcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOCkpPGJyPg0KJmd0
OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqA0NjAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsm
Z3Q7PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDsmZ3Q7wqAgwqAgwqBUb255PGJyPg0KJmd0OyZn
dDvCoCDCoCDCoCZndDsmZ3Q7PGJyPg0KJmd0OyZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7Jmd0
Ozxicj4NCiZndDsmZ3Q7wqAgwqAgwqAtLSA8YnI+DQomZ3Q7Jmd0O8KgIMKgIMKgQW50b25pbyBR
dWFydHVsbGk8YnI+DQomZ3Q7Jmd0Ozxicj4NCiZndDsgPGJyPg0KPGJyPg0KLS0gPGJyPg0KQW50
b25pbyBRdWFydHVsbGk8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+DQo=

--0000000000001509e605b8d18ec0--

