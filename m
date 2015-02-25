Sender: Vasiliy Kulikov <segooon@...277...>
Date: Wed, 25 Feb 2015 19:07:18 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150225160718.GA6306@...2009...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH v4] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds support for using certificates stored in the Mac OSX
Keychain to authenticate with the OpenVPN server.  This works with
certificates stored on the computer as well as certificates on hardware
tokens that support Apple's tokend interface.  The patch is based on
the Windows Crypto API certificate functionality that currently exists
in OpenVPN.

This patch version implements management client which handles RSA-SIGN
command for RSA offloading.  Also it handles new 'NEED-CERTIFICATE'
request to pass a certificate from the keychain to OpenVPN.

OpenVPN itself gets new 'NEED-CERTIFICATE" command which is called when
--management-external-cert is used.  It is implemented as a multiline
command very similar to an existing 'RSA-SIGN' command.

The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.

v4:
 - added '--management-external-cert' argument
 - keychain-mcd now parses NEED-CERTIFICATE argument if 'auto' is passed
   as cmdline's identity template
 - fixed typo in help output option name
 - added '--management-external-cert' info in openvpn(8) manpage
 - added 'certificate' command documentation into doc/management-notes.txt

v3:
 - used new 'NEED-CERTIFICATE' command for certificate data request instead of 'NEED-OK'
 - improved option checking
 - improved invalid certificate selection string handling
 - added man page for keychain-mcd
 - handle INFO, FATAL commands from openvpn and show them to user
 * ACK from Arne Schwabe for OpenVPN part
 * ACK from James based on Arne's testing

v2 (http://sourceforge.net/p/openvpn/mailman/message/33225603/):
 - used management interface to communicate with OpenVPN process

v1 (http://sourceforge.net/p/openvpn/mailman/message/33125844/):
 - used RSA_METHOD to extend openvpn itself

Signed-off-by: Vasily Kulikov <segoon@...2008...>
--
diff --git a/.gitignore b/.gitignore
index 538c020..f504ddb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -19,7 +19,6 @@ Debug
 Win32-Output
 .deps
 .libs
-Makefile
 Makefile.in
 aclocal.m4
 autodefs.h
diff --git a/contrib/keychain-mcd/Makefile b/contrib/keychain-mcd/Makefile
new file mode 100644
index 0000000..c6431df
--- /dev/null
+++ b/contrib/keychain-mcd/Makefile
@@ -0,0 +1,13 @@
+CFILES = cert_data.c common_osx.c crypto_osx.c main.c
+OFILES = $(CFILES:.c=.o) ../../src/openvpn/base64.o
+prog = keychain-mcd
+
+CC = gcc
+CFLAGS = -Wall
+LDFLAGS =  -framework CoreFoundation -framework Security -framework CoreServices
+
+$(prog): $(OFILES)
+	$(CC) $(LDFLAGS) $(OFILES) -o $(prog)
+
+%.o: %.c
+	$(CC) $(CFLAGS) -c $< -o $@
diff --git a/contrib/keychain-mcd/cert_data.c b/contrib/keychain-mcd/cert_data.c
new file mode 100644
index 0000000..4f06cdf
--- /dev/null
+++ b/contrib/keychain-mcd/cert_data.c
@@ -0,0 +1,733 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2015 Vasily Kulikov <segoon@...2008...>
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
+
+#include "cert_data.h"
+#include <CommonCrypto/CommonDigest.h>
+#include <openssl/ssl.h>
+
+#include "common_osx.h"
+#include "crypto_osx.h"
+#include <err.h>
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
+      warnx("SecCertificateCopyData() returned NULL");
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
+#if 0
+  fprintf(stderr, "name = '%s', value = '%s'\n",
+      CFStringGetCStringPtr(pRetVal->name, kCFStringEncodingUTF8),
+      CFStringGetCStringPtr(pRetVal->value, kCFStringEncodingUTF8));
+#endif
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
+int parseNameComponent(CFStringRef dn, CFStringRef *pName, CFStringRef *pValue)
+{
+  CFArrayRef nameStrings = CFStringCreateArrayBySeparatingStrings(NULL, dn, kCertNameEquals);
+
+  *pName = *pValue = NULL;
+
+  if (CFArrayGetCount(nameStrings) != 2)
+    return 0;
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
+  return 1;
+}
+
+int tryAppendSingleCertField(CertNameRef pCertName, CFArrayRef where, CFStringRef key,
+    CFStringRef name, CFStringRef value)
+{
+  if (CFStringCompareWithOptions(name, key, CFRangeMake(0, CFStringGetLength(name)), kCFCompareCaseInsensitive) 
+      == kCFCompareEqualTo) {
+    CFArrayAppendValue((CFMutableArrayRef)where, value);
+    return 1;
+  }
+  return 0;
+}
+
+int appendCertField(CertNameRef pCert, CFStringRef name, CFStringRef value)
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
+  int ret = 0;
+
+  for (i=0; i<sizeof(fields)/sizeof(fields[0]); i++)
+    ret += tryAppendSingleCertField(pCert, fields[i].field, fields[i].key, name, value);
+  return ret;
+}
+
+int parseCertName(CFStringRef nameDesc, CFMutableArrayRef names)
+{
+  CFArrayRef nameStrings = CFStringCreateArrayBySeparatingStrings(NULL, nameDesc, kCertNameFwdSlash);
+  int count = CFArrayGetCount(nameStrings);
+  int i;
+  int ret = 1;
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
+      if (!parseNameComponent(dn, &name, &value))
+        ret = 0;
+  
+      if (!name || !value)
+        {
+          if (name)
+            CFRelease(name);
+    
+          if (value)
+            CFRelease(value);
+          if (name && !value)
+            ret = 0;
+    
+          CFRelease(dn);
+          continue;
+        }
+  
+      if (!appendCertField(pCertName, name, value))
+        ret = 0;
+      CFRelease(name);
+      CFRelease(value);
+      CFRelease(dn);
+    }
+
+  CFArrayAppendValue(names, pCertName);
+  CFRelease(nameStrings);
+  return ret;
+}
+
+int arrayParseDescDataPair(const void *val, void *context)
+{
+  DescDataRef pDescData = (DescDataRef)val;
+  CertDataRef pCertData = (CertDataRef)context;
+  int ret = 1;
+
+  if (!pDescData->name || !pDescData->value)
+    return 0;
+
+  if (CFStringCompareWithOptions(pDescData->name, kCertDataSubjectName, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    ret = parseCertName(pDescData->value, (CFMutableArrayRef)pCertData->subject);
+  else if (CFStringCompareWithOptions(pDescData->name, kCertDataIssuerName, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    ret = parseCertName(pDescData->value, (CFMutableArrayRef)pCertData->issuer);
+  else if (CFStringCompareWithOptions(pDescData->name, kCertDataSha1Name, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    pCertData->sha1 = CFRetain(pDescData->value);
+  else if (CFStringCompareWithOptions(pDescData->name, kCertDataMd5Name, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    pCertData->md5 = CFRetain(pDescData->value);
+  else if (CFStringCompareWithOptions(pDescData->name, kCertDataSerialName, CFRangeMake(0, CFStringGetLength(pDescData->name)), kCFCompareCaseInsensitive) == kCFCompareEqualTo)
+    pCertData->serial = CFRetain(pDescData->value);
+  else
+    return 0;
+
+  return ret;
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
+  for (int i=0; i<CFArrayGetCount(pairs); i++)
+    if (!arrayParseDescDataPair(CFArrayGetValueAtIndex(pairs, i), pCertData)) {
+      arrayDestroyDescData(pCertData, NULL);
+      CFArrayApplyFunction(pairs, CFRangeMake(0, CFArrayGetCount(pairs)), arrayDestroyDescData, NULL);
+      CFRelease(pairs);
+      return 0;
+    }
+
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
+      warnx("GetDateFieldFromCertificate() returned NULL");
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
+      warnx ("No identities in keychain found");
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
+          warnx ("identity == NULL");
+          continue;
+        }
+  
+      SecCertificateRef certificate = NULL;
+      SecIdentityCopyCertificate (identity, &certificate);
+      if (certificate == NULL)
+        {
+          warnx ("SecIdentityCopyCertificate() returned NULL");
+          continue;
+        }
+  
+      CertDataRef pCertData2 = createCertDataFromCertificate(certificate);		
+      if (pCertData2 == NULL)
+        {
+          warnx ("createCertDataFromCertificate() returned NULL");
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
+              warnx ("GetDateFieldFromCertificate() returned NULL");
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
diff --git a/contrib/keychain-mcd/cert_data.h b/contrib/keychain-mcd/cert_data.h
new file mode 100644
index 0000000..407cca1
--- /dev/null
+++ b/contrib/keychain-mcd/cert_data.h
@@ -0,0 +1,46 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2015 Vasily Kulikov <segoon@...2008...>
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
diff --git a/contrib/keychain-mcd/common_osx.c b/contrib/keychain-mcd/common_osx.c
new file mode 100644
index 0000000..3effa8b
--- /dev/null
+++ b/contrib/keychain-mcd/common_osx.c
@@ -0,0 +1,94 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2015 Vasily Kulikov <segoon@...2008...>
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
+/*
+#include "config.h"
+#include "syshead.h"
+#include "common.h"
+#include "buffer.h"
+#include "error.h"
+*/
+
+#include "common_osx.h"
+#include <err.h>
+
+void printCFString(CFStringRef str)
+{
+  CFIndex bufferLength = CFStringGetLength(str) + 1;
+  char *pBuffer = (char*)malloc(sizeof(char) * bufferLength);
+  CFStringGetCString(str, pBuffer, bufferLength, kCFStringEncodingUTF8);
+  warnx("%s\n", pBuffer);
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
diff --git a/contrib/keychain-mcd/common_osx.h b/contrib/keychain-mcd/common_osx.h
new file mode 100644
index 0000000..4273548
--- /dev/null
+++ b/contrib/keychain-mcd/common_osx.h
@@ -0,0 +1,36 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2015 Vasily Kulikov <segoon@...2008...>
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
+#include <CoreFoundation/CoreFoundation.h>
+
+void printCFString(CFStringRef str);
+char* cfstringToCstr(CFStringRef str);
+CFStringRef createHexString(unsigned char *pData, int length);
+void printHex(unsigned char *pData, int length);
+
+#endif //__Common_osx_h__
diff --git a/contrib/keychain-mcd/crypto_osx.c b/contrib/keychain-mcd/crypto_osx.c
new file mode 100644
index 0000000..eda7121
--- /dev/null
+++ b/contrib/keychain-mcd/crypto_osx.c
@@ -0,0 +1,75 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2015 Vasily Kulikov <segoon@...2008...>
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
+
+#include <CommonCrypto/CommonDigest.h>
+#include <Security/SecKey.h>
+#include <Security/Security.h>
+
+#include "crypto_osx.h"
+#include <err.h>
+
+void printErrorMsg(const char *func, CFErrorRef error)
+{
+  CFStringRef desc = CFErrorCopyDescription(error);
+  warnx("%s failed: %s", func, CFStringGetCStringPtr(desc, kCFStringEncodingUTF8));
+  CFRelease(desc);
+}
+
+void printErrorStatusMsg(const char *func, OSStatus status)
+{
+  CFStringRef error;
+  error = SecCopyErrorMessageString(status, NULL);
+  if (error)
+    {
+      warnx("%s failed: %s", func, CFStringGetCStringPtr(error, kCFStringEncodingUTF8));
+      CFRelease(error);
+    }
+  else
+    warnx("%s failed: %X", func, (int)status);
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
diff --git a/contrib/keychain-mcd/crypto_osx.h b/contrib/keychain-mcd/crypto_osx.h
new file mode 100644
index 0000000..0da58b6
--- /dev/null
+++ b/contrib/keychain-mcd/crypto_osx.h
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Brian Raderman <brian@...1360...>
+ *  Copyright (C) 2013-2015 Vasily Kulikov <segoon@...2008...>
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
diff --git a/contrib/keychain-mcd/keychain-mcd.8 b/contrib/keychain-mcd/keychain-mcd.8
new file mode 100644
index 0000000..ca86ea4
--- /dev/null
+++ b/contrib/keychain-mcd/keychain-mcd.8
@@ -0,0 +1,162 @@
+.TH keychain-mcd 8
+.SH NAME
+
+keychain-mcd \- Mac OS X Keychain management daemon for OpenVPN
+
+.SH SYNOPSIS
+
+.B keychain-mcd 
+.I identity-template management-server-ip management-server-port 
+[
+.I password-file
+]
+
+.SH DESCRIPTION
+
+.B keychain-mcd
+is Mac OS X Keychain management daemon for OpenVPN.
+It loads the certificate and private key from the Mac OSX Keychain (Mac OSX Only).
+.B keychain-mcd
+connects to OpenVPN via management interface and handles
+certificate and private key commands (namely 
+.B NEED-CERTIFICATE
+and 
+.B RSA-SIGN
+commands).
+
+.B keychain-mcd
+makes it possible to use any smart card supported by Mac OSX using the tokend interface, but also any
+kind of certificate, residing in the Keychain, where you have access to
+the private key.  This option has been tested on the client side with an Aladdin eToken
+on Mac OSX Leopard and with software certificates stored in the Keychain on Mac OS X.
+
+Note that Mac OS X might need to present the user with an authentication GUI when the Keychain
+is accessed by keychain-mcd.
+
+Use 
+.B keychain-mcd
+along with 
+.B --management-external-key 
+and/or
+.B --management-external-cert
+passed to
+.B openvpn.
+
+.SH OPTIONS
+
+.TP
+.BR identity-template 
+
+A select string which is used to choose a keychain identity from
+Mac OS X Keychain or
+.I auto
+if the identity template is passed from openvpn.
+
+\fBSubject\fR, \fBIssuer\fR, \fBSerial\fR, \fBSHA1\fR, \fBMD5\fR selectors can be used.
+
+To select a certificate based on a string search in the
+certificate's subject and/or issuer:
+
+.nf
+
+"SUBJECT:c=US/o=Apple Inc./ou=me.com/cn=username ISSUER:c=US/o=Apple Computer, Inc./ou=Apple Computer Certificate Authority/cn=Apple .Mac Certificate Authority"
+
+.fi
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
+along with the subject and issuer.
+
+To select a certificate based on certificate's MD5 or SHA1 thumbprint:
+
+.nf
+"SHA1: 30 F7 3A 7A B7 73 2A 98 54 33 4A A7 00 6F 6E AC EC D1 EF 02"
+
+"MD5: D5 F5 11 F1 38 EB 5F 4D CF 23 B6 94 E8 33 D8 B5"
+.fi
+
+Again, you can include both the SHA1 and the MD5 thumbprints, but you can also use just one of them.
+The thumbprint hex strings can easily be copy-and-pasted from the OSX Keychain Access GUI in the Applications/Utilities folder.
+The hex string comparison is not case sensitive.
+
+To select a certificate based on certificate's serial number:
+
+"Serial: 3E 9B 6F 02 00 00 00 01 1F 20"
+
+If 
+.BR identity-template
+equals to
+.I auto
+then the actual identity template is
+obtained from argument of NEED-CERTIFICATE notification of openvpn.
+In this case the argument of NEED-CERTIFICATE must begin with 'macosx-keychain:' prefix
+and the rest of it must contain the actual identity template in the format described above.
+
+
+.TP
+.BR management-server-ip 
+OpenVPN management IP to connect to.
+Both IPv4 and IPv6 addresses can be used.
+
+.TP
+.BR management-server-port 
+OpenVPN management port to connect to.
+Use
+.B unix
+for 
+.I management-server-port
+and socket path for 
+.I management-server-ip
+to connect to a local unix socket.
+
+.TP
+.BR password-file
+
+Password file containing the management password on first line.
+The password will be used to connect to 
+.B openvpn
+management interface.
+
+Pass 
+.I password-file 
+to 
+.B keychain-mcd
+if 
+.I pw-file
+was specified in
+.B --management
+option to 
+.B openvpn.
+
+
+.SH AUTHOR
+
+Vasily Kulikov <segoon@...2008...>
+
+.SH "SEE ALSO"
+
+.BR openvpn (8)
+
diff --git a/contrib/keychain-mcd/main.c b/contrib/keychain-mcd/main.c
new file mode 100644
index 0000000..0641b03
--- /dev/null
+++ b/contrib/keychain-mcd/main.c
@@ -0,0 +1,255 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2015 Vasily Kulikov <segoon@...2008...>
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
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <sys/un.h>
+#include <err.h>
+#include <netdb.h>
+
+#include <Security/Security.h>
+#include <CoreServices/CoreServices.h>
+
+#include "cert_data.h"
+#include "crypto_osx.h"
+#include "../../src/openvpn/base64.h"
+
+
+SecIdentityRef template_to_identity(const char *template)
+{
+    SecIdentityRef identity;
+    CertDataRef pCertDataTemplate = createCertDataFromString(template);
+    if (pCertDataTemplate == NULL)
+        errx(1, "Bad certificate template");
+    identity = findIdentity(pCertDataTemplate);
+    if (identity == NULL)
+        errx(1, "No such identify");
+    fprintf(stderr, "Identity found\n");
+    destroyCertData(pCertDataTemplate);
+    return identity;
+}
+
+int connect_to_management_server(const char *ip, const char *port)
+{
+    int fd;
+    struct sockaddr_un addr_un;
+    struct sockaddr *addr;
+    size_t addr_len;
+
+    if (strcmp(port, "unix") == 0) {
+        addr = (struct sockaddr*)&addr_un;
+        addr_len = sizeof(addr_un);
+
+        addr_un.sun_family = AF_UNIX;
+        strncpy(addr_un.sun_path, ip, sizeof(addr_un.sun_path));
+        fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    }
+    else {
+        int rv;
+        struct addrinfo *result;
+        struct addrinfo hints;
+
+        memset(&hints, 0, sizeof(hints));
+        hints.ai_family = AF_UNSPEC;
+        hints.ai_socktype = SOCK_STREAM;
+
+        rv = getaddrinfo(ip, port, &hints, &result);
+        if (rv < 0)
+            errx(1, "getaddrinfo: %s", gai_strerror(rv));
+        if (result == NULL)
+            errx(1, "getaddrinfo returned 0 addressed");
+
+        /* Use the first found address */
+        fd = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
+        addr = result->ai_addr;
+        addr_len = result->ai_addrlen;
+    }
+    if (fd < 0)
+        err(1, "socket");
+
+    if (connect(fd, addr, addr_len) < 0)
+        err(1, "connect");
+
+    return fd;
+}
+
+int is_prefix(const char *s, const char *prefix)
+{
+    return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
+void handle_rsasign(FILE *man_file, SecIdentityRef identity, const char *input)
+{
+    const char *input_b64 = strchr(input, ':') + 1;
+    char *input_binary;
+    int input_len;
+    char *output_binary;
+    size_t output_len;
+    char *output_b64;
+
+    input_len = strlen(input_b64)*8/6 + 4;
+    input_binary = malloc(input_len);
+    input_len = openvpn_base64_decode(input_b64, input_binary, input_len);
+    if (input_len < 0)
+        errx(1, "openvpn_base64_decode: overflow");
+    
+    output_len = 1024;
+    output_binary = malloc(output_len);
+    signData(identity, (const uint8_t *)input_binary, input_len, (uint8_t *)output_binary, &output_len);
+    if (output_len == 0)
+        errx(1, "handle_rsasign: failed to sign data");
+
+    openvpn_base64_encode(output_binary, output_len, &output_b64);
+    fprintf(man_file, "rsa-sig\n%s\nEND\n", output_b64);
+    free(output_b64);
+    free(input_binary);
+    free(output_binary);
+
+    fprintf(stderr, "Handled RSA_SIGN command\n");
+}
+
+void handle_needcertificate(FILE *man_file, SecIdentityRef identity)
+{
+    OSStatus status;
+    SecCertificateRef certificate = NULL;
+    CFDataRef data;
+    const unsigned char *cert;
+    size_t cert_len;
+    char *result_b64, *tmp_b64;
+
+    status = SecIdentityCopyCertificate(identity, &certificate);
+    if (status != noErr) {
+        const char *msg = GetMacOSStatusErrorString(status);
+        err(1, "SecIdentityCopyCertificate() failed: %s", msg);
+    }
+
+    data = SecCertificateCopyData(certificate);
+    if (data == NULL)
+        err(1, "SecCertificateCopyData() returned NULL");
+
+    cert = CFDataGetBytePtr(data);
+    cert_len = CFDataGetLength(data);
+
+    openvpn_base64_encode(cert, cert_len, &result_b64);
+#if 0
+    fprintf(stderr, "certificate %s\n", result_b64);
+#endif
+
+    fprintf(man_file, "certificate\n");
+    fprintf(man_file, "-----BEGIN CERTIFICATE-----\n");
+    tmp_b64 = result_b64;
+    while (strlen(tmp_b64) > 64) {
+      fprintf(man_file, "%.64s\n", tmp_b64);
+      tmp_b64 += 64;
+    }
+    if (*tmp_b64)
+      fprintf(man_file, "%s\n", tmp_b64);
+    fprintf(man_file, "-----END CERTIFICATE-----\n");
+    fprintf(man_file, "END\n");
+
+    free(result_b64);
+    CFRelease(data);
+    CFRelease(certificate);
+
+    fprintf(stderr, "Handled NEED 'cert' command\n");
+}
+
+void management_loop(SecIdentityRef identity, int man_fd, const char *password)
+{
+    char *buffer = NULL;
+    size_t buffer_len = 0;
+    FILE *man = fdopen(man_fd, "w+");
+    if (man == 0)
+        err(1, "fdopen");
+
+    if (password)
+        fprintf(man, "%s\n", password);
+
+    while (1) {
+        if (getline(&buffer, &buffer_len, man) < 0)
+            err(1, "getline");
+#if 0
+        fprintf(stderr, "M: %s", buffer);
+#endif
+
+        if (is_prefix(buffer, ">RSA_SIGN:"))
+            handle_rsasign(man, identity, buffer);
+        if (is_prefix(buffer, ">NEED-CERTIFICATE")) {
+            if (!identity) {
+                const char prefix[] = ">NEED-CERTIFICATE:macosx-keychain:";
+                if (!is_prefix(buffer, prefix))
+                  errx(1, "No identity template is passed via command line and " \
+                      "NEED-CERTIFICATE management interface command " \
+                      "misses 'macosx-keychain' prefix.");
+                identity = template_to_identity(buffer+strlen(prefix));
+            }
+            handle_needcertificate(man, identity);
+        }
+        if (is_prefix(buffer, ">FATAL"))
+            fprintf(stderr, "Fatal message from OpenVPN: %s\n", buffer+7);
+        if (is_prefix(buffer, ">INFO"))
+            fprintf(stderr, "INFO message from OpenVPN: %s\n", buffer+6);
+    }
+}
+
+char *read_password(const char *fname)
+{
+    char *password = NULL;
+    FILE *pwf = fopen(fname, "r");
+    size_t n = 0;
+
+    if (pwf == NULL)
+        errx(1, "fopen(%s) failed", fname);
+    if (getline(&password, &n, pwf) < 0)
+        err(1, "getline");
+    fclose(pwf);
+    return password;
+}
+
+int main(int argc, char* argv[])
+{
+    if (argc < 4)
+        err(1, "usage: %s <identity_template> <management_ip> <management_port> [<pw-file>]", argv[0]);
+
+    char *identity_template = argv[1];
+    char *s_ip = argv[2];
+    char *s_port = argv[3];
+    char *password = NULL;
+    int man_fd;
+
+    if (argc > 4) {
+        char *s_pw_file = argv[4];
+        password = read_password(s_pw_file);
+    }
+    
+    SecIdentityRef identity = NULL;
+    if (strcmp(identity_template, "auto"))
+        identity = template_to_identity(identity_template);
+    man_fd = connect_to_management_server(s_ip, s_port);
+    fprintf(stderr, "Successfully connected to openvpn\n");
+
+    management_loop(identity, man_fd, password);
+}
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index ef39b85..028cf9e 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -777,6 +777,28 @@ correct signature.
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
 
+COMMAND -- certificate (OpenVPN 2.3 or higher)
+----------------------------------------------
+Provides support for external storage of the certificate. Requires the
+--management-external-cert option. This option can be used instead of "cert"
+in client mode. On SSL protocol initialization a notification will be sent
+to the management interface with a hint as follows:
+
+>NEED-CERTIFICATE:macosx-keychain:subject:o=OpenVPN-TEST
+
+The management interface client should use the hint to obtain the specific
+SSL certificate and then return base64 encoded certificate as follows:
+
+certificate
+[BASE64_CERT_LINE]
+.
+.
+.
+END
+
+This capability is intended to allow the use of certificates
+stored outside of the filesystem (e.g. in Mac OS X Keychain)
+with OpenVPN via the management interface.
 
 OUTPUT FORMAT
 -------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 96ba555..8a9eec7 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2591,6 +2591,15 @@ Allows usage for external private key file instead of
 option (client-only).
 .\"*********************************************************
 .TP
+.B \-\-management-external-cert certificate-hint
+Allows usage for external certificate instead of
+.B \-\-cert
+option (client-only).
+.B certificate-hint
+is an arbitrary string which is passed to a management
+interface client as an argument of NEED-CERTIFICATE notification.
+.\"*********************************************************
+.TP
 .B \-\-management-forget-disconnect
 Make OpenVPN forget passwords when management session
 disconnects.
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 46f874b..421d60e 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1066,8 +1066,10 @@ buffer_list_peek (struct buffer_list *ol)
 }
 
 void
-buffer_list_aggregate (struct buffer_list *bl, const size_t max)
+buffer_list_aggregate_separator (struct buffer_list *bl, const size_t max, const char *sep)
 {
+  int sep_len = strlen(sep);
+
   if (bl->head)
     {
       struct buffer_entry *more = bl->head;
@@ -1075,7 +1077,7 @@ buffer_list_aggregate (struct buffer_list *bl, const size_t max)
       int count = 0;
       for (count = 0; more && size <= max; ++count)
 	{
-	  size += BLEN(&more->buf);
+	  size += BLEN(&more->buf) + sep_len;
 	  more = more->next;
 	}
 
@@ -1092,6 +1094,7 @@ buffer_list_aggregate (struct buffer_list *bl, const size_t max)
 	    {
 	      struct buffer_entry *next = e->next;
 	      buf_copy (&f->buf, &e->buf);
+	      buf_write(&f->buf, sep, sep_len);
 	      free_buf (&e->buf);
 	      free (e);
 	      e = next;
@@ -1105,6 +1108,12 @@ buffer_list_aggregate (struct buffer_list *bl, const size_t max)
 }
 
 void
+buffer_list_aggregate (struct buffer_list *bl, const size_t max)
+{
+  buffer_list_aggregate_separator(bl, max, "");
+}
+
+void
 buffer_list_pop (struct buffer_list *ol)
 {
   if (ol && ol->head)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 7469da6..5695f64 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -931,6 +931,7 @@ void buffer_list_advance (struct buffer_list *ol, int n);
 void buffer_list_pop (struct buffer_list *ol);
 
 void buffer_list_aggregate (struct buffer_list *bl, const size_t max);
+void buffer_list_aggregate_separator (struct buffer_list *bl, const size_t max, const char *sep);
 
 struct buffer_list *buffer_list_file (const char *fn, int max_line_len);
 #endif /* BUFFER_H */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 9f44cd9..cdfe2be 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -113,6 +113,8 @@ man_help ()
 #ifdef MANAGMENT_EXTERNAL_KEY
   msg (M_CLIENT, "rsa-sig                : Enter an RSA signature in response to >RSA_SIGN challenge");
   msg (M_CLIENT, "                         Enter signature base64 on subsequent lines followed by END");
+  msg (M_CLIENT, "certificate            : Enter a client certificate in response to >NEED-CERT challenge");
+  msg (M_CLIENT, "                         Enter certificate base64 on subsequent lines followed by END");
 #endif
   msg (M_CLIENT, "signal s               : Send signal s to daemon,");
   msg (M_CLIENT, "                         s = SIGHUP|SIGTERM|SIGUSR1|SIGUSR2.");
@@ -868,6 +870,12 @@ in_extra_dispatch (struct management *man)
       man->connection.ext_key_input = man->connection.in_extra;
       man->connection.in_extra = NULL;
       return;
+    case IEC_CERTIFICATE:
+      man->connection.ext_cert_state = EKS_READY;
+      buffer_list_free (man->connection.ext_cert_input);
+      man->connection.ext_cert_input = man->connection.in_extra;
+      man->connection.in_extra = NULL;
+      return;
 #endif
     }
    in_extra_reset (&man->connection, IER_RESET);
@@ -1030,6 +1038,20 @@ man_rsa_sig (struct management *man)
     msg (M_CLIENT, "ERROR: The rsa-sig command is not currently available");
 }
 
+static void
+man_certificate (struct management *man)
+{
+  struct man_connection *mc = &man->connection;
+  if (mc->ext_cert_state == EKS_SOLICIT)
+    {
+      mc->ext_cert_state = EKS_INPUT;
+      mc->in_extra_cmd = IEC_CERTIFICATE;
+      in_extra_reset (mc, IER_NEW);
+    }
+  else
+    msg (M_CLIENT, "ERROR: The certificate command is not currently available");
+}
+
 #endif
 
 static void
@@ -1311,6 +1333,10 @@ man_dispatch_command (struct management *man, struct status_output *so, const ch
     {
       man_rsa_sig (man);
     }
+  else if (streq (p[0], "certificate"))
+    {
+      man_certificate (man);
+    }
 #endif
 #ifdef ENABLE_PKCS11
   else if (streq (p[0], "pkcs11-id-count"))
@@ -3097,15 +3123,14 @@ management_query_user_pass (struct management *man,
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
-char * /* returns allocated base64 signature */
-management_query_rsa_sig (struct management *man,
-			  const char *b64_data)
+int
+management_query_multiline (struct management *man,
+			  const char *b64_data, const char *prompt, const char *cmd, int *state, struct buffer_list **input)
 {
   struct gc_arena gc = gc_new ();
-  char *ret = NULL;
+  int ret = 0;
   volatile int signal_received = 0;
   struct buffer alert_msg = clear_buf();
-  struct buffer *buf;
   const bool standalone_disabled_save = man->persist.standalone_disabled;
   struct man_connection *mc = &man->connection;
 
@@ -3114,10 +3139,15 @@ management_query_rsa_sig (struct management *man,
       man->persist.standalone_disabled = false; /* This is so M_CLIENT messages will be correctly passed through msg() */
       man->persist.special_state_msg = NULL;
 
-      mc->ext_key_state = EKS_SOLICIT;
+      *state = EKS_SOLICIT;
 
-      alert_msg = alloc_buf_gc (strlen(b64_data)+64, &gc);
-      buf_printf (&alert_msg, ">RSA_SIGN:%s", b64_data);
+      if (b64_data) {
+        alert_msg = alloc_buf_gc (strlen(b64_data)+strlen(prompt)+3, &gc);
+        buf_printf (&alert_msg, ">%s:%s", prompt, b64_data);
+      } else {
+        alert_msg = alloc_buf_gc (strlen(prompt)+3, &gc);
+        buf_printf (&alert_msg, ">%s", prompt);
+      }
 
       man_wait_for_client_connection (man, &signal_received, 0, MWCC_OTHER_WAIT);
 
@@ -3135,40 +3165,107 @@ management_query_rsa_sig (struct management *man,
 	    man_check_for_signals (&signal_received);
 	  if (signal_received)
 	    goto done;
-	} while (mc->ext_key_state != EKS_READY);
+	} while (*state != EKS_READY);
 
-      if (buffer_list_defined(mc->ext_key_input))
-	{
-	  buffer_list_aggregate (mc->ext_key_input, 2048);
-	  buf = buffer_list_peek (mc->ext_key_input);
-	  if (buf && BLEN(buf) > 0)
-	    {
-	      ret = (char *) malloc(BLEN(buf)+1);
-	      check_malloc_return(ret);
-	      memcpy(ret, buf->data, BLEN(buf));
-	      ret[BLEN(buf)] = '\0';
-	    }
-	}
+      ret = 1;
     }
 
  done:
-  if (mc->ext_key_state == EKS_READY && ret)
-    msg (M_CLIENT, "SUCCESS: rsa-sig command succeeded");
-  else if (mc->ext_key_state == EKS_INPUT || mc->ext_key_state == EKS_READY)
-    msg (M_CLIENT, "ERROR: rsa-sig command failed");
+  if (*state == EKS_READY && ret)
+    msg (M_CLIENT, "SUCCESS: %s command succeeded", cmd);
+  else if (*state == EKS_INPUT || *state == EKS_READY)
+    msg (M_CLIENT, "ERROR: %s command failed", cmd);
 
   /* revert state */
   man->persist.standalone_disabled = standalone_disabled_save;
   man->persist.special_state_msg = NULL;
   in_extra_reset (mc, IER_RESET);
-  mc->ext_key_state = EKS_UNDEF;
-  buffer_list_free (mc->ext_key_input);
-  mc->ext_key_input = NULL;
+  *state = EKS_UNDEF;
 
   gc_free (&gc);
   return ret;
 }
 
+char * /* returns allocated base64 signature */
+management_query_multiline_flatten_newline (struct management *man,
+    const char *b64_data, const char *prompt, const char *cmd, int *state, struct buffer_list **input)
+{
+  int ok;
+  char *result = NULL;
+  struct buffer *buf;
+
+  ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
+  if (ok && buffer_list_defined(*input))
+  {
+    buffer_list_aggregate_separator (*input, 10000, "\n");
+    buf = buffer_list_peek (*input);
+    if (buf && BLEN(buf) > 0)
+    {
+      result = (char *) malloc(BLEN(buf)+1);
+      check_malloc_return(result);
+      memcpy(result, buf->data, BLEN(buf));
+      result[BLEN(buf)] = '\0';
+    }
+  }
+
+  buffer_list_free (*input);
+  *input = NULL;
+
+  return result;
+}
+
+char * /* returns allocated base64 signature */
+management_query_multiline_flatten (struct management *man,
+    const char *b64_data, const char *prompt, const char *cmd, int *state, struct buffer_list **input)
+{
+  int ok;
+  char *result = NULL;
+  struct buffer *buf;
+
+  ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
+  if (ok && buffer_list_defined(*input))
+  {
+    buffer_list_aggregate (*input, 2048);
+    buf = buffer_list_peek (*input);
+    if (buf && BLEN(buf) > 0)
+    {
+      result = (char *) malloc(BLEN(buf)+1);
+      check_malloc_return(result);
+      memcpy(result, buf->data, BLEN(buf));
+      result[BLEN(buf)] = '\0';
+    }
+  }
+
+  buffer_list_free (*input);
+  *input = NULL;
+
+  return result;
+}
+
+char * /* returns allocated base64 signature */
+management_query_rsa_sig (struct management *man,
+			  const char *b64_data)
+{
+  return management_query_multiline_flatten(man, b64_data, "RSA_SIGN", "rsa-sign",
+      &man->connection.ext_key_state, &man->connection.ext_key_input);
+}
+
+
+char* management_query_cert (struct management *man, const char *cert_name)
+{
+  const char prompt_1[] = "NEED-CERTIFICATE:";
+  struct buffer buf_prompt = alloc_buf(strlen(cert_name) + 20);
+  buf_write(&buf_prompt, prompt_1, strlen(prompt_1));
+  buf_write(&buf_prompt, cert_name, strlen(cert_name)+1); // +1 for \0
+
+  char *result;
+  result = management_query_multiline_flatten_newline(management,
+      NULL, (char*)buf_bptr(&buf_prompt), "certificate",
+      &man->connection.ext_cert_state, &man->connection.ext_cert_input);
+  free_buf(&buf_prompt);
+  return result;
+}
+
 #endif
 
 /*
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 1c8dda6..8d6e87e 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -268,6 +268,7 @@ struct man_connection {
 # define IEC_CLIENT_AUTH 1
 # define IEC_CLIENT_PF   2
 # define IEC_RSA_SIGN    3
+# define IEC_CERTIFICATE 4
   int in_extra_cmd;
   struct buffer_list *in_extra;
 #ifdef MANAGEMENT_DEF_AUTH
@@ -281,6 +282,8 @@ struct man_connection {
 # define EKS_READY   3
   int ext_key_state;
   struct buffer_list *ext_key_input;
+  int ext_cert_state;
+  struct buffer_list *ext_cert_input;
 #endif
 #endif
   struct event_set *es;
@@ -338,6 +341,7 @@ struct management *management_init (void);
 #define MF_UP_DOWN          (1<<10)
 #define MF_QUERY_REMOTE     (1<<11)
 #define MF_QUERY_PROXY      (1<<12)
+#define MF_EXTERNAL_CERT    (1<<13)
 
 bool management_open (struct management *man,
 		      const char *addr,
@@ -420,6 +424,7 @@ void management_learn_addr (struct management *management,
 #ifdef MANAGMENT_EXTERNAL_KEY
 
 char *management_query_rsa_sig (struct management *man, const char *b64_data);
+char* management_query_cert (struct management *man, const char *cert_name);
 
 #endif
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64ded09..cd222b0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1591,6 +1591,11 @@ show_settings (const struct options *o)
   SHOW_STR (ca_file);
   SHOW_STR (ca_path);
   SHOW_STR (dh_file);
+#ifdef MANAGMENT_EXTERNAL_KEY
+  if((o->management_flags & MF_EXTERNAL_CERT))
+	SHOW_PARM ("cert_file","EXTERNAL_CERT","%s");
+  else
+#endif
   SHOW_STR (cert_file);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
@@ -2172,6 +2177,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #ifdef MANAGMENT_EXTERNAL_KEY
 	if (options->management_flags & MF_EXTERNAL_KEY)
 	  msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs11-provider is also specified.");
+	if (options->management_flags & MF_EXTERNAL_CERT)
+	  msg(M_USAGE, "Parameter --management-external-cert cannot be used when --pkcs11-provider is also specified.");
 #endif
 	if (options->pkcs12_file)
 	  msg(M_USAGE, "Parameter --pkcs12 cannot be used when --pkcs11-provider is also specified.");
@@ -2203,6 +2210,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #ifdef MANAGMENT_EXTERNAL_KEY
           if (options->management_flags & MF_EXTERNAL_KEY)
 	    msg(M_USAGE, "Parameter --management-external-key cannot be used when --cryptoapicert is also specified.");
+          if (options->management_flags & MF_EXTERNAL_CERT)
+	    msg(M_USAGE, "Parameter --management-external-cert cannot be used when --cryptoapicert is also specified.");
 #endif
 	}
       else
@@ -2220,7 +2229,9 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	    msg(M_USAGE, "Parameter --key cannot be used when --pkcs12 is also specified.");
 #ifdef MANAGMENT_EXTERNAL_KEY
           if (options->management_flags & MF_EXTERNAL_KEY)
-	    msg(M_USAGE, "Parameter --external-management-key cannot be used when --pkcs12 is also specified.");
+	    msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs12 is also specified.");
+          if (options->management_flags & MF_EXTERNAL_CERT)
+	    msg(M_USAGE, "Parameter --management-external-cert cannot be used when --pkcs12 is also specified.");
 #endif
 #endif
         }
@@ -2262,6 +2273,9 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	    }
 	  else
 	    {
+#ifdef MANAGMENT_EXTERNAL_KEY
+          if (!(options->management_flags & MF_EXTERNAL_CERT))
+#endif
 	      notnull (options->cert_file, "certificate file (--cert) or PKCS#12 file (--pkcs12)");
 #ifdef MANAGMENT_EXTERNAL_KEY
           if (!(options->management_flags & MF_EXTERNAL_KEY))
@@ -4249,6 +4263,12 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_EXTERNAL_KEY;
     }
+  else if (streq (p[0], "management-external-cert") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->management_flags |= MF_EXTERNAL_CERT;
+      options->management_certificate = p[1];
+    }
 #endif
 #ifdef MANAGEMENT_DEF_AUTH
   else if (streq (p[0], "management-client-auth"))
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5ba4f2f..990c719 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -372,6 +372,7 @@ struct options
 
   /* Mask of MF_ values of manage.h */
   unsigned int management_flags;
+  const char *management_certificate;
 #endif
 
 #ifdef ENABLE_PLUGIN
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c81659f..2beba21 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -516,10 +516,19 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
     }
 #endif
 #ifdef MANAGMENT_EXTERNAL_KEY
-  else if ((options->management_flags & MF_EXTERNAL_KEY) && options->cert_file)
-    {
-      tls_ctx_use_external_private_key(new_ctx, options->cert_file,
-	  options->cert_file_inline);
+  else if ((options->management_flags & MF_EXTERNAL_KEY) && 
+           (options->cert_file || options->management_flags & MF_EXTERNAL_CERT))
+    {
+      if (options->cert_file) {
+        tls_ctx_use_external_private_key(new_ctx, options->cert_file,
+          options->cert_file_inline);
+      } else {
+        char *external_certificate = management_query_cert(management,
+            options->management_certificate);
+        tls_ctx_use_external_private_key(new_ctx, INLINE_FILE_TAG,
+            external_certificate);
+        free(external_certificate);
+      }
     }
 #endif
   else

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="openvpn-macosx-keychain-mcd-4.interdiff"

diff -u b/contrib/keychain-mcd/keychain-mcd.8 b/contrib/keychain-mcd/keychain-mcd.8
--- b/contrib/keychain-mcd/keychain-mcd.8
+++ b/contrib/keychain-mcd/keychain-mcd.8
@@ -48,7 +48,9 @@
 .BR identity-template 
 
 A select string which is used to choose a keychain identity from
-Mac OS X Keychain.
+Mac OS X Keychain or
+.I auto
+if the identity template is passed from openvpn.
 
 \fBSubject\fR, \fBIssuer\fR, \fBSerial\fR, \fBSHA1\fR, \fBMD5\fR selectors can be used.
 
@@ -104,6 +106,16 @@
 
 "Serial: 3E 9B 6F 02 00 00 00 01 1F 20"
 
+If 
+.BR identity-template
+equals to
+.I auto
+then the actual identity template is
+obtained from argument of NEED-CERTIFICATE notification of openvpn.
+In this case the argument of NEED-CERTIFICATE must begin with 'macosx-keychain:' prefix
+and the rest of it must contain the actual identity template in the format described above.
+
+
 .TP
 .BR management-server-ip 
 OpenVPN management IP to connect to.
diff -u b/contrib/keychain-mcd/main.c b/contrib/keychain-mcd/main.c
--- b/contrib/keychain-mcd/main.c
+++ b/contrib/keychain-mcd/main.c
@@ -197,8 +197,17 @@
 
         if (is_prefix(buffer, ">RSA_SIGN:"))
             handle_rsasign(man, identity, buffer);
-        if (is_prefix(buffer, ">NEED-CERTIFICATE"))
+        if (is_prefix(buffer, ">NEED-CERTIFICATE")) {
+            if (!identity) {
+                const char prefix[] = ">NEED-CERTIFICATE:macosx-keychain:";
+                if (!is_prefix(buffer, prefix))
+                  errx(1, "No identity template is passed via command line and " \
+                      "NEED-CERTIFICATE management interface command " \
+                      "misses 'macosx-keychain' prefix.");
+                identity = template_to_identity(buffer+strlen(prefix));
+            }
             handle_needcertificate(man, identity);
+        }
         if (is_prefix(buffer, ">FATAL"))
             fprintf(stderr, "Fatal message from OpenVPN: %s\n", buffer+7);
         if (is_prefix(buffer, ">INFO"))
@@ -225,7 +234,7 @@
     if (argc < 4)
         err(1, "usage: %s <identity_template> <management_ip> <management_port> [<pw-file>]", argv[0]);
 
-    char *cert_prop = argv[1];
+    char *identity_template = argv[1];
     char *s_ip = argv[2];
     char *s_port = argv[3];
     char *password = NULL;
@@ -236,7 +245,9 @@
         password = read_password(s_pw_file);
     }
     
-    SecIdentityRef identity = template_to_identity(cert_prop);
+    SecIdentityRef identity = NULL;
+    if (strcmp(identity_template, "auto"))
+        identity = template_to_identity(identity_template);
     man_fd = connect_to_management_server(s_ip, s_port);
     fprintf(stderr, "Successfully connected to openvpn\n");
 
diff -u b/src/openvpn/manage.c b/src/openvpn/manage.c
--- b/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3251,11 +3251,19 @@
 }
 
 
-char* management_query_cert (struct management *man)
+char* management_query_cert (struct management *man, const char *cert_name)
 {
-  return management_query_multiline_flatten_newline(management,
-      NULL, "NEED-CERTIFICATE", "certificate",
+  const char prompt_1[] = "NEED-CERTIFICATE:";
+  struct buffer buf_prompt = alloc_buf(strlen(cert_name) + 20);
+  buf_write(&buf_prompt, prompt_1, strlen(prompt_1));
+  buf_write(&buf_prompt, cert_name, strlen(cert_name)+1); // +1 for \0
+
+  char *result;
+  result = management_query_multiline_flatten_newline(management,
+      NULL, (char*)buf_bptr(&buf_prompt), "certificate",
       &man->connection.ext_cert_state, &man->connection.ext_cert_input);
+  free_buf(&buf_prompt);
+  return result;
 }
 
 #endif
diff -u b/src/openvpn/manage.h b/src/openvpn/manage.h
--- b/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -424,7 +424,7 @@
 #ifdef MANAGMENT_EXTERNAL_KEY
 
 char *management_query_rsa_sig (struct management *man, const char *b64_data);
-char* management_query_cert (struct management *man);
+char* management_query_cert (struct management *man, const char *cert_name);
 
 #endif
 
diff -u b/src/openvpn/options.c b/src/openvpn/options.c
--- b/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2229,9 +2229,9 @@
 	    msg(M_USAGE, "Parameter --key cannot be used when --pkcs12 is also specified.");
 #ifdef MANAGMENT_EXTERNAL_KEY
           if (options->management_flags & MF_EXTERNAL_KEY)
-	    msg(M_USAGE, "Parameter --external-management-key cannot be used when --pkcs12 is also specified.");
+	    msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs12 is also specified.");
           if (options->management_flags & MF_EXTERNAL_CERT)
-	    msg(M_USAGE, "Parameter --external-management-cert cannot be used when --pkcs12 is also specified.");
+	    msg(M_USAGE, "Parameter --management-external-cert cannot be used when --pkcs12 is also specified.");
 #endif
 #endif
         }
@@ -4263,10 +4263,11 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_EXTERNAL_KEY;
     }
-  else if (streq (p[0], "management-external-cert"))
+  else if (streq (p[0], "management-external-cert") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_EXTERNAL_CERT;
+      options->management_certificate = p[1];
     }
 #endif
 #ifdef MANAGEMENT_DEF_AUTH
diff -u b/src/openvpn/ssl.c b/src/openvpn/ssl.c
--- b/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -523,7 +523,8 @@
         tls_ctx_use_external_private_key(new_ctx, options->cert_file,
           options->cert_file_inline);
       } else {
-        char *external_certificate = management_query_cert(management);
+        char *external_certificate = management_query_cert(management,
+            options->management_certificate);
         tls_ctx_use_external_private_key(new_ctx, INLINE_FILE_TAG,
             external_certificate);
         free(external_certificate);
only in patch2:
unchanged:
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -777,6 +777,28 @@ correct signature.
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
 
+COMMAND -- certificate (OpenVPN 2.3 or higher)
+----------------------------------------------
+Provides support for external storage of the certificate. Requires the
+--management-external-cert option. This option can be used instead of "cert"
+in client mode. On SSL protocol initialization a notification will be sent
+to the management interface with a hint as follows:
+
+>NEED-CERTIFICATE:macosx-keychain:subject:o=OpenVPN-TEST
+
+The management interface client should use the hint to obtain the specific
+SSL certificate and then return base64 encoded certificate as follows:
+
+certificate
+[BASE64_CERT_LINE]
+.
+.
+.
+END
+
+This capability is intended to allow the use of certificates
+stored outside of the filesystem (e.g. in Mac OS X Keychain)
+with OpenVPN via the management interface.
 
 OUTPUT FORMAT
 -------------
only in patch2:
unchanged:
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2591,6 +2591,15 @@ Allows usage for external private key file instead of
 option (client-only).
 .\"*********************************************************
 .TP
+.B \-\-management-external-cert certificate-hint
+Allows usage for external certificate instead of
+.B \-\-cert
+option (client-only).
+.B certificate-hint
+is an arbitrary string which is passed to a management
+interface client as an argument of NEED-CERTIFICATE notification.
+.\"*********************************************************
+.TP
 .B \-\-management-forget-disconnect
 Make OpenVPN forget passwords when management session
 disconnects.
only in patch2:
unchanged:
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -372,6 +372,7 @@ struct options
 
   /* Mask of MF_ values of manage.h */
   unsigned int management_flags;
+  const char *management_certificate;
 #endif
 
 #ifdef ENABLE_PLUGIN

--2fHTh5uZTiUOsy+g--

