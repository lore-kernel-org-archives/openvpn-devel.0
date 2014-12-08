Sender: Vasiliy Kulikov <segooon@...277...>
Date: Mon, 8 Dec 2014 14:52:02 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20141208115202.GA4807@...2009...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add Mac OS X keychain support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Anton Karpov <tokza@...2010...>

This patch adds support for using certificates stored in the Mac OSX
Keychain to authenticate with the OpenVPN server.  This works with
certificates stored on the computer as well as certificates on hardware
tokens that support Apple's tokend interface.  The patch is very similar
to, and also based on, the Windows Crypto API certificate functionality
that currently exists in OpenVPN.

The previous version of the patch was sent by Brian Raderman
(http://thread.gmane.org/gmane.network.openvpn.devel/3631).  The current
version uses autoconf, doesn't use printf, fixes several small bugs like
ignoring errors, and it now works with Tunnelblick.  The previous version
has been tested with an Aladdin eToken on Mac OSX Leopard and with
software only certificates on Mac OSX Leopard and Snow Leopard, as
reported by Brian Raderman in his email.  The current version of the
patch was tested in Yandex company on ~3000 hosts using several Mac OS X
versions (10.7, 10.8. 10.9. 10.10) using Tunnelblick.

It was tested both on OpenVPN started from the terminal and using
Tunnelblick.  Renegotiation was tested too.

There are several warnings on Mac OS X related to functions deprecation
like RSA_new() and similar.  However, they are used in other OpenVPN
code, so I decided not to touch it.

The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.

Signed-off-by: Vasily Kulikov <segoon@...2008...>
--

diff --git a/configure.ac b/configure.ac
index 608ab6d..127e173 100644
--- a/configure.ac
+++ b/configure.ac
@@ -258,6 +258,13 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
+	[macosx-keychain],
+	[AS_HELP_STRING([--enable-macosx-keychain], [enable MAC OS X keychain support @<:@default=yes@:>@])],
+	,
+	[enable_keychain="no"]
+)
+
+AC_ARG_ENABLE(
 	[systemd],
 	[AS_HELP_STRING([--enable-systemd], [enable systemd suppport @<:@default=no@:>@])],
 	,
@@ -330,6 +337,7 @@ case "$host" in
 		have_tap_header="yes"
 		dnl some Mac OS X tendering (we use vararg macros...)
 		CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
+		MACOSX=yes
 		;;
 	*-mingw*)
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
@@ -1088,6 +1096,11 @@ if test "${enable_ssl}" = "yes"; then
 	AC_DEFINE([ENABLE_SSL], [1], [Enable ssl library])
 fi
 
+if test "${enable_macosx_keychain}" = "yes"; then
+	test "${MACOSX}" != "yes" && AC_MSG_ERROR([keychain is available on MAC OS X only])
+	AC_DEFINE([ENABLE_KEYCHAIN], [1], [Enable MAC OS X keychain support])
+fi
+
 if test "${enable_crypto}" = "yes"; then
 	test "${have_crypto_crypto}" != "yes" && AC_MSG_ERROR([${with_crypto_library} crypto is required but missing])
 	test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
@@ -1199,6 +1212,7 @@ AC_SUBST([PLUGIN_AUTH_PAM_CFLAGS])
 AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
 
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
+AM_CONDITIONAL([MACOSX], [test "${MACOSX}" = "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 96ba555..a23d950 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4450,6 +4450,77 @@ Certificate Store GUI.
 
 .\"*********************************************************
 .TP
+.B --keychaincert select-string
+Load the certificate and private key from the
+Mac OSX Keychain (Mac OSX Only).
+
+Use this option instead of
+.B --cert
+and
+.B --key.
+
+This makes it possible to use any smart card supported by Mac OSX using the tokend interface, but also any
+kind of certificate, residing in the Keychain, where you have access to
+the private key.  This option has been tested on the client side with an Aladdin eToken
+on Mac OSX Leopard and with software certificates stored in the Keychain on Mac OSX Leopard and
+Mac OSX Snow Leopard.  As of this writing (4/27/10) Aladdin has not yet released Snow Leopard drivers.
+
+To select a certificate based on a string search in the
+certificate's subject and/or issuer:
+
+.B --keychaincert
+"SUBJECT:c=US/o=Apple Inc./ou=me.com/cn=username ISSUER:c=US/o=Apple Computer, Inc./ou=Apple Computer Certificate Authority/cn=Apple .Mac Certificate Authority"
+
+.I "Distinguished Name Component Abbreviations:" 
+.br
+o = organization
+.br
+ou = organizational unit
+.br
+c = country
+.br
+l = locality
+.br
+st = state
+.br
+cn = common name
+.br
+e = email
+.br
+
+All of the distinguished name components are optional, although you do need to specify at least one of them.  You can 
+add spaces around the '/' and '=' characters, e.g. "SUBJECT: c = US / o = Apple Inc.".  You do not need to specify
+both the subject and the issuer, one or the other will work fine.
+The identity searching algorithm will return the
+certificate it finds that matches all of the criteria you have specified.
+If there are several certificates matching all of the criteria then the youngest certificate is returned
+(i.e. with the greater "not before" validity field).
+You can also include the MD5 and/or SHA1 thumbprints and/or serial number
+along with the subject and issuer (see example of thumbprint search criteria below).  
+
+To select a certificate based on certificate's MD5 or SHA1 thumbprint:
+
+.B --keychaincert
+"SHA1: 30 F7 3A 7A B7 73 2A 98 54 33 4A A7 00 6F 6E AC EC D1 EF 02"
+
+.B --keychaincert
+"MD5: D5 F5 11 F1 38 EB 5F 4D CF 23 B6 94 E8 33 D8 B5"
+
+Again, you can include both the SHA1 and the MD5 thumbprints, but you can also use just one of them.  The thumbprint hex
+strings can easily be copy-and-pasted from the OSX Keychain Access GUI in the Applications/Utilities folder.  The hex string comparison is
+not case sensitive.
+
+To select a certificate based on certificate's serial number:
+
+.B --keychaincert
+"Serial: 3E 9B 6F 02 00 00 00 01 1F 20"
+
+Note that this option can be used with the --daemon option.
+However, if mac OSX needs to present the user with an authentication GUI when the Keychain
+is accessed by openvpn, the --daemon option will prevent the GUI from being shown and therefore cause the authentication to silently fail.
+
+.\"*********************************************************
+.TP
 .B \-\-key-method m
 Use data channel key negotiation method
 .B m.
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 021573e..81a678e 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -49,7 +49,7 @@ char * dirname(char *str);
 char * basename(char *str);
 #endif /* HAVE_BASENAME */
 
-#ifndef HAVE_GETTIMEOFDAY
+#if !defined(HAVE_GETTIMEOFDAY) && !defined(ENABLE_KEYCHAIN)
 int gettimeofday (struct timeval *tv, void *tz);
 #endif
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index d089f50..da40079 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -116,7 +116,11 @@ openvpn_SOURCES = \
 	syshead.h \
 	tun.c tun.h \
 	win32.h win32.c \
-	cryptoapi.h cryptoapi.c
+	cryptoapi.h cryptoapi.c \
+	common_osx.c common_osx.h \
+	crypto_osx.c crypto_osx.h \
+	cert_data.c cert_data.h \
+	keychain.c keychain.h
 openvpn_LDADD = \
 	$(top_builddir)/src/compat/libcompat.la \
 	$(SOCKETS_LIBS) \
@@ -132,3 +136,6 @@ if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
 endif
+if MACOSX
+openvpn_LDFLAGS = -framework CoreFoundation -framework Security
+endif
diff --git a/src/openvpn/cert_data.c b/src/openvpn/cert_data.c
new file mode 100644
index 0000000..4e8eff3
--- /dev/null
+++ b/src/openvpn/cert_data.c
@@ -0,0 +1,766 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2014 Vasily Kulikov <segoon@...2008...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include "config.h"
+#include "syshead.h"
+
+#ifdef ENABLE_KEYCHAIN
+
+#include "cert_data.h"
+#include <CommonCrypto/CommonDigest.h>
+#include <openssl/ssl.h>
+
+#include "common_osx.h"
+#include "crypto_osx.h"
+#include "error.h"
+
+CFStringRef kCertDataSubjectName = CFSTR("subject"),
+            kCertDataIssuerName = CFSTR("issuer"),
+            kCertDataSha1Name = CFSTR("SHA1"),
+            kCertDataMd5Name = CFSTR("MD5"),
+            kCertDataSerialName = CFSTR("serial"),
+            kCertNameFwdSlash = CFSTR("/"),
+            kCertNameEquals = CFSTR("=");
+CFStringRef kCertNameOrganization = CFSTR("o"),
+            kCertNameOrganizationalUnit = CFSTR("ou"),
+            kCertNameCountry = CFSTR("c"),
+            kCertNameLocality = CFSTR("l"),
+            kCertNameState = CFSTR("st"),
+            kCertNameCommonName = CFSTR("cn"),
+            kCertNameEmail = CFSTR("e");
+CFStringRef kStringSpace = CFSTR(" "),
+            kStringEmpty = CFSTR("");
+
+typedef struct _CertName
+{
+  CFArrayRef countryName, organization, organizationalUnit, commonName, description, emailAddress, 
+             stateName, localityName;
+} CertName, *CertNameRef;		
+
+typedef struct _DescData
+{
+  CFStringRef name, value;
+} DescData, *DescDataRef;
+
+void destroyDescData(DescDataRef pData);
+
+CertNameRef createCertName()
+{
+  CertNameRef pCertName = (CertNameRef)malloc(sizeof(CertName));
+  pCertName->countryName = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);
+  pCertName->organization =  CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);
+  pCertName->organizationalUnit = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);
+  pCertName->commonName = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);
+  pCertName->description = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);	
+  pCertName->emailAddress = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);
+  pCertName->stateName = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);
+  pCertName->localityName = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);
+  return pCertName;
+}
+
+void destroyCertName(CertNameRef pCertName)
+{	
+  if (!pCertName)
+    return;
+
+  CFRelease(pCertName->countryName);
+  CFRelease(pCertName->organization);
+  CFRelease(pCertName->organizationalUnit);
+  CFRelease(pCertName->commonName);
+  CFRelease(pCertName->description);
+  CFRelease(pCertName->emailAddress);
+  CFRelease(pCertName->stateName);
+  CFRelease(pCertName->localityName);
+  free(pCertName);
+}
+
+bool CFStringRefCmpCString(CFStringRef cfstr, const char *str)
+{
+  CFStringRef tmp = CFStringCreateWithCStringNoCopy(NULL, str, kCFStringEncodingUTF8, kCFAllocatorNull);
+  CFComparisonResult cresult = CFStringCompare(cfstr, tmp, 0);
+  bool result = cresult == kCFCompareEqualTo;
+  CFRelease(tmp);
+  return result;
+}
+
+CFDateRef GetDateFieldFromCertificate(SecCertificateRef certificate, CFTypeRef oid)
+{
+  const void *keys[] = { oid };
+  CFDictionaryRef dict = NULL;
+  CFErrorRef error;
+  CFDateRef date = NULL;
+
+  CFArrayRef keySelection = CFArrayCreate(NULL, keys , sizeof(keys)/sizeof(keys[0]), &kCFTypeArrayCallBacks);
+  dict = SecCertificateCopyValues(certificate, keySelection, &error);
+  if (dict == NULL)
+    {
+      printErrorMsg("GetDateFieldFromCertificate: SecCertificateCopyValues", error);
+      goto release_ks;
+    }
+  CFDictionaryRef vals = dict ? CFDictionaryGetValue(dict, oid) : NULL;
+  CFNumberRef vals2 = vals ? CFDictionaryGetValue(vals, kSecPropertyKeyValue) : NULL;
+  if (vals2 == NULL)
+    goto release_dict;
+
+  CFAbsoluteTime validityNotBefore;
+  if (CFNumberGetValue(vals2, kCFNumberDoubleType, &validityNotBefore))
+    date = CFDateCreate(kCFAllocatorDefault,validityNotBefore);
+
+release_dict:
+  CFRelease(dict);
+release_ks:
+  CFRelease(keySelection);
+  return date;
+}
+
+CFArrayRef GetFieldsFromCertificate(SecCertificateRef certificate, CFTypeRef oid)
+{
+  CFMutableArrayRef fields = CFArrayCreateMutable(NULL, 0, NULL);
+  CertNameRef pCertName = createCertName();
+  const void* keys[] = { oid, };
+  CFDictionaryRef dict;
+  CFErrorRef error;
+
+  CFArrayRef keySelection = CFArrayCreate(NULL, keys , 1, NULL);
+
+  dict = SecCertificateCopyValues(certificate, keySelection, &error);
+  if (dict == NULL) {
+      printErrorMsg("GetFieldsFromCertificate: SecCertificateCopyValues", error);
+      CFRelease(keySelection);
+      CFRelease(fields);
+      return NULL;
+  }
+  CFDictionaryRef vals = CFDictionaryGetValue(dict, oid);
+  CFArrayRef vals2 = vals ? CFDictionaryGetValue(vals, kSecPropertyKeyValue) : NULL;
+  if (vals2)
+    {
+      for(int i = 0; i < CFArrayGetCount(vals2); i++) {
+        CFDictionaryRef subDict = CFArrayGetValueAtIndex(vals2, i);
+        CFStringRef label = CFDictionaryGetValue(subDict, kSecPropertyKeyLabel);
+        CFStringRef value = CFDictionaryGetValue(subDict, kSecPropertyKeyValue);
+
+        if (CFStringCompare(label, kSecOIDEmailAddress, 0) == kCFCompareEqualTo)
+          CFArrayAppendValue((CFMutableArrayRef)pCertName->emailAddress, value);
+        else if (CFStringCompare(label, kSecOIDCountryName, 0) == kCFCompareEqualTo)
+          CFArrayAppendValue((CFMutableArrayRef)pCertName->countryName, value);
+        else if (CFStringCompare(label, kSecOIDOrganizationName, 0) == kCFCompareEqualTo)
+          CFArrayAppendValue((CFMutableArrayRef)pCertName->organization, value);
+        else if (CFStringCompare(label, kSecOIDOrganizationalUnitName, 0) == kCFCompareEqualTo)
+          CFArrayAppendValue((CFMutableArrayRef)pCertName->organizationalUnit, value);
+        else if (CFStringCompare(label, kSecOIDCommonName, 0) == kCFCompareEqualTo)
+          CFArrayAppendValue((CFMutableArrayRef)pCertName->commonName, value);
+        else if (CFStringCompare(label, kSecOIDDescription, 0) == kCFCompareEqualTo)
+          CFArrayAppendValue((CFMutableArrayRef)pCertName->description, value);
+        else if (CFStringCompare(label, kSecOIDStateProvinceName, 0) == kCFCompareEqualTo)
+          CFArrayAppendValue((CFMutableArrayRef)pCertName->stateName, value);
+        else if (CFStringCompare(label, kSecOIDLocalityName, 0) == kCFCompareEqualTo)
+          CFArrayAppendValue((CFMutableArrayRef)pCertName->localityName, value);
+      }
+      CFArrayAppendValue(fields, pCertName);
+    }
+
+  CFRelease(dict);
+  CFRelease(keySelection);
+  return fields;
+}
+
+CertDataRef createCertDataFromCertificate(SecCertificateRef certificate)
+{
+  CertDataRef pCertData = (CertDataRef)malloc(sizeof(CertData));
+  pCertData->subject = GetFieldsFromCertificate(certificate, kSecOIDX509V1SubjectName);
+  pCertData->issuer = GetFieldsFromCertificate(certificate, kSecOIDX509V1IssuerName);
+
+  CFDataRef data = SecCertificateCopyData(certificate);
+  if (data == NULL)
+    {
+      msg (D_AUTH, "SecCertificateCopyData() returned NULL");
+      destroyCertData(pCertData);
+      return NULL;
+    }
+
+  unsigned char sha1[CC_SHA1_DIGEST_LENGTH]; 
+  CC_SHA1(CFDataGetBytePtr(data), CFDataGetLength(data), sha1); 
+  pCertData->sha1 = createHexString(sha1, CC_SHA1_DIGEST_LENGTH);
+
+  unsigned char md5[CC_MD5_DIGEST_LENGTH]; 
+  CC_MD5(CFDataGetBytePtr(data), CFDataGetLength(data), md5);
+  pCertData->md5 = createHexString((unsigned char*)md5, CC_MD5_DIGEST_LENGTH);
+
+  CFDataRef serial = SecCertificateCopySerialNumber(certificate, NULL);
+  pCertData->serial = createHexString((unsigned char *)CFDataGetBytePtr(serial), CFDataGetLength(serial));
+  CFRelease(serial);
+
+  return pCertData;
+}
+
+CFStringRef stringFromRange(const char *cstring, CFRange range)
+{
+  CFStringRef str = CFStringCreateWithBytes (NULL, (uint8*)&cstring[range.location], range.length, kCFStringEncodingUTF8, false);
+  CFMutableStringRef mutableStr = CFStringCreateMutableCopy(NULL, 0, str);
+  CFStringTrimWhitespace(mutableStr);
+  CFRelease(str);
+  return mutableStr;
+}
+
+DescDataRef createDescData(const char *description, CFRange nameRange, CFRange valueRange)
+{
+  DescDataRef pRetVal = (DescDataRef)malloc(sizeof(DescData));
+
+  memset(pRetVal, 0, sizeof(DescData));
+
+  if (nameRange.length > 0)
+    pRetVal->name = stringFromRange(description, nameRange);
+
+  if (valueRange.length > 0)
+    pRetVal->value = stringFromRange(description, valueRange);
+
+  return pRetVal;
+}
+
+void destroyDescData(DescDataRef pData)
+{
+  if (pData->name)
+    CFRelease(pData->name);
+
+  if (pData->value)
+    CFRelease(pData->value);
+
+  free(pData);
+}
+
+CFArrayRef createDescDataPairs(const char *description)
+{
+  int numChars = strlen(description);
+  CFRange nameRange, valueRange;
+  DescDataRef pData;
+  CFMutableArrayRef retVal = CFArrayCreateMutable(NULL, 0, NULL);
+
+  int i = 0;
+
+  nameRange = CFRangeMake(0, 0);
+  valueRange = CFRangeMake(0, 0);
+  bool bInValue = false;
+
+  while(i < numChars)
+    {
+      if (!bInValue && (description[i] != ':'))
+        {
+          nameRange.length++;
+        }
+      else if (bInValue && (description[i] != ':'))
+        {
+          valueRange.length++;
+        }
+      else if(!bInValue)
+        {
+          bInValue = true;
+          valueRange.location = i + 1;
+          valueRange.length = 0;
+        }
+      else //(bInValue)
+        {
+          bInValue = false;
+          while(description[i] != ' ')
+            {
+              valueRange.length--;
+              i--;
+            }
+    
+          pData = createDescData(description, nameRange, valueRange);
+          CFArrayAppendValue(retVal, pData);
+    
+          nameRange.location = i + 1;
+          nameRange.length = 0;
+        }
+  
+      i++;
+    }
+
+  pData = createDescData(description, nameRange, valueRange);
+  CFArrayAppendValue(retVal, pData);
+  return retVal;
+}
+
+void arrayDestroyDescData(const void *val, void *context)
+{
+  DescDataRef pData = (DescDataRef) val;
+  destroyDescData(pData);
+}
+
+
+void parseNameComponent(CFStringRef dn, CFStringRef *pName, CFStringRef *pValue)
+{
+  CFArrayRef nameStrings = CFStringCreateArrayBySeparatingStrings(NULL, dn, kCertNameEquals);
+
+  *pName = *pValue = NULL;
+
+  if (CFArrayGetCount(nameStrings) != 2)
+    return;
+
+  CFMutableStringRef str;
+
+  str = CFStringCreateMutableCopy(NULL, 0, CFArrayGetValueAtIndex(nameStrings, 0));
+  CFStringTrimWhitespace(str);
+  *pName = str;
+
+  str = CFStringCreateMutableCopy(NULL, 0, CFArrayGetValueAtIndex(nameStrings, 1));
+  CFStringTrimWhitespace(str);
+  *pValue = str;
+
+  CFRelease(nameStrings);
+}
+
+void tryAppendSingleCertField(CertNameRef pCertName, CFArrayRef where, CFStringRef key,
+    CFStringRef name, CFStringRef value)
+{
+  if (CFStringCompareWithOptions(name, key, CFRangeMake(0, CFStringGetLength(name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    CFArrayAppendValue((CFMutableArrayRef)where, value);
+}
+
+void appendCertField(CertNameRef pCert, CFStringRef name, CFStringRef value)
+{
+  struct {
+    CFArrayRef field;
+    CFStringRef key;
+  } fields[] = {
+    { pCert->organization, kCertNameOrganization},
+    { pCert->organizationalUnit, kCertNameOrganizationalUnit},
+    { pCert->countryName, kCertNameCountry},
+    { pCert->localityName, kCertNameLocality},
+    { pCert->stateName, kCertNameState},
+    { pCert->commonName, kCertNameCommonName},
+    { pCert->emailAddress, kCertNameEmail},
+  };
+  int i;
+
+  for (i=0; i<sizeof(fields)/sizeof(fields[0]); i++)
+    tryAppendSingleCertField(pCert, fields[i].field, fields[i].key, name, value);
+}
+
+void parseCertName(CFStringRef nameDesc, CFMutableArrayRef names)
+{
+  CFArrayRef nameStrings = CFStringCreateArrayBySeparatingStrings(NULL, nameDesc, kCertNameFwdSlash);
+  int count = CFArrayGetCount(nameStrings);
+  int i;
+
+  CertNameRef pCertName = createCertName();
+
+  for(i = 0;i < count;i++)
+    {
+      CFMutableStringRef dn = CFStringCreateMutableCopy(NULL, 0, CFArrayGetValueAtIndex(nameStrings, i));
+      CFStringTrimWhitespace(dn);
+  
+      CFStringRef name, value;
+  
+      parseNameComponent(dn, &name, &value);
+  
+      if (!name || !value)
+        {
+          if (name)
+            CFRelease(name);
+    
+          if (value)
+            CFRelease(value);
+    
+          CFRelease(dn);
+          continue;
+        }
+  
+      appendCertField(pCertName, name, value);
+      CFRelease(name);
+      CFRelease(value);
+      CFRelease(dn);
+    }
+
+  CFArrayAppendValue(names, pCertName);
+  CFRelease(nameStrings);
+}
+
+void arrayParseDescDataPair(const void *val, void *context)
+{
+  DescDataRef pDescData = (DescDataRef)val;
+  CertDataRef pCertData = (CertDataRef)context;
+
+  if (!pDescData->name || !pDescData->value)
+    return;
+
+  if (CFStringCompareWithOptions(pDescData->name, kCertDataSubjectName, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    parseCertName(pDescData->value, (CFMutableArrayRef)pCertData->subject);
+  else if (CFStringCompareWithOptions(pDescData->name, kCertDataIssuerName, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    parseCertName(pDescData->value, (CFMutableArrayRef)pCertData->issuer);
+  else if (CFStringCompareWithOptions(pDescData->name, kCertDataSha1Name, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    pCertData->sha1 = CFRetain(pDescData->value);
+  else if (CFStringCompareWithOptions(pDescData->name, kCertDataMd5Name, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    pCertData->md5 = CFRetain(pDescData->value);
+  else if (CFStringCompareWithOptions(pDescData->name, kCertDataSerialName, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    pCertData->serial = CFRetain(pDescData->value);
+  else
+    msg( M_WARN, "WARNING: no key in keychain");
+}
+
+CertDataRef createCertDataFromString(const char *description)
+{
+  CertDataRef pCertData = (CertDataRef)malloc(sizeof(CertData));
+  pCertData->subject = CFArrayCreateMutable(NULL, 0, NULL);
+  pCertData->issuer = CFArrayCreateMutable(NULL, 0, NULL);
+  pCertData->sha1 = NULL;
+  pCertData->md5 = NULL;
+  pCertData->serial = NULL;
+
+  CFArrayRef pairs = createDescDataPairs(description);
+  CFArrayApplyFunction(pairs, CFRangeMake(0, CFArrayGetCount(pairs)), arrayParseDescDataPair, pCertData);
+  CFArrayApplyFunction(pairs, CFRangeMake(0, CFArrayGetCount(pairs)), arrayDestroyDescData, NULL);
+  CFRelease(pairs);
+  return pCertData;
+}
+
+void arrayDestroyCertName(const void *val, void *context)
+{
+  CertNameRef pCertName = (CertNameRef)val;
+  destroyCertName(pCertName);
+}
+
+void destroyCertData(CertDataRef pCertData)
+{
+  if (pCertData->subject)
+    {
+      CFArrayApplyFunction(pCertData->subject, CFRangeMake(0, CFArrayGetCount(pCertData->subject)), arrayDestroyCertName, NULL);
+      CFRelease(pCertData->subject);
+    }
+
+  if (pCertData->issuer)
+    {
+      CFArrayApplyFunction(pCertData->issuer, CFRangeMake(0, CFArrayGetCount(pCertData->issuer)), arrayDestroyCertName, NULL);
+      CFRelease(pCertData->issuer);
+    }
+
+  if (pCertData->sha1)
+    CFRelease(pCertData->sha1);
+
+  if (pCertData->md5)
+    CFRelease(pCertData->md5);
+
+  if (pCertData->serial)
+    CFRelease(pCertData->serial);
+
+  free(pCertData);
+}
+
+bool stringArrayMatchesTemplate(CFArrayRef strings, CFArrayRef templateArray)
+{
+  int templateCount, stringCount, i;
+
+  templateCount = CFArrayGetCount(templateArray);
+
+  if (templateCount > 0)
+    {
+      stringCount = CFArrayGetCount(strings);
+      if (stringCount != templateCount)
+        return false;
+  
+      for(i = 0;i < stringCount;i++)
+        {
+          CFStringRef str, template;
+    
+          template = (CFStringRef)CFArrayGetValueAtIndex(templateArray, i);
+          str = (CFStringRef)CFArrayGetValueAtIndex(strings, i);
+    
+          if (CFStringCompareWithOptions(template, str, CFRangeMake(0, CFStringGetLength(template)), kCFCompareCaseInsensitive) != kCFCompareEqualTo)
+            return false;
+        }
+    }
+
+  return true;
+
+}
+
+bool certNameMatchesTemplate(CertNameRef pCertName, CertNameRef pTemplate)
+{
+  if (!stringArrayMatchesTemplate(pCertName->countryName, pTemplate->countryName))
+    return false;
+  else if (!stringArrayMatchesTemplate(pCertName->organization, pTemplate->organization))
+    return false;
+  else if (!stringArrayMatchesTemplate(pCertName->organizationalUnit, pTemplate->organizationalUnit))
+    return false;
+  else if (!stringArrayMatchesTemplate(pCertName->commonName, pTemplate->commonName))
+    return false;
+  else if (!stringArrayMatchesTemplate(pCertName->emailAddress, pTemplate->emailAddress))
+    return false;
+  else if (!stringArrayMatchesTemplate(pCertName->stateName, pTemplate->stateName))
+    return false;
+  else if (!stringArrayMatchesTemplate(pCertName->localityName, pTemplate->localityName))
+    return false;
+  else
+    return true;
+}
+
+bool certNameArrayMatchesTemplate(CFArrayRef certNameArray, CFArrayRef templateArray)
+{
+  int templateCount, certCount, i;
+
+  templateCount = CFArrayGetCount(templateArray);
+
+  if (templateCount > 0)
+    {
+      certCount = CFArrayGetCount(certNameArray);
+      if (certCount != templateCount)
+        return false;
+  
+      for(i = 0;i < certCount;i++)
+        {
+          CertNameRef pName, pTemplateName;
+    
+          pTemplateName = (CertNameRef)CFArrayGetValueAtIndex(templateArray, i);
+          pName = (CertNameRef)CFArrayGetValueAtIndex(certNameArray, i);
+    
+          if (!certNameMatchesTemplate(pName, pTemplateName))
+            return false;
+        }
+    }
+
+  return true;
+}
+
+bool hexStringMatchesTemplate(CFStringRef str, CFStringRef template)
+{
+  if (template)
+    {
+      if (!str)
+        return false;
+  
+      CFMutableStringRef strMutable, templateMutable;
+  
+      strMutable = CFStringCreateMutableCopy(NULL, 0, str);
+      templateMutable = CFStringCreateMutableCopy(NULL, 0, template);
+  
+      CFStringFindAndReplace(strMutable, kStringSpace, kStringEmpty, CFRangeMake(0, CFStringGetLength(strMutable)), 0);
+      CFStringFindAndReplace(templateMutable, kStringSpace, kStringEmpty, CFRangeMake(0, CFStringGetLength(templateMutable)), 0);
+  
+      CFComparisonResult result = CFStringCompareWithOptions(templateMutable, strMutable, CFRangeMake(0, CFStringGetLength(templateMutable)), kCFCompareCaseInsensitive);
+  
+      CFRelease(strMutable);
+      CFRelease(templateMutable);
+  
+      if (result != kCFCompareEqualTo)
+        return false;
+    }
+
+  return true;
+}
+
+bool certDataMatchesTemplate(CertDataRef pCertData, CertDataRef pTemplate)
+{
+  if (!certNameArrayMatchesTemplate(pCertData->subject, pTemplate->subject))
+    return false;
+
+  if (!certNameArrayMatchesTemplate(pCertData->issuer, pTemplate->issuer))
+    return false;
+
+  if (!hexStringMatchesTemplate(pCertData->sha1, pTemplate->sha1))
+    return false;
+
+  if (!hexStringMatchesTemplate(pCertData->md5, pTemplate->md5))
+    return false;
+
+  if (!hexStringMatchesTemplate(pCertData->serial, pTemplate->serial))
+    return false;
+
+  return true;
+}
+
+bool certExpired(SecCertificateRef certificate)
+{
+  bool result;
+  CFDateRef notAfter = GetDateFieldFromCertificate(certificate, kSecOIDX509V1ValidityNotAfter);
+  CFDateRef notBefore = GetDateFieldFromCertificate(certificate, kSecOIDX509V1ValidityNotBefore);
+  CFDateRef now = CFDateCreate(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent());
+
+  if (!notAfter || !notBefore || !now)
+    {
+      msg (D_AUTH, "GetDateFieldFromCertificate() returned NULL");
+      result = true;
+    }
+  else
+    {
+      if (CFDateCompare(notBefore, now, NULL) != kCFCompareLessThan ||
+          CFDateCompare(now, notAfter, NULL) != kCFCompareLessThan)
+        result = true;
+      else
+        result = false;
+    }
+
+  CFRelease(notAfter);
+  CFRelease(notBefore);
+  CFRelease(now);
+  return result;
+}
+
+void printString(const void *val, void *context) 
+{
+  CFStringRef str = (CFStringRef)val;
+  const char *label = (const char *)context;
+  msg(M_INFO, "%s = %s\n", label, CFStringGetCStringPtr(str, kCFStringEncodingUTF8));
+}
+
+void printCertName(CertNameRef pCertName) 
+{
+  CFArrayApplyFunction(pCertName->countryName, CFRangeMake(0, CFArrayGetCount(pCertName->countryName)), printString, "Country Name");
+  CFArrayApplyFunction(pCertName->organization, CFRangeMake(0, CFArrayGetCount(pCertName->organization)), printString, "Organization");
+  CFArrayApplyFunction(pCertName->organizationalUnit, CFRangeMake(0, CFArrayGetCount(pCertName->organizationalUnit)), printString, "Organizational Unit");
+  CFArrayApplyFunction(pCertName->commonName, CFRangeMake(0, CFArrayGetCount(pCertName->commonName)), printString, "Common Name");
+  CFArrayApplyFunction(pCertName->description, CFRangeMake(0, CFArrayGetCount(pCertName->description)), printString, "Description");
+  CFArrayApplyFunction(pCertName->emailAddress, CFRangeMake(0, CFArrayGetCount(pCertName->emailAddress)), printString, "Email Address");
+  CFArrayApplyFunction(pCertName->stateName, CFRangeMake(0, CFArrayGetCount(pCertName->stateName)), printString, "State Name");
+  CFArrayApplyFunction(pCertName->localityName, CFRangeMake(0, CFArrayGetCount(pCertName->localityName)), printString, "Locality Name");
+}
+
+void arrayPrintCertName(const void *val, void *context)
+{
+  CertNameRef pCertName = (CertNameRef) val;
+  printCertName(pCertName);
+}
+
+void printCertData(CertDataRef pCertData)
+{
+  msg(M_INFO, "*** Subject ***\n");
+  if (pCertData->subject)
+    CFArrayApplyFunction(pCertData->subject, CFRangeMake(0, CFArrayGetCount(pCertData->subject)), arrayPrintCertName, NULL);
+
+  msg(M_INFO, "*** Issuer ***\n");
+  if (pCertData->issuer)
+    CFArrayApplyFunction(pCertData->issuer, CFRangeMake(0, CFArrayGetCount(pCertData->issuer)), arrayPrintCertName, NULL);
+
+  msg(M_INFO, "*** Fingerprints ***\n");
+
+  msg(M_INFO, "SHA1 = ");
+  if (pCertData->sha1)
+    printCFString(pCertData->sha1);
+
+  msg(M_INFO, "\n");
+
+  msg(M_INFO, "MD5 = ");
+  if (pCertData->md5)
+    printCFString(pCertData->md5);
+
+  msg(M_INFO, "\n");
+
+  msg(M_INFO, "Serial Number = ");
+  if (pCertData->serial)
+    printCFString(pCertData->serial);
+
+  msg(M_INFO, "\n");	
+}
+
+SecIdentityRef findIdentity(CertDataRef pCertDataTemplate)
+{
+  const void *keys[] = {
+    kSecClass,
+    kSecReturnRef,
+    kSecMatchLimit
+  };
+  const void *values[] = {
+    kSecClassIdentity,
+    kCFBooleanTrue,
+    kSecMatchLimitAll
+  };
+  CFArrayRef result = NULL;
+
+  CFDictionaryRef query = CFDictionaryCreate(NULL, keys, values,
+      sizeof(keys) / sizeof(*keys),
+      &kCFTypeDictionaryKeyCallBacks,
+      &kCFTypeDictionaryValueCallBacks);
+  OSStatus status = SecItemCopyMatching(query, (CFTypeRef*)&result);
+  CFRelease(query);
+  if (status != noErr)
+    {
+      msg (D_AUTH, "No identities in keychain found");
+      return NULL;
+    }
+
+  SecIdentityRef bestIdentity = NULL;
+  CFDateRef bestNotBeforeDate = NULL;
+
+  for (int i=0; i<CFArrayGetCount(result); i++)
+    {
+      SecIdentityRef identity = (SecIdentityRef)CFArrayGetValueAtIndex(result, i);
+      if (identity == NULL)
+        {
+          msg (D_AUTH, "identity == NULL");
+          continue;
+        }
+  
+      SecCertificateRef certificate = NULL;
+      SecIdentityCopyCertificate (identity, &certificate);
+      if (certificate == NULL)
+        {
+          msg (D_AUTH, "SecIdentityCopyCertificate() returned NULL");
+          continue;
+        }
+  
+      CertDataRef pCertData2 = createCertDataFromCertificate(certificate);		
+      if (pCertData2 == NULL)
+        {
+          msg (D_AUTH, "createCertDataFromCertificate() returned NULL");
+          goto release_cert;
+        }
+      bool bMatches = certDataMatchesTemplate(pCertData2, pCertDataTemplate);
+      bool bExpired = certExpired(certificate);
+      destroyCertData(pCertData2);
+  
+      if (bMatches && !bExpired)
+        {
+          CFDateRef notBeforeDate = GetDateFieldFromCertificate(certificate, kSecOIDX509V1ValidityNotBefore);
+          if (!notBeforeDate)
+            {
+              msg (D_AUTH, "GetDateFieldFromCertificate() returned NULL");
+              goto release_cert;
+            }
+          if (bestIdentity == NULL)
+            {
+              CFRetain(identity);
+              bestIdentity = identity;
+    
+              bestNotBeforeDate = notBeforeDate;
+              CFRetain(notBeforeDate);
+            }
+          else if (CFDateCompare(bestNotBeforeDate, notBeforeDate, NULL) == kCFCompareLessThan)
+            {
+              CFRelease(bestIdentity);
+              CFRetain(identity);
+              bestIdentity = identity;
+    
+              bestNotBeforeDate = notBeforeDate;
+              CFRetain(notBeforeDate);
+            }
+          CFRelease(notBeforeDate);
+        }
+    release_cert:
+      CFRelease(certificate);
+    }
+  CFRelease(result);
+
+  return bestIdentity;
+}
+#endif //ENABLE_KEYCHAIN
diff --git a/src/openvpn/cert_data.h b/src/openvpn/cert_data.h
new file mode 100644
index 0000000..261c1d1
--- /dev/null
+++ b/src/openvpn/cert_data.h
@@ -0,0 +1,46 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2014 Vasily Kulikov <segoon@...2008...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __cert_data_h__
+#define __cert_data_h__
+
+#include <CoreFoundation/CoreFoundation.h>
+#include <Security/Security.h>
+
+typedef struct _CertData
+{
+	CFArrayRef subject;
+	CFArrayRef issuer;
+	CFStringRef serial;
+	CFStringRef md5, sha1;
+} CertData, *CertDataRef;
+
+CertDataRef createCertDataFromCertificate(SecCertificateRef certificate);
+CertDataRef createCertDataFromString(const char *description);
+void destroyCertData(CertDataRef pCertData);
+bool certDataMatchesTemplate(CertDataRef pCertData, CertDataRef pTemplate);
+void printCertData(CertDataRef pCertData);
+SecIdentityRef findIdentity(CertDataRef pCertDataTemplate);
+
+#endif
diff --git a/src/openvpn/common_osx.c b/src/openvpn/common_osx.c
new file mode 100644
index 0000000..152fee7
--- /dev/null
+++ b/src/openvpn/common_osx.c
@@ -0,0 +1,93 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2014 Vasily Kulikov <segoon@...2008...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include "config.h"
+#include "syshead.h"
+#include "common.h"
+#include "buffer.h"
+#include "error.h"
+
+#ifdef ENABLE_KEYCHAIN
+#include "common_osx.h"
+
+void printCFString(CFStringRef str)
+{
+  CFIndex bufferLength = CFStringGetLength(str) + 1;
+  char *pBuffer = (char*)malloc(sizeof(char) * bufferLength);
+  CFStringGetCString(str, pBuffer, bufferLength, kCFStringEncodingUTF8);
+  msg(M_INFO, pBuffer);
+  free(pBuffer);
+}
+
+char* cfstringToCstr(CFStringRef str)
+{
+  CFIndex bufferLength = CFStringGetLength(str) + 1;
+  char *pBuffer = (char*)malloc(sizeof(char) * bufferLength);
+  CFStringGetCString(str, pBuffer, bufferLength, kCFStringEncodingUTF8);
+  return pBuffer;
+}
+
+void appendHexChar(CFMutableStringRef str, unsigned char halfByte)
+{
+  if (halfByte < 10)
+    {
+      CFStringAppendFormat (str, NULL, CFSTR("%d"), halfByte);
+    }
+  else
+    {
+      char tmp[2] = {'A'+halfByte-10, 0};
+      CFStringAppendCString(str, tmp, kCFStringEncodingUTF8);
+    }
+}
+
+CFStringRef createHexString(unsigned char *pData, int length)
+{
+  unsigned char byte, low, high;
+  int i;
+  CFMutableStringRef str = CFStringCreateMutable(NULL, 0);
+
+  for(i = 0;i < length;i++)
+    {
+      byte = pData[i];
+      low = byte & 0x0F;
+      high = (byte >> 4);
+
+      appendHexChar(str, high);
+      appendHexChar(str, low);
+
+      if (i != (length - 1))
+        CFStringAppendCString(str, " ", kCFStringEncodingUTF8);
+    }
+
+  return str;
+}
+
+void printHex(unsigned char *pData, int length)
+{
+  CFStringRef hexStr = createHexString(pData, length);
+  printCFString(hexStr);
+  CFRelease(hexStr);
+}
+#endif //ENABLE_KEYCHAIN
diff --git a/src/openvpn/common_osx.h b/src/openvpn/common_osx.h
new file mode 100644
index 0000000..0485334
--- /dev/null
+++ b/src/openvpn/common_osx.h
@@ -0,0 +1,40 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2014 Vasily Kulikov <segoon@...2008...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __common_osx_h__
+#define __common_osx_h__
+
+#include "config.h"
+
+#ifdef ENABLE_KEYCHAIN
+#include <CoreFoundation/CoreFoundation.h>
+#endif
+
+void printCFString(CFStringRef str);
+char* cfstringToCstr(CFStringRef str);
+CFStringRef createHexString(unsigned char *pData, int length);
+void printHex(unsigned char *pData, int length);
+
+#endif //__Common_osx_h__
diff --git a/src/openvpn/crypto_osx.c b/src/openvpn/crypto_osx.c
new file mode 100644
index 0000000..693b7d7
--- /dev/null
+++ b/src/openvpn/crypto_osx.c
@@ -0,0 +1,80 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2014 Vasily Kulikov <segoon@...2008...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include "config.h"
+#include "syshead.h"
+
+#ifdef ENABLE_KEYCHAIN
+
+#include <CommonCrypto/CommonDigest.h>
+#include <Security/SecKey.h>
+#include <Security/Security.h>
+
+#include "crypto_osx.h"
+#include "error.h"
+
+void printErrorMsg(const char *func, CFErrorRef error)
+{
+  CFStringRef desc = CFErrorCopyDescription(error);
+  msg(M_ERR, "%s failed: %s", func, CFStringGetCStringPtr(desc, kCFStringEncodingUTF8));
+  CFRelease(desc);
+}
+
+void printErrorStatusMsg(const char *func, OSStatus status)
+{
+  CFStringRef error;
+  error = SecCopyErrorMessageString(status, NULL);
+  if (error)
+    {
+      msg(M_ERR, "%s failed: %s", func, CFStringGetCStringPtr(error, kCFStringEncodingUTF8));
+      CFRelease(error);
+    }
+  else
+    msg(M_ERR, "%s failed: %X", func, (int)status);
+}
+
+void signData(SecIdentityRef identity, const uint8_t *from, int flen, uint8_t *to, size_t *tlen)
+{
+  SecKeyRef privateKey = NULL;
+  OSStatus status;
+
+  status = SecIdentityCopyPrivateKey(identity,  &privateKey); 
+  if (status != noErr)
+    {
+      printErrorStatusMsg("signData: SecIdentityCopyPrivateKey", status);
+      *tlen = 0;
+      return;
+    }
+
+  status = SecKeyRawSign(privateKey, kSecPaddingPKCS1, from, flen, to, tlen);
+  CFRelease(privateKey);
+  if (status != noErr)
+    {
+      printErrorStatusMsg("signData: SecKeyRawSign", status);
+      *tlen = 0;
+      return;
+    }
+}
+#endif //ENABLE_KEYCHAIN
diff --git a/src/openvpn/crypto_osx.h b/src/openvpn/crypto_osx.h
new file mode 100644
index 0000000..705e5f4
--- /dev/null
+++ b/src/openvpn/crypto_osx.h
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2014 Vasily Kulikov <segoon@...2008...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __crypto_osx_h__
+#define __crypto_osx_h__
+
+#include <CoreFoundation/CoreFoundation.h>
+#include <Security/Security.h>
+
+extern OSStatus SecKeyRawSign (
+   SecKeyRef key,
+   SecPadding padding,
+   const uint8_t *dataToSign,
+   size_t dataToSignLen,
+   uint8_t *sig,
+   size_t *sigLen
+);
+
+void signData(SecIdentityRef identity, const uint8_t *from, int flen, uint8_t *to, size_t *tlen);
+void printErrorMsg(const char *func, CFErrorRef error);
+
+#endif //__crypto_osx_h__
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a673be5..c076c8b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -39,6 +39,7 @@
 #include "pool.h"
 #include "gremlin.h"
 #include "pkcs11.h"
+#include "keychain.h"
 #include "ps.h"
 #include "lladdr.h"
 #include "ping.h"
@@ -929,6 +930,10 @@ possibly_become_daemon (const struct options *options, const bool first_time)
   bool ret = false;
   if (first_time && options->daemon)
     {
+#if defined(ENABLE_KEYCHAIN)
+      if (options->keychain_cert)
+        keychain_daemonFixup(options);
+#endif
       ASSERT (!options->inetd);
       if (daemon (options->cd_dir != NULL, options->log) < 0)
 	msg (M_ERR, "daemon() failed or unsupported");
diff --git a/src/openvpn/keychain.c b/src/openvpn/keychain.c
new file mode 100644
index 0000000..dc1beb8
--- /dev/null
+++ b/src/openvpn/keychain.c
@@ -0,0 +1,312 @@
+/*
+ * File: keyhchain.c.  Original was named cryptoapi.c.
+ *
+ * Copyright (c) 2004 Peter 'Luna' Runestig <peter@...292...>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without modifi-
+ * cation, are permitted provided that the following conditions are met:
+ *
+ *   o  Redistributions of source code must retain the above copyright notice,
+ *      this list of conditions and the following disclaimer.
+ *
+ *   o  Redistributions in binary form must reproduce the above copyright no-
+ *      tice, this list of conditions and the following disclaimer in the do-
+ *      cumentation and/or other materials provided with the distribution.
+ *
+ *   o  The names of the contributors may not be used to endorse or promote
+ *      products derived from this software without specific prior written
+ *      permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
+ * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LI-
+ * ABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUEN-
+ * TIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEV-
+ * ER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABI-
+ * LITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
+ * THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * This code has been modified from the original version by Brian Raderman 
+ * <brian@...1360...> and later by Vasily Kulikov
+ * <segoon@...2008...>.  It was changed to work with the Mac OSX Keychain
+ * services instead of the Microsoft Crypto API, which was its original
+ * intent.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include <arpa/inet.h>
+#include "syshead.h"
+
+#ifdef ENABLE_KEYCHAIN
+
+#include <openssl/ssl.h>
+#include <openssl/err.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <assert.h>
+#include <CoreFoundation/CoreFoundation.h>
+#include <Security/Security.h>
+#include "cert_data.h"
+#include "common_osx.h"
+#include "crypto_osx.h"
+#include "keychain.h"
+
+/* Size of an SSL signature: MD5+SHA1 */
+#define SSL_SIG_LENGTH	36
+
+/* try to funnel any Keychain/CSSM error messages to OpenSSL ERR_... */
+#define ERR_LIB_KEYCHAIN (ERR_LIB_USER + 70)
+#define KeychainErr(f)   err_put_apple_error((f), __FILE__, __LINE__)
+#define KEYCHAIN_F_FIND_IDENTITY	    101
+#define KEYCHAIN_F_CREATE_CERT_DATA_FROM_STRING   102
+#define KEYCHAIN_F_SIGN_DATA			    103
+
+SecIdentityRef initIdentity(CertDataRef template);
+
+static ERR_STRING_DATA KEYCHAIN_str_functs[] =	{
+  { ERR_PACK(ERR_LIB_KEYCHAIN, 0, 0),				    "Mac OSX Keychain"},
+  { ERR_PACK(0, KEYCHAIN_F_FIND_IDENTITY, 0),		    "findIdentity" },
+  { ERR_PACK(0, KEYCHAIN_F_CREATE_CERT_DATA_FROM_STRING, 0),	    "createCertDataFromString" },
+  { ERR_PACK(0, KEYCHAIN_F_SIGN_DATA, 0),    "signData" },
+  { 0, NULL }
+};
+
+static void err_put_apple_error(int func, const char *file, int line)
+{
+  static int init = 0;
+
+  if (!init)
+    {
+      ERR_load_strings(ERR_LIB_KEYCHAIN, KEYCHAIN_str_functs);
+  
+      ERR_STRING_DATA *esd = calloc(4, sizeof(ERR_STRING_DATA));
+      if (esd)
+        {
+          esd[0].error = 101;
+          esd[0].string = "Unable to find identity in keychain (certificate + private key)";
+    
+          esd[1].error = 102;
+          esd[1].string = "Unable to parse certificate description string";
+    
+          esd[2].error = 103;
+          esd[2].string = "Unable to sign data with private key";
+    
+          ERR_load_strings(ERR_LIB_KEYCHAIN, esd);
+        }
+  
+      init++;
+    }
+
+  ERR_PUT_error(ERR_LIB_KEYCHAIN, func, 0, file, line);
+}
+
+/* encrypt */
+static int rsa_pub_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+  /* I haven't been able to trigger this one, but I want to know if it happens... */
+  assert(0);
+  return 0;
+}
+
+/* verify arbitrary data */
+static int rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+  /* I haven't been able to trigger this one, but I want to know if it happens... */
+  assert(0);
+  return 0;
+}
+
+/* sign arbitrary data */
+static int rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+  SecIdentityRef identity = (SecIdentityRef) rsa->meth->app_data;
+  size_t length = 32000; // XXX: the caller doesn't tell us the real length
+
+  if (!identity) 
+    {
+      RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, ERR_R_PASSED_NULL_PARAMETER);
+      return 0;
+    }
+
+  if (padding != RSA_PKCS1_PADDING) 
+    {
+      RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
+      return 0;
+    }
+
+  signData(identity, (const uint8_t *)from, flen, (uint8_t *)to, &length);
+  return length;
+}
+
+/* decrypt */
+static int rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+  /* I haven't been able to trigger this one, but I want to know if it happens... */
+  assert(0);
+  return 0;
+}
+
+/* called at RSA_new */
+static int init(RSA *rsa)
+{
+  return 0;
+}
+
+/* called at RSA_free */
+static int finish(RSA *rsa)
+{
+  SecIdentityRef identity = (SecIdentityRef) rsa->meth->app_data;
+
+  if (!identity)
+    return 0;
+
+  free((char *) rsa->meth);
+  rsa->meth = NULL;
+  return 1;
+}
+
+int SSL_CTX_use_Keychain_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
+{
+  X509 *cert = NULL;
+  RSA *rsa = NULL, *pub_rsa;
+  RSA_METHOD *my_rsa_method = calloc(1, sizeof(RSA_METHOD));
+  SecIdentityRef identity = NULL;
+  SecCertificateRef certificate = NULL;
+  OSStatus status;
+  CFDataRef data;
+  int rc = 0;
+
+  if (my_rsa_method == NULL) 
+    {
+      SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+      return 0;
+    }
+
+  CertDataRef pCertDataTemplate = createCertDataFromString(cert_prop);
+  identity = initIdentity(pCertDataTemplate);
+  destroyCertData(pCertDataTemplate);
+
+  if (!identity) 
+    {
+      KeychainErr(KEYCHAIN_F_FIND_IDENTITY);
+      goto err_my_rsa_method;
+    }
+
+  status = SecIdentityCopyCertificate(identity, &certificate);
+  if (status != noErr)
+    goto err_identity;
+
+  data = SecCertificateCopyData(certificate);
+  if (data == NULL)
+    {
+      CFRelease(certificate);
+      goto err_identity;
+    }
+
+  const unsigned char *ptr = CFDataGetBytePtr(data);
+  /* cert_context->pbCertEncoded is the cert X509 DER encoded. */
+  cert = d2i_X509(NULL, &ptr, CFDataGetLength(data));
+  CFRelease(certificate);
+  if (cert == NULL) 
+    {
+      SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_ASN1_LIB);
+      goto err_data;
+    }
+
+  my_rsa_method->name = "Mac OSX Keychain RSA Method";
+  my_rsa_method->rsa_pub_enc = rsa_pub_enc;
+  my_rsa_method->rsa_pub_dec = rsa_pub_dec;
+  my_rsa_method->rsa_priv_enc = rsa_priv_enc;
+  my_rsa_method->rsa_priv_dec = rsa_priv_dec;
+  /* my_rsa_method->init = init; */
+  my_rsa_method->finish = finish;
+  my_rsa_method->flags = RSA_METHOD_FLAG_NO_CHECK;
+  my_rsa_method->app_data = (char *) identity;
+
+  rsa = RSA_new();
+  if (rsa == NULL)
+    {
+      SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+      goto err_cert;
+    }
+
+  /* cert->cert_info->key->pkey is NULL until we call SSL_CTX_use_certificate(),
+   * so we do it here then...  */
+  if (!SSL_CTX_use_certificate(ssl_ctx, cert))
+    goto err_rsa;
+
+  /* the public key */
+  pub_rsa = cert->cert_info->key->pkey->pkey.rsa;
+  /* SSL_CTX_use_certificate() increased the reference count in 'cert', so
+   * we decrease it here with X509_free(), or it will never be cleaned up. */
+  X509_free(cert);
+  cert = NULL;
+
+  rsa->n = BN_dup(pub_rsa->n);
+  rsa->flags |= RSA_FLAG_EXT_PKEY;
+  if (!RSA_set_method(rsa, my_rsa_method))
+    goto err_rsa;
+  my_rsa_method = NULL;
+
+  if (!SSL_CTX_use_RSAPrivateKey(ssl_ctx, rsa))
+    goto err_rsa;
+  /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa', so
+   * we decrease it here with RSA_free(), or it will never be cleaned up. */
+  RSA_free(rsa);
+  rsa = NULL;
+
+  /* identity is freed in finish() */
+  identity = NULL;
+
+  rc = 1;
+
+err_rsa:
+  if (rsa)
+    RSA_free(rsa);
+err_cert:
+  if (cert)
+    X509_free(cert);
+err_data:
+  if (data)
+    CFRelease(data);
+err_identity:
+  if (identity)
+    CFRelease(identity);
+err_my_rsa_method:
+  if (my_rsa_method)
+    free(my_rsa_method);
+  return rc;
+}
+
+SecIdentityRef initIdentity(CertDataRef template)
+{
+  static SecIdentityRef savedIdentity;
+  static bool identityInitialized = false;
+
+  if (!identityInitialized)
+    {
+      identityInitialized = true;
+      savedIdentity = findIdentity(template);
+    }
+  return savedIdentity;
+}
+
+void keychain_daemonFixup(const struct options *options)
+{
+  if (options->keychain_cert)
+    {
+      CertDataRef pCertDataTemplate = createCertDataFromString(options->keychain_cert);
+      initIdentity(pCertDataTemplate);
+      destroyCertData(pCertDataTemplate);
+    }
+}
+
+#endif				/* ENABLE_KEYCHAIN */
diff --git a/src/openvpn/keychain.h b/src/openvpn/keychain.h
new file mode 100644
index 0000000..05e75d4
--- /dev/null
+++ b/src/openvpn/keychain.h
@@ -0,0 +1,10 @@
+#ifndef _OSXKEYCHAIN_H_
+#define _OSXKEYCHAIN_H_
+
+#include "options.h"
+
+int SSL_CTX_use_Keychain_certificate(SSL_CTX *ssl_ctx, const char *cert_prop);
+void keychain_daemonFixup(const struct options *options);
+
+
+#endif /* !_OSXKEYCHAIN_H_ */
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index fd87fc1..6942b87 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -30,6 +30,10 @@
 
 #include "syshead.h"
 
+#ifdef ENABLE_KEYCHAIN
+#include <Security/Security.h>
+#endif
+
 #include "init.h"
 #include "forward.h"
 #include "multi.h"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64ded09..9d0b217 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -586,6 +586,10 @@ static const char usage_message[] =
   "--cryptoapicert select-string : Load the certificate and private key from the\n"
   "                  Windows Certificate System Store.\n"
 #endif
+#ifdef ENABLE_KEYCHAIN
+  "--keychaincert  select-string : Load the certificate and private key from the\n"
+  "                  Mac OSX Keychain.\n"
+#endif
   "--tls-cipher l  : A list l of allowable TLS ciphers separated by : (optional).\n"
   "                : Use --show-tls to see a list of supported TLS ciphers.\n"
   "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
@@ -1605,6 +1609,9 @@ show_settings (const struct options *o)
 #ifdef ENABLE_CRYPTOAPI
   SHOW_STR (cryptoapi_cert);
 #endif
+#ifdef ENABLE_KEYCHAIN
+  SHOW_STR (keychain_cert);
+#endif
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
   SHOW_STR (tls_export_cert);
@@ -2179,6 +2186,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	if (options->cryptoapi_cert)
 	  msg(M_USAGE, "Parameter --cryptoapicert cannot be used when --pkcs11-provider is also specified.");
 #endif
+#ifdef ENABLE_KEYCHAIN
+	if (options->keychain_cert)
+	   msg(M_USAGE, "Parameter --keychaincert cannot be used when --pkcs11-provider is also specified.");
+#endif
        }
       else
 #endif
@@ -2205,9 +2216,26 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	    msg(M_USAGE, "Parameter --management-external-key cannot be used when --cryptoapicert is also specified.");
 #endif
 	}
-      else
+	else
+#elif defined(ENABLE_KEYCHAIN)
+	if (options->keychain_cert)
+	{
+		if ((!(options->ca_file)) && (!(options->ca_path)))
+			msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
+		if (options->cert_file)
+			msg(M_USAGE, "Parameter --cert cannot be used when --keychaincert is also specified.");
+		if (options->priv_key_file)
+			msg(M_USAGE, "Parameter --key cannot be used when --keychaincert is also specified.");
+		if (options->pkcs12_file)
+			msg(M_USAGE, "Parameter --pkcs12 cannot be used when --keychaincert is also specified.");
+#ifdef MANAGMENT_EXTERNAL_KEY
+          if (options->management_flags & MF_EXTERNAL_KEY)
+	    msg(M_USAGE, "Parameter --management-external-key cannot be used when --cryptoapicert is also specified.");
+#endif
+	}
+	else
 #endif
-      if (options->pkcs12_file)
+       if (options->pkcs12_file)
         {
 #ifdef ENABLE_CRYPTO_POLARSSL
 	  msg(M_USAGE, "Parameter --pkcs12 cannot be used with the PolarSSL version version of OpenVPN.");
@@ -6565,6 +6593,13 @@ add_option (struct options *options,
       options->cryptoapi_cert = p[1];
     }
 #endif
+#ifdef ENABLE_KEYCHAIN
+  else if (streq (p[0], "keychaincert") && p[1])
+  {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->keychain_cert = p[1];
+  }
+#endif
   else if (streq (p[0], "key") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5ba4f2f..037f362 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -545,6 +545,9 @@ struct options
 #ifdef ENABLE_CRYPTOAPI
   const char *cryptoapi_cert;
 #endif
+#ifdef ENABLE_KEYCHAIN
+  const char *keychain_cert;
+#endif
 
   /* data channel key exchange method */
   int key_method;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c81659f..205bc42 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -515,6 +515,12 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
       tls_ctx_load_cryptoapi(new_ctx, options->cryptoapi_cert);
     }
 #endif
+#ifdef ENABLE_KEYCHAIN
+  else if (options->keychain_cert)
+  {
+    tls_ctx_load_keychain(new_ctx, options->keychain_cert);
+  }
+#endif
 #ifdef MANAGMENT_EXTERNAL_KEY
   else if ((options->management_flags & MF_EXTERNAL_KEY) && options->cert_file)
     {
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index b0777bf..c7233a1 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -224,6 +224,17 @@ void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert
 #endif /* WIN32 */
 
 /**
+ * Use Mac OS X keychain for key and cert, and add to library-specific TLS
+ * context.
+ *
+ * @param ctx			TLS context to use
+ * @param keychain_cert		String representing the certificate to load.
+ */
+#ifdef ENABLE_KEYCHAIN
+void tls_ctx_load_keychain(struct tls_root_ctx *ctx, const char *keychain_cert);
+#endif /* ENABLE_KEYCHAIN */
+
+/**
  * Load certificate file into the given TLS context. If the given certificate
  * file contains a certificate chain, load the whole chain.
  *
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6782a95..bddf14d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -50,6 +50,10 @@
 #include "cryptoapi.h"
 #endif
 
+#ifdef ENABLE_KEYCHAIN
+#include "keychain.h"
+#endif
+
 #include "ssl_verify_openssl.h"
 
 #include <openssl/err.h>
@@ -535,6 +539,17 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 }
 #endif /* WIN32 */
 
+#ifdef ENABLE_KEYCHAIN
+void
+tls_ctx_load_keychain(struct tls_root_ctx *ctx, const char *keychain_cert)
+{
+  /* Load Certificate and Private Key */
+  if (!SSL_CTX_use_Keychain_certificate (ctx->ctx, keychain_cert))
+    msg (M_SSLERR, "Cannot load certificate \"%s\" from Mac OSX Keychain",
+		    keychain_cert);
+}
+#endif /* ENABLE_KEYCHAIN */
+
 static void
 tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BIO *bio)
 {

