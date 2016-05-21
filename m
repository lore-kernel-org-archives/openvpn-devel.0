Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <20160521185940.GT53051@...1296...>
Date: Sat, 21 May 2016 23:32:40 +0200
Message-Id: <A72247F4-3D1B-42B1-AD1E-EC1E28EF5346@...2127...>
References: <AE97EF71-3179-4CA9-859C-EE9F2A5DEFBA@...2127...>
	<20160521185940.GT53051@...1296...>
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>


Hi Gert,


> Hi,
>=20
> On Sat, May 21, 2016 at 07:05:01PM +0200, Jens Neuhalfen wrote:
>> ./t_lpback.sh fails with AES-GCM mode on Solaris 11. CRYPTO_gcm128_setiv=
 from libcrypto seems to jump into NULL pointer country.=20
>=20
> Oh, interesting.  My OpenSSL on the OpenSolaris box is so old that it does
> not have the AES-GCM modes, so I never tested this (and, of course, "all=
=20
> tests pass").
>=20
> Is this Sparc or Intel Solaris?  Which version of OpenSSL?  32 or 64 bit?


This is=20
* Solaris 11.3 on Intel 64 bit (isainfo -k =E2=80=94> amd64), fresh from Su=
n^H^H^HOracle

* OpenSSL 1.0.1p.  openssl is compiled as 32 bit library (file /lib/libcryp=
to.so.1.0.0 =E2=80=94> /lib/libcrypto.so.1.0.0:        ELF 32-bit LSB dynam=
ic lib 80386 Version 1 [SSE2 SSE MMX CMOV FPU], dynamically linked, not str=
ipped).


pkg info openssl
          Name: library/security/openssl
       Summary: OpenSSL - a Toolkit for Secure Sockets Layer (SSL v2/v3) an=
d Transport Layer (TLS v1) protocols and general purpose cryptographic libr=
ary
   Description: OpenSSL is a full-featured toolkit implementing the Secure
                Sockets Layer (SSL v2/v3) and Transport Layer Security (TLS=
 v1)
                protocols as well as a full-strength general purpose
                cryptography library.
      Category: System/Security
         State: Installed
     Publisher: solaris
       Version: 1.0.1.16 (1.0.1p)
 Build Release: 5.11
        Branch: 0.175.3.0.0.30.0
Packaging Date: August 21, 2015 05:11:12 PM
          Size: 13.26 MB
          FMRI: pkg://solaris/library/security/openssl@...2141...,5.11-0.17=
5.3.0.0.30.0:20150821T171112Z


Cheers Jens
