Date: Thu, 01 Jul 2021 18:55:19 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <fM-kyn3ptlaOsePELa4BR_HXTrhn7WLWkHdOIrnG2ReTjLswBkQSh0hbpNTOAIb13mD3cVUcdc5nV8RxmDK1dvDIzgf1aI06wYTJyXn6Bvc=@protonmail.com>
In-Reply-To: <5ef18d92-2ba7-f651-52cf-edfbfa9c682a@...2080...>
References: <zi-Vj2bRDxVU6FgVs0cJcBRxRwZ8B6q5EYNx4g1mHxOg0o5sQneGqWmwMQEwkZ_fcYxWkcTTYPZC7pXDJn6WZQBsS_RyBduPltGkRhsIX2M=@protonmail.com>
 <P_ZqTHMMD5zv_kUeNix7rzuNV00OT9o2LqrU8BdYhMVaq6j5vdLe5YKK3AS13531enQBYdltUJp8Ks7eNCm3xBBfnWo7t9GGHw526akJXwU=@protonmail.com>
 <5ef18d92-2ba7-f651-52cf-edfbfa9c682a@...2080...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_Nb9jcIFX8R3OqE9laWNKKXW8WTSJdpGqiyFdwyaMDQ"
Subject: Re: [Openvpn-devel] --tmp-dir and systemd PrivateTmp incompatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_Nb9jcIFX8R3OqE9laWNKKXW8WTSJdpGqiyFdwyaMDQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi David,

with your help, I was able to use systemd.PrivateTmp correctly.

thanks for this detailed explanation.
R

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Thursday, July 1st, 2021 at 13:41, David Sommerseth <openvpn@...2080...>=
 wrote:

> On 01/07/2021 00:56, tincantech via Openvpn-devel wrote:
>
> > Hi
>
> [... copied from first mail ...]
>
> > > Thus the problem is two fold:
> >
> > It is not possible to pre-determine a temporary directory within the sy=
stemd
> >
> > PrivateTmp assigned folder within an openvpn config which needs to use =
--tmp-dir
> >
> > 2.
> >
> > Openvpn is forced to assign a non-standard temporary folder to --tmp-di=
r which
> >
> > lies outside of the systemd assigned private temporary folder.[... seco=
nd mail ...]
> >
> > the problem is three fold:
> >
> > 3.
> >
> > How would I then point scripts to the systemd assigned folder ?
> >
> > (Yet another env var: systemd_private_tmp)
> >
> > > The most logical answer is "To take matters into my own hands"
> > >
> > > and specify my own temporary location but that does not sound
> > >
> > > like a "secure" approach generally .. which is the point of using
> > >
> > > systemd to "secure" things, in the first place.
>
> First of all - what you are describing is what you are observing. But I'm=
 missing the context of when you need a publicly available tmp-dir.
>
> The PrivateTmp is a security hardening. Using /tmp and /var/tmp to dump v=
arious data has been a well-known security issue for years. And not just wi=
thin OpenVPN, but all kind of running daemons have faced security challenge=
s with the use of a global tmp-dir.
>
> First some background.
>
> In 2010 we added some hardening to avoid some of the potential issues wit=
h tmp-dir and temp-files needed for the script hooks (see commit 4e1cc5f6d =
for details). Already back then we knew this was not covering all issues, b=
ut it was still a good step forward to harden this issue. For those not bei=
ng satisfied with this change, can use --tmp-dir to relocate this directory=
 with stricter privileges. That's probably as strict as you can go.
>
> The challenge at hand was that another process could manage to create a t=
empfile with the same tempname as OpenVPN did earlier, which OpenVPN would =
pick up and read despite it had not created it (it was the task of the plug=
-in/script to do so earlier). This was a perfect trap to inject data from o=
utside, even from a user not privileged to configure OpenVPN. So we changed=
 the model so OpenVPN always creates the temp-file before it runs the plug-=
in/script and ensures the privileges on that file is correct.
>
> And then came systemd with PrivateTmp which added further hardening.
>
> That's the background ... now to PrivateTmp
>
> When running scripts via OpenVPN's script hooks or plug-ins, they should =
run under the same confinement as the OpenVPN process, so it should share t=
he same tmp-dir. So PrivateTmp should not cause any issues in regards to sc=
ript hooks or plug-ins. They should all share the same tmp-dir. I don't rec=
all now if some $TMP or $TMPDIR variables would be set as well.
>
> Now if you want your scripts to leave data after it has run, a tmp-dir is=
 still the wrong location for such data - as then it isn't strictly a tempo=
rary file. In that case, these scripts should ideally use a different path =
with is not confined inside a private tmp-dir.
>
> Some reasonable locations:
>
> -   Most Linux packaging provides /var/lib/openvpn, which should be owned
>
>     by openvpn:openvpn by default. Creating a subdirectory here with the
>
>     proper ACL would be considered appropriate.
> -   If the data you want to leave for another script/process to pick up
>
>     (like a queue), the typical location for that would be /var/spool
>
>     /openpvn (which needs to be created).
> -   If it is cached data, then /var/cache/openvpn would be appropriate.
>
> -   If it is runtime related data, which may be wiped when the OpenVPN
>
>     process is stopped, using /run/openvpn/ would be fine - but these
>
>     days, /run is mostly mounted as a tmpfs filesystem so be careful with
>
>     the amount of data you put there.
>
>     My point is, don't use tmp-dir to save data which isn't really tempor=
ary, where temporary means it should not live there for very long. And don'=
t abuse the --tmp-dir option to relocate it to one of these more persistent=
 locations. Just don't use tmp-dir as a "data exchange point" outside of th=
e communication between the OpenVPN process and the scripts/plug-ins it run=
s.
>
>     --
>
>     kind regards,
>
>     David Sommerseth
>
>     OpenVPN Inc
>
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJg3g+JACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ16HQf/eidEB35HMiT4Jds0GDFS5d8286+lGobsH43z0aVReYfgK/+c
Z3qtcoxKPZNyGeYnyJHCKs1OrtRLVa3O0YJ4kUBhdUFtI8g6wEz5C/XKNDHu
KCjl5kCYtkFG9mzIINXKVTkDOROtI7rDX9+6sW4VvdHb7MSrn+nwWdiX+in0
kUw2rSjXJMyL9dj+NCmpK8HIEkcK6RcedBDlYIq9PtsloQIU8HRRLIySGMpu
II6o0T+PmNTwmIvZctFD42fDGZQpZCP9BWWgdNRpzz7m3qbKWQAxv/EfwKEJ
8fd1FOFL1gIudk5d2kgagspQHrUmAGAUWGFlHKLoGq70LPCp0cX1SQ=3D=3D
=3DmXP4
-----END PGP SIGNATURE-----

--b1_Nb9jcIFX8R3OqE9laWNKKXW8WTSJdpGqiyFdwyaMDQ
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_Nb9jcIFX8R3OqE9laWNKKXW8WTSJdpGqiyFdwyaMDQ
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkj4VeQgkKExQcD8HFaNnfGjdzbFnNf8j88Es1hVObRsFoJKihFV2d1fVGQekjVsg==

--b1_Nb9jcIFX8R3OqE9laWNKKXW8WTSJdpGqiyFdwyaMDQ--


