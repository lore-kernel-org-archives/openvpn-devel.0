From: Simon Rozman <simon@...2293...>
Date: Sun, 5 Nov 2017 22:06:52 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...> <20171105192019.GM958@...1296...>
In-Reply-To: <20171105192019.GM958@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Let me explain all proposed modifications case-by-case below...

> > diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c index
> > d43cbcf..f88ba2c 100644
> > --- a/src/openvpn/block_dns.c
> > +++ b/src/openvpn/block_dns.c
> > @@ -370,7 +370,7 @@ get_interface_metric(const NET_IFINDEX index,
> const ADDRESS_FAMILY family)
> >          }
> >          return ipiface.Metric;
> >      }
> > -    return -err;
> > +    return -(int)err;
> >  }=09
>=20
> This, I can somewhat agree to, as "err" is an unsigned type so there migh=
t be
> a hidden integer overflow if it happens to be "large".  Which it won't be=
, but
> still.

Adding the `(int)` resolves the warning C4146: unary minus operator applied=
 to unsigned type, result still unsigned.
https://msdn.microsoft.com/en-us/library/4kh09110.aspx

It doesn't change much, but it shut-ups one compiler warning.

> >  /*
> > diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> > index 4123d0f..6c39aaa 100644
> > --- a/src/openvpnserv/automatic.c
> > +++ b/src/openvpnserv/automatic.c
> > @@ -155,7 +155,7 @@ match(const WIN32_FIND_DATA *find, LPCTSTR
> ext)
> >   * Modify the extension on a filename.
> >   */
> >  static bool
> > -modext(LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)
> > +modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
> >  {
> >      int i;
>=20
> Not sure why this is needed?  The code verifies that size is ">0", so a s=
igned
> variable is ok here.

warning C4018: '<=3D': signed/unsigned mismatch (in Win32 builds twice)
https://msdn.microsoft.com/en-us/library/y92ktdf2.aspx

Parameter size is compared to the result of _tcslen() which is size_t. Henc=
e, you had a signed int and unsigned size_t comparison.

However, modext() is called exactly at one location in the code:

                if (!modext(log_file, _countof(log_file), find_obj.cFileNam=
e, TEXT("log")))
                    ...

Observe, the size parameter is _countof(log_file) which is size_t, converte=
d to int to be passed as parameter to modext(), and finally compared agains=
t _tcslen() which is size_t in modext(). In other words: it had an orange, =
converted it to an apple, and finally compared it to another orange.

> > diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
> index
> > b8b817b..7901fd6 100644
> > --- a/src/openvpnserv/common.c
> > +++ b/src/openvpnserv/common.c
> > @@ -36,7 +36,7 @@ openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR
> format, va_list arglist)
> >          len =3D _vsntprintf(str, size, format, arglist);
> >          str[size - 1] =3D 0;
> >      }
> > -    return (len >=3D 0 && len < size);
> > +    return (len >=3D 0 && (size_t)len < size);
> >  }
>=20
> This is, if I understand right, because "len < size" will implicitly cast=
 size to
> (int), causing integer overflow if size is too big for a signed int?

warning C4018: '<': signed/unsigned mismatch (in Win32 builds).

The MSVC is not happy if it needs to decide between signed or unsigned comp=
arison itself. So the programmer needs to cast either side to match the sig=
ned/unsigned manually.

The `len >=3D 0` assures that len is always positive or zero before `len < =
size` is evaluated. Therefore, it is no harm to cast len to size_t to force=
 unsigned comparison.

> >  int
> >  openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...) diff
> > --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> > index 8d94197..96e0de0 100644
> > --- a/src/openvpnserv/interactive.c
> > +++ b/src/openvpnserv/interactive.c
> > @@ -188,7 +188,7 @@ typedef enum {
> >  static DWORD
> >  AsyncPipeOp(async_op_t op, HANDLE pipe, LPVOID buffer, DWORD size,
> > DWORD count, LPHANDLE events)  {=09
> > -    int i;
> > +    DWORD i;
>=20
> ... and this totally escapes me.  Why would an "int" suddenly be no longe=
r a
> legal loop variable...?

This one is my favourite. :) I hope I'll manage to explain it (I am not a n=
ative English speaker. Please, be patient.) This one is not just about C401=
8 again. Although, the `i < count` in `for (i =3D 0; i < count; i++)` does =
raise the C4018. That's how it got my attention.

This particular loop variable i was used in one loop only. In that particul=
ar loop, it iterates on [0...count) interval. The lower bound is zero (any =
scalar zero). The upper bound is a DWORD. Thus, the interval is essentially=
 a [DWORD...DWORD) type. So the most natural selection for the loop variabl=
e is DWORD then. This avoids all 32/64-bit issues, signed/unsigned comparis=
on warnings etc.

When you need to iterate from 'A' to 'Z', the most natural selection for lo=
op variable is char; when you count oranges, the appropriate loop variable =
is orange...

> >      BOOL success;
> >      HANDLE io_event;
> >      DWORD res, bytes =3D 0;
> > @@ -1061,7 +1061,7 @@ RegisterDNS(LPVOID unused)
> >          { ipcfg, L"ipconfig /flushdns",    timeout },
> >          { ipcfg, L"ipconfig /registerdns", timeout },
> >      };
> > -    int ncmds =3D sizeof(cmds) / sizeof(cmds[0]);
> > +    DWORD ncmds =3D sizeof(cmds) / sizeof(cmds[0]);
>=20
> Same thing here...

Exactly. This one's the other way around: Here, the original code used `DWO=
RD i` as the loop variable. But the upper bound was `int ncmds`. Since ncmd=
s is a school example for size_t, the unsigned DWORD is still a better choi=
ce than int.

Although, if I was coding this, I'd change everything to size_t. :)

> > index 7a2d0e3..5422d33 100644
> > --- a/src/openvpnserv/validate.c
> > +++ b/src/openvpnserv/validate.c
> > @@ -298,7 +298,7 @@ IsUserInGroup(PSID sid, const PTOKEN_GROUPS
> token_groups, const WCHAR *group_nam
> >              break;
> >          }
> >          /* If a match is already found, ret =3D=3D TRUE and the loop i=
s skipped */
> > -        for (int i =3D 0; i < nread && !ret; ++i)
> > +        for (DWORD i =3D 0; i < nread && !ret; ++i)
>=20
> ... and here.

Again, the nread is number of members of a security group - a DWORD (Window=
s API really likes this type). It should be iterated using a DWORD or face =
the dreaded signed/unsigned comparison warning again.

> Consider me not convinced...

I hope you might reconsider again. :)

> what exactly are the warnings MSVC spits out here?

As described above.

MSVC for OpenVPN projects is set to Warning level 3. On the scale of 0 to 4=
 Microsoft calls this level the "production quality" level. Apart from thos=
e signed/unsigned warnings, there were some 32/64-bit warnings reported at =
64-bit MSVC builds and are addressed by "[PATCH 12/13] Memory size arithmet=
ic reviewed according to 64-bit MSVC complaints".

All that said, the OpenVPN Interactive Service code is a very fine example =
of code that - given the number of lines - produces very low volume of warn=
ings. Why not address and fix them, when we're so close?

While most of the MSVC compiler warnings are false-alarms, one out of many =
does represent a potential threat. But you don't know which one that is. Th=
erefore it is best to address them all. :) Just my personal philosophy, usi=
ng which, I keep the helpdesk guys out of my office quite efficiently.

Best regards,
Simon


