Message-ID: <40F816BC.50408@...201...>
From: Derek Burdick <derek@...201...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Better understanding Proxy.c vs Socks.c
References: <40F7F410.70200@...83...>
In-Reply-To: <40F7F410.70200@...83...>
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
Date: Fri Jul 16 10:57:02 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

webmaster wrote:

> Hi,
> 
> is it right, that proxy.c only is needed to establish a connection via 
> the proxy. After that the communication is done via Socks.c?
> 
> And what does
> 
> /* format Socks CONNECT message */
>  buf[0] = '\x05';        /* VER = 5 */
>  buf[1] = '\x01';        /* CMD = 1 (CONNECT) */
>  buf[2] = '\x00';        /* RSV */
>  buf[3] = '\x03';        /* ATYP = 3 (DOMAINNAME) */
> 
> in socks.c mean? Is there any documentation on this?
> 
> Greetings
> 
> Ullrich
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
     This looks like a Socks version 5 connect request.  You can find 
the socks v5 protocol definition here:
http://www.faqs.org/rfcs/rfc1928.html

     Without looking at the code in detail, but with some experience 
programming using socks and HTTP proxies, I would say yes.  Basically 
once the connection is brought up through the proxy and authenticated 
(optional), it just forwards what it sends and receives.

     You may also be interested in the HTTP CONNECT method.  The RFC is 
here:
http://www.rfc-editor.org/cgi-bin/rfcdoctype.pl?loc=RFC&letsgo=2818&type=http&file_format=txt

-Derek


