References: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
From: debbie10t <debbie10t@...277...>
Message-ID: <7ace0a84-5bdc-53af-bc83-460d1192e0a8@...277...>
Date: Sun, 2 Apr 2017 02:36:19 +0100
MIME-Version: 1.0
In-Reply-To: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
Subject: Re: [Openvpn-devel] gentoo build inconsistency with openssl in
 openvpn using elliptic curve cert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 02/04/17 00:57, debbie10t wrote:

> me@...2259... ~/openvpn $ 2.4/src/openvpn/openvpn
> /etc/openvpn/tunc_xxxxxu_il.conf
>
> Sat Apr  1 23:37:57 2017 us=342905 OpenVPN 2.4.1
> [git:2.4/8731dfa7caaf8b6d] x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO]
> [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Apr  1 2017
> Sat Apr  1 23:37:57 2017 us=342948 library versions: OpenSSL 1.0.2k  26
> Jan 2017, LZO 2.08
> Sat Apr  1 23:37:57 2017 us=343040 MANAGEMENT: TCP Socket listening on
> [AF_INET]127.0.0.1:xxxxx
>
> <snip>
>
> Sat Apr  1 23:37:57 2017 us=343513 OpenSSL: error:0609E09C:digital
> envelope routines:PKEY_SET_TYPE:unsupported algorithm
> Sat Apr  1 23:37:57 2017 us=343642 OpenSSL: error:0B07706F:x509
> certificate routines:X509_PUBKEY_get:unsupported algorithm
> Sat Apr  1 23:37:57 2017 us=343706 OpenSSL: error:140BF10C:SSL
> routines:SSL_SET_CERT:x509 lib
> Sat Apr  1 23:37:57 2017 us=343765 Cannot load inline certificate file
> Sat Apr  1 23:37:57 2017 us=343827 Exiting due to fatal error
>

Sorry .. that <snip> was only me cutting the options log, the log above 
is an exact copy of the remaining output otherwise.

