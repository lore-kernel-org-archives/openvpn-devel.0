From: samuli@...515...
Date: Mon, 20 Jun 2011 10:49:41 +0300
Message-Id: <1308556181-20317-1-git-send-email-samuli@...515...>
In-Reply-To: <1308302282-27985-1-git-send-email-samuli@...515...>
References: <1308302282-27985-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add new openssl.cnf to easy-rsa/Windows
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

This is required for patch "Fix a build-ca issue on Windows" to work
---
 easy-rsa/Windows/openssl.cnf |  350 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 350 insertions(+), 0 deletions(-)
 create mode 100644 easy-rsa/Windows/openssl.cnf

diff --git a/easy-rsa/Windows/openssl.cnf b/easy-rsa/Windows/openssl.cnf
new file mode 100644
index 0000000..9d2cd5b
--- /dev/null
+++ b/easy-rsa/Windows/openssl.cnf
@@ -0,0 +1,350 @@
+#
+# OpenSSL example configuration file.
+# This is mostly being used for generation of certificate requests.
+#
+
+# This definition stops the following lines choking if HOME isn't
+# defined.
+HOME			=3D .
+RANDFILE		=3D $ENV::HOME/.rnd
+
+# Extra OBJECT IDENTIFIER info:
+#oid_file		=3D $ENV::HOME/.oid
+oid_section		=3D new_oids
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
+# We can add new OIDs in here for use by 'ca', 'req' and 'ts'.
+# Add a simple OID like this:
+# testoid1=3D1.2.3.4
+# Or use config file substitution like this:
+# testoid2=3D${testoid1}.5.6
+
+# Policies used by the TSA examples.
+tsa_policy1 =3D 1.2.3.4.1
+tsa_policy2 =3D 1.2.3.4.5.6
+tsa_policy3 =3D 1.2.3.4.5.7
+
+####################################################################
+[ ca ]
+default_ca	=3D CA_default		# The default ca section
+
+####################################################################
+[ CA_default ]
+
+dir		=3D ./demoCA		# Where everything is kept
+certs		=3D $dir/certs		# Where the issued certs are kept
+crl_dir		=3D $dir/crl		# Where the issued crl are kept
+database	=3D $dir/index.txt	# database index file.
+#unique_subject	=3D no			# Set to 'no' to allow creation of
+					# several ctificates with same subject.
+new_certs_dir	=3D $dir/newcerts		# default place for new certs.
+
+certificate	=3D $dir/cacert.pem 	# The CA certificate
+serial		=3D $dir/serial 		# The current serial number
+crlnumber	=3D $dir/crlnumber	# the current crl number
+					# must be commented out to leave a V1 CRL
+crl		=3D $dir/crl.pem 		# The current CRL
+private_key	=3D $dir/private/cakey.pem# The private key
+RANDFILE	=3D $dir/private/.rand	# private random number file
+
+x509_extensions	=3D usr_cert		# The extentions to add to the cert
+
+# Comment out the following two lines for the "traditional"
+# (and highly broken) format.
+name_opt 	=3D ca_default		# Subject Name options
+cert_opt 	=3D ca_default		# Certificate field options
+
+# Extension copying option: use with caution.
+# copy_extensions =3D copy
+
+# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
+# so this is commented out by default to leave a V1 CRL.
+# crlnumber must also be commented out to leave a V1 CRL.
+# crl_extensions	=3D crl_ext
+
+default_days	=3D 365			# how long to certify for
+default_crl_days=3D 30			# how long before next CRL
+default_md	=3D default		# use public key default MD
+preserve	=3D no			# keep passed DN ordering
+
+# A few difference way of specifying how similar the request should look
+# For type CA, the listed attributes must be the same, and the optional
+# and supplied fields are just that :-)
+policy		=3D policy_match
+
+# For the CA policy
+[ policy_match ]
+countryName		=3D match
+stateOrProvinceName	=3D match
+organizationName	=3D match
+organizationalUnitName	=3D optional
+commonName		=3D supplied
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
+emailAddress		=3D optional
+
+####################################################################
+[ req ]
+default_bits		=3D 1024
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
+# pkix	 : PrintableString, BMPString (PKIX recommendation before 2004)
+# utf8only: only UTF8Strings (PKIX recommendation after 2004).
+# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
+# MASK:XXXX a literal mask value.
+# WARNING: ancient versions of Netscape crash on BMPStrings or UTF8Strings.
+string_mask =3D utf8only
+
+# req_extensions =3D v3_req # The extensions to add to a certificate reque=
st
+
+[ req_distinguished_name ]
+countryName			=3D Country Name (2 letter code)
+countryName_default		=3D AU
+countryName_min			=3D 2
+countryName_max			=3D 2
+
+stateOrProvinceName		=3D State or Province Name (full name)
+stateOrProvinceName_default	=3D Some-State
+
+localityName			=3D Locality Name (eg, city)
+
+0.organizationName		=3D Organization Name (eg, company)
+0.organizationName_default	=3D Internet Widgits Pty Ltd
+
+# we can do this but it is not needed normally :-)
+#1.organizationName		=3D Second Organization Name (eg, company)
+#1.organizationName_default	=3D World Wide Web Pty Ltd
+
+organizationalUnitName		=3D Organizational Unit Name (eg, section)
+#organizationalUnitName_default	=3D
+
+commonName			=3D Common Name (eg, YOUR name)
+commonName_max			=3D 64
+
+emailAddress			=3D Email Address
+emailAddress_max		=3D 64
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
+nsComment			=3D "OpenSSL Generated Certificate"
+
+# PKIX recommendations harmless if included in all certificates.
+subjectKeyIdentifier=3Dhash
+authorityKeyIdentifier=3Dkeyid,issuer
+
+# This stuff is for subjectAltName and issuerAltname.
+# Import the email address.
+# subjectAltName=3Demail:copy
+# An alternative to produce certificates that aren't
+# deprecated according to PKIX.
+# subjectAltName=3Demail:move
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
+# This is required for TSA certificates.
+# extendedKeyUsage =3D critical,timeStamping
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
+authorityKeyIdentifier=3Dkeyid:always,issuer
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
+authorityKeyIdentifier=3Dkeyid:always
+
+[ proxy_cert_ext ]
+# These extensions should be added when creating a proxy certificate
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
+nsComment			=3D "OpenSSL Generated Certificate"
+
+# PKIX recommendations harmless if included in all certificates.
+subjectKeyIdentifier=3Dhash
+authorityKeyIdentifier=3Dkeyid,issuer
+
+# This stuff is for subjectAltName and issuerAltname.
+# Import the email address.
+# subjectAltName=3Demail:copy
+# An alternative to produce certificates that aren't
+# deprecated according to PKIX.
+# subjectAltName=3Demail:move
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
+# This really needs to be in place for it to be a proxy certificate.
+proxyCertInfo=3Dcritical,language:id-ppl-anyLanguage,pathlen:3,policy:foo
+
+####################################################################
+[ tsa ]
+
+default_tsa =3D tsa_config1	# the default TSA section
+
+[ tsa_config1 ]
+
+# These are used by the TSA reply generation only.
+dir		=3D ./demoCA		# TSA root directory
+serial		=3D $dir/tsaserial	# The current serial number (mandatory)
+crypto_device	=3D builtin		# OpenSSL engine to use for signing
+signer_cert	=3D $dir/tsacert.pem 	# The TSA signing certificate
+					# (optional)
+certs		=3D $dir/cacert.pem	# Certificate chain to include in reply
+					# (optional)
+signer_key	=3D $dir/private/tsakey.pem # The TSA private key (optional)
+
+default_policy	=3D tsa_policy1		# Policy if request did not specify it
+					# (optional)
+other_policies	=3D tsa_policy2, tsa_policy3	# acceptable policies (optiona=
l)
+digests		=3D md5, sha1		# Acceptable message digests (mandatory)
+accuracy	=3D secs:1, millisecs:500, microsecs:100	# (optional)
+clock_precision_digits  =3D 0	# number of digits after dot. (optional)
+ordering		=3D yes	# Is ordering defined for timestamps?
+				# (optional, default: no)
+tsa_name		=3D yes	# Must the TSA name be included in the reply?
+				# (optional, default: no)
+ess_cert_id_chain	=3D no	# Must the ESS cert id chain be included?
+				# (optional, default: no)
--=20
1.7.4.1


