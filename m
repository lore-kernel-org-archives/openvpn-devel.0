From: samuli@...515...
Date: Wed, 29 Jun 2011 11:24:07 +0300
Message-Id: <1309335848-14414-2-git-send-email-samuli@...515...>
In-Reply-To: <1309335848-14414-1-git-send-email-samuli@...515...>
References: <1308302282-27985-1-git-send-email-samuli@...515...>
	<1309335848-14414-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Updated "easy-rsa" for OpenSSL 1.0.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

This patch fixes remaining issues with Trac ticket #125. It does the follow=
ing:

- Update easy-rsa/2.0/README
- Rename easy-rsa/2.0/openssl.cnf as openssl-0.9.8.cnf
- Add easy-rsa/2.0/openssl-1.0.0.cnf
- Updated vars.bat.sample to use openssl-1.0.0.cnf
- Updated win/openvpn.nsi to use openssl-1.0.0.cnf
- Add a few undefined variables to vars and vars.bat.sample:
  required by OpenSSL 1.0.0 (at least on Windows)

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 easy-rsa/2.0/README              |    4 +-
 easy-rsa/2.0/openssl-1.0.0.cnf   |  285 ++++++++++++++++++++++++++++++++++=
+++
 easy-rsa/2.0/openssl.cnf         |  291 ----------------------------------=
----
 easy-rsa/2.0/vars                |    6 +
 easy-rsa/Windows/vars.bat.sample |    7 +-
 win/openvpn.nsi                  |    2 +-
 6 files changed, 300 insertions(+), 295 deletions(-)
 create mode 100755 easy-rsa/2.0/openssl-1.0.0.cnf
 delete mode 100755 easy-rsa/2.0/openssl.cnf

diff --git a/easy-rsa/2.0/README b/easy-rsa/2.0/README
index bde0d8c..6f5395c 100644
--- a/easy-rsa/2.0/README
+++ b/easy-rsa/2.0/README
@@ -74,8 +74,8 @@ Release Notes for easy-rsa-2.0
 INSTALL easy-rsa
=20
 1. Edit vars.
-2. Set KEY_CONFIG to point to the openssl.cnf file
-   included in this distribution.
+2. Set KEY_CONFIG to point to the correct openssl-<version>.cnf
+   file included in this distribution.
 3. Set KEY_DIR to point to a directory which will
    contain all keys, certificates, etc.  This
    directory need not exist, and if it does,
diff --git a/easy-rsa/2.0/openssl-1.0.0.cnf b/easy-rsa/2.0/openssl-1.0.0.cnf
new file mode 100755
index 0000000..da425aa
--- /dev/null
+++ b/easy-rsa/2.0/openssl-1.0.0.cnf
@@ -0,0 +1,285 @@
+# For use with easy-rsa version 2.0 and OpenSSL 1.0.0*
+
+# This definition stops the following lines choking if HOME isn't
+# defined.
+HOME			=3D .
+RANDFILE		=3D $ENV::HOME/.rnd
+openssl_conf		=3D openssl_init
+
+[ openssl_init ]
+# Extra OBJECT IDENTIFIER info:
+#oid_file		=3D $ENV::HOME/.oid
+oid_section		=3D new_oids
+engines			=3D engine_section
+
+# To use this configuration file with the "-extfile" option of the
+# "openssl x509" utility, name here the section containing the
+# X.509v3 extensions to use:
+# extensions		=3D=20
+# (Alternatively, use a configuration file that has only
+# X.509v3 extensions in its main [=3D default] section.)
+
+[ new_oids ]
+
+# We can add new OIDs in here for use by 'ca' and 'req'.
+# Add a simple OID like this:
+# testoid1=3D1.2.3.4
+# Or use config file substitution like this:
+# testoid2=3D${testoid1}.5.6
+
+####################################################################
+[ ca ]
+default_ca	=3D CA_default		# The default ca section
+
+####################################################################
+[ CA_default ]
+
+dir		=3D $ENV::KEY_DIR		# Where everything is kept
+certs		=3D $dir			# Where the issued certs are kept
+crl_dir		=3D $dir			# Where the issued crl are kept
+database	=3D $dir/index.txt	# database index file.
+new_certs_dir	=3D $dir			# default place for new certs.
+
+certificate	=3D $dir/ca.crt	 	# The CA certificate
+serial		=3D $dir/serial 		# The current serial number
+crl		=3D $dir/crl.pem 		# The current CRL
+private_key	=3D $dir/ca.key		# The private key
+RANDFILE	=3D $dir/.rand		# private random number file
+
+x509_extensions	=3D usr_cert		# The extentions to add to the cert
+
+# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
+# so this is commented out by default to leave a V1 CRL.
+# crl_extensions	=3D crl_ext
+
+default_days	=3D 3650			# how long to certify for
+default_crl_days=3D 30			# how long before next CRL
+default_md	=3D md5			# use public key default MD
+preserve	=3D no			# keep passed DN ordering
+
+# A few difference way of specifying how similar the request should look
+# For type CA, the listed attributes must be the same, and the optional
+# and supplied fields are just that :-)
+policy		=3D policy_anything
+
+# For the CA policy
+[ policy_match ]
+countryName		=3D match
+stateOrProvinceName	=3D match
+organizationName	=3D match
+organizationalUnitName	=3D optional
+commonName		=3D supplied
+name			=3D optional
+emailAddress		=3D optional
+
+# For the 'anything' policy
+# At this point in time, you must list all acceptable 'object'
+# types.
+[ policy_anything ]
+countryName		=3D optional
+stateOrProvinceName	=3D optional
+localityName		=3D optional
+organizationName	=3D optional
+organizationalUnitName	=3D optional
+commonName		=3D supplied
+name			=3D optional
+emailAddress		=3D optional
+
+####################################################################
+[ req ]
+default_bits		=3D $ENV::KEY_SIZE
+default_keyfile 	=3D privkey.pem
+distinguished_name	=3D req_distinguished_name
+attributes		=3D req_attributes
+x509_extensions	=3D v3_ca	# The extentions to add to the self signed cert
+
+# Passwords for private keys if not present they will be prompted for
+# input_password =3D secret
+# output_password =3D secret
+
+# This sets a mask for permitted string types. There are several options.=
=20
+# default: PrintableString, T61String, BMPString.
+# pkix	 : PrintableString, BMPString (PKIX recommendation after 2004).
+# utf8only: only UTF8Strings (PKIX recommendation after 2004).
+# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
+# MASK:XXXX a literal mask value.
+string_mask =3D nombstr
+
+# req_extensions =3D v3_req # The extensions to add to a certificate reque=
st
+
+[ req_distinguished_name ]
+countryName			=3D Country Name (2 letter code)
+countryName_default		=3D $ENV::KEY_COUNTRY
+countryName_min			=3D 2
+countryName_max			=3D 2
+
+stateOrProvinceName		=3D State or Province Name (full name)
+stateOrProvinceName_default	=3D $ENV::KEY_PROVINCE
+
+localityName			=3D Locality Name (eg, city)
+localityName_default		=3D $ENV::KEY_CITY
+
+0.organizationName		=3D Organization Name (eg, company)
+0.organizationName_default	=3D $ENV::KEY_ORG
+
+# we can do this but it is not needed normally :-)
+#1.organizationName		=3D Second Organization Name (eg, company)
+#1.organizationName_default	=3D World Wide Web Pty Ltd
+
+organizationalUnitName		=3D Organizational Unit Name (eg, section)
+#organizationalUnitName_default	=3D
+
+commonName			=3D Common Name (eg, your name or your server\'s hostname)
+commonName_max			=3D 64
+
+name				=3D Name
+name_max			=3D 64
+
+emailAddress			=3D Email Address
+emailAddress_default		=3D $ENV::KEY_EMAIL
+emailAddress_max		=3D 40
+
+# JY -- added for batch mode
+organizationalUnitName_default =3D $ENV::KEY_OU
+commonName_default =3D $ENV::KEY_CN
+name_default =3D $ENV::KEY_NAME
+
+
+# SET-ex3			=3D SET extension number 3
+
+[ req_attributes ]
+challengePassword		=3D A challenge password
+challengePassword_min		=3D 4
+challengePassword_max		=3D 20
+
+unstructuredName		=3D An optional company name
+
+[ usr_cert ]
+
+# These extensions are added when 'ca' signs a request.
+
+# This goes against PKIX guidelines but some CAs do it and some software
+# requires this to avoid interpreting an end user certificate as a CA.
+
+basicConstraints=3DCA:FALSE
+
+# Here are some examples of the usage of nsCertType. If it is omitted
+# the certificate can be used for anything *except* object signing.
+
+# This is OK for an SSL server.
+# nsCertType			=3D server
+
+# For an object signing certificate this would be used.
+# nsCertType =3D objsign
+
+# For normal client use this is typical
+# nsCertType =3D client, email
+
+# and for everything including object signing:
+# nsCertType =3D client, email, objsign
+
+# This is typical in keyUsage for a client certificate.
+# keyUsage =3D nonRepudiation, digitalSignature, keyEncipherment
+
+# This will be displayed in Netscape's comment listbox.
+nsComment			=3D "Easy-RSA Generated Certificate"
+
+# PKIX recommendations harmless if included in all certificates.
+subjectKeyIdentifier=3Dhash
+authorityKeyIdentifier=3Dkeyid,issuer:always
+extendedKeyUsage=3DclientAuth
+keyUsage =3D digitalSignature
+
+
+# This stuff is for subjectAltName and issuerAltname.
+# Import the email address.
+# subjectAltName=3Demail:copy
+
+# Copy subject details
+# issuerAltName=3Dissuer:copy
+
+#nsCaRevocationUrl		=3D http://www.domain.dom/ca-crl.pem
+#nsBaseUrl
+#nsRevocationUrl
+#nsRenewalUrl
+#nsCaPolicyUrl
+#nsSslServerName
+
+[ server ]
+
+# JY ADDED -- Make a cert with nsCertType set to "server"
+basicConstraints=3DCA:FALSE
+nsCertType                     =3D server
+nsComment                      =3D "Easy-RSA Generated Server Certificate"
+subjectKeyIdentifier=3Dhash
+authorityKeyIdentifier=3Dkeyid,issuer:always
+extendedKeyUsage=3DserverAuth
+keyUsage =3D digitalSignature, keyEncipherment
+
+[ v3_req ]
+
+# Extensions to add to a certificate request
+
+basicConstraints =3D CA:FALSE
+keyUsage =3D nonRepudiation, digitalSignature, keyEncipherment
+
+[ v3_ca ]
+
+
+# Extensions for a typical CA
+
+
+# PKIX recommendation.
+
+subjectKeyIdentifier=3Dhash
+
+authorityKeyIdentifier=3Dkeyid:always,issuer:always
+
+# This is what PKIX recommends but some broken software chokes on critical
+# extensions.
+#basicConstraints =3D critical,CA:true
+# So we do this instead.
+basicConstraints =3D CA:true
+
+# Key usage: this is typical for a CA certificate. However since it will
+# prevent it being used as an test self-signed certificate it is best
+# left out by default.
+# keyUsage =3D cRLSign, keyCertSign
+
+# Some might want this also
+# nsCertType =3D sslCA, emailCA
+
+# Include email address in subject alt name: another PKIX recommendation
+# subjectAltName=3Demail:copy
+# Copy issuer details
+# issuerAltName=3Dissuer:copy
+
+# DER hex encoding of an extension: beware experts only!
+# obj=3DDER:02:03
+# Where 'obj' is a standard or added object
+# You can even override a supported extension:
+# basicConstraints=3D critical, DER:30:03:01:01:FF
+
+[ crl_ext ]
+
+# CRL extensions.
+# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.
+
+# issuerAltName=3Dissuer:copy
+authorityKeyIdentifier=3Dkeyid:always,issuer:always
+
+[ engine_section ]
+#
+# If you are using PKCS#11
+# Install engine_pkcs11 of opensc (www.opensc.org)
+# And uncomment the following
+# verify that dynamic_path points to the correct location
+#
+#pkcs11 =3D pkcs11_section
+
+[ pkcs11_section ]
+engine_id =3D pkcs11
+dynamic_path =3D /usr/lib/engines/engine_pkcs11.so
+MODULE_PATH =3D $ENV::PKCS11_MODULE_PATH
+PIN =3D $ENV::PKCS11_PIN
+init =3D 0
diff --git a/easy-rsa/2.0/openssl.cnf b/easy-rsa/2.0/openssl.cnf
deleted file mode 100755
index 3e4d3b3..0000000
--- a/easy-rsa/2.0/openssl.cnf
+++ /dev/null
@@ -1,291 +0,0 @@
-# For use with easy-rsa version 2.0
-
-#
-# OpenSSL example configuration file.
-# This is mostly being used for generation of certificate requests.
-#
-
-# This definition stops the following lines choking if HOME isn't
-# defined.
-HOME			=3D .
-RANDFILE		=3D $ENV::HOME/.rnd
-openssl_conf		=3D openssl_init
-
-[ openssl_init ]
-# Extra OBJECT IDENTIFIER info:
-#oid_file		=3D $ENV::HOME/.oid
-oid_section		=3D new_oids
-engines                 =3D engine_section
-
-# To use this configuration file with the "-extfile" option of the
-# "openssl x509" utility, name here the section containing the
-# X.509v3 extensions to use:
-# extensions		=3D=20
-# (Alternatively, use a configuration file that has only
-# X.509v3 extensions in its main [=3D default] section.)
-
-[ new_oids ]
-
-# We can add new OIDs in here for use by 'ca' and 'req'.
-# Add a simple OID like this:
-# testoid1=3D1.2.3.4
-# Or use config file substitution like this:
-# testoid2=3D${testoid1}.5.6
-
-####################################################################
-[ ca ]
-default_ca	=3D CA_default		# The default ca section
-
-####################################################################
-[ CA_default ]
-
-dir		=3D $ENV::KEY_DIR		# Where everything is kept
-certs		=3D $dir			# Where the issued certs are kept
-crl_dir		=3D $dir			# Where the issued crl are kept
-database	=3D $dir/index.txt	# database index file.
-new_certs_dir	=3D $dir			# default place for new certs.
-
-certificate	=3D $dir/ca.crt	 	# The CA certificate
-serial		=3D $dir/serial 		# The current serial number
-crl		=3D $dir/crl.pem 		# The current CRL
-private_key	=3D $dir/ca.key	 	# The private key
-RANDFILE	=3D $dir/.rand		# private random number file
-
-x509_extensions	=3D usr_cert		# The extentions to add to the cert
-
-# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
-# so this is commented out by default to leave a V1 CRL.
-# crl_extensions	=3D crl_ext
-
-default_days	=3D 3650			# how long to certify for
-default_crl_days=3D 30			# how long before next CRL
-default_md	=3D md5			# which md to use.
-preserve	=3D no			# keep passed DN ordering
-
-# A few difference way of specifying how similar the request should look
-# For type CA, the listed attributes must be the same, and the optional
-# and supplied fields are just that :-)
-policy		=3D policy_anything
-
-# For the CA policy
-[ policy_match ]
-countryName		=3D match
-stateOrProvinceName	=3D match
-organizationName	=3D match
-organizationalUnitName	=3D optional
-commonName		=3D supplied
-name			=3D optional
-emailAddress		=3D optional
-
-# For the 'anything' policy
-# At this point in time, you must list all acceptable 'object'
-# types.
-[ policy_anything ]
-countryName		=3D optional
-stateOrProvinceName	=3D optional
-localityName		=3D optional
-organizationName	=3D optional
-organizationalUnitName	=3D optional
-commonName		=3D supplied
-name			=3D optional
-emailAddress		=3D optional
-
-####################################################################
-[ req ]
-default_bits		=3D $ENV::KEY_SIZE
-default_keyfile 	=3D privkey.pem
-distinguished_name	=3D req_distinguished_name
-attributes		=3D req_attributes
-x509_extensions	=3D v3_ca	# The extentions to add to the self signed cert
-
-# Passwords for private keys if not present they will be prompted for
-# input_password =3D secret
-# output_password =3D secret
-
-# This sets a mask for permitted string types. There are several options.=
=20
-# default: PrintableString, T61String, BMPString.
-# pkix	 : PrintableString, BMPString.
-# utf8only: only UTF8Strings.
-# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
-# MASK:XXXX a literal mask value.
-# WARNING: current versions of Netscape crash on BMPStrings or UTF8Strings
-# so use this option with caution!
-string_mask =3D nombstr
-
-# req_extensions =3D v3_req # The extensions to add to a certificate reque=
st
-
-[ req_distinguished_name ]
-countryName			=3D Country Name (2 letter code)
-countryName_default		=3D $ENV::KEY_COUNTRY
-countryName_min			=3D 2
-countryName_max			=3D 2
-
-stateOrProvinceName		=3D State or Province Name (full name)
-stateOrProvinceName_default	=3D $ENV::KEY_PROVINCE
-
-localityName			=3D Locality Name (eg, city)
-localityName_default		=3D $ENV::KEY_CITY
-
-0.organizationName		=3D Organization Name (eg, company)
-0.organizationName_default	=3D $ENV::KEY_ORG
-
-# we can do this but it is not needed normally :-)
-#1.organizationName		=3D Second Organization Name (eg, company)
-#1.organizationName_default	=3D World Wide Web Pty Ltd
-
-organizationalUnitName		=3D Organizational Unit Name (eg, section)
-#organizationalUnitName_default	=3D
-
-commonName			=3D Common Name (eg, your name or your server\'s hostname)
-commonName_max			=3D 64
-
-name				=3D Name
-name_max			=3D 64
-
-emailAddress			=3D Email Address
-emailAddress_default		=3D $ENV::KEY_EMAIL
-emailAddress_max		=3D 40
-
-# JY -- added for batch mode
-organizationalUnitName_default =3D $ENV::KEY_OU
-commonName_default =3D $ENV::KEY_CN
-name_default =3D $ENV::KEY_NAME
-
-# SET-ex3			=3D SET extension number 3
-
-[ req_attributes ]
-challengePassword		=3D A challenge password
-challengePassword_min		=3D 4
-challengePassword_max		=3D 20
-
-unstructuredName		=3D An optional company name
-
-[ usr_cert ]
-
-# These extensions are added when 'ca' signs a request.
-
-# This goes against PKIX guidelines but some CAs do it and some software
-# requires this to avoid interpreting an end user certificate as a CA.
-
-basicConstraints=3DCA:FALSE
-
-# Here are some examples of the usage of nsCertType. If it is omitted
-# the certificate can be used for anything *except* object signing.
-
-# This is OK for an SSL server.
-# nsCertType			=3D server
-
-# For an object signing certificate this would be used.
-# nsCertType =3D objsign
-
-# For normal client use this is typical
-# nsCertType =3D client, email
-
-# and for everything including object signing:
-# nsCertType =3D client, email, objsign
-
-# This is typical in keyUsage for a client certificate.
-# keyUsage =3D nonRepudiation, digitalSignature, keyEncipherment
-
-# This will be displayed in Netscape's comment listbox.
-nsComment			=3D "Easy-RSA Generated Certificate"
-
-# PKIX recommendations harmless if included in all certificates.
-subjectKeyIdentifier=3Dhash
-authorityKeyIdentifier=3Dkeyid,issuer:always
-extendedKeyUsage=3DclientAuth
-keyUsage =3D digitalSignature
-
-# This stuff is for subjectAltName and issuerAltname.
-# Import the email address.
-# subjectAltName=3Demail:copy
-
-# Copy subject details
-# issuerAltName=3Dissuer:copy
-
-#nsCaRevocationUrl		=3D http://www.domain.dom/ca-crl.pem
-#nsBaseUrl
-#nsRevocationUrl
-#nsRenewalUrl
-#nsCaPolicyUrl
-#nsSslServerName
-
-[ server ]
-
-# JY ADDED -- Make a cert with nsCertType set to "server"
-basicConstraints=3DCA:FALSE
-nsCertType			=3D server
-nsComment			=3D "Easy-RSA Generated Server Certificate"
-subjectKeyIdentifier=3Dhash
-authorityKeyIdentifier=3Dkeyid,issuer:always
-extendedKeyUsage=3DserverAuth
-keyUsage =3D digitalSignature, keyEncipherment
-
-[ v3_req ]
-
-# Extensions to add to a certificate request
-
-basicConstraints =3D CA:FALSE
-keyUsage =3D nonRepudiation, digitalSignature, keyEncipherment
-
-[ v3_ca ]
-
-
-# Extensions for a typical CA
-
-
-# PKIX recommendation.
-
-subjectKeyIdentifier=3Dhash
-
-authorityKeyIdentifier=3Dkeyid:always,issuer:always
-
-# This is what PKIX recommends but some broken software chokes on critical
-# extensions.
-#basicConstraints =3D critical,CA:true
-# So we do this instead.
-basicConstraints =3D CA:true
-
-# Key usage: this is typical for a CA certificate. However since it will
-# prevent it being used as an test self-signed certificate it is best
-# left out by default.
-# keyUsage =3D cRLSign, keyCertSign
-
-# Some might want this also
-# nsCertType =3D sslCA, emailCA
-
-# Include email address in subject alt name: another PKIX recommendation
-# subjectAltName=3Demail:copy
-# Copy issuer details
-# issuerAltName=3Dissuer:copy
-
-# DER hex encoding of an extension: beware experts only!
-# obj=3DDER:02:03
-# Where 'obj' is a standard or added object
-# You can even override a supported extension:
-# basicConstraints=3D critical, DER:30:03:01:01:FF
-
-[ crl_ext ]
-
-# CRL extensions.
-# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.
-
-# issuerAltName=3Dissuer:copy
-authorityKeyIdentifier=3Dkeyid:always,issuer:always
-
-[ engine_section ]
-#
-# If you are using PKCS#11
-# Install engine_pkcs11 of opensc (www.opensc.org)
-# And uncomment the following
-# verify that dynamic_path points to the correct location
-#
-#pkcs11 =3D pkcs11_section
-
-[ pkcs11_section ]
-engine_id =3D pkcs11
-dynamic_path =3D /usr/lib/engines/engine_pkcs11.so
-MODULE_PATH =3D $ENV::PKCS11_MODULE_PATH
-PIN =3D $ENV::PKCS11_PIN
-init =3D 0
-
diff --git a/easy-rsa/2.0/vars b/easy-rsa/2.0/vars
index cded885..2ea1ced 100755
--- a/easy-rsa/2.0/vars
+++ b/easy-rsa/2.0/vars
@@ -66,3 +66,9 @@ export KEY_PROVINCE=3D"CA"
 export KEY_CITY=3D"SanFrancisco"
 export KEY_ORG=3D"Fort-Funston"
 export KEY_EMAIL=3D"me@...430..."
+export KEY_EMAIL=3Dmail@...1470...
+export KEY_CN=3Dchangeme
+export KEY_NAME=3Dchangeme
+export KEY_OU=3Dchangeme
+export PKCS11_MODULE_PATH=3Dchangeme
+export PKCS11_PIN=3D1234
diff --git a/easy-rsa/Windows/vars.bat.sample b/easy-rsa/Windows/vars.bat.s=
ample
index 3c4b607..36e6f71 100644
--- a/easy-rsa/Windows/vars.bat.sample
+++ b/easy-rsa/Windows/vars.bat.sample
@@ -4,7 +4,7 @@ rem the openssl.cnf file included
 rem with easy-rsa.
=20
 set HOME=3D%ProgramFiles%\OpenVPN\easy-rsa
-set KEY_CONFIG=3Dopenssl.cnf
+set KEY_CONFIG=3Dopenssl-1.0.0.cnf
=20
 rem Edit this variable to point to
 rem your soon-to-be-created key
@@ -33,3 +33,8 @@ set KEY_PROVINCE=3DCA
 set KEY_CITY=3DSanFrancisco
 set KEY_ORG=3DOpenVPN
 set KEY_EMAIL=3Dmail@...1470...
+set KEY_CN=3Dchangeme
+set KEY_NAME=3Dchangeme
+set KEY_OU=3Dchangeme
+set PKCS11_MODULE_PATH=3Dchangeme
+set PKCS11_PIN=3D1234
diff --git a/win/openvpn.nsi b/win/openvpn.nsi
index 82be118..13c04f2 100755
--- a/win/openvpn.nsi
+++ b/win/openvpn.nsi
@@ -274,7 +274,7 @@ Section "${PRODUCT_NAME} RSA Certificate Management Scr=
ipts" SecOpenVPNEasyRSA
=20
   # Original nsi script looked for ${EASYRSA}\2.0\openssl.cnf.sample. A ne=
wer=20
   # openssl.cnf is needed on OpenVPN 2.2+.
-  File "${EASYRSA}\Windows\openssl.cnf"
+  File "${EASYRSA}\2.0\openssl-1.0.0.cnf"
=20
   File "${EASYRSA}\Windows\vars.bat.sample"
=20
--=20
1.7.4.1


