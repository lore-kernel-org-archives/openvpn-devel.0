Message-ID: <4714B37D.2070402@...1061...>
Date: Tue, 16 Oct 2007 13:50:05 +0100
From: Matthew Richardson <M.Richardson@...1061...>
MIME-Version: 1.0
References: <47149548.60001@...1061...> <1876949290.20071016125750@...449...>
	<47149E7B.3040003@...1061...> <748131909.20071016132959@...449...>
In-Reply-To: <748131909.20071016132959@...449...>
Subject: Re: [Openvpn-devel] Altering routing Tables as non-admin on Windows
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
To: openvpn-devel@lists.sourceforge.net

> MR>   If this has changed, and there is a way
> MR> to interact with the service as non-admin then I will certainly look 
> MR> into this...
> 
> take subinacl to change the ACL of the openvpn-service
> http://www.microsoft.com/downloads/details.aspx?FamilyID=e8ba3e56-d8fe-4a91-93cf-ed6985e3927b&displaylang=en
> users need the right to start/stop the service

I just replied to Carsten to thank him for pointing me to this, and then 
discovered something which is a show-stopper for me - if run as a 
service, OpenVPN can only do certificate authentication, not 
user/password auth, since there is no way to pass the auth details to 
the service:

http://www.openvpn.se/files/howto/openvpn-howto_run_openvpn_as_nonadmin-Rev1.1.html

We would prefer to use password auth instead of certificate distribution 
in our environment.

However, the page given above states:

"There is work in progress to enhance the OpenVPN Service so it can be 
controlled via a TCP socket. This will allow individual tunnels to 
started and stopped at will, as well as supplying OpenVPN with the 
password used to encrypt the private key. OpenVPN GUI 2.0 will be 
rewritten to make use of this service."

which seems to cover what I would like to see in OpenVPN.  Can anyone 
shed any more light on this?


Matthew




