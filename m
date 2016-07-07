References: <71715370-6FF1-41BC-94FA-12EBE8E33A40@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <577E0E34.9090805@...2080...>
Date: Thu, 7 Jul 2016 10:09:24 +0200
MIME-Version: 1.0
In-Reply-To: <71715370-6FF1-41BC-94FA-12EBE8E33A40@...277...>
Subject: Re: [Openvpn-devel] Code to confirm "FIPS MODE" throwing compile
 error
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Kevin Long <kevinlong206@...277...>, openvpn-devel@lists.sourceforge.net

On 07/01/16 23:57, Kevin Long wrote:
>=20
> Hello,
>=20
> I believe I have successfully compiled openvpn on debian , using static o=
penssl library containing the FIPS compliance module.
>=20
>=20
> However, I have followed this instruction found online:
>=20
> "Now you should have a FIPS capable OpenSSL (NOTE: OpenSSL itself is not =
FIPS validated, only FIPS capable along with the FIPS Object Module). To ma=
ke OpenVPN FIPS compliant, you need to add:
>=20
> #ifdef OPENSSL_FIPS=20
>         if(options.no_fips <=3D 0) {
>                 if(!FIPS_mode_set(1) {
>                         ERR_load_crypto_strings();
>                         ERR_print_errors_fp(stderr);
>                         exit(1);
>=20
>                }
>        }
>        else
>                fprintf(stderr,"*** IN FIPS MODE ***\n");
> #endif
>=20
> in the file /src/openvpn.c in the OpenVPN source code folder, in the main=
 () function at the very bottom on the file, just before the: return openvp=
n_main(argc, argv);=E2=80=9D
>=20
>=20
>=20
>=20
> Placing that code into the openvpn.c main function throws the following c=
ompiler error:
>=20
> openvpn.c: In function =E2=80=98main=E2=80=99:
> openvpn.c:361:12: error: =E2=80=98options=E2=80=99 undeclared (first use =
in this function)
>          if(options.no_fips <=3D 0) {
>             ^
> openvpn.c:361:12: note: each undeclared identifier is reported only once =
for each function it appears in
> openvpn.c:362:38: error: expected =E2=80=98)=E2=80=99 before =E2=80=98{=
=E2=80=99 token
>                  if(!FIPS_mode_set(1) {
>                                       ^
> openvpn.c:368:8: error: expected expression before =E2=80=98}=E2=80=99 to=
ken
>         }
>         ^
> Makefile:627: recipe for target 'openvpn.o=E2=80=99 failed
>=20
>=20
>=20
>=20
>=20
> Please pardon my ignorance. My goal is to get FIPS compliance and to be a=
ble to confirm it,  but I have not been able to find a good tutorial on how=
 to do this.

This code isn't available in the upstream OpenVPN code base AFAICT ...

$ git rev-parse HEAD
b76acd72cd8ea295b925e058336440ff819ca8f4
$ git rev-parse --symbolic-full-name HEAD
refs/heads/release/2.3
$ git grep --ignore-case fips
$ git log -p | grep -i fips
$

So this seems to be an external patch which have never been in our code
base.  The first 'git grep' looks for anything in all source files which
contains 'fips' (and ignoring upper/lower case).  The 'git log -p | grep
-i fips' greps through all commits, including the code changes itself,
since the very beginning of the git tree - which dates back to the time
where the 2.1 BETA was forked out as a separate SVN branch back in
September 2005.

I also did the same check on the master branch, with the same results.

You also say you believe you compiled this successfully on Debian, I
doubt that.  Then it was a different additional patch *or* OPENSSL_FIPS
 was not defined when building OpenVPN.

If you want to have a certified OpenVPN release, then I'd probably
recommend looking into OpenVPN-NL [1] instead.

[1] <https://openvpn.fox-it.com/>


--=20
kind regards,

David Sommerseth

