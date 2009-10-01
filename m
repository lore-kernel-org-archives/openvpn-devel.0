From: Marcel =?iso-8859-1?q?Pennewi=DF?= <mailinglists@...1145...>
Date: Thu, 1 Oct 2009 11:41:52 +0200
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
	<7bb795fd0909302333x42aa4869gaf70cf7dc07d611d@...278...>
	<7bb795fd0910010022i14565834vaa0d29b7fa48eb44@...278...>
In-Reply-To: <7bb795fd0910010022i14565834vaa0d29b7fa48eb44@...278...>
MIME-Version: 1.0
Message-Id: <200910011141.52317.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 01 October 2009 09:22:31 JuanJo Ciarlante wrote:
> Compiled from
>  
> http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn-2.1_rc19c-ipv6-0
>.4.7.tar.gz , it went find for both, as the symbol(s) are ok at the objects:
>
> $ nm -p multi.o ssl.o | egrep 'o:|tls_auth'
> multi.o:
>                  U tls_authenticate_key
>                  U tls_authentication_status
> ssl.o:
> 0000000000000080 T tls_authenticate_key
> 0000000000000ba0 T tls_auth_standalone_init
> 0000000000000d80 T tls_auth_standalone_finalize
> 0000000000000ff0 T tls_authentication_status
>
> , ie: tls_authenticate_key symbol present as code ("T "ext) in ssl.o
> , could be there something fishy/unclean in your building env?

i don't know but build log seems not to show any problems. after the build 
error my multi.o and ssl.o are are different from yours:

larissa openvpn-2.1_rc19 # nm -p multi.o ssl.o | egrep 'o:|tls_auth'
multi.o:
                 U tls_authenticate_key
                 U tls_authentication_status
ssl.o:
0000000000000080 T tls_authentication_status
0000000000000be0 T tls_auth_standalone_init
0000000000000da0 T tls_auth_standalone_finalize

the problem only exists when i add your patch. without your patch everything 
runs fine. i'm using openvpn-source from 
http://ftp.tu-ilmenau.de/mirror/gentoo/distfiles/openvpn-2.1_rc19.tar.gz
which is the official source from gentoo-portage and apply your patch.

i'll try your sources asap.

Regards,
Marcel



