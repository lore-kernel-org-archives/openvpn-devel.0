Message-ID: <4C9BC064.9030201@...1147...>
Date: Thu, 23 Sep 2010 23:02:28 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4BF14A59.2000200@...1369...>	<4C0E6EAB.3040304@...1369...>	<4C0F3F06.2030004@...1114...>	<4C0F4620.7030100@...1369...>	<4C0F89D5.6040603@...1147...>
	<4C100DF0.2050804@...1378...>	<4C1016CB.3010701@...1114...>
	<4C101F11.9010502@...1369...>
	<4C74C387.2090609@...1369...>
	<4C74D953.3060503@...1147...>
	<4C9B3284.7030303@...1369...>
In-Reply-To: <4C9B3284.7030303@...1369...>
Subject: Re: [Openvpn-devel] openvpn-2.1.0-r1: easy-rsa tools creates broken
 client CERTs unusable for TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Martin Mokrejs <mmokrejs@...1369...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Martin,

Martin Mokrejs wrote:
> Hi Jan,
>   I am sorry for the long delay, I was away some days and then just overloaded
> by other duties. I have increased the verbosity on both client and server.
> I see some weird IP address on the server in the log: 94.112.118.14 is not
> my physical eth0 IP address nor the virtual network to be created by openvpn.
> I trimmed down both logs as the information in these is repeated every few
> lines.
>   

the client log suggests that you've installed the client cert 
(client.crt) on the server ...
I've compared the output of your openssl x509 command with the one on my 
box and there's only 2 line of difference:

13,14c13,14
<             RSA Public Key: (1024 bit)
<                 Modulus (1024 bit):
---
 >                 Public-Key: (1024 bit)
 >                 Modulus:


I would not worry about those.
Can you try running a few more openssl commands:

 > openssl verify -CAfile test-ca.crt -purpose sslclient client.crt
client.crt: OK

 > openssl verify -CAfile test-ca.crt -purpose sslserver client.crt
client.crt: /C=NL/O=Test/CN=glaurung/emailAddress=janjust@...1147...
error 26 at 0 depth lookup:unsupported certificate purpose
OK

 > openssl verify -CAfile test-ca.crt -purpose sslserver server.crt
server.crt: OK

 > openssl verify -CAfile test-ca.crt -purpose sslclient server.crt
server.crt: /C=NL/O=Test/CN=kudde/emailAddress=janjust@...1147...
error 26 at 0 depth lookup:unsupported certificate purpose
OK

the client cert should match only the purpose 'sslclient' and the server 
cert (from the keys.tar.gz file I emailed you) should only match the 
purpose 'sslserver'. If you get the same output as I do then you should 
take another hard look at your client and server keys.
The client log lines

Sep 23 12:26:07 vrapenec openvpn[2864]: Incoming Ciphertext -> TLS
Sep 23 12:26:07 vrapenec openvpn[2864]: VERIFY ERROR: depth=0, 
error=unable to get local issuer certificate: 
/C=NL/O=Test/CN=glaurung/emailAddress=janjust@...1147...
Sep 23 12:26:07 vrapenec openvpn[2864]: SSL alert (write): fatal: unknown CA
Sep 23 12:26:07 vrapenec openvpn[2864]: TLS_ERROR: BIO read 
tls_read_plaintext error: error:14090086:SSL 
routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed   

suggest that you've not installed the right ca.crt (test-ca.crt from 
keys.tar.gz)

HTH,

JJK


> Here are the configs on the client:
>
> # grep -v "^#" ../iresite.conf
> cd /etc/openvpn/iresite
> config mmokrejs.conf
> # grep -v "^#" mmokrejs.conf
> client
> dev tun
> proto udp
> remote 195.113.57.32 1194
> resolv-retry infinite
> nobind
> user nobody
> group nobody
> persist-key
> persist-tun
> mute-replay-warnings
> ca keys/ca.crt
> cert keys/client.crt  # broken due to bug in openssl or easy-rsa? 
> key keys/client.key
> remote-cert-tls server
> tls-auth keys/ta.key 0
> cipher BF-CBC        # Blowfish (default)
> comp-lzo
> verb 9
> #
>
> Jan Just Keijser wrote:
>   
>> Hi Martin,
>>
>> the '0' and '1' are direction parameters for the ta.key file. I actually
>> made a mistake when I posted
>>  ta.key 0
>> for both client and server - that will never work. Either omit the
>> parameter or use 0 on the server and 1 on the client.
>>
>> For the error that you are seeing the ta.key file is irrelevant,
>> however. You can verify this by removing the 'tls-auth' line. You should
>> still get the exact same error.
>>     
>
> Yes, removal of the tls-auth line doe snot help with your, "broken" keys.
> ;-)
>
>   
>> Can you increase the verbosity on the server when connecting? It's the
>>
>> VERIFY ERROR: depth=0, error=unsupported certificate purpose:
>> /C=NL/O=Test/CN=glaurung/emailAddress=janjust@...1396...
>>
>> error which is troubling: it could be that Gentoo did something to the
>> openssl libs to cause this. Also, what happens if you type
>>
>> openssl x509 -text -noout -in client.crt
>>
>> and look for the X509v3 extensions? The certificate purposes should be
>> listed. If I do this with the client.crt file I sent you I get
>>
>>        X509v3 extensions:
>>            X509v3 Basic Constraints:
>>                CA:FALSE
>>            Netscape Comment:
>>                Easy-RSA Generated Certificate
>>            X509v3 Subject Key Identifier:
>>                96:58:6A:E5:E0:D5:70:3C:A5:4D:67:08:40:33:45:E6:E4:44:79:EF
>>            X509v3 Authority Key Identifier:
>>               
>> keyid:E2:52:EE:0F:91:54:A4:7A:FB:2E:45:A8:9A:13:16:EE:FA:20:21:F8
>>                DirName:/C=NL/O=Test/CN=Test CA/xxxxxxx
>>                serial:DF:DD:C7:62:11:B9:F9:58
>>
>>            X509v3 Extended Key Usage:
>>                TLS Web Client Authentication
>>            X509v3 Key Usage:
>>                Digital Signature
>>
>> does the gentoo openssl command report something different?
>>     
>
> It is different:
>
> # openssl x509 -text -noout -in keys/client.crt
> Certificate:
>     Data:
>         Version: 3 (0x2)
>         Serial Number: 2 (0x2)
>         Signature Algorithm: sha1WithRSAEncryption
>         Issuer: C=NL, O=Test, CN=Test CA/name=Jan Just/emailAddress=janjust@...1147...
>         Validity
>             Not Before: Jun  9 08:31:05 2010 GMT
>             Not After : Jun  6 08:31:05 2020 GMT
>         Subject: C=NL, O=Test, CN=glaurung/emailAddress=janjust@...1147...
>         Subject Public Key Info:
>             Public Key Algorithm: rsaEncryption
>                 Public-Key: (1024 bit)
>                 Modulus:
>                     00:a4:c2:d6:ee:5f:e9:75:5b:b0:ca:67:40:14:e5:
>                     5c:24:42:04:ab:b0:de:3d:48:16:11:20:68:ff:6a:
>                     47:18:7b:2e:14:f8:55:ee:1a:d7:5e:9f:cc:17:58:
>                     89:c2:e3:c2:56:8c:23:6d:fb:64:20:50:c7:dd:f4:
>                     ec:f9:b4:94:07:f3:9e:97:a1:74:f4:b5:d7:4c:27:
>                     b6:ea:de:ea:e9:ce:7b:f2:20:10:2b:47:a3:35:f1:
>                     25:6a:23:04:4d:bb:41:1d:f7:be:71:80:27:c8:76:
>                     12:b6:c5:e8:f0:eb:a4:5e:e8:b2:64:7b:e7:ad:27:
>                     59:18:8e:54:18:2c:2e:11:61
>                 Exponent: 65537 (0x10001)
>         X509v3 extensions:
>             X509v3 Basic Constraints: 
>                 CA:FALSE
>             Netscape Comment: 
>                 Easy-RSA Generated Certificate
>             X509v3 Subject Key Identifier: 
>                 96:58:6A:E5:E0:D5:70:3C:A5:4D:67:08:40:33:45:E6:E4:44:79:EF
>             X509v3 Authority Key Identifier: 
>                 keyid:E2:52:EE:0F:91:54:A4:7A:FB:2E:45:A8:9A:13:16:EE:FA:20:21:F8
>                 DirName:/C=NL/O=Test/CN=Test CA/name=Jan Just/emailAddress=janjust@...1147...
>                 serial:DF:DD:C7:62:11:B9:F9:58
>
>             X509v3 Extended Key Usage: 
>                 TLS Web Client Authentication
>             X509v3 Key Usage: 
>                 Digital Signature
>     Signature Algorithm: sha1WithRSAEncryption
>         9a:a5:fe:67:3c:ac:b6:be:2a:11:83:51:53:f7:19:9d:18:bd:
>         bc:92:93:1a:60:39:41:db:84:6b:d4:39:a9:8d:92:9b:c8:57:
>         20:f1:9f:72:48:3d:7d:83:dc:00:ef:ce:97:02:d3:de:11:09:
>         28:be:05:dd:7b:31:bf:c0:de:f3:55:9c:93:ae:37:91:06:27:
>         c5:6d:8b:0c:f2:d2:15:e5:a1:61:b3:65:ad:c4:46:bc:8c:3a:
>         2c:38:4a:a5:27:3e:e6:11:f5:03:ad:22:7b:ca:50:dc:4d:1a:
>         d8:92:1e:44:c4:55:b6:cd:b8:92:a8:c0:ea:3b:62:4b:26:a1:
>         11:bf
> #
>
>
>
> Regrads,
> Martin
>
>
>   
>> HTH,
>>
>> JJK
>>
>> Martin Mokrejs wrote:
>>     
>>> Hi,
>>>   I am re-sending my answer from June 22 to this thread:
>>> http://thread.gmane.org/gmane.network.openvpn.devel/3703
>>> It must have somehow fallen deeply in your email boxes. ;-) The text
>>> below show that the two certificates Jan
>>> Just Keijser generated the days before could not be used on my Gentoo
>>> box. Clearly, the problem is with Gentoo
>>> install/my binaries and has nothing to do with the key and certificate
>>> creation.
>>> Thanks,
>>> Martin
>>>
>>> --------------
>>> Hi everybody,
>>>   so I tested the keys which Jan generated and did reproduce the
>>> problem again
>>> on my Gentoo Linux build. It is related to the fact that I had on client:
>>>
>>> tls-auth /home/janjust/rsa-test/ta.key 1
>>>
>>> while on the server
>>>
>>> tls-auth /home/janjust/rsa-test/ta.key 0
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: OpenVPN 2.1.0
>>> i686-pc-linux-gnu [SSL] [LZO2] [EPOLL] built on May 17 2010
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: NOTE: OpenVPN 2.1 requires
>>> '--script-security 2' or higher to call user-defined scripts or
>>> executables
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: Control Channel
>>> Authentication: using 'keys/ta.key' as a OpenVPN static key file
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: Outgoing Control Channel
>>> Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: Incoming Control Channel
>>> Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: LZO compression initialized
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: Control Channel MTU parms [
>>> L:1542 D:166 EF:66 EB:0 ET:0 EL:0 ]
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: Data Channel MTU parms [
>>> L:1542 D:1450 EF:42 EB:135 ET:0 EL:0 AF:3/1 ]
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: Local Options hash (VER=V4):
>>> '504e774e'
>>> Jun 22 23:24:18 vrapenec openvpn[21646]: Expected Remote Options hash
>>> (VER=V4): '14168603'
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: NOTE: UID/GID downgrade will
>>> be delayed because of --client, --pull, or --up-delay
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: Socket Buffers:
>>> R=[108544->131072] S=[108544->131072]
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: UDPv4 link local: [undef]
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: UDPv4 link remote:
>>> XXX.XXX.XXX.XXX:1194
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: TLS: Initial packet from
>>> XXX.XXX.XXX.XXX:1194, sid=2f11657e e78d6a4f
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: VERIFY ERROR: depth=0,
>>> error=unsupported certificate purpose:
>>> /C=NL/O=Test/CN=glaurung/emailAddress=janjust@...1396...
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: TLS_ERROR: BIO read
>>> tls_read_plaintext error: error:14090086:SSL
>>> routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: TLS Error: TLS object ->
>>> incoming plaintext read error
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: TLS Error: TLS handshake failed
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: TCP/UDP: Closing socket
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: SIGUSR1[soft,tls-error]
>>> received, process restarting
>>> Jun 22 23:24:18 vrapenec openvpn[21647]: Restart pause, 2 second(s)
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: NOTE: OpenVPN 2.1 requires
>>> '--script-security 2' or higher to call user-defined scripts or
>>> executables
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: Re-using SSL/TLS context
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: LZO compression initialized
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: Control Channel MTU parms [
>>> L:1542 D:166 EF:66 EB:0 ET:0 EL:0 ]
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: Data Channel MTU parms [
>>> L:1542 D:1450 EF:42 EB:135 ET:0 EL:0 AF:3/1 ]
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: Local Options hash (VER=V4):
>>> '504e774e'
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: Expected Remote Options hash
>>> (VER=V4): '14168603'
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: Socket Buffers:
>>> R=[108544->131072] S=[108544->131072]
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: UDPv4 link local: [undef]
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: UDPv4 link remote:
>>> XXX.XXX.XXX.XXX:1194
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: TLS: Initial packet from
>>> XXX.XXX.XXX.XXX:1194, sid=350eb404 4c110b32
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: VERIFY ERROR: depth=0,
>>> error=unsupported certificate purpose:
>>> /C=NL/O=Test/CN=glaurung/emailAddress=janjust@...1396...
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: TLS_ERROR: BIO read
>>> tls_read_plaintext error: error:14090086:SSL
>>> routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: TLS Error: TLS object ->
>>> incoming plaintext read error
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: TLS Error: TLS handshake failed
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: TCP/UDP: Closing socket
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: SIGUSR1[soft,tls-error]
>>> received, process restarting
>>> Jun 22 23:24:20 vrapenec openvpn[21647]: Restart pause, 2 second(s)
>>>
>>>
>>> It is unclear to me according to the comments in the client.conf file
>>> what is
>>> the number after "ta.key" doing (some version number?) and at the
>>> moment am not
>>> looking it up in the docs. ;)
>>>
>>>
>>>
>>>
>>>
>>>
>>> If I set the number on client also to "0" (like on the server) I get:
>>>
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: OpenVPN 2.1.0
>>> i686-pc-linux-gnu [SSL] [LZO2] [EPOLL] built on May 17 2010
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: NOTE: OpenVPN 2.1 requires
>>> '--script-security 2' or higher to call user-defined scripts or
>>> executables
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: Control Channel
>>> Authentication: using 'keys/ta.key' as a OpenVPN static key file
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: Outgoing Control Channel
>>> Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: Incoming Control Channel
>>> Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: LZO compression initialized
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: Control Channel MTU parms [
>>> L:1542 D:166 EF:66 EB:0 ET:0 EL:0 ]
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: Data Channel MTU parms [
>>> L:1542 D:1450 EF:42 EB:135 ET:0 EL:0 AF:3/1 ]
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: Local Options hash (VER=V4):
>>> '79fd358d'
>>> Jun 22 23:19:25 vrapenec openvpn[21597]: Expected Remote Options hash
>>> (VER=V4): 'd81d562e'
>>> Jun 22 23:19:25 vrapenec openvpn[21598]: NOTE: UID/GID downgrade will
>>> be delayed because of --client, --pull, or --up-delay
>>> Jun 22 23:19:25 vrapenec openvpn[21598]: Socket Buffers:
>>> R=[108544->131072] S=[108544->131072]
>>> Jun 22 23:19:25 vrapenec openvpn[21598]: UDPv4 link local: [undef]
>>> Jun 22 23:19:25 vrapenec openvpn[21598]: UDPv4 link remote:
>>> XXX.XXX.XXX.XXX:1194
>>>
>>>
>>> but no VPN is started (note the "undef" value, and can confirm that with
>>> ifconfig -a):
>>>
>>> tunl0     Link encap:IPIP Tunnel  HWaddr             NOARP  MTU:1480 
>>> Metric:1
>>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>           collisions:0 txqueuelen:0           RX bytes:0 (0.0 B)  TX
>>> bytes:0 (0.0 B)
>>>
>>>
>>> Hope this helps,
>>> Martin
>>>
>>>
>>>  
>>>       
>>>> janjust@...1396... wrote:
>>>> attached are the certs I generated yesterday. The server and client
>>>> configuration I used were very minimal:
>>>>
>>>> server.conf:
>>>>
>>>> tls-server
>>>> proto udp
>>>> port 1194
>>>> dev tun
>>>> server 192.168.200.0 255.255.248.0
>>>> ca       /home/janjust/rsa-test/test-ca.crt
>>>> cert     /home/janjust/rsa-test/server.crt
>>>> key      /home/janjust/rsa-test/server.key
>>>> dh       /home/janjust/rsa-test/dh1024.pem
>>>> tls-auth /home/janjust/rsa-test/ta.key 0
>>>> persist-key
>>>> persist-tun
>>>> keepalive 10 60
>>>> remote-cert-tls client
>>>>
>>>> client.conf:
>>>>
>>>> client
>>>> proto udp
>>>> remote openvpnserver
>>>> port 1194
>>>> dev tun
>>>> nobind
>>>> ca       /home/janjust/rsa-test/test-ca.crt
>>>> cert     /home/janjust/rsa-test/client.crt
>>>> key      /home/janjust/rsa-test/client.key
>>>> tls-auth /home/janjust/rsa-test/ta.key 0
>>>> remote-cert-tls server
>>>>     
>>>>         
>>>
>>> Martin Mokrejs wrote:
>>>  
>>>       
>>>> David Sommerseth wrote:
>>>>    
>>>>         
>>>>> On 09/06/10 23:56, Martin MOKREJ` wrote:
>>>>>      
>>>>>           
>>>>>>   The patches in Gentoo I for example here:
>>>>>>         
>>>>>>             
>>>> I use Gentoo, I believed that was a "typo" of Jan and did not comment
>>>> on that.
>>>>
>>>>
>>>>    
>>>>         
>>>>>> Please improve the openVPN docs. Further, isn't it possible to
>>>>>> provide two openssl.cf files, one for client and the other for
>>>>>> server, and fill-in more default values. I never know where to place
>>>>>> FQDN, where to place "server", "client", and you saw in my proposed
>>>>>> patch that I had to invent even more.
>>>>>>         
>>>>>>             
>>>>> The documentation needs to be reviewed, to be sure it does provide
>>>>> accurate information.  Having that said, it doesn't seem to be that
>>>>> many
>>>>> who struggles with this on the ##openvpn IRC channel.  I admit I've not
>>>>> paid too much attention to the discussions there the last few weeks,
>>>>> but
>>>>> this (VERIFY KU ERROR) is not on the "top 10" trouble list, afaik.
>>>>>       
>>>>>           
>>>> I believe it is an issue. I posted how I generated the certificates and
>>>> expect that somebody would have already told me I did answer the
>>>> questionaree
>>>> in a wrong way. For sure, the shell scripts can run something like
>>>> "openssl x509 -in cert.crt -text" and verify that the certificate will
>>>> be usable for client or server only. The user would not have to
>>>> transfer it
>>>> to the server to realize it is going to refuse it.
>>>> Here you can see how I generated the certificates:
>>>> http://rt.openssl.org/Ticket/Display.html?id=2268&user=guest&pass=guest
>>>> It's too late here but I think instead of teh word "client" I used word
>>>> "server". But, if the server key/cert cannot be created by the build-ca
>>>> script or sign-req, then we found why I maybe had to tweak the
>>>> openssl.cf
>>>> file. ;-)
>>>>
>>>> My apologies if I followed a wrong manual, I think I followed some on
>>>> your
>>>> site but anyway, I am sure you you check more thoroughly what I did and
>>>> make the scripts more fool-proof.
>>>>
>>>> Once I get physically to an old Sun Solaris 2.6 machine I will turn
>>>> it on
>>>> and check that they run smoothly with those "remove bashism" patches.
>>>> ;-)
>>>> In 2-3 weeks.
>>>>
>>>>
>>>>    
>>>>         
>>>>> But on the other hand, most easy-rsa users do also make use of the
>>>>> ./build-key-server and ./build-key{,-pass,-pkcs12} scripts.  It
>>>>> might be
>>>>> an issue related to ./sign-req.
>>>>>
>>>>> I strongly do not recommend having more openssl.cnf files.  It is
>>>>> possible to use one file, which makes the maintenance easier in the
>>>>> long
>>>>> run.  The ./pkitool script should take care of providing the needed
>>>>> "tweaks" to separate between client and server certificates.
>>>>>       
>>>>>           
>>>> BTW, what I do not like that I have to have write perms into
>>>> /some/blah/openvpn/easy-rsa/. It is counterintuitive to have to do as
>>>> root:
>>>>
>>>> # cd /some/blah/openvpn/easy-rsa/
>>>> # ./build-ca
>>>>
>>>> I believe the scripts can be called from any cwd() and the keys/ subdirs
>>>> can be made in there. Sure, I have no problem doing
>>>> ". /some/blah/openvpn/easy-rsa/openssl.cf" before executing
>>>> /some/blah/openvpn/easy-rsa/build-ca. ;-) Just some clues.
>>>>
>>>>    
>>>>         
>>>>> For a similar script based version which might work better, take a look
>>>>> at ssl-admin
>>>>> <http://www.secure-computing.net/wiki/index.php/Ssl-admin>.
>>>>>       
>>>>>           
>>>> Will look later, thanks.
>>>>
>>>>    
>>>>         
>>>>> I also noticed that Ubuntu was mentioned in the thread.  It might
>>>>> not be
>>>>> directly related, but if you have an Ubuntu OpenVPN 2.1_rc7 - rc11
>>>>> installation in use, beware that these versions do have some patches
>>>>> which makes it incompatible with other versions.  And the failure in
>>>>> this case is not obvious.  So, if possible, upgrade to OpenVPN
>>>>> 2.1.0/2.1.1 on client and server.
>>>>>       
>>>>>           
>>>> No, as I posted, the only patches applied on my setup were those two,
>>>> and the contents of the whole files/ subdir you have just inspected
>>>> through some Gentoo mirror.
>>>>
>>>> Time for sleep here, ;-)
>>>> Martin
>>>>     
>>>>         
>>
>>     


