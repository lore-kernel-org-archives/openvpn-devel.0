Message-ID: <424C52EF.60100@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: [Openvpn-devel] "ping" config kills connections on 2.0rc16
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
Date: Thu Mar 31 11:45:50 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Currently not being able to test of this problem also exists in more 
recent rc's, I'll just mention it: when is use the "ping" or "keepalive" 
settings, periodically the SSL connections reset, the syslog output 
follows below. Without the ping settings connections seem tu survive 
much longer!

Hope this is useful information.

Cheers,

Rolf Fokkens

Apr  1 03:23:32 plaza-server openvpn[2502]: TLS: Initial packet from 
83.118.84.1
29:11800, sid=737dedce 3fab1f1c
Apr  1 03:23:33 plaza-server openvpn[2502]: VERIFY OK: depth=1, 
/C=NL/L=Groningen/O=Vertis_bv/CN=Vertis-VPN-CA
Apr  1 03:23:33 plaza-server openvpn[2502]: VERIFY OK: depth=0, 
/C=NL/L=Groningen/O=Vertis_bv/CN=N003.Vertis-VPN
Apr  1 03:23:33 plaza-server openvpn[2502]: Data Channel Encrypt: Cipher 
'AES-128-CBC' initialized with 128 bit key
Apr  1 03:23:33 plaza-server openvpn[2502]: Data Channel Encrypt: Using 
160 bitmessage hash 'SHA1' for HMAC authentication
Apr  1 03:23:33 plaza-server openvpn[2502]: Data Channel Decrypt: Cipher 
'AES-128-CBC' initialized with 128 bit key
Apr  1 03:23:33 plaza-server openvpn[2502]: Data Channel Decrypt: Using 
160 bitmessage hash 'SHA1' for HMAC authentication
Apr  1 03:23:33 plaza-server openvpn[2502]: Control Channel: TLSv1, 
cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 512 bit RSA
Apr  1 03:23:33 plaza-server openvpn[2502]: [N003.Vertis-VPN] Peer 
Connection Initiated with 83.118.84.129:11800
Apr  1 03:23:34 plaza-server openvpn[2502]: Initialization Sequence 
Completed
Apr  1 03:24:02 plaza-server openvpn[2502]: Authenticate/Decrypt packet 
error: cipher final failed
Apr  1 03:24:04 plaza-server openvpn[2502]: TLS_ERROR: BIO read 
tls_read_plaintext error: error:06065064:digital envelope 
routines:EVP_DecryptFinal:bad decrypt
Apr  1 03:24:04 plaza-server openvpn[2502]: TLS Error: TLS object -> 
incoming plaintext read error
Apr  1 03:24:04 plaza-server openvpn[2502]: TLS Error: TLS handshake failed
Apr  1 03:24:04 plaza-server openvpn[2502]: TCP/UDP: Closing socket
Apr  1 03:24:04 plaza-server openvpn[2502]: Closing TUN/TAP interface
Apr  1 03:24:04 plaza-server openvpn[2502]: SIGUSR1[soft,tls-error] 
received, process restarting
Apr  1 03:24:04 plaza-server openvpn[2502]: Restart pause, 2 second(s)


