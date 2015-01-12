Sender: Vasiliy Kulikov <segooon@...277...>
Date: Mon, 12 Jan 2015 11:51:21 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150112085121.GA25193@...2009...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2] Mac OS X Keychain management client
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

This patch adds support for using certificates stored in the Mac OSX
Keychain to authenticate with the OpenVPN server.  This works with
certificates stored on the computer as well as certificates on hardware
tokens that support Apple's tokend interface.  The patch is based on
the Windows Crypto API certificate functionality that currently exists
in OpenVPN.

This patch version implements management client which handles rsa_sign
command for RSA offloading.  Also it handled new 'Cert' request to pass
a certificate from the keychain to OpenVPN.

This is a PoC version of the patch.  If the concept is OK for OpenVPN,
I'll integrate it into autoconf, add documentation based on the
manpage from the previous version of the patch, and add more strict argv
checks for interferred options.

The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.

The previous version of the patch:

http://thread.gmane.org/gmane.network.openvpn.devel/9320

Signed-off-by: Vasily Kulikov <segoon@...2008...>
---

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
index 0000000..edfa21b
--- /dev/null
+++ b/contrib/keychain-mcd/cert_data.c
@@ -0,0 +1,761 @@
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
+    warnx("WARNING: no key in keychain");
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
+void printString(const void *val, void *context) 
+{
+  CFStringRef str = (CFStringRef)val;
+  const char *label = (const char *)context;
+  warnx("%s = %s\n", label, CFStringGetCStringPtr(str, kCFStringEncodingUTF8));
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
+  warnx("*** Subject ***\n");
+  if (pCertData->subject)
+    CFArrayApplyFunction(pCertData->subject, CFRangeMake(0, CFArrayGetCount(pCertData->subject)), arrayPrintCertName, NULL);
+
+  warnx("*** Issuer ***\n");
+  if (pCertData->issuer)
+    CFArrayApplyFunction(pCertData->issuer, CFRangeMake(0, CFArrayGetCount(pCertData->issuer)), arrayPrintCertName, NULL);
+
+  warnx("*** Fingerprints ***\n");
+
+  warnx("SHA1 = ");
+  if (pCertData->sha1)
+    printCFString(pCertData->sha1);
+
+  warnx("\n");
+
+  warnx("MD5 = ");
+  if (pCertData->md5)
+    printCFString(pCertData->md5);
+
+  warnx("\n");
+
+  warnx("Serial Number = ");
+  if (pCertData->serial)
+    printCFString(pCertData->serial);
+
+  warnx("\n");	
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
index 0000000..261c1d1
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
diff --git a/contrib/keychain-mcd/common_osx.c b/contrib/keychain-mcd/common_osx.c
new file mode 100644
index 0000000..fd9275a
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
index 0000000..f21230e
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
index 0000000..9c874e7
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
index 0000000..705e5f4
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
diff --git a/contrib/keychain-mcd/main.c b/contrib/keychain-mcd/main.c
new file mode 100644
index 0000000..393b2cf
--- /dev/null
+++ b/contrib/keychain-mcd/main.c
@@ -0,0 +1,204 @@
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
+void handle_needcert(FILE *man_file, SecIdentityRef identity)
+{
+    OSStatus status;
+    SecCertificateRef certificate = NULL;
+    CFDataRef data;
+    const unsigned char *cert;
+    size_t cert_len;
+    char *result_b64;
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
+    fprintf(stderr, "needok CERT %s\n", result_b64);
+#endif
+    fprintf(man_file, "needok CERT '%s'\n", result_b64);
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
+        if (is_prefix(buffer, ">NEED-OK:Need 'CERT'"))
+            handle_needcert(man, identity);
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
+    char *cert_prop = argv[1];
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
+    SecIdentityRef identity = template_to_identity(cert_prop);
+    man_fd = connect_to_management_server(s_ip, s_port);
+    fprintf(stderr, "Successfully connected to openvpn\n");
+
+    management_loop(identity, man_fd, password);
+}
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 9f44cd9..c101055 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1894,6 +1894,46 @@ int managment_android_persisttun_action (struct management *man)
 
 #endif
 
+char *cert_to_pem(const char *cert)
+{
+  const char s1[] = "-----BEGIN CERTIFICATE-----\n";
+  const char s2[] = "-----END CERTIFICATE-----\n";
+  char *buf = malloc(strlen(cert)*67/64 + strlen(s1) + strlen(s2) + 4);
+  char *p;
+  const char *cert_p;
+  buf[0] = 0;
+  const int line_len =  64;
+
+  p = buf + sprintf(buf, "%s", s1);
+  cert_p = cert;
+  while (*cert_p) {
+    int n = snprintf(p, line_len, "%s", cert_p);
+    if (n >= line_len) n = line_len-1;
+    p += n;
+    cert_p += n;
+    p[0] = '\n';
+    p[1] = 0;
+    p += 1;
+  }
+
+  strcat(p, s2);
+
+#if 0
+  fprintf(stderr, "External certificate:\n%s\nEND\n", buf);
+#endif
+  return buf;
+}
+
+char* management_query_cert (struct management *man)
+{
+  struct user_pass up;
+
+  CLEAR(up);
+  strncpy (up.username, "Certificate", sizeof(up.username)-1);
+  management_query_user_pass(management, &up , "CERT", GET_USER_PASS_NEED_OK,(void*) 0);
+  return cert_to_pem(up.password);
+}
+
 static int
 man_read (struct management *man)
 {
@@ -2209,7 +2249,7 @@ man_connection_init (struct management *man)
        * Allocate helper objects for command line input and
        * command output from/to the socket.
        */
-      man->connection.in = command_line_new (1024);
+      man->connection.in = command_line_new (4096);
       man->connection.out = buffer_list_new (0);
 
       /*
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 1c8dda6..5bb393f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -338,6 +338,7 @@ struct management *management_init (void);
 #define MF_UP_DOWN          (1<<10)
 #define MF_QUERY_REMOTE     (1<<11)
 #define MF_QUERY_PROXY      (1<<12)
+#define MF_EXTERNAL_CERT    (1<<13)
 
 bool management_open (struct management *man,
 		      const char *addr,
@@ -384,6 +385,7 @@ bool management_android_control (struct management *man, const char *command, co
 #define ANDROID_OPEN_BEFORE_CLOSE 3
 int managment_android_persisttun_action (struct management *man);
 #endif
+char* management_query_cert (struct management *man);
 
 bool management_should_daemonize (struct management *man);
 bool management_would_hold (struct management *man);
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 41748bd..a8858d3 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -205,7 +205,7 @@ struct user_pass
 # ifdef ENABLE_PKCS11
 #   define USER_PASS_LEN 4096
 # else
-#   define USER_PASS_LEN 128
+#   define USER_PASS_LEN 12800
 # endif
   char username[USER_PASS_LEN];
   char password[USER_PASS_LEN];
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64ded09..8f5f7e7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1591,6 +1591,9 @@ show_settings (const struct options *o)
   SHOW_STR (ca_file);
   SHOW_STR (ca_path);
   SHOW_STR (dh_file);
+  if((o->management_flags & MF_EXTERNAL_CERT))
+	SHOW_PARM ("cert_file","EXTERNAL_CERT","%s");
+  else
   SHOW_STR (cert_file);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
@@ -2262,6 +2265,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	    }
 	  else
 	    {
+          if (!(options->management_flags & MF_EXTERNAL_CERT))
 	      notnull (options->cert_file, "certificate file (--cert) or PKCS#12 file (--pkcs12)");
 #ifdef MANAGMENT_EXTERNAL_KEY
           if (!(options->management_flags & MF_EXTERNAL_KEY))
@@ -4250,6 +4254,11 @@ add_option (struct options *options,
       options->management_flags |= MF_EXTERNAL_KEY;
     }
 #endif
+  else if (streq (p[0], "management-external-cert"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->management_flags |= MF_EXTERNAL_CERT;
+    }
 #ifdef MANAGEMENT_DEF_AUTH
   else if (streq (p[0], "management-client-auth"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5ba4f2f..2b29406 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -52,8 +52,8 @@
 /*
  * Max size of options line and parameter.
  */
-#define OPTION_PARM_SIZE 256
-#define OPTION_LINE_SIZE 256
+#define OPTION_PARM_SIZE 4096
+#define OPTION_LINE_SIZE 4096
 
 extern const char title_string[];
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c81659f..cb8a739 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -516,10 +516,18 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
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
+        char *external_certificate = management_query_cert(management);
+        tls_ctx_use_external_private_key(new_ctx, INLINE_FILE_TAG,
+            external_certificate);
+        free(external_certificate);
+      }
     }
 #endif
   else

