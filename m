Message-ID: <408E6A50.6090209@...194...>
From: Stephan Scholz <sscholz@...194...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Many to one TCP question
References: <408C37BA.5080806@...203...>
In-Reply-To: <408C37BA.5080806@...203...>
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
Date: Tue Apr 27 07:22:01 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Lonnie Cumberland <lonnie@...203...>
Cc: Openvpn-devel@lists.sourceforge.net

Hi Lonnie,

this could already be done with 1.6 by some tweaks and using inetd.
I have tried it and it worked fine.
Disadvantage: one OpenVPN process per user is created -> memory consumption.

In the FAQ on the openvpn homepage, there is a short howto:
"How can I implement OpenVPN as a classic, forking TCP server
which can service multiple clients over a single TCP port?"

Stephan

> Hello All,
> 
> Well, I've been away from the list for a little while and was wondering 
> if someone could please bring me up to speed on the development of the 
> "Many-to-One" TCP progress?
> 
> It is my understanding that in the OpenVPN 2.0 (early) Beta, that UDP 
> connections can be established in a many to one TAP/TUN interface, but 
> how about the TCP side?
> 
> I am hoping to get a project under way as soon at this has been 
> implemented.
> 
> Thanks All,
> Lonnie
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


