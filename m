From: <lonnie@...203...>
Subject: Re: [Openvpn-devel] Many to one TCP question
Message-ID: <6BFB097224B04B5A80102597419003F3.MAI@...204...>
Mime-version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_000_000B_CE5E84DC.A16A4754"
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
Date: Tue Apr 27 08:44:07 2004
To: sscholz@...194...
Cc: Openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

----=_NextPart_000_000B_CE5E84DC.A16A4754
Content-type: text/plain;

Thanks for the reply to my email on this matter.

In reading over the information on the site, I can see what you are talking about and also about
the memory consumption because of the many instances, one for each user.

In the early Beta 2.0 release notes, it talks about UDP in a "many-to-one" design which I assume
means only one instance per user. 

I was wondering if this would soon be available for the TCP side of the house as well as it seems
to be more valuable for road warrior connections over the Internet and can easily tunnel through
firewalls, although I could be wrong on this.

Thanks again,
Lonnie

----- Original Message -----
From: Stephan Scholz
To:  Lonnie Cumberland <lonnie@...203...>
Cc:   Openvpn-devel@lists.sourceforge.net
Sent: Tue, 27 Apr 2004 16:12:32 +0200
Subject: Re: [Openvpn-devel] Many to one TCP question

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


----=_NextPart_000_000B_CE5E84DC.A16A4754--


