Date: Mon, 18 Sep 2006 16:16:32 -0400
From: Mike Martin <Mike.Martin@...777...>
In-reply-to: <eemsu7$os3$1@...165...>
Message-id: <450EFEA0.4000807@...777...>
MIME-version: 1.0
References: <450C6060.6060605@...777...>
	<9e0cf0bf0609161341n286986d8i4a39a8cab4d59a5c@...278...>
	<450C6B2E.9040107@...777...> <450E9BD1.9030703@...277...>
	<450EE9E8.6020000@...777...> <eemsu7$os3$1@...165...>
Subject: Re: [Openvpn-devel] request for input re: OpenVPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the response, Charles,

I have added comments in-line:

Charles Duffy wrote:
> I'm not an OpenVPN developer per se -- other than a few trivial 
> patches -- but I should be able to comment.
>
> First -- the requirements for what you want a VPN to do in a grid 
> environment are something which need to be specified. Since OpenVPN is 
> limited to either a 2-endpoint peer-to-peer model or a hub-and-spoke 
> model, it isn't necessarily well-suited to cases where a arbitrary 
> communications will need to be encrypted within a cloud.
>   
One of the arguments in my paper takes issue with that belief, which has 
been put forth in a seminal document be Ian Foster, who is an important 
figure in Grid research. I like to pick a good fight. ;-) However, I am 
not dogmatic about it, and accept that I may be off base. I believe that 
there are times when Grid applications will make persistent connections, 
with variable degrees of activity, between peers within the cloud. There 
may be prolonged times of little, or no traffic, and there may be 
prolonged times of extreme traffic, depending on need and availability. 
It is all about using the best resources available, when they are 
needed. But I also believe the grid, if it is to work as envisioned, 
must be very adaptable to the needs of its participants. Suppose we have 
a company willing to share their resources on the Grid, but who have a 
policy of only allowing access to their network via VPN, using X.509 
certificates. Maybe they have a massive internal network which is not 
busy on evenings and week-ends, and they are willing to let research 
facilities make use of idle CPUs for a reasonable price. Perhaps it 
would be wise to build the ability into the Globus Toolkit to 
automatically open and manage VPN connections when they are required. 
The service could be advertised on a Service Discovery Service, the 
parameters could be outlined in a WSDL, and the certificate management 
could occur using the parameters of the Grid Security Infrastructure 
(GSI), which uses X.509. It seems feasible to me. It may never happen, 
but it's worth looking at.
> Second, OpenVPN already provides a number of methods to interact with 
> it which are readily programmatically accessible. This includes the 
> manual page; OS-level signals; command-line and configuration file 
> parameters; etc. My experience is that these are more than adequate 
> for controlling the behavior which is presently available -- and that 
> in cases where these tools and in of themselves don't provide the 
> desired level of functionality, that building additional layers on top 
> of the preexisting interfaces (rather than building entirely new 
> interfaces) is appropriate.
>   
The goal is, in the long term, to come up with a universal API which 
would allow developers of Grid service software to write programs which 
would be able to allow remote Grid clients to manage VPN connections via 
a Web service interface. A generic API can prove very useful for VPN 
developers. They could provide implementations of the generic API with 
their products, which would allow any software using that API to make 
use of it. A good example of this is the GSSAPI: 
http://www.faqs.org/faqs/kerberos-faq/general/section-84.html Perhaps, 
some day, a generic VPN API would be published as an RFC. I am simply 
using OpenVPN as a test case through which to explore these issues, and 
make some modest recommendations for future work.
> Could you document the exact functionality you wish to add, and the 
> business case for exposing that functionality as a native API?
>   
Actually, one of the main goals of my paper is to determine exactly 
which functionality should be added. If I could answer that question, I 
wouldn't be looking for input here. I do believe that if the Grid were 
ever to live up to its much-hyped promise, much benefit could be accrued 
to any software which works well with it. After having looked at 
OpenVPN, as compared to other SSL based VPNs and IPSec based VPNs, I 
have come to think that OpenVPN would be a perfect fit as a default VPN 
for the Globus Toolkit (if only I had any degree of clout. My paper will 
undoubtedly languish in the digital equivalent of a dark and moldy 
warehouse). It relies on well-known, commonly used protocols, which 
incidentally are also used in the GSI. It is flexible, not too complex, 
and secure. Whatever the case, I'm just writing an academic paper, 
hoping to add a bit to our vast body of knowledge. Maybe someone will 
read it and do something cool with OpenVPN. It is a nice piece of software.
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job 
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache 
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>   



