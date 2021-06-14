From: Antonio Quartulli <a@...2181...>
Message-ID: <f40e6882-da83-ae0a-2230-ab1cbbe3d0c1@...2181...>
Date: Mon, 14 Jun 2021 02:24:21 +0200
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] TLS Error: local/remote TLS keys are out of sync
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hello,

when using the master branch I get the following output on the server
upon renegotiation, when using deferred auth:

2021-06-14 02:15:50 client/10.10.10.2:1194 TLS Error: local/remote TLS
keys are out of sync: [AF_INET6]::ffff:10.10.10.2:1194 (received key id:
6, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_DEFERRED id=6
sid=bbb535c3 f49bfb24] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=5
sid=bbb535c3 f49bfb24] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0
sid=00000000 00000000])
2021-06-14 02:15:51 client/10.10.10.2:1194 TLS Error: local/remote TLS
keys are out of sync: [AF_INET6]::ffff:10.10.10.2:1194 (received key id:
6, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_DEFERRED id=6
sid=bbb535c3 f49bfb24] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=5
sid=bbb535c3 f49bfb24] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0
sid=00000000 00000000])
2021-06-14 02:15:52 client/10.10.10.2:1194 TLS Error: local/remote TLS
keys are out of sync: [AF_INET6]::ffff:10.10.10.2:1194 (received key id:
6, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_DEFERRED id=6
sid=bbb535c3 f49bfb24] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=5
sid=bbb535c3 f49bfb24] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0
sid=00000000 00000000])
2021-06-14 02:15:53 client/10.10.10.2:1194 TLS Error: local/remote TLS
keys are out of sync: [AF_INET6]::ffff:10.10.10.2:1194 (received key id:
6, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_DEFERRED id=6
sid=bbb535c3 f49bfb24] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=5
sid=bbb535c3 f49bfb24] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0
sid=00000000 00000000])
2021-06-14 02:15:54 client/10.10.10.2:1194 TLS Error: local/remote TLS
keys are out of sync: [AF_INET6]::ffff:10.10.10.2:1194 (received key id:
6, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_DEFERRED id=6
sid=bbb535c3 f49bfb24] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=5
sid=bbb535c3 f49bfb24] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0
sid=00000000 00000000])
2021-06-14 02:15:55 client/10.10.10.2:1194 TLS Error: local/remote TLS
keys are out of sync: [AF_INET6]::ffff:10.10.10.2:1194 (received key id:
6, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_DEFERRED id=6
sid=bbb535c3 f49bfb24] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=5
sid=bbb535c3 f49bfb24] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0
sid=00000000 00000000])
2021-06-14 02:15:56 client/10.10.10.2:1194 TLS Error: local/remote TLS
keys are out of sync: [AF_INET6]::ffff:10.10.10.2:1194 (received key id:
6, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_DEFERRED id=6
sid=bbb535c3 f49bfb24] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=5
sid=bbb535c3 f49bfb24] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0
sid=00000000 00000000])


The situation gets fixed by itself in a bunch of seconds.
I wonder if this has anything to do with the cached auth not increasing
some state, while the key has been substituted.


It seems to be reproducible very easily.

@Arne, ideas?

I start the server this way:

${OVPN} \
	--server 10.10.0.0 255.255.255.0 \
	--dev tun \
	--cipher AES-256-GCM \
	--peer-fingerprint ${FP} \
	--cert ${CERT} --key ${KEY} \
	--verb 3 --dh none --auth-user-pass-verify auth.sh via-env
--script-security 3

and the client this way:

${OVPN} --dev tun --client --remote 10.10.10.1 \
	--cipher AES-256-GCM \
	--peer-fingerprint ${FP} \
	--cert ${CERT} --key ${KEY} --verb 3 --reneg-sec 20 --auth-user-pass

auth.sh is the following:

#!/bin/bash

echo PASS=$password
echo FILE=$auth_control_file
(
	sleep 5
	if [ "$password" = "testyes" ]; then
		echo SUCCESS
		if [ -n "$auth_control_file" ]; then
			echo 1 >$auth_control_file
		fi
		exit 0
	fi

	echo FAIL
	if [ -n "$auth_control_file" ]; then
		echo 0 >$auth_control_file
	fi
	exit 1
)&
exit 2


I use this test setup since a while and I did not get any error like
this in the past.

If nobody has any idea I can try to bisect and see when this started.

Regards,


-- 
Antonio Quartulli

