Message-ID: <442EB40B.8070606@...101...>
From: inode <inode@...101...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] NTLM proxy problem.
References: <44294D0A.208@...101...> <200604011802.56973.openvpn@...275...>
In-Reply-To: <200604011802.56973.openvpn@...275...>
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
Date: Sat Apr  1 09:11:02 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: William Preston <openvpn@...275...>
Cc: openvpn-devel@lists.sourceforge.net

The squid has been compiled with the kerberos support and samba 3 
(latest version) is used as an external authenticator. You can find in 
this link a configuration similar to myne (this link if for gentoo, but 
I hope that you will not have problem to compile or configure it. If you 
got one, just write me directly): http://mkeadle.org/?p=13

For your test you can also use your isa server, but the domain in NTLM 
packets must be set.

The faster way that I have identified to resolve this problem is modify 
the code of the function ntlm_phase_3 adding a search of "\" in the 
username and if exist set the first part of the username to domain and 
the second part as the username. In this way you will not have to modify 
the proxy data structure and also you will fix the problem under a 
authenticator with multiple domains.

For the first problem exposed the faster way if just add a connection 
keep alive, the second it's add to the proxy routines to undestand if 
the connection has been closed and in this case open a newone.

Thank you for the faster reply.

inode

William Preston wrote:
> On Tuesday 28 March 2006 16:49, inode wrote:
>> I'm doing some test with openvpn, and I saw some problem using NTLM auth
>> proxy.
>>
>> I tested the software on a ISA server and all work fine, the problem is
>> using a squid proxy with NTLM.
>>
> 
> I only tested NTLM against Microsoft ISA Server.
> 
>> - NTLM domain, actualy on openvpn config file the user can't set the
>> domain of the credentials sent to the proxy. An Microsoft ISA server
>> will have a "default domain" to try the authentication, but that doesn't
>> mean that "default domain" will be the right one... Also on squid the
>> domain is required and a null domain will be refused.
> 
> OK, fair enough :-)
> 
> can you let me know exactly how you compiled the NTLM support into
> Squid so that I can reproduce this.  Are you linking against SaMBa - and if
> so then which version?
> 
> thanks,
> 
> 
> William
> 

