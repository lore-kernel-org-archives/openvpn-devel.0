MIME-Version: 1.0
In-Reply-To: <4D713CD3.3000606@...515...>
References: <4D713CD3.3000606@...515...>
Date: Fri, 4 Mar 2011 23:14:33 +0200
Message-ID: <AANLkTin4QkZ36mi7qHyB9R+i1FdQJi66mi6nhhvYMWmN@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Content-Type: multipart/mixed; boundary=bcaec51dd30fedb939049daea1e5
Subject: Re: [Openvpn-devel] OpenVPN 2.2-RC released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--bcaec51dd30fedb939049daea1e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Any reason why the windows cross compile fix we discussed [1] did not
made it into mainline?

Attached again.

This is trivial patch, which resume the ability to build openvpn using
cross compiler and autotools.

Please apply so we don't need to maintain this out of tree.

You can test build at [2].

Alon

[1] http://permalink.gmane.org/gmane.network.openvpn.devel/3991
[2] https://www.opensc-project.org/opensc/wiki/build

2011/3/4 Samuli Sepp=C3=A4nen <samuli@...515...>
>
> The OpenVPN community project team is proud to release OpenVPN 2.2-RC.
> It can be downloaded from here:
>
> =C2=A0* http://openvpn.net/index.php/open-source/downloads.html
>
> Changes include:
>
> =C2=A0 =C2=A0* Windows installer built and packaged with the new Python-b=
ased
> buildsystem that utilizes the Visual Studio 2008 toolchain
> =C2=A0 =C2=A0* Lots of enhancements and fixes to the Python-based Windows
> buildsystem (see Changelog for details)
> =C2=A0 =C2=A0* Make the --x509-username-field feature an opt-in feature
>
> A more comprehensive list of changes is available here:
>
> =C2=A0*
> http://openvpn.net/index.php/open-source/documentation/change-log/425-cha=
ngelog-for-openvpn-22.html
>
> If you find a bug in this release, please file a bug report to our Trac
> bug tracker. In uncertain cases please contact our developers first,
> either using the openvpn-devel mailinglist or the developer IRC channel
> (#openvpn-devel at irc.freenode.net).
>
> NOTE: In production environments you should use the latest stable
> release, not this release candidate build.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> -------------------------------------------------------------------------=
-----
> What You Don't Know About Data Connectivity CAN Hurt You
> This paper provides an overview of data connectivity, details
> its effect on application quality, and explores various alternative
> solutions. http://p.sf.net/sfu/progress-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--bcaec51dd30fedb939049daea1e5
Content-Type: application/octet-stream; name="openvpn-001-windows.patch"
Content-Disposition: attachment; filename="openvpn-001-windows.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkvldjtt0

ZGlmZiAtdXJOcCBvcGVudnBuLTIuMS4zL2FjaW5jbHVkZS5tNCBvcGVudnBuLTIuMS4zLm5ldy9h
Y2luY2x1ZGUubTQKLS0tIG9wZW52cG4tMi4xLjMvYWNpbmNsdWRlLm00CTIwMTAtMDMtMzEgMDk6
NDc6MDguMDAwMDAwMDAwICswMzAwCisrKyBvcGVudnBuLTIuMS4zLm5ldy9hY2luY2x1ZGUubTQJ
MjAxMC0wOS0xMyAxNzo1MDowOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTkwLDM0ICs5MCwzMCBAQCBB
Q19ERUZVTihbVFlQRV9TT0NLTEVOX1RdLAogICAgICAgQUNfTVNHX0NIRUNLSU5HKFtmb3Igc29j
a2xlbl90IGVxdWl2YWxlbnRdKQogICAgICAgQUNfQ0FDSEVfVkFMKFtjdXJsX2N2X3NvY2tsZW5f
dF9lcXVpdl0sCiAgICAgICBbCi0gICAgICAgICAjIFN5c3RlbXMgaGF2ZSBlaXRoZXIgInN0cnVj
dCBzb2NrYWRkciAqIiBvcgotICAgICAgICAgIyAidm9pZCAqIiBhcyB0aGUgc2Vjb25kIGFyZ3Vt
ZW50IHRvIGdldHBlZXJuYW1lCi0gICAgICAgICBjdXJsX2N2X3NvY2tsZW5fdF9lcXVpdj0KLSAg
ICAgICAgIGZvciBhcmcyIGluICJzdHJ1Y3Qgc29ja2FkZHIiIHZvaWQ7IGRvCi0gICAgICAgICAg
ICBmb3IgdCBpbiBpbnQgc2l6ZV90IHVuc2lnbmVkIGxvbmcgInVuc2lnbmVkIGxvbmciOyBkbwot
ICAgICAgICAgICAgICAgQUNfVFJZX0NPTVBJTEUoWwotICAgICAgICAgICAgICAgICAgI2lmZGVm
IF9XSU4zMgotICAgICAgICAgICAgICAgICAgI2luY2x1ZGUgPHdpbmRvd3MuaD4KLSAgICAgICAg
ICAgICAgICAgICNkZWZpbmUgUFJFRklYMSBXSU5TT0NLX0FQSV9MSU5LQUdFCi0gICAgICAgICAg
ICAgICAgICAjZGVmaW5lIFBSRUZJWDIgUEFTQ0FMCi0gICAgICAgICAgICAgICAgICAjZWxzZQot
ICAgICAgICAgICAgICAgICAgI2luY2x1ZGUgPHN5cy90eXBlcy5oPgotICAgICAgICAgICAgICAg
ICAgI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KLSAgICAgICAgICAgICAgICAgICNkZWZpbmUgUFJF
RklYMQotICAgICAgICAgICAgICAgICAgI2RlZmluZSBQUkVGSVgyCi0gICAgICAgICAgICAgICAg
ICAjZGVmaW5lIFNPQ0tFVCBpbnQKLSAgICAgICAgICAgICAgICAgICNlbmRpZgotCi0gICAgICAg
ICAgICAgICAgICBQUkVGSVgxIGludCBQUkVGSVgyIGdldHBlZXJuYW1lIChTT0NLRVQsICRhcmcy
ICosICR0ICopOwotICAgICAgICAgICAgICAgXSxbCi0gICAgICAgICAgICAgICAgICAkdCBsZW47
Ci0gICAgICAgICAgICAgICAgICBnZXRwZWVybmFtZSgwLDAsJmxlbik7Ci0gICAgICAgICAgICAg
ICBdLFsKLSAgICAgICAgICAgICAgICAgIGN1cmxfY3Zfc29ja2xlbl90X2VxdWl2PSIkdCIKLSAg
ICAgICAgICAgICAgICAgIGJyZWFrCi0gICAgICAgICAgICAgICBdKQorICAgICAgICAgY2FzZSAi
JGhvc3QiIGluCisJICotbWluZ3cqKSBjdXJsX2N2X3NvY2tsZW5fdF9lcXVpdj1pbnQgOzsKKwkg
KikKKyAgICAgICAgICAgICMgU3lzdGVtcyBoYXZlIGVpdGhlciAic3RydWN0IHNvY2thZGRyICoi
IG9yCisgICAgICAgICAgICAjICJ2b2lkICoiIGFzIHRoZSBzZWNvbmQgYXJndW1lbnQgdG8gZ2V0
cGVlcm5hbWUKKyAgICAgICAgICAgIGN1cmxfY3Zfc29ja2xlbl90X2VxdWl2PQorICAgICAgICAg
ICAgZm9yIGFyZzIgaW4gInN0cnVjdCBzb2NrYWRkciIgdm9pZDsgZG8KKyAgICAgICAgICAgICAg
IGZvciB0IGluIGludCBzaXplX3QgdW5zaWduZWQgbG9uZyAidW5zaWduZWQgbG9uZyI7IGRvCisg
ICAgICAgICAgICAgICAgICBBQ19UUllfQ09NUElMRShbCisgICAgICAgICAgICAgICAgICAgICAj
aW5jbHVkZSA8c3lzL3R5cGVzLmg+CisgICAgICAgICAgICAgICAgICAgICAjaW5jbHVkZSA8c3lz
L3NvY2tldC5oPgorCisgICAgICAgICAgICAgICAgICAgICBpbnQgZ2V0cGVlcm5hbWUgKGludCwg
JGFyZzIgKiwgJHQgKik7CisgICAgICAgICAgICAgICAgICBdLFsKKyAgICAgICAgICAgICAgICAg
ICAgICR0IGxlbjsKKyAgICAgICAgICAgICAgICAgICAgIGdldHBlZXJuYW1lKDAsMCwmbGVuKTsK
KyAgICAgICAgICAgICAgICAgIF0sWworICAgICAgICAgICAgICAgICAgICAgY3VybF9jdl9zb2Nr
bGVuX3RfZXF1aXY9IiR0IgorICAgICAgICAgICAgICAgICAgICAgYnJlYWsKKyAgICAgICAgICAg
ICAgICAgIF0pCisgICAgICAgICAgICAgICBkb25lCiAgICAgICAgICAgICBkb25lCi0gICAgICAg
ICBkb25lCisJIDs7CisJIGVzYWMKIAogICAgICAgICAgaWYgdGVzdCAieCRjdXJsX2N2X3NvY2ts
ZW5fdF9lcXVpdiIgPSB4OyB0aGVuCiAgICAgICAgICAgICBBQ19NU0dfRVJST1IoW0Nhbm5vdCBm
aW5kIGEgdHlwZSB0byB1c2UgaW4gcGxhY2Ugb2Ygc29ja2xlbl90XSkKZGlmZiAtdXJOcCBvcGVu
dnBuLTIuMS4zL2NvbmZpZ3VyZS5hYyBvcGVudnBuLTIuMS4zLm5ldy9jb25maWd1cmUuYWMKLS0t
IG9wZW52cG4tMi4xLjMvY29uZmlndXJlLmFjCTIwMTAtMDQtMjggMTk6MjU6MzguMDAwMDAwMDAw
ICswMzAwCisrKyBvcGVudnBuLTIuMS4zLm5ldy9jb25maWd1cmUuYWMJMjAxMC0wOS0xMyAxNzo1
MDozNS4wMDAwMDAwMDAgKzAyMDAKQEAgLTMwOCw2ICszMDgsNyBAQCBjYXNlICIkdGFyZ2V0IiBp
bgogCTs7CiAqbWluZ3cqKQogCUFDX0RFRklORShUQVJHRVRfV0lOMzIsIDEsIFtBcmUgd2UgcnVu
bmluZyBXSU4zMj9dKQorCUNQUEZMQUdTPSIke0NQUEZMQUdTfSAtRFdJTjMyX0xFQU5fQU5EX01F
QU4iCiAJT1BFTlZQTl9BRERfTElCUygtbGdkaTMyKQogCU9QRU5WUE5fQUREX0xJQlMoLWx3czJf
MzIpCiAJT1BFTlZQTl9BRERfTElCUygtbHdpbmluZXQpCmRpZmYgLXVyTnAgb3BlbnZwbi0yLjEu
My9zeXNoZWFkLmggb3BlbnZwbi0yLjEuMy5uZXcvc3lzaGVhZC5oCi0tLSBvcGVudnBuLTIuMS4z
L3N5c2hlYWQuaAkyMDEwLTA3LTI3IDAxOjA2OjUxLjAwMDAwMDAwMCArMDMwMAorKysgb3BlbnZw
bi0yLjEuMy5uZXcvc3lzaGVhZC5oCTIwMTAtMDktMTMgMTc6NDQ6MTYuMDAwMDAwMDAwICswMjAw
CkBAIC01MSw2ICs1MSw3IEBACiAKICNpZmRlZiBXSU4zMgogI2luY2x1ZGUgPHdpbmRvd3MuaD4K
KyNpbmNsdWRlIDx3aW5zb2NrMi5oPgogI2RlZmluZSBzbGVlcCh4KSBTbGVlcCgoeCkqMTAwMCkK
ICNkZWZpbmUgcmFuZG9tIHJhbmQKICNkZWZpbmUgc3JhbmRvbSBzcmFuZApkaWZmIC11ck5wIG9w
ZW52cG4tMi4xLjMvdGFwLXdpbjMyL2NvbW1vbi5oIG9wZW52cG4tMi4xLjMubmV3L3RhcC13aW4z
Mi9jb21tb24uaAotLS0gb3BlbnZwbi0yLjEuMy90YXAtd2luMzIvY29tbW9uLmgJMjAxMC0wNC0y
OCAxOToyNTozOS4wMDAwMDAwMDAgKzAzMDAKKysrIG9wZW52cG4tMi4xLjMubmV3L3RhcC13aW4z
Mi9jb21tb24uaAkyMDEwLTA5LTEzIDE3OjU0OjI2LjAwMDAwMDAwMCArMDIwMApAQCAtMjgsNyAr
MjgsOSBAQAogLy8gY29tbW9uIHRvIGJvdGguCiAvLz09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09CiAKKyNpZm5kZWYgSEFWRV9DT05GSUdfSAogI2luY2x1ZGUg
ImF1dG9kZWZzLmgiCisjZW5kaWYKIAogLy89PT09PT09PT09PT09CiAvLyBUQVAgSU9DVExzCg==
--bcaec51dd30fedb939049daea1e5--

