References: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
	<CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>
From: Noel Kuntze <noel@...2150...>
Message-ID: <531e4123-aa78-6b00-1e10-9ff91cd445ca@...2150...>
Date: Sun, 10 Jul 2016 19:44:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qXeRe4udmfkSiSQp0qk4qg57brB5pqnjG"
Subject: Re: [Openvpn-devel] [PATCH: tap-windows6] Implement option to
 disable source IP check of ARP requests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qXeRe4udmfkSiSQp0qk4qg57brB5pqnjG
Content-Type: multipart/mixed; boundary="B1uS69Fd0gqK78m33rACT4COQDXgfv5Qs"
From: Noel Kuntze <noel@...2150...>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <531e4123-aa78-6b00-1e10-9ff91cd445ca@...2150...>
Subject: Re: [Openvpn-devel] [PATCH: tap-windows6] Implement option to disable
	source IP check of ARP requests
References: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
	<CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>
In-Reply-To: <CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>

--B1uS69Fd0gqK78m33rACT4COQDXgfv5Qs
Content-Type: multipart/mixed; boundary="------------B03B5AC279667806C1462546"

This is a multi-part message in MIME format.
--------------B03B5AC279667806C1462546
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello list,

On 09.07.2016 21:11, Selva Nair wrote:
>=20
> On Sat, Jul 9, 2016 at 12:16 PM, Noel Kuntze <noel@...2150... <mailto:noe=
l@...2150...>> wrote:
>=20
>     The changed source code compiles successfully, however I do not know =
if the behaviour is correct, as I do not have a code signing certificate or=
 EV certificate
>=20
>     that I could sign the driver with.
>=20
>=20
> You can test it with a test signature on a machine booted with TESTSIGNIN=
G boot config option:
>=20
> bcdedit.exe -set TESTSIGNING ON
>=20
> For more info see https://msdn.microsoft.com/en-ca/library/windows/hardwa=
re/ff553484(v=3Dvs.85).aspx <https://msdn.microsoft.com/en-ca/library/windo=
ws/hardware/ff553484%28v=3Dvs.85%29.aspx>
>=20
> Selva

I tested the changes (they work as intended) and pruned them into one singl=
e diff. There's no commit message in it, because I produced it with `git di=
ff` and don't want to break the diff accidently.
The miniscule changes of whitespaces that were produced by whatever softwar=
e are gone, so it's less noisy. The fixes for my own progbramming errors ar=
e also pruned into this fix.

The instructions in Selva's link weren't enough to convince windows to trus=
t the driver. I had to also enable debug mode and I signed it with one of m=
y own certificates.
The patch is attached.

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards,
Noel Kuntze

GPG Key ID: 0x63EC6658
Fingerprint: 23CA BB60 2146 05E7 7278 6592 3839 298F 63EC 6658


--------------B03B5AC279667806C1462546
Content-Type: text/x-patch;
 name="0001-implement-source-ip-check.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-implement-source-ip-check.patch"

diff --git a/src/adapter.c b/src/adapter.c
index 2883b79..fd575f9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -222,6 +222,9 @@ tapReadConfiguration(
     Adapter->MediaStateAlwaysConnected =3D FALSE;
     Adapter->LogicalMediaState =3D FALSE;
     Adapter->AllowNonAdmin =3D FALSE;
+    // source check can not be set in the registry yet. This has to be s=
et each
+    // time the adapter is opened.
+    Adapter->m_source_check =3D TRUE;
     //
     // Open the registry for this adapter to read advanced
     // configuration parameters stored by the INF file.
diff --git a/src/adapter.h b/src/adapter.h
index 2f09d12..70a394d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -4,6 +4,7 @@
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.=

  *=20
+ *  Copyright (C) 2016 Noel Kuntze <noel@...2150...>
  *  This source code is Copyright (C) 2002-2014 OpenVPN Technologies, In=
c.,
  *  and is released under the GPL version 2 (see below).
  *
@@ -251,6 +252,10 @@ typedef struct _TAP_ADAPTER_CONTEXT
   BOOLEAN m_CalledAdapterFreeResources;
   BOOLEAN m_RegisteredAdapterShutdownHandler;
=20
+   // This variable is initialised as TRUE. If it is set to FALSE, the a=
dapter does
+   // not check the source IP field of the ARP requests it receives on t=
he adapter.
+  BOOLEAN m_source_check;
+
 } TAP_ADAPTER_CONTEXT, *PTAP_ADAPTER_CONTEXT;
=20
 FORCEINLINE
diff --git a/src/device.c b/src/device.c
index 2b7ba9b..85897b6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4,6 +4,7 @@
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.=

  *
+ *  Copyright (C) 2016 Noel Kuntze <noel@...2150...>
  *  This source code is Copyright (C) 2002-2014 OpenVPN Technologies, In=
c.,
  *  and is released under the GPL version 2 (see below).
  *
@@ -692,7 +693,20 @@ Return Value:
             }
         }
         break;
-
+    case TAP_WIN_IOCTL_CONFIG_SET_SRC_CHECK:
+        {
+            if (inBufLength >=3D sizeof(ULONG))
+            {
+                adapter->m_source_check =3D (BOOLEAN) ((PULONG) (Irp->As=
sociatedIrp.SystemBuffer))[0];
+                Irp->IoStatus.Information =3D 1;
+            }
+            else
+            {
+                NOTE_ERROR();
+                Irp->IoStatus.Status =3D ntStatus =3D STATUS_INVALID_PAR=
AMETER;
+            }
+        }
+        break;
     default:
=20
         //
diff --git a/src/tap-windows.h b/src/tap-windows.h
index d546a5b..0809c2e 100644
--- a/src/tap-windows.h
+++ b/src/tap-windows.h
@@ -4,6 +4,7 @@
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.=

  *
+ *  Copyright (C) 2016 Noel Kuntze <noel@...2150...>
  *  This source code is Copyright (C) 2002-2014 OpenVPN Technologies, In=
c.,
  *  and is released under the GPL version 2 (see below).
  *
@@ -49,7 +50,7 @@
=20
 /* obsoletes TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT */
 #define TAP_WIN_IOCTL_CONFIG_TUN            TAP_WIN_CONTROL_CODE (10, ME=
THOD_BUFFERED)
-
+#define TAP_WIN_IOCTL_CONFIG_SET_SRC_CHECK  TAP_WIN_CONTROL_CODE (11, ME=
THOD_BUFFERED)
 /*
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  * Registry keys
diff --git a/src/txpath.c b/src/txpath.c
index f627934..8af5f21 100644
--- a/src/txpath.c
+++ b/src/txpath.c
@@ -4,6 +4,7 @@
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.=

  *=20
+ *  Copyright (C) 2016 Noel Kuntze <noel@...2150...>
  *  This source code is Copyright (C) 2002-2014 OpenVPN Technologies, In=
c.,
  *  and is released under the GPL version 2 (see below).
  *
@@ -216,6 +217,15 @@ ProcessARP(
     //-----------------------------------------------
     // Is this the kind of packet we are looking for?
     //-----------------------------------------------
+    BOOLEAN source_check =3D FALSE;
+    if (Adapter->m_source_check)
+    {
+        source_check =3D (src->m_ARP_IP_Source =3D=3D adapter_ip);
+    }
+    else
+    {
+        source_check =3D TRUE;
+    }
     if (src->m_Proto =3D=3D htons (NDIS_ETH_TYPE_ARP)
         && MAC_EQUAL (src->m_MAC_Source, Adapter->PermanentAddress)
         && MAC_EQUAL (src->m_ARP_MAC_Source, Adapter->PermanentAddress)
@@ -225,7 +235,7 @@ ProcessARP(
         && src->m_MAC_AddressSize =3D=3D sizeof (MACADDR)
         && src->m_PROTO_AddressType =3D=3D htons (NDIS_ETH_TYPE_IPV4)
         && src->m_PROTO_AddressSize =3D=3D sizeof (IPADDR)
-        && src->m_ARP_IP_Source =3D=3D adapter_ip
+        && source_check
         && (src->m_ARP_IP_Destination & ip_netmask) =3D=3D ip_network
         && src->m_ARP_IP_Destination !=3D adapter_ip)
     {

--------------B03B5AC279667806C1462546--

--B1uS69Fd0gqK78m33rACT4COQDXgfv5Qs--

--qXeRe4udmfkSiSQp0qk4qg57brB5pqnjG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQI0BAEBCAAeBQJXgomJFxxub2VsQGZhbWlsaWUta3VudHplLmRlAAoJEDg5KY9j
7GZYDVkQAIDz8zlwsEnG9J+Nt+nZYilqVUOXG6he5GIaY6tSvxiMou5OLOJa9Ipr
GI1Zf+ntfvzvGxe+L2LZLC5/1ahKfWIPeGr9V4Yr4sRlCVxnEz/UIhQq0aNNMLs1
jlmVX5cdSCtasnhMorjSPFMxR5Aqb/ws/6WONe0mWYkGko6AnSSdthnEKZVaPRkZ
Uf2UTkrndKAGiabFtIFhpgdEHtrnTeXKtctHHtsEfG9OR8/H12l8zHQWKBG+iVDn
40vTKj9OhDWcPYp3gK4VhxqglVXI2sxLrq+E9Lj7PPMwfpLb+j1n7O6+qjbXBBRq
XS5zWNEga2lpFZhl2MXuCVm6RaQUXbDagmOUVg5xI7fp2zQB3kmUX6ZSowLTBPYr
DXvNX2IcDNjFC+h8oCuGPLEAAOhu4NtGGrgDaR5iIAQFFNs9ea4kEU+wb2RymZ3N
c/sXuMX8eTlLj+d69fxAncEgU5G9uT23o+JjH8y4US1pa7khcLb9JQXuD75DiOIZ
b3zAWKdWNbIzd666VaTp8pczrmB8RgvN9BFHnJZZ1j0prNgbEv5kga3tK9+GHaMv
kdU8ik7hAZy+tXDHje7inA2cuIeoTfnKMHZRMGpHvE/7erJt78xd1Gwyy4ymjG/C
UvbAOrM7X3ArZWEbC9ojNxNE8mQV0gs5tyCOo1bHHr/vn617VLlF
=oQ4p
-----END PGP SIGNATURE-----

--qXeRe4udmfkSiSQp0qk4qg57brB5pqnjG--

