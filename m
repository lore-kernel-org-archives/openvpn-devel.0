Message-ID: <4319D72B.30101@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn and smartcards
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Sep  3 13:29:03 2005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I've seen some corresponding regarding this issue... But could 
not understand the formal position of the development team.

It seems that currently openvpn does not support smartcards.

I've noticed that a patch is available from Fritz Elfert that 
enables the use of openvpn and opensc smartcards.
http://openvpn.net/archive/openvpn-devel/2005-02/msg00000.html

I could not find any roadmap or document that describes future 
intension of adding smartcard support for openvpn.

The usage of smartcard is very important since  the inability 
to duplicate them and the fact that they are locked after X 
failed attempt to access them, makes them idle for identification.

Although the in the past opensc (www.opensc.com) tried to 
suggest a standard API to access smartcards, the most commonly 
adopted and supported is PKCS#11.

PKCS#11 is a high-level API specification that allows a 
software to access objects on cryptographic token and perform 
cryptographic operation using none extractable keys located 
on that token.
Usually, an application may extract X.509 certificates from 
the tokens and perform RSA operation using the private key on 
the token.
Most vendors provides a PKCS#11 library to be used by 
application to access their devices.
More information may be found at 
www.rsasecurity.com/rsalabs/pkcs/pkcs-11/index.html

Many applications are using PKCS#11, including Mozilla 
Firefox, Mozilla Thunderbird, Opera, Java and more...

PKCS#11 is also cross platform, so the same implementation can 
be run on Unix and Windows platform.

Currently, openvpn supports openssl engine for cipher operations.

There  is an opensc PKCS#11 engine for openssl, that can be 
loaded dynamically, for example:
$ openssl
OpenSSL> engine dynamic
-pre SO_PATH:/usr/lib/opensc/engine_pkcs11.so
-pre ID:pkcs11
-pre LIST_ADD:1
-pre LOAD
-pre MODULE_PATH:/usr/local/lib/XXX.so
(dynamic) Dynamic engine loading support
[Success]: SO_PATH:/usr/lib/opensc/engine_pkcs11.so
[Success]: ID:pkcs11
[Success]: LIST_ADD:1
[Success]: LOAD
[Success]: MODULE_PATH:/usr/local/lib/XXX.so
Loaded: (pkcs11) pkcs11 engine
OpenSSL>

The above adds a new engine for the openssl to use, the new 
engine is called pkcs11 and is using the /usr/local/lib/XXX.so 
PKCS#11 library that is provided by the cryptographic token 
provider, then a key can be accessed using fake file name in 
the form of slot_[#]-id_[#]

The engine approach can be used as a first simple stage of 
supporting keys that available on smartcards. the problem is 
that this engine cannot fetch X.509 certificate from the 
token, and cannot enum keys, as expected from PKI application.

For this steep, I guess a new configuration options should be 
added:
1. load-engine - load new engines getting all the arguments 
required.
2. tls-engine - a separate engine to be used during tls 
negotiations.

For the long term, directly supporting PKCS#11 API 
specification is the right way to go.

I will be happy to read any comments,
Best Regards,
Alon Bar-Lev.

