References: <20171012072440.8704-1-simon@...2293...>
 <99D61A626FDA8A4B90A270669121BE10857E4741@...2294...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <fc8fb665-ee87-9162-5d79-4578f429dfce@...2181...>
Date: Thu, 12 Oct 2017 16:19:43 +0800
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857E4741@...2294...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hmOjH7cEA75urTI3jEjGUoiENwJPiDnmQ"
Subject: Re: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and
 MSVC compilers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hmOjH7cEA75urTI3jEjGUoiENwJPiDnmQ
Content-Type: multipart/mixed; boundary="G5F5iAMqVRDx8iDLGRXiEsVeBB0rsdEOG";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <fc8fb665-ee87-9162-5d79-4578f429dfce@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and MSVC
 compilers
References: <20171012072440.8704-1-simon@...2293...>
 <99D61A626FDA8A4B90A270669121BE10857E4741@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857E4741@...2294...>

--G5F5iAMqVRDx8iDLGRXiEsVeBB0rsdEOG
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 12/10/17 16:09, Simon Rozman wrote:
> This is a follow-up (or better worded: a replacement) patch for "[PATCH
> 01/13] snwprintf() =3D> _snwprintf()".
>=20
> I have taken into consideration all Selva's recommendations.
>=20

In case you weren't, you can write comments like the one above right
after the '---' in the patch itself.
This way you don't need to rush to reply to your own patch, but
everything comes together.

So basically you first create the patch with git-format-patch, then edit
it and then send it with git-send-email.

> Best regards,
> Simon
>=20
>> -----Original Message-----
>> From: Simon Rozman [mailto:simon@...2293...]
>> Sent: Thursday, October 12, 2017 9:25 AM
>> To: openvpn-devel@lists.sourceforge.net
>> Cc: Simon Rozman
>> Subject: [PATCH] Uniform snwprintf() across MinGW and MSVC compilers
>>
>> MinGW's snwprintf() is a replacement for ISO C's swprintf() used by MSVC.
>> MSVC also provides _snwprintf(), however using it leads to unportable
> code.
>>
>> After a discussion with Selva Nair on devel mailing list, an agreement w=
as
>> reached to use swprintf() for MSVC builds.
>>
>> This patch uniforms snwprintf() usage while making it compile using MinGW
>> and MSVC.
>>
>> Assigning _snwprintf() return value to unused variable was also removed =
at
>> one occasion.
>> ---

Here you can write what you want. This text will be dropped when
applying the patch.


Cheers,


>>  config-msvc.h                 | 3 ++-
>>  src/openvpn/tun.c             | 2 +-
>>  src/openvpnserv/interactive.c | 8 ++++----
>>  3 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/config-msvc.h b/config-msvc.h index 0bb153d..c940d15 100644
>> --- a/config-msvc.h
>> +++ b/config-msvc.h
>> @@ -93,9 +93,10 @@
>>  #define strncasecmp strnicmp
>>  #define strcasecmp _stricmp
>>
>> -#if _MSC_VER<1900
>> +#if _MSC_VER < 1900
>>  #define snprintf _snprintf
>>  #endif
>> +#define snwprintf swprintf
>>
>>  #if _MSC_VER < 1800
>>  #define strtoull strtoul
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c index 3639718..9e3ca41
>> 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -4622,7 +4622,7 @@ get_adapter_index_method_1(const char *guid)
>>      DWORD index;
>>      ULONG aindex;
>>      wchar_t wbuf[256];
>> -    _snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
>> +    snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
>>      wbuf [SIZE(wbuf) - 1] =3D 0;
>>      if (GetAdapterIndex(wbuf, &aindex) !=3D NO_ERROR)
>>      {
>> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c
>> index 823b25b..a060a06 100644
>> --- a/src/openvpnserv/interactive.c
>> +++ b/src/openvpnserv/interactive.c
>> @@ -276,7 +276,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD
>> count, LPHANDLE events)
>>       * Same format as error messages (3 line string) with error =3D 0 in
>>       * 0x%08x format, PID on line 2 and a description "Process ID" on
> line 3
>>       */
>> -    _snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
>> +    snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
>>      buf[_countof(buf) - 1] =3D '\0';
>>
>>      WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events); @@ -1066=
,7
>> +1066,7 @@ RegisterDNS(LPVOID unused)
>>
>>      if (GetSystemDirectory(sys_path, MAX_PATH))
>>      {
>> -        _snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path,
> L"ipconfig.exe");
>> +        snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path,
>> + L"ipconfig.exe");
>>          ipcfg[MAX_PATH-1] =3D L'\0';
>>      }
>>
>> @@ -1706,8 +1706,8 @@ RunOpenvpn(LPVOID p)
>>      else if (exit_code !=3D 0)
>>      {
>>          WCHAR buf[256];
>> -        int len =3D _snwprintf(buf, _countof(buf),
>> -                             L"OpenVPN exited with error: exit code =3D
> %lu", exit_code);
>> +        snwprintf(buf, _countof(buf),
>> +                  L"OpenVPN exited with error: exit code =3D %lu",
>> + exit_code);
>>          buf[_countof(buf) - 1] =3D  L'\0';
>>          ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
>>      }
>> --
>> 2.9.0.windows.1
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--G5F5iAMqVRDx8iDLGRXiEsVeBB0rsdEOG--

--hmOjH7cEA75urTI3jEjGUoiENwJPiDnmQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnfJZ8ACgkQB6U8WA7y
zXRgqRAAnTsXXKnGiOyuSIWIyoJeP/CabHIWVNqf3R38HUSva4Mx2KfauuiqXVFz
ne1S9QNpoaVw1BSsPs6XbWi31Hl6ModL6Y9b9Km9z5u8mjRIUPnHrN8bVkaHBGEm
fcqE21Sb7biekwXUJKMgbBA1hmCf6dekQJsvVM8uxCqSbPfkB2GS1DQn+F5B8KQ2
3AXDtGcsmXpJL595AwTzYCB7hv3uLo86sCWMYcLQ+apnODOaflRvF4NH2bXVzOCW
18NYjsdi8jgFTgb07t24b+QUsBzKZCYxh9gHuHCr8NkaOxUGtB9kNYO/t/pt+v0U
kpZOejkDZcjfHq4FWgO7gSQ6k0Q+2X/ZFt1QnY1pv83Cmz5OcHGXT6WWxBO0gqgG
okTGE0Uw1u/uE6SypZ+pwPhg4WidvNAgn9rDj1w7ChKm3pJFFG7mGvQrjIKsiwmL
pZf1wxXnqaYnEkUoXofs2W/3+vIsRsvONsK5BXjJ72qmBnoy1aYfJwc+Ewxowutc
9qGNAlGZ0R3gpjk8OSwGWXXbe+bKemtbltfZg9jSIXNsUaGO8Nic0BK1DCREf8s2
AOTFfpXQe1aIDtUwIyaxeEqLphCaDZ1VTqurK7m7XCPu16fv0RO0W+jVfikFV09u
ZL3SpoihCh3220xLGpUaqmwxbKxQtA1Jf2PAqKqornnO4Ej0EGU=
=GlIm
-----END PGP SIGNATURE-----

--hmOjH7cEA75urTI3jEjGUoiENwJPiDnmQ--

