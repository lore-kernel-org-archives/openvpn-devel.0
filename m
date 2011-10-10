Message-ID: <4E92967E.3030206@...1147...>
Date: Mon, 10 Oct 2011 08:53:50 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <056601cc852b$1637b7e0$42a727a0$@net>
In-Reply-To: <056601cc852b$1637b7e0$42a727a0$@net>
Subject: Re: [Openvpn-devel] Fatal Error on XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Richard Francis <rfransix@...164...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

the log line
"VERIFY ERROR: depth=1, error=self signed certificate in certificate 
chain: 
/C=US/ST=NewYork/L=minerals/O=certify.com/OU=R_D/CN=certify/emailAddress=certify@...1513..."

shows that the client does not trust the server certificate, or the CA 
certificate that signed the server certificate; verify that you have 
loaded the right 'ca.crt' file in the client. You can print information 
about certificates using
  openssl x509 -text -noout -in ca.crt
or
  openssl x509 -subject -issuer -noout -in ca.crt

HTH,

JJK

Richard Francis wrote:
>
> Hi, anyone can help? Greatly appreciative of your expertise.
>
>  
>
> Fri Oct 07 14:41:38 2011 us=958000 Current Parameter Settings:
>
> Fri Oct 07 14:41:38 2011 us=958000 config = 'VPN.ovpn'
>
> Fri Oct 07 14:41:38 2011 us=958000 mode = 0
>
> Fri Oct 07 14:41:38 2011 us=958000 show_ciphers = DISABLED
>
> Fri Oct 07 14:41:38 2011 us=958000 show_digests = DISABLED
>
> Fri Oct 07 14:41:38 2011 us=958000 show_engines = DISABLED
>
> Fri Oct 07 14:41:38 2011 us=958000 genkey = DISABLED
>
> Fri Oct 07 14:41:38 2011 us=958000 key_pass_file = '[UNDEF]'
>
> Fri Oct 07 14:41:38 2011 us=958000 show_tls_ciphers = DISABLED
>
> Fri Oct 07 14:41:38 2011 us=958000 Connection profiles [default]:
>
> Fri Oct 07 14:41:38 2011 us=958000 proto = tcp-client
>
> Fri Oct 07 14:41:38 2011 us=958000 local = '[UNDEF]'
>
> Fri Oct 07 14:41:38 2011 us=958000 local_port = 0
>
> Fri Oct 07 14:41:38 2011 us=958000 remote = 'vpn.certify.com'
>
> Fri Oct 07 14:41:38 2011 us=958000 remote_port = 443
>
> Fri Oct 07 14:41:38 2011 us=958000 remote_float = DISABLED
>
> Fri Oct 07 14:41:38 2011 us=958000 bind_defined = DISABLED
>
> Fri Oct 07 14:41:38 2011 us=958000 bind_local = DISABLED
>
> Fri Oct 07 14:41:38 2011 us=958000 connect_retry_seconds = 5
>
> Fri Oct 07 14:41:38 2011 us=958000 connect_timeout = 10
>
> Fri Oct 07 14:41:38 2011 us=958000 NOTE: --mute triggered...
>
> Fri Oct 07 14:41:38 2011 us=958000 252 variation(s) on previous 20 
> message(s) suppressed by --mute
>
> Fri Oct 07 14:41:38 2011 us=958000 OpenVPN 2.1.3 i686-pc-mingw32 [SSL] 
> [LZO2] [PKCS11] built on Aug 20 2010
>
> Fri Oct 07 14:41:38 2011 us=978000 WARNING: No server certificate 
> verification method has been enabled. See 
> http://openvpn.net/howto.html#mitm for more info.
>
> Fri Oct 07 14:41:38 2011 us=978000 NOTE: OpenVPN 2.1 requires 
> '--script-security 2' or higher to call user-defined scripts or 
> executables
>
> Fri Oct 07 14:41:39 2011 us=508000 LZO compression initialized
>
> Fri Oct 07 14:41:39 2011 us=528000 Control Channel MTU parms [ L:1576 
> D:140 EF:40 EB:0 ET:0 EL:0 ]
>
> Fri Oct 07 14:41:39 2011 us=538000 Socket Buffers: R=[8192->8192] 
> S=[8192->8192]
>
> Fri Oct 07 14:41:39 2011 us=819000 Data Channel MTU parms [ L:1576 
> D:1450 EF:44 EB:135 ET:32 EL:0 AF:3/1 ]
>
> Fri Oct 07 14:41:39 2011 us=819000 Local Options String: 'V4,dev-type 
> tap,link-mtu 1576,tun-mtu 1532,proto TCPv4_CLIENT,comp-lzo,cipher 
> BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'
>
> Fri Oct 07 14:41:39 2011 us=819000 Expected Remote Options String: 
> 'V4,dev-type tap,link-mtu 1576,tun-mtu 1532,proto 
> TCPv4_SERVER,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,key-method 
> 2,tls-server'
>
> Fri Oct 07 14:41:39 2011 us=819000 Local Options hash (VER=V4): '31fdf004'
>
> Fri Oct 07 14:41:39 2011 us=819000 Expected Remote Options hash 
> (VER=V4): '3e6d1056'
>
> Fri Oct 07 14:41:39 2011 us=819000 Attempting to establish TCP 
> connection with 1.1.1.1:443
>
> Fri Oct 07 14:41:39 2011 us=909000 TCP connection established with 
> 1.1.1.1:443
>
> Fri Oct 07 14:41:39 2011 us=909000 TCPv4_CLIENT link local: [undef]
>
> Fri Oct 07 14:41:39 2011 us=909000 TCPv4_CLIENT link remote: 1.1.1.1:443
>
> Fri Oct 07 14:41:39 2011 us=979000 TLS: Initial packet from 
> 1.1.1.1:443, sid=48fe7a7z 189d19pc
>
> Fri Oct 07 14:41:41 2011 us=401000 VERIFY ERROR: depth=1, error=self 
> signed certificate in certificate chain: 
> /C=US/ST=NewYork/L=minerals/O=certify.com/OU=R_D/CN=certify/emailAddress=certify@...1513...
>
> Fri Oct 07 14:41:41 2011 us=401000 TLS_ERROR: BIO read 
> tls_read_plaintext error: error:14090086:SSL 
> routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
>
> Fri Oct 07 14:41:41 2011 us=401000 TLS Error: TLS object -> incoming 
> plaintext read error
>
> Fri Oct 07 14:41:41 2011 us=401000 TLS Error: TLS handshake failed
>
> Fri Oct 07 14:41:41 2011 us=401000 Fatal TLS error 
> (check_tls_errors_co), restarting
>
> Fri Oct 07 14:41:41 2011 us=401000 TCP/UDP: Closing socket
>
> Fri Oct 07 14:41:41 2011 us=411000 SIGUSR1[soft,tls-error] received, 
> process restarting
>
> Fri Oct 07 14:41:41 2011 us=411000 Restart pause, 5 second(s)
>
>  
>
>  
>
> Richard Francis
>
> http://www.pelicancomputers.us
>
> 1.847.256.0639
>
>  
>
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> All of the data generated in your IT infrastructure is seriously valuable.
> Why? It contains a definitive record of application performance, security
> threats, fraudulent activity, and more. Splunk takes this data and makes
> sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-d2dcopy2
> ------------------------------------------------------------------------
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>   


