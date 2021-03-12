References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
 <50c23608-1b71-1651-fa4e-af0d39aba7b3@...2525...>
 <0f47e3c7-f9d2-1649-0fb7-b0b58fa4b84a@...1227...>
 <33d99bf3-96ae-4728-87b2-cc442aa611a4@...2525...>
 <2e1ae5d6-d7bf-9784-689a-b92f51204bda@...1227...>
 <a8c09fa3-8574-7659-5dd0-88321b3f1f12@...2525...>
 <dd3bcfb4-6201-fbbc-fe6d-d9270a04e54e@...2525...>
 <e8a89269-6147-3531-e270-62cc1e5ff10b@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <f35b0880-3fbb-6a6e-e051-147fbcbe2f11@...2525...>
Date: Fri, 12 Mar 2021 16:12:06 +0100
MIME-Version: 1.0
In-Reply-To: <e8a89269-6147-3531-e270-62cc1e5ff10b@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Arne,

I found that the connecting issue is that 
wolfSSL_CTX_set_min_proto_version will fail when the user (in this case 
OpenVPN) tries to set a protocol version that was not compiled in. I 
modified our configure.ac script when building for OpenVPN along with 
some additional fixes in this pull request: 
https://github.com/wolfSSL/wolfssl/pull/3871

I also found an error in one of OpenVPN's unit tests. I submitted a 
patch for that test in a separate email.

Sincerely
Juliusz

On 03/03/2021 13:34, Arne Schwabe wrote:
> Am 22.02.21 um 16:28 schrieb Juliusz Sosinowicz:
>> Hi Arne,
>>
>> have you had any success in compiling OpenVPN with wolfSSL?
>>
> Yes, sorry for taking so long. However the client does not work with my
> test config (those are on my mac):
>
> 2021-03-03 13:19:11 library versions: wolfSSL 4.7.1
> 2021-03-03 13:19:11 tls_ctx_set_tls_versions: failed to set minimum TLS
> version
> 2021-03-03 13:19:11 Error: private key password verification failed
> 2021-03-03 13:19:11 Exiting due to fatal error
>
> Note that this profile just has an inline <cert>, <key> and <ca> section.
>
> Another profile, just with <ca> and without certificates fails with:
>
> sudo ./src/openvpn/openvpn ~/dl/focal_generic.ovpn
> 2021-03-03 13:21:52 DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but
> missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN
> version will ignore --cipher for cipher negotiations. Add 'AES-256-CBC'
> to --data-ciphers or change --cipher 'AES-256-CBC' to
> --data-ciphers-fallback 'AES-256-CBC' to silence this warning.
> 2021-03-03 13:21:52 OpenVPN 2.6_git
> [git:review/wolfsll/5594040c534f20e3+] x86_64-apple-darwin20.3.0 [SSL
> (OpenSSL)] [LZ4] [MH/RECVDA] [AEAD] built on Mar  3 2021
> 2021-03-03 13:21:52 library versions: wolfSSL 4.7.1
> Enter Auth Username:arne
> Enter Auth Password:
> 2021-03-03 13:21:58 Cannot load CA certificate file [[INLINE]] (no
> entries were read)
> 2021-03-03 13:21:58 Exiting due to fatal error
>
> To see if the problem is isolated to my macbook, I tried again on Ubuntu
> 20.10.
>
> % make check
> [...]
> If the addresses are in use, this test will retry up to two times.
> 2021-03-03 12:28:25 Cipher negotiation is disabled since neither P2MP
> client nor server mode is enabled
> 2021-03-03 12:28:25 WARNING: file 'sample-keys/server.key' is group or
> others accessible
> 2021-03-03 12:28:25 WARNING: file 'sample-keys/ta.key' is group or
> others accessible
> 2021-03-03 12:28:25 OpenVPN 2.6_git
> [git:review/wolfsll/5594040c534f20e3+] x86_64-pc-linux-gnu [SSL
> (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Mar  3 2021
> 2021-03-03 12:28:25 library versions: wolfSSL 4.7.1, LZO 2.10
> 2021-03-03 12:28:25 net_route_v4_best_gw query: dst 0.0.0.0
> 2021-03-03 12:28:25 net_route_v4_best_gw result: via 192.168.188.1 dev eth0
> 2021-03-03 12:28:25 NOTE: the current --script-security setting may
> allow this configuration to call user-defined scripts
> 2021-03-03 12:28:25 Cipher negotiation is disabled since neither P2MP
> client nor server mode is enabled
> 2021-03-03 12:28:25 OpenVPN 2.6_git
> [git:review/wolfsll/5594040c534f20e3+] x86_64-pc-linux-gnu [SSL
> (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Mar  3 2021
> 2021-03-03 12:28:25 library versions: wolfSSL 4.7.1, LZO 2.10
> 2021-03-03 12:28:25 NOTE: the current --script-security setting may
> allow this configuration to call user-defined scripts
> 2021-03-03 12:28:25 tls_ctx_set_tls_versions: failed to set minimum TLS
> version
> 2021-03-03 12:28:25 Error: private key password verification failed
> 2021-03-03 12:28:25 Exiting due to fatal error
> FAIL: t_cltsrv.sh
> Test 0: OK
> Test 1: OK
> Test 2: OK
> Test 3: OK
> Test 4: OK
> Test 5: OK
> Test 6: OK
> Test 7: OK
> PASS: t_net.sh
> ====================================================
> 1 of 3 tests failed
> (1 test was not run)
> Please report to openvpn-users@lists.sourceforge.net
> ====================================================
>
> Same result for the configs. I tested a config with an not inlined file
> then:
>
> [12:32]arne@...2599...:~% ./wolfo2build/./src/openvpn/openvpn
> focal_generic.ovpn
> 2021-03-03 12:32:54 DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but
> missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN
> version will ignore --cipher for cipher negotiations. Add 'AES-256-CBC'
> to --data-ciphers or change --cipher 'AES-256-CBC' to
> --data-ciphers-fallback 'AES-256-CBC' to silence this warning.
> 2021-03-03 12:32:54 OpenVPN 2.6_git
> [git:review/wolfsll/5594040c534f20e3+] x86_64-pc-linux-gnu [SSL
> (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Mar  3 2021
> 2021-03-03 12:32:54 library versions: wolfSSL 4.7.1, LZO 2.10
> Enter Auth Username:j
> Enter Auth Password:
> 2021-03-03 12:32:56 Cannot load CA certificate file focal-ca.pem (no
> entries were read)
> 2021-03-03 12:32:56 Exiting due to fatal error
> [12:32]{1}arne@...2599...:~% openssl x509 -in focal-ca.pem
> -----BEGIN CERTIFICATE-----
> MIHzMIGmoAMCAQICAgDrMAUGAytlcDASMRAwDgYDVQQDDAdlZDI1IENBMB4XDTIx
> MDEwNzE3MjQxNloXDTMxMDEwNjE3MjQxNlowEjEQMA4GA1UEAwwHZWQyNSBDQTAq
> MAUGAytlcAMhAFP90d3bP9Bk49MFBtQEXqtdvGlymOped9L+X17paUfAoyAwHjAP
> BgNVHRMBAf8EBTADAQH/MAsGA1UdDwQEAwIBBjAFBgMrZXADQQDbdEko8+2dsfgb
> NSejIFv3JRw7FymlIH6dBnH9kN4qCkcm1/avhErxURGUJgounEn4UZtK5w1u+Wf8
> y6/RvusO
> -----END CERTIFICATE-----
>
>
> And that also fails.
>
> So it compiles now but in the past it got to a point that it connected
> and worked.
>
> Arne

