From: Noel Kuntze <noel@...2150...>
Message-ID: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
Date: Sat, 9 Jul 2016 18:16:05 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="43rowtixQg8GWSokUk1dgoOams5gphUpg"
Subject: [Openvpn-devel] [PATCH: tap-windows6] Implement option to disable
 source IP check of ARP requests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--43rowtixQg8GWSokUk1dgoOams5gphUpg
Content-Type: multipart/mixed; boundary="r4iiaMv05WFmqNHjj3c2GB553JJsScFSt"
From: Noel Kuntze <noel@...2150...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
Subject: [PATCH: tap-windows6] Implement option to disable source IP check of
	ARP requests

--r4iiaMv05WFmqNHjj3c2GB553JJsScFSt
Content-Type: multipart/mixed; boundary="------------648028B140BE6DF2C6074405"

This is a multi-part message in MIME format.
--------------648028B140BE6DF2C6074405
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello list,


Attached to this email are 8 patches that extend the NDIS6 TAP driver for W=
indows with an

option to disable the source IP check that happens when processing ARP requ=
ests.

The option is enabled (TRUE) by default, which means that the source IP is =
checked.
It can be set to FALSE to disable it. That means that the source IP of ARP =
requests is checked.

I implemented this feature to optionally disable the requirement that the l=
ocal IP is in the same subnet as the remote subnet. In my case,

I want to use the driver with strongswan, which is an implementation of IKE=
v1 and IKEv2. It has no such requirement for the local address or remote ad=
dress(es).


The changed source code compiles successfully, however I do not know if the=
 behaviour is correct, as I do not have a code signing certificate or EV ce=
rtificate

that I could sign the driver with.


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards,
Noel Kuntze

GPG Key ID: 0x63EC6658
Fingerprint: 23CA BB60 2146 05E7 7278 6592 3839 298F 63EC 6658


--------------648028B140BE6DF2C6074405
Content-Type: text/x-patch;
	name="0001-tap-windows.h-Add-control-code-for-setting-source-ch.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-tap-windows.h-Add-control-code-for-setting-source-ch.pa";
	filename*1="tch"

=46rom 2fa2b0fe051deb35b8d45e1af102dcd4746284c5 Mon Sep 17 00:00:00 2001
From: Noel Kuntze <noel@...2150...>
Date: Fri, 8 Jul 2016 17:00:01 +0200
Subject: [PATCH 1/8] tap-windows.h: Add control code for setting source c=
heck
 of ARP requests.

---
 src/tap-windows.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/tap-windows.h b/src/tap-windows.h
index d546a5b..c84c669 100644
--- a/src/tap-windows.h
+++ b/src/tap-windows.h
@@ -44,6 +44,7 @@
 #define TAP_WIN_IOCTL_CONFIG_DHCP_MASQ      TAP_WIN_CONTROL_CODE (7, MET=
HOD_BUFFERED)
 #define TAP_WIN_IOCTL_GET_LOG_LINE          TAP_WIN_CONTROL_CODE (8, MET=
HOD_BUFFERED)
 #define TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT   TAP_WIN_CONTROL_CODE (9, MET=
HOD_BUFFERED)
+#define TAP_WIN_IOCTL_CONFIG_SET_SRC_CHECK  TAP_WIN_CONTROL_CODE (10, ME=
THOD_BUFFERED)
=20
 /* Added in 8.2 */
=20
--=20
2.9.0


--------------648028B140BE6DF2C6074405
Content-Type: text/x-patch;
	name="0002-adapter.h-Add-boolean-to-disable-the-source-check.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0002-adapter.h-Add-boolean-to-disable-the-source-check.patch"

=46rom 1798a35ef4c0a502740921217e3dd4681554463b Mon Sep 17 00:00:00 2001
From: Noel Kuntze <noel@...2150...>
Date: Fri, 8 Jul 2016 18:24:02 +0200
Subject: [PATCH 2/8] adapter.h: Add boolean to disable the source check

---
 src/adapter.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/adapter.h b/src/adapter.h
index 2f09d12..000b6ad 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -251,6 +251,10 @@ typedef struct _TAP_ADAPTER_CONTEXT
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
--=20
2.9.0


--------------648028B140BE6DF2C6074405
Content-Type: text/x-patch;
	name="0003-device.c-Implement-setting-of-option-via-DeviceIoCon.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0003-device.c-Implement-setting-of-option-via-DeviceIoCon.pa";
	filename*1="tch"

=46rom 2bd43f495522310b18b0961ba9775a8420a2a94f Mon Sep 17 00:00:00 2001
From: Noel Kuntze <noel@...2150...>
Date: Fri, 8 Jul 2016 20:27:14 +0200
Subject: [PATCH 3/8] device.c: Implement setting of option via DeviceIoCo=
ntrol

---
 src/device.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 2b7ba9b..2b9e58e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -692,7 +692,20 @@ Return Value:
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
+                Irp->IoStatus.Information =3D 1
+            }
+            else
+            {
+                NOTE_ERROR();
+                Irp->IoStatus.Status =3D ntStatus =3D STATUS_INVALID_PAR=
AMETER;
+            }
+        }
+            break;
     default:
=20
         //
--=20
2.9.0


--------------648028B140BE6DF2C6074405
Content-Type: text/x-patch;
	name="0004-txpath.c-Actually-make-use-of-the-new-configuration-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0004-txpath.c-Actually-make-use-of-the-new-configuration-.pa";
	filename*1="tch"

=46rom ea1618ad51f5b268d5d34ab24b7466f2337f67b1 Mon Sep 17 00:00:00 2001
From: Noel Kuntze <noel@...2150...>
Date: Fri, 8 Jul 2016 22:17:37 +0200
Subject: [PATCH 4/8] txpath.c: Actually make use of the new configuration=

 option.

---
 src/txpath.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/txpath.c b/src/txpath.c
index f627934..b50062c 100644
--- a/src/txpath.c
+++ b/src/txpath.c
@@ -216,6 +216,15 @@ ProcessARP(
     //-----------------------------------------------
     // Is this the kind of packet we are looking for?
     //-----------------------------------------------
+    BOOLEAN source_check =3D FALSE;
+    if (Adapter->m_source_check)
+    {
+        source_check =3D (Adapter->src->m_ARP_IP_Source =3D=3D adapter_i=
p);
+    }
+    else
+    {
+        source_check =3D TRUE;
+    }
     if (src->m_Proto =3D=3D htons (NDIS_ETH_TYPE_ARP)
         && MAC_EQUAL (src->m_MAC_Source, Adapter->PermanentAddress)
         && MAC_EQUAL (src->m_ARP_MAC_Source, Adapter->PermanentAddress)
@@ -225,7 +234,7 @@ ProcessARP(
         && src->m_MAC_AddressSize =3D=3D sizeof (MACADDR)
         && src->m_PROTO_AddressType =3D=3D htons (NDIS_ETH_TYPE_IPV4)
         && src->m_PROTO_AddressSize =3D=3D sizeof (IPADDR)
-        && src->m_ARP_IP_Source =3D=3D adapter_ip
+        && source_check
         && (src->m_ARP_IP_Destination & ip_netmask) =3D=3D ip_network
         && src->m_ARP_IP_Destination !=3D adapter_ip)
     {
--=20
2.9.0


--------------648028B140BE6DF2C6074405
Content-Type: text/x-patch;
 name="0005-Fix-missing-programming-errors.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0005-Fix-missing-programming-errors.patch"

=46rom bfa780f8abb6cd506a4ebc5dbd94a0a398122f73 Mon Sep 17 00:00:00 2001
From: Noel Kuntze <noel@...2150...>
Date: Sat, 9 Jul 2016 00:16:35 +0200
Subject: [PATCH 5/8] Fix missing ;, programming errors.

---
 src/device.c | 2 +-
 src/txpath.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2b9e58e..a13ff4a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -697,7 +697,7 @@ Return Value:
             if (inBufLength >=3D sizeof(ULONG))
             {
                 adapter->m_source_check =3D (BOOLEAN) ((PULONG) (Irp->As=
sociatedIrp.SystemBuffer))[0];
-                Irp->IoStatus.Information =3D 1
+                Irp->IoStatus.Information =3D 1;
             }
             else
             {
diff --git a/src/txpath.c b/src/txpath.c
index b50062c..c0e0d51 100644
--- a/src/txpath.c
+++ b/src/txpath.c
@@ -219,7 +219,7 @@ ProcessARP(
     BOOLEAN source_check =3D FALSE;
     if (Adapter->m_source_check)
     {
-        source_check =3D (Adapter->src->m_ARP_IP_Source =3D=3D adapter_i=
p);
+        source_check =3D (src->m_ARP_IP_Source =3D=3D adapter_ip);
     }
     else
     {
--=20
2.9.0


--------------648028B140BE6DF2C6074405
Content-Type: text/x-patch;
	name="0006-tap-windows.h-Fix-accidental-reuse-of-ioctl-value.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0006-tap-windows.h-Fix-accidental-reuse-of-ioctl-value.patch"

=46rom f4c5968201a1eff00748f31048509bea8173ad9a Mon Sep 17 00:00:00 2001
From: Noel Kuntze <noel@...2150...>
Date: Sat, 9 Jul 2016 00:20:25 +0200
Subject: [PATCH 6/8] tap-windows.h: Fix accidental reuse of ioctl value.

---
 src/tap-windows.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/tap-windows.h b/src/tap-windows.h
index c84c669..562c65b 100644
--- a/src/tap-windows.h
+++ b/src/tap-windows.h
@@ -44,13 +44,12 @@
 #define TAP_WIN_IOCTL_CONFIG_DHCP_MASQ      TAP_WIN_CONTROL_CODE (7, MET=
HOD_BUFFERED)
 #define TAP_WIN_IOCTL_GET_LOG_LINE          TAP_WIN_CONTROL_CODE (8, MET=
HOD_BUFFERED)
 #define TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT   TAP_WIN_CONTROL_CODE (9, MET=
HOD_BUFFERED)
-#define TAP_WIN_IOCTL_CONFIG_SET_SRC_CHECK  TAP_WIN_CONTROL_CODE (10, ME=
THOD_BUFFERED)
=20
 /* Added in 8.2 */
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
--=20
2.9.0


--------------648028B140BE6DF2C6074405
Content-Type: text/x-patch;
	name="0007-adapter.c-Initialise-m_source_check.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0007-adapter.c-Initialise-m_source_check.patch"

=46rom 033dab9d8fa59a5751dff6ea72a61ff25a39b0dd Mon Sep 17 00:00:00 2001
From: Noel Kuntze <noel@...2150...>
Date: Sat, 9 Jul 2016 00:51:06 +0200
Subject: [PATCH 7/8] adapter.c: Initialise m_source_check.

---
 src/adapter.c | 3 +++
 1 file changed, 3 insertions(+)

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
--=20
2.9.0


--------------648028B140BE6DF2C6074405
Content-Type: text/x-patch;
 name="0008-src-Add-own-copyright.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0008-src-Add-own-copyright.patch"

=46rom 9dbdf8a3bacfa043c1c47eac7a1e9a20f2c69635 Mon Sep 17 00:00:00 2001
From: Noel Kuntze <noel@...2150...>
Date: Sat, 9 Jul 2016 00:51:43 +0200
Subject: [PATCH 8/8] src/*: Add own copyright.

---
 src/adapter.h     | 1 +
 src/device.c      | 1 +
 src/tap-windows.h | 1 +
 src/txpath.c      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/src/adapter.h b/src/adapter.h
index 000b6ad..70a394d 100644
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
diff --git a/src/device.c b/src/device.c
index a13ff4a..85897b6 100644
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
diff --git a/src/tap-windows.h b/src/tap-windows.h
index 562c65b..0809c2e 100644
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
diff --git a/src/txpath.c b/src/txpath.c
index c0e0d51..8af5f21 100644
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
--=20
2.9.0


--------------648028B140BE6DF2C6074405--

--r4iiaMv05WFmqNHjj3c2GB553JJsScFSt--

--43rowtixQg8GWSokUk1dgoOams5gphUpg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQI0BAEBCAAeBQJXgSNIFxxub2VsQGZhbWlsaWUta3VudHplLmRlAAoJEDg5KY9j
7GZYq3sP/3S1TBxXFMtOU0QiNJIZGKl7u3dMYTzvs//+4KETCBJ85OsCuE6jBfix
yatb3h75UmXta9nHdO6kVPGGq4/RiH+B7KiSD2TiwSM9x+wPG+Z45OT7GcsGMy/J
xGcxTNzZmDH4rZ+TJh99XIcZxFre+JD84ZRJU+abTvXTE7bhhnWEiyJ/wZM8gCYb
dm28c3W9bYIXXj6OyGukFCR/HHW9dRcnKGauhTjjAlery0OlaIOsJvw0aDNGtq+f
Ct2JR9Xtuk/EZemgXKvwkJ8hT9yTgdL84lrurFMt0qQBaryl+1ObYhP6M/bcbqTO
I7DWdVfacVMnprzAFA/MrtmvySXSLWnXCoInMyrOoxvx46a/6L8gPMRbyqJJdAQK
MQXHGsyalctp/b8Wk5PzEhVobZRErIrr7J9en+YChzgLUniAazPqa1Zc/VyummSV
2OES5vkAJxbEoA33+Bj44jib6xSRx8L7weiPhfBdkTNLAUdNLjzuOoghWj4MtLzZ
2jQ+q77rIfgxK8pXlbm3kx2AI3W7O8sCtQ9YsssRfLqgelRsDhzlayJXhlir7pNL
ErDPd5Jn7Ah66LBXG0Uk9O21w7T4gw36sDnDURsi5oD5wOCW3yWGzlghx0MU2Ged
nMOcNtoGeVQFxknWgy4U7Zono9ccxRLoU2quuONYN4KzdiUclk/e
=asqI
-----END PGP SIGNATURE-----

--43rowtixQg8GWSokUk1dgoOams5gphUpg--

