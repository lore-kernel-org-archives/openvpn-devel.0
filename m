References: <20210422151724.2132573-1-arne@...1227...>
 <20210506141259.309741-1-arne@...1227...>
 <2eba0560-91a5-f44a-755b-797ada0043ee@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a1222456-b443-4958-8313-ee90222be0f7@...1227...>
Date: Fri, 7 May 2021 15:03:36 +0200
MIME-Version: 1.0
In-Reply-To: <2eba0560-91a5-f44a-755b-797ada0043ee@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3] Return cached result in
 tls_authentication_status
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 06.05.21 um 23:49 schrieb Antonio Quartulli:
> Hi Arne,
> 
> after our discussion on IRC I understood you expected this patch to not
> change the server behaviour.
> 
> If something is suboptimal, it means it was suboptimal also before this
> patch.
> 
> However, with your patch I can clearly see a longer delay in returning
> the AUTH result to the client, in case of deferred auth.
> 
> Without your patch (initial lines are the output of my auth-verify script):
> 
> PASS=testno
> FILE=/tmp/openvpn_acf_662a1165ab3293aa3fb053050e1c2463.tmp
> FAIL
> 2021-05-06 23:40:28 10.10.10.2:1194 TLS: Username/Password
> authentication deferred for username 'test'
> 2021-05-06 23:40:28 10.10.10.2:1194 Control Channel: TLSv1.3, cipher
> TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 bit EC, curve
> secp384r1, signature: ecdsa-with-SHA256
> 2021-05-06 23:40:28 10.10.10.2:1194 [client] Peer Connection Initiated
> with [AF_INET6]::ffff:10.10.10.2:1194
> 2021-05-06 23:40:29 10.10.10.2:1194 PUSH: Received control message:
> 'PUSH_REQUEST'
> 2021-05-06 23:40:29 10.10.10.2:1194 Delayed exit in 5 seconds
> 2021-05-06 23:40:29 10.10.10.2:1194 SENT CONTROL [client]: 'AUTH_FAILED'
> (status=1)
> 
> My script uses the deferred logic, but it is super fast (as you can see
> it fails before the server can even do anything else).
> 
> Later, as soon as the first PUSH_REQUEST is received, the server replies
> immediately with an AUTH_FAILED.
> 
> 
> With your patch (script and everything else stays the same):
> 
> PASS=testno
> FILE=/tmp/openvpn_acf_4cdab09a9640e8eb4cacadfc1734bb2c.tmp
> FAIL
> 2021-05-06 23:45:22 10.10.10.2:1194 TLS: Username/Password
> authentication deferred for username 'test'
> 2021-05-06 23:45:22 10.10.10.2:1194 Control Channel: TLSv1.3, cipher
> TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 bit EC, curve
> secp384r1, signature: ecdsa-with-SHA256
> 2021-05-06 23:45:22 10.10.10.2:1194 [client] Peer Connection Initiated
> with [AF_INET6]::ffff:10.10.10.2:1194
> 2021-05-06 23:45:23 10.10.10.2:1194 PUSH: Received control message:
> 'PUSH_REQUEST'
> 2021-05-06 23:45:28 10.10.10.2:1194 PUSH: Received control message:
> 'PUSH_REQUEST'
> 2021-05-06 23:45:33 10.10.10.2:1194 Delayed exit in 5 seconds
> 2021-05-06 23:45:33 10.10.10.2:1194 SENT CONTROL [client]: 'AUTH_FAILED'
> (status=1)
> 
> As you can see the script does the deferred auth immediately, but the
> server send the AUTH_FAILED only after the PUSH_REQUEST being received
> *after some (10?) seconds since the failure of the script*.
> 
> To me this sounds like the server is caching the current status for some
> (10?) seconds and it is not updating it with the actual result.
> 
> However, this does not seem to happen without your patch as the server
> is probably forcing a reload of the result from file everytime a
> PUSH_REQUEST is received.
>

Yes it is that each PUSH_REQUEST forces a check on the deferred auth
files. The question is if we want to lower the interval to check to
avoid this long time. But then again on the other hand (at least this
specific instance) only affects AUTH_FAILED being delayed.

The other instance of non-caching lookup in the older code is in
multi_connection_established and this is a bit more tricky since it is
actually in the positive code path and is called through various code
paths.

In my own tests I had --enable-async-push which masks this by having
inotify pick this up.


I feel we should maybe lower the interval to something lower? Or
implement something like an exponential backoff like 0,0,1,2,5,10s?

Arne

