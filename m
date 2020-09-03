MIME-Version: 1.0
References: <CAKuzo_gnC6zdR7c-M44M2RQ=xnCcRPMOGaU+AmCJvprOJCnZsw@...278...>
In-Reply-To: <CAKuzo_gnC6zdR7c-M44M2RQ=xnCcRPMOGaU+AmCJvprOJCnZsw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 3 Sep 2020 15:11:13 +0300
Message-ID: <CAGyAFMVXg0p7tzLsqm=jmMHnCaq5UcvsOYVGimaie5hpAk6vOQ@...278...>
Subject: Re: [Openvpn-devel] On tap-windows6 adapter installation by
 tapctl.exe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

>
> As per setupapi.dev.log, it appears that step 4 (d) is failing with some =
access error to the driver store unless elevated to SYSTEM (see Trac 1321).=
 This leaves the adapter not fully configured. Hard to say exactly what fai=
ls as none of the function calls return any error.

I can confirm that. This call

/* Install the device. */
    if (!SetupDiCallClassInstaller(
            DIF_INSTALLDEVICE,
            hDevInfoList,
            &devinfo_data))
    {
        dwResult =3D GetLastError();
        msg(M_NONFATAL | M_ERRNO, "%s:
SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed", __FUNCTION__);
        goto cleanup_remove_device;
    }

produces this error in setupapi.dev.log

>>>  [Configure Driver Package - c:\windows\system32\driverstore\filereposi=
tory\oemvista.inf_amd64_8a00bc07868b5df3\oemvista.inf]
>>>  Section start 2020/09/03 12:08:49.525
      cmd: "C:\Users\lev\Projects\openvpn\x64-Output\Debug\tapctl.exe" crea=
te
     sto: Source Filter  =3D tap0901.ndi
     sto: Target Filter  =3D ROOT\NET\0004
     inf: Class GUID     =3D {4d36e972-e325-11ce-bfc1-08002be10318}
     inf: Class Options  =3D Configurable
!!!  idb: Failed to open driver package object
'oemvista.inf_amd64_8a00bc07868b5df3'. Error =3D 0x00000005
<<<  Section end 2020/09/03 12:08:49.558
<<<  [Exit status: FAILURE(0x00000005)]


>>>  [Restart Device - ROOT\NET\0004]
>>>  Section start 2020/09/03 12:08:49.565
      cmd: "C:\Users\lev\Projects\openvpn\x64-Output\Debug\tapctl.exe" crea=
te
     dvi: Device Status: 0x01802501 [0x0e - 0x00000000]
!    dvi: Device restart was skipped (NEEDREBOOT/NEEDRESTART).
<<<  Section end 2020/09/03 12:08:49.588
<<<  [Exit status: SUCCESS]

> I propose to replace 4(d) with a call to DiInstallDevice() instead. My te=
sts show this completes without error.

I can confirm that too. This patch

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 7cb3dedc..8d071320 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -29,6 +29,7 @@

 #include <windows.h>
 #include <cfgmgr32.h>
+#include <newdev.h>
 #include <objbase.h>
 #include <setupapi.h>
 #include <stdio.h>
@@ -38,6 +39,7 @@
 #pragma comment(lib, "advapi32.lib")
 #pragma comment(lib, "ole32.lib")
 #pragma comment(lib, "setupapi.lib")
+#pragma comment(lib, "newdev.lib")
 #endif

 const static GUID GUID_DEVCLASS_NET =3D { 0x4d36e972L, 0xe325, 0x11ce,
{ 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
@@ -900,19 +902,13 @@ tap_create_adapter(
     }

     /* Install the device. */
-    if (!SetupDiCallClassInstaller(
-            DIF_INSTALLDEVICE,
-            hDevInfoList,
-            &devinfo_data))
+    if (!DiInstallDevice(NULL, hDevInfoList, &devinfo_data, NULL, 0,
pbRebootRequired))
     {
         dwResult =3D GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s:
SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed", __FUNCTION__);
+        msg(M_NONFATAL | M_ERRNO, "%s: DiInstallDevice failed", __FUNCTION=
__);
         goto cleanup_remove_device;
     }

-    /* Check if a system reboot is required. (Ignore errors) */
-    check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
-
     /* Get network adapter ID from registry. Retry for max 30sec. */
     dwResult =3D get_net_adapter_guid(hDevInfoList, &devinfo_data, 30,
pguidAdapter);

works for both tapctl and MSI installer - created adapters are usable
by non-admin.

>
> This also has an advantage that we could call it with driver_info =3D NUL=
L which will force the system to use the latest matching driver. That would=
 also eliminate step 3 which is right now very inefficient, though not requ=
ired to fix the problem at hand.

Yeah, I also works for me without

for (DWORD dwIndex =3D 0;; dwIndex++)
    {

loop.

>
> If this sounds sane, I'll submit a patch.

Please do!

--=20
-Lev

