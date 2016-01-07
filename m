From: Kevin Long <kevinlong206@...277...>
Message-Id: <71715370-6FF1-41BC-94FA-12EBE8E33A40@...277...>
Date: Thu, 7 Jan 2016 14:57:34 -0800
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: [Openvpn-devel] Code to confirm "FIPS MODE" throwing compile error
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
To: openvpn-devel@lists.sourceforge.net


Hello,

I believe I have successfully compiled openvpn on debian , using static ope=
nssl library containing the FIPS compliance module.


However, I have followed this instruction found online:

"Now you should have a FIPS capable OpenSSL (NOTE: OpenSSL itself is not FI=
PS validated, only FIPS capable along with the FIPS Object Module). To make=
 OpenVPN FIPS compliant, you need to add:

#ifdef OPENSSL_FIPS=20
        if(options.no_fips <=3D 0) {
                if(!FIPS_mode_set(1) {
                        ERR_load_crypto_strings();
                        ERR_print_errors_fp(stderr);
                        exit(1);

               }
       }
       else
               fprintf(stderr,"*** IN FIPS MODE ***\n");
#endif

in the file /src/openvpn.c in the OpenVPN source code folder, in the main (=
) function at the very bottom on the file, just before the: return openvpn_=
main(argc, argv);=E2=80=9D




Placing that code into the openvpn.c main function throws the following com=
piler error:

openvpn.c: In function =E2=80=98main=E2=80=99:
openvpn.c:361:12: error: =E2=80=98options=E2=80=99 undeclared (first use in=
 this function)
         if(options.no_fips <=3D 0) {
            ^
openvpn.c:361:12: note: each undeclared identifier is reported only once fo=
r each function it appears in
openvpn.c:362:38: error: expected =E2=80=98)=E2=80=99 before =E2=80=98{=E2=
=80=99 token
                 if(!FIPS_mode_set(1) {
                                      ^
openvpn.c:368:8: error: expected expression before =E2=80=98}=E2=80=99 token
        }
        ^
Makefile:627: recipe for target 'openvpn.o=E2=80=99 failed





Please pardon my ignorance. My goal is to get FIPS compliance and to be abl=
e to confirm it,  but I have not been able to find a good tutorial on how t=
o do this.






