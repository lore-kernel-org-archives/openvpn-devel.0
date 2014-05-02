Message-ID: <5362FBD6.3030404@...1901...>
Date: Thu, 01 May 2014 21:58:46 -0400
From: Timothe Litt <litt@...1901...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms030408050006030102020309"
Subject: [Openvpn-devel] [PATCH] Add support for specifying the syslog
 facility, requested in, trac #188. (Rev 2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a cryptographically signed message in MIME format.

--------------ms030408050006030102020309
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Reflects review comments from David; doc changes, single patch, one name=20
change,
some clarification in the commit message.  No functional changes.

Detailed response/rationale in previous email.

 From 4af33b94ad4e2509fb9bc195eb50404c0d2b7581 Mon Sep 17 00:00:00 2001
From: Timothe Litt <litt@...1901...>
Date: Thu, 1 May 2014 20:57:45 -0400
Subject: [PATCH] Add support for specifying the syslog facility,=20
requested in trac #188.

Revision 2, reflects review comments from David.

Users want this because it allows them to have syslog put all OpenVPN=20
messages
in specific file(s) by using syslog.conf.

Adds --syslog-facility name option, which must precede --daemon and=20
--syslog.

Adds ability to specify facility as [name] in --daemon and --syslog's=20
progname argument,
which makes it possible to specify the syslog facility name without=20
modifying certain
system init scripts.  --syslog-facility takes precedence.

For example, Debian automatically generates a --daemon vpn-{configname}
directive.  If you name the config foo[local1].conf, it's as though you=20
were able to
specify --syslog-facility local1 --daemon vpn-foo --config=20
foo[local1].conf.  Absent
this feature, this isn't possible without modifying the=20
distribution-provided init script.

--syslog-facility list (or any other undefined name) will list the=20
facilities that the
platform supports.

The old method of -DLOG_OPENVPN still provides the facility used by default.

Thus, syslog facility can be specified in one of three ways:
   --syslog-facility
   --daemon or --syslog's progname argument with embedded [facility]
   -DLOG_OPENVPN

For a given configuration:
    if --syslog-facility is present, its argument determines the facility.
    Otherwise:
        if --daemon or --syslog has a progname argument that contains a=20
[facility] string,
        the [facility] will be used.
    Otherwise:
       The compile-time default LOG_OPENVPN, usually 'daemon', is used.

This is forward and backward compatible with existing scripts & initfiles.

Signed-off-by: Timothe Litt <litt@...1901...>
---
  doc/openvpn.8         |   17 +++++++
  src/openvpn/error.c   |  129=20
+++++++++++++++++++++++++++++++++++++++++++++++--
  src/openvpn/error.h   |    1 +
  src/openvpn/options.c |   19 ++++++++
  4 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 34894e5..e25a39c 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2169,6 +2169,12 @@ When unspecified,
  .B progname
  defaults to "openvpn".

+If --syslog-facility has not been specified and the name
+includes [facility], the specified syslog facility name will be used with
+the system logger.  This method of specifying the facility name may be
+useful when initialization scripts generate --daemon progname from
+the config file name.  This avoids the need to edit the script.
+
  When OpenVPN is run with the
  .B \-\-daemon
  option, it will try to delay daemonization until the majority of=20
initialization
@@ -2188,6 +2194,17 @@ directive above for description of
  .B progname
  parameter.
  .TP
+.B \-\-syslog-faciity name
+When logging to syslog, use name (e.g. local1 or daemon) for the facility.
+If name is absent or not supported, a platform-dependent list of valid
+facility names is provided.
+
+Must be specified before --daemon and --syslog.
+If this is not convenient, the facility name may be specified as [name] in
+the name parameter of either directive.  See --daemon.
+
+If this option is not specified, the default facility is usually 'daemon'.
+.TP
  .B \-\-errors-to-stderr
  Output errors to stderr instead of stdout unless log output is=20
redirected by one of the
  .B \-\-log
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index fd9f19d..53048bf 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -89,9 +89,10 @@ static bool machine_readable_output;   /* GLOBAL */
  /* Should timestamps be included on messages to stdout/stderr? */
  static bool suppress_timestamps; /* GLOBAL */

-/* The program name passed to syslog */
+/* The program name and facility passed to syslog */
  #if SYSLOG_CAPABILITY
  static char *pgmname_syslog;  /* GLOBAL */
+static int facility_syslog =3D -1; /* Unspec (RFC5424 - can not be=20
negative) */
  #endif

  /* If non-null, messages should be written here (used for debugging=20
only) */
@@ -439,6 +440,93 @@ out_of_memory (void)
    exit (1);
  }

+#if SYSLOG_CAPABILITY
+static int lookup_syslog_facility_code (const char *name, int default_code)
+{
+  static struct {
+    int code;
+    const char *const name;
+  } facnames[] =3D {
+    { LOG_AUTH, "auth" },
+#ifdef LOG_AUTHPRIV  /* Prefered (private), but non-POSIX */
+    { LOG_AUTHPRIV, "authpriv" },
+#else
+    { LOG_AUTH, "authpriv" }, /* Map to non-secure code */
+#endif
+    { LOG_CRON, "cron" },
+    { LOG_DAEMON, "daemon" },
+#ifdef LOG_FTP
+    { LOG_FTP, "ftp" },
+#endif
+    { LOG_LPR, "lpr" },
+    { LOG_MAIL, "mail" },
+    { LOG_NEWS, "news" },
+#ifdef LOG_SYSLOG
+    { LOG_SYSLOG, "syslog" },
+#endif
+    { LOG_USER, "user" },
+#ifdef LOG_UUCP
+    { LOG_UUCP, "uucp" },
+#endif
+    { LOG_LOCAL0, "local0" },
+    { LOG_LOCAL1, "local1" },
+    { LOG_LOCAL2, "local2" },
+    { LOG_LOCAL3, "local3" },
+    { LOG_LOCAL4, "local4" },
+    { LOG_LOCAL5, "local5" },
+    { LOG_LOCAL6, "local6" },
+    { LOG_LOCAL7, "local7" },
+
+    { 0, NULL },
+  }, *fac;
+
+   if (use_syslog)
+    {
+      msg (M_ERR, "syslog facility can not be changed after logging has=20
started");
+      return;
+    }
+
+ /* Lookup facility code by name */
+
+  for (fac =3D facnames; fac->name; fac++)
+    {
+      if (!strcmp (fac->name, name))
+       {
+         return  fac->code;
+       }
+    }
+
+  /* Not found, look for name of facility that will be used */
+
+  if (default_code =3D=3D -1)
+    default_code =3D LOG_OPENVPN;
+
+  for (fac =3D facnames; fac->name; fac++)
+    {
+      if (fac->code =3D=3D default_code)
+       {
+         break;
+       }
+    }
+
+  /* Warn, and list valid names (they are platform-dependent) */
+
+  msg (M_WARN, "syslog: %s is not a valid facility name, using %s", name,
+       (fac->name? fac->name : "default"));
+  for (fac =3D facnames; fac->name; fac++)
+    {
+      msg (M_INFO, "syslog: %s facility is valid on this platform",=20
fac->name);
+    }
+  return default_code;
+}
+
+void set_syslog_facility (const char *name)
+{
+  facility_syslog =3D lookup_syslog_facility_code (name, -1);
+}
+
+#endif
+
  void
  open_syslog (const char *pgmname, bool stdio_to_null)
  {
@@ -447,8 +535,43 @@ open_syslog (const char *pgmname, bool stdio_to_null)
      {
        if (!use_syslog)
         {
-         pgmname_syslog =3D string_alloc (pgmname ? pgmname : PACKAGE, NUL=
L);
-         openlog (pgmname_syslog, LOG_PID, LOG_OPENVPN);
+         char *pname =3D pgmname_syslog =3D string_alloc (pgmname ?
+                                                      pgmname :=20
PACKAGE, NULL);
+         int facility =3D facility_syslog;
+         if (facility =3D=3D -1)
+           {
+             /* Unspecified, default */
+
+             facility =3D LOG_OPENVPN;
+
+             /* Attempt to extract from program name (simplifies init=20
files) */
+             char *facb, *face;
+
+             /* Decode optional [facilityname] prefix */
+
+             if ((facb =3D strchr (pgmname_syslog, '[')) !=3D NULL
+                 && (face =3D strchr (facb+1, ']')) !=3D NULL)
+               {
+                 char *facname =3D malloc (face - facb); /* [name] =3D>=20
name\0 */
+
+                 /* Extract facility name and remove from option string */
+
+                 *face++ =3D '\0';
+                 strcpy (facname, facb+1);
+                 memmove (facb, face, strlen(face)+1);
+
+                 /* Default program name */
+
+                 if (!*pname)
+                   pname =3D PACKAGE;
+
+                 /* Convert extracted facility name to code */
+
+                 facility =3D lookup_syslog_facility_code (facname,=20
facility);
+                 free (facname);
+               }
+           }
+         openlog (pname, LOG_PID, facility);
           use_syslog =3D true;

           /* Better idea: somehow pipe stdout/stderr output to msg() */
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1e1f2ac..cbd1980 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -234,6 +234,7 @@ void msg_forked (void);

  /* syslog output */

+void set_syslog_facility (const char *name);
  void open_syslog (const char *pgmname, bool stdio_to_null);
  void close_syslog ();

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 40210e6..e6cc1cc 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -333,9 +333,21 @@ static const char usage_message[] =3D
    "--setcon context: Apply this SELinux context after initialization.\n"
  #endif
    "--cd dir        : Change to this directory before initialization.\n"
+#if SYSLOG_CAPABILITY
+  "--syslog-facility name : When logging to syslog, use name (e.g. \n"
+  "                  local1) for the facility.  If name is absent or not\n"
+  "                  supported, a platform-dependent list of valid\n"
+  "                  facility names is provided.  Must be specified\n"
+  "                  before --daemon and --syslog.\n"
+#endif
    "--daemon [name] : Become a daemon after initialization.\n"
    "                  The optional 'name' parameter will be passed\n"
    "                  as the program name to the system logger.\n"
+#if SYSLOG_CAPABILITY
+  "                  If --syslog-facility has not been specified and \n"
+  "                  the name includes [facility], the specified\n"
+  "                  syslog facility name will be used.\n"
+#endif
    "--syslog [name] : Output to syslog, but do not become a daemon.\n"
    "                  See --daemon above for a description of the=20
'name' parm.\n"
    "--inetd [name] ['wait'|'nowait'] : Run as an inetd or xinetd server.\n"
@@ -4661,6 +4673,13 @@ add_option (struct options *options,
        VERIFY_PERMISSION (OPT_P_GENERAL);
        options->up_restart =3D true;
      }
+#if SYSLOG_CAPABILITY
+  else if (streq (p[0], "syslog-facility"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      set_syslog_facility (p[1]);
+    }
+#endif
    else if (streq (p[0], "syslog"))
      {
        VERIFY_PERMISSION (OPT_P_GENERAL);
--
1.7.10.4

--=20
Timothe Litt
ACM Distinguished Engineer
--------------------------
This communication may not represent the ACM or my employer's views,
if any, on the matters discussed.



--------------ms030408050006030102020309
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIPDzCC
BjQwggQcoAMCAQICASAwDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDI1NVoXDTE3MTAyNDIxMDI1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMsohUWcASz7GfKrpTOM
KqANy9BV7V0igWdGxA8IU77L3aTxErQ+fcxtDYZ36Z6GH0YFn7fq5RADteP0AYzrCA+EQTfi
8q1+kA3m0nwtwXG94M5sIqsvs7lRP1aycBke/s5g9hJHryZ2acScnzczjBCAo7X1v5G3yw8M
DP2m2RCye0KfgZ4nODerZJVzhAlOD9YejvAXZqHksw56HzElVIoYSZ3q4+RJuPXXfIoyby+Y
2m1E+YzX5iCZXBx05gk6MKAW1vaw4/v2OOLy6FZH3XHHtOkzUreG//CsFnB9+uaYSlR65cdG
zTsmoIK8WH1ygoXhRBm98SD7Hf/r3FELNvUCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBSuVYNv7DHKufcd+q9rMfPIHeOsuzAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBADqp
Jw3I07QWke9plNBpxUxcffc7nUrIQpJHDci91DFG7fVhHRkMZ1J+BKg5UNUxIFJ2Z9B90Mic
c/NXcs7kPBRdn6XGO/vPc87Y6R+cWS9Nc9+fp3Enmsm94OxOwI9wn8qnr/6o3mD4noP9Jphw
UPTXwHovjavRnhUQHLfo/i2NG0XXgTHXS2Xm0kVUozXqpYpAdumMiB/vezj1QHQJDmUdPYMc
p+reg9901zkyT3fDW/ivJVv6pWtkh6Pw2ytZT7mvg7YhX3V50Nv860cV11mocUVcqBLv0gcT
+HBDYtbuvexNftwNQKD5193A7zN4vG7CTYkXxytSjKuXrpEatEiFPxWgb84nVj25SU5q/r1X
hwby6mLhkbaXslkVtwEWT3Van49rKjlK4XrUKYYWtnfzq6aSak5u0Vpxd1rY79tWhD3EdCvO
hNz/QplNa+VkIsrcp7+8ZhP1l1b2U6MaxIVteuVMD3X0vziIwr7jxYae9FZjbxlpUemqXjcC
0QaFfN7qI0JsQMALL7iGRBg7K0CoOBzECdD3fuZil5kU/LP9cr1BK31U0Uy651bFnAMMMkqh
AChIbn0ei72VnbpSsrrSdF0BAGYQ8vyHae5aCg+H75dVCV33K6FuxZrf09yTz+Vx/PkdRUYk
XmZz/OTfyJXsUOUXrym6KvI2rYpccSk5MIII0zCCB7ugAwIBAgICJtUwDQYJKoZIhvcNAQEF
BQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBD
bGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xMjA5MjUxODQyMTha
Fw0xNDA5MjcxOTIyNDJaMIGQMRkwFwYDVQQNExBPZ3RBNVhZZXZheGFkbGtKMQswCQYDVQQG
EwJVUzEWMBQGA1UECBMNTWFzc2FjaHVzZXR0czEVMBMGA1UEBxMMU291dGhib3JvdWdoMRUw
EwYDVQQDEwxUaW1vdGhlIExpdHQxIDAeBgkqhkiG9w0BCQEWEXRpbW90aGVAbGl0dHMubmV0
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA38JrSHJ7GVdQiTppuafIBrhphuLL
HAmpeAFNvUBuUUh4X8Nx4Ag03hrC/B7OWYpUJI1HgWCK/eMtKEWF7UMwFhkMeqWSdrZyb4uk
EqTf46SyyAghF6BGuuVTiptED63FwzQY2PTXCmAJviuRXoJMzlhAwzUFpsWTFhswigFLrMCn
kJ9nndqnxQmMFpD7pjJ6kFkxKz/5k1CEzAfSerWHkIOBuXFyYpDDgDFXN1+qF25HsVVw+4xT
1/tNvCEVQ9WAleUznLvWgT5sV8tTewsUiYOgSqyoHiuJCOc9YJF2pUHGZVV+WzS8YIb95ax5
5yoS+C3D3FFzl6CbcI3nc6csqkP4bNBqm96Z/WdfTV4ouoycI4N9AJ86l6/Ygjz3/juFI9ni
as8nE051hksnyCon87fyP3/NezZ9NcUYVUnki1cVhfh2cN+s79fGWbUJePjT0fmso0FVcSRp
ddLyeZladbifFG+TiQO9BFt97e16OwyFpXRIzZWnfEiG2ss51Vpv9au8RrLgBD07aKE3mzZp
xZzoZ8c/jgb1YcUyAyaVmdOk4A3eGe7c8Loa+eYIRwkbjoE6H/PKcoRNIqnYQ44zvOOONRDI
S3vBpzofVK5Ndx0NVDIvsbWEPb9ntR32taUUZ334SPN447UO3sjvItFg1oOuC1i6kL6l1vRM
GNouPvECAwEAAaOCBDcwggQzMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUJZNwH8x9MtxbZmI9AK6Jj+IELcowHwYD
VR0jBBgwFoAUrlWDb+wxyrn3HfqvazHzyB3jrLswgaYGA1UdEQSBnjCBm4ERdGltb3RoZUBs
aXR0cy5uZXSBEXRpbW90aGVAbGl0dHMubmV0gQxsaXR0QGFjbS5vcmeBDWxpdHRAaWVlZS5v
cmeBFGhvc3RtYXN0ZXJAbGl0dHMubmV0gRdsaXR0c25ldGFkbWluQGxpdHRzLm5ldIETd2lr
aWFkbWluQGxpdHRzLm5ldIESc2VjdXJpdHlAbGl0dHMubmV0MIICIQYDVR0gBIICGDCCAhQw
ggIQBgsrBgEEAYG1NwECAjCCAf8wLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2lu
dGVybWVkaWF0ZS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3Jk
aW5nIHRvIHRoZSBDbGFzcyAyIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFy
dENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3Nl
IGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggr
BgEFBQcCAjCBjzAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRM
aWFiaWxpdHkgYW5kIHdhcnJhbnRpZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdh
bCBhbmQgTGltaXRhdGlvbnMiIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQv
MC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsG
AQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIv
Y2xhc3MyL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20v
Y2VydHMvc3ViLmNsYXNzMi5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEAXJ5dj2hKDwAh3aPsYWSJdC6PE7O2
u4pZz4H1mucRf3ZLoLjrAMhtINAqrWkvfiOTWQruNpQAXL+Gb6pk5sDoSXwISbPraVMb4uCS
g++F/XTCvqfsCitXd6Jhl5dyV0pi2MwmHyrBsjsER1EwA+39av+cfoL0gKuJy5y92wRt0It8
Eu77N5HaMlDlxEXXTQWP5Q2g7IZy+/ZeeG8FjrUM/bmwyvdb3mBreKgL2mZHnG+mf09IDACG
9ogoV2xJNQ0lRHxH5NJ/XGSztQACboxl3wK/t86Vhh6i1JeaLMcJ5oaemxdATK0NZVk/hIK0
hXGzTMVw1xoP/9LSYyoRD6yypzGCBNowggTWAgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQG
A1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNh
dGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAibVMAkGBSsOAwIaBQCgggIbMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDUwMjAxNTg0NlowIwYJKoZIhvcNAQkEMRYEFA8/
3KtaW0YfMjlKzm3ey2v4DZ3EMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgaQGCSsGAQQBgjcQBDGBljCBkzCBjDELMAkGA1UEBhMC
SUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENl
cnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJ
bnRlcm1lZGlhdGUgQ2xpZW50IENBAgIm1TCBpgYLKoZIhvcNAQkQAgsxgZaggZMwgYwxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFBy
aW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQICJtUwDQYJKoZIhvcNAQEBBQAEggIAHfqu
41D5B+0WbzqHxBouKyXhSVz6nQdsMSIllaYIcf3Cw2ezj2ZSWVfAxCwhTpqC1pumnm4UNJQJ
3DMJ+nTCOoU98p+FEGUF6St8ojx2Choryt/ODlX/U5LHm+DHfTOjQgQxE+wqcPlTm75toQuy
qdRQBymj0VLe52drEjXAoNKtJZE2aRa0v7HcXobxB1b93InlAmZbumN0KemgGmkUcDtasaUk
vTLJS0j7+honEmm1SE7jcg+hOiLLAMtWwDD1aFwgHpuZHqAGYdliFTe/YWWaWw31+qcUFyLE
1tn62PYpn8bcIdTjt/O6Y/GG4hSJ4lq+MYAaoHiT6OTlwv72Jm5g8rpZqDAGWGgWef4jT92S
g1V2qnY/vBxHKHCqbKtwXpHg/tgZEDzA8yNbNJslRXfxdjz3lULnPohvtq1SZiR5PczkNC5M
HVAgAN9oSjWMqML+XDyqMQOmDNRxGipJsS8k+SqmAZElfOgE5zUUhtQiMcVUMEwL51JZgnlO
yQXG8I1X+pkuvP4mS8EL+PEzfy4TW8/op4q5eys6CweFb0/l22JRwILmq7Uo4idHukbZkuF4
3xsPX7YADy8aAaOX3CPcYbxF7hsKfE9SD/JbKb+60bFFAhPYfv0ZurnLYbXbgAiLcYIgz8gB
EyBePmPJaOh2/gOThTXlusSA2VqzmIQAAAAAAAA=
--------------ms030408050006030102020309--

