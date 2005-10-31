Subject: Re: [Openvpn-devel] [bug report] DOS: openvpn 2.0.2 segfaults on Solaris 9.
Mime-Version: 1.0 (Apple Message framework v552)
From: =?ISO-8859-1?Q?Marc_Br=FCnink?= <mbruen@...487...>
In-Reply-To: <436645A3.2050808@...411...>
Message-Id: <99F24BE0-4A32-11DA-9F53-000A959A666C@...487...>
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
Date: Mon Oct 31 09:21:36 2005
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Montag, Okt 31, 2005, at 17:26 Europe/Berlin, Giancarlo Razzolini=20
wrote:

> Marc Br=FCnink wrote:
>> Hi list,
>>
>> I'm posting this there in case someone already fixed it or is disposed
>> to fix it :-)
>> First of all: OpenVPN is great! Thanks for your work!.
>> Second of all: I've encounterd a reproducible bug :-(
>> I'm running
>> OpenVPN 2.0.2 sparc-sun-solaris2.9 [SSL] [LZO] built on Oct 17 2005
>> on a
>> SunOS sun 5.9 Generic_112233-12 sun4u sparc SUNW,Sun-Fire-V240
>> machine. OpenVPN is running in tcp server mode. Everything works=20
>> perfect
>> unless I do a portscan on this machine. Then OpenVPN simply segfaults.
>> I'm using
>> nmap -T Aggressive <ipaddress> -p 1194
>>
>>
>> Mon Oct 31 17:08:03 2005 us=3D485855 PO_WAIT[0,0] fd=3D3 rev=3D0x00000001
>> rwflags=3D0x0001 arg=3D0x00000001 [scalable]
>> Mon Oct 31 17:08:03 2005 us=3D485945 MULTI: REAP range 16 -> 32
>> Mon Oct 31 17:08:03 2005 us=3D485973 MULTI: multi_create_instance called
>> Mon Oct 31 17:08:03 2005 us=3D486033 PO_INIT maxevents=3D4=20
>> flags=3D0x00000002
>> Mon Oct 31 17:08:03 2005 us=3D486059 Re-using SSL/TLS context
>> Mon Oct 31 17:08:03 2005 us=3D486091 MTU DYNAMIC mtu=3D0, flags=3D1, 0 -=
>=20
>> 140
>> Mon Oct 31 17:08:03 2005 us=3D486108 TLS: tls_session_init: entry
>> Mon Oct 31 17:08:03 2005 us=3D486221 PID packet_id_init seq_backtrack=3D0
>> time_backtrack=3D0
>> Mon Oct 31 17:08:03 2005 us=3D486364 PID packet_id_init seq_backtrack=3D0
>> time_backtrack=3D0
>> Mon Oct 31 17:08:03 2005 us=3D486398 TLS: tls_session_init: new session
>> object, sid=3Dd9b0a377 97bb2ba0
>> Mon Oct 31 17:08:03 2005 us=3D486415 TLS: tls_session_init: entry
>> Mon Oct 31 17:08:03 2005 us=3D486437 PID packet_id_init seq_backtrack=3D0
>> time_backtrack=3D0
>> Mon Oct 31 17:08:03 2005 us=3D486503 PID packet_id_init seq_backtrack=3D0
>> time_backtrack=3D0
>> Mon Oct 31 17:08:03 2005 us=3D486530 TLS: tls_session_init: new session
>> object, sid=3De7b0b371 1f6a5f51
>> Mon Oct 31 17:08:03 2005 us=3D486558 Control Channel MTU parms [ L:1543
>> D:140 EF:40 EB:0 ET:0 EL:0 ]
>> Mon Oct 31 17:08:03 2005 us=3D486583 MTU DYNAMIC mtu=3D1450, flags=3D2, =
1543
>> -> 1450
>> Mon Oct 31 17:08:03 2005 us=3D486609 Data Channel MTU parms [ L:1543
>> D:1450 EF:43 EB:4 ET:0 EL:0 ]
>> Mon Oct 31 17:08:03 2005 us=3D486688 Local Options String: 'V4,dev-type
>> tun,link-mtu 1543,tun-mtu 1500,proto TCPv4_SERVER,cipher BF-CBC,auth
>> SHA1,keysize 128,key-method 2,tls-server'
>> Mon Oct 31 17:08:03 2005 us=3D486712 Expected Remote Options String:
>> 'V4,dev-type tun,link-mtu 1543,tun-mtu 1500,proto TCPv4_CLIENT,cipher
>> BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'
>> Mon Oct 31 17:08:03 2005 us=3D486775 Local Options hash (VER=3DV4):=20
>> '7e068940'
>> Mon Oct 31 17:08:03 2005 us=3D486809 Expected Remote Options hash
>> (VER=3DV4): 'db02a8f8'
>> Mon Oct 31 17:08:03 2005 us=3D486832 STREAM: RESET
>> Mon Oct 31 17:08:03 2005 us=3D486848 STREAM: INIT maxlen=3D1543
>> Mon Oct 31 17:08:03 2005 us=3D486932 TCP: accept(3) failed: Software
>> caused connection abort (errno=3D130)
>> Mon Oct 31 17:08:03 2005 us=3D486962 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487030 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487048 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487063 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487115 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487130 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487146 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487159 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487179 PID packet_id_free
>> Mon Oct 31 17:08:03 2005 us=3D487206 MULTI: multi_close_instance called
>>
>>
>> If you need further information or need someone to test code -> Drop=20
>> me
>> a line. I would love to see this bug fixed, because it's actually a
>> pretty easy DOS and prohibits the use of OpenVPN on a production=20
>> machine.
>>
>>
>> Many thanks
>> Marc
>>
>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by the JBoss Inc.
>> Get Certified Today * Register for a JBoss Training Course
>> Free Certification Exam for All Training Attendees Through End of 2005
>> Visit http://www.jboss.com/services/certification for more information
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
> One question:
>
> This happens if you are using the tls-auth directive?
>
> As far as i know, if you use the tls auth, the packet that the nmap=20
> tool
> generate, will be dropped, as it doesn't have the right hmac code. I
> think that using tls-auth can be a temporary workaround until that bug
> is fixed.


This didn't help a bit.
Anyway thanks for your fast reply.
Any other ideas?

Thanks
Marc


