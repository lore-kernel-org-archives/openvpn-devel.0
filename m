Message-ID: <437E91BE.3060301@...504...>
From: Ian Berry <iberry@...504...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] new tap device for each connection
References: <437E7AE1.4030204@...503...>
In-Reply-To: <437E7AE1.4030204@...503...>
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
Date: Fri Nov 18 18:46:01 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Manolis Stamatogiannakis <mstamat@...503...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

I ran into this exact situation. Based on my knowledge of how OpenVPN 
operates in "server mode", I figured that it would require a significant 
change to allow this. As a workaround, I run OpenVPN in "inetd mode", 
which forces a new openvpn process for each client and therefore a 
separate tap interface. Works great for me.

Ian

Manolis Stamatogiannakis wrote:
> Hi all,
> Does anybody know how/if I can run OpenVPN as server and have it create 
> a new tap interface for each authenticated connection?
> 
> If this is not possible, how much work would it be to implement it as a 
> patch? Would it fit with the OpenVPN internals, or it would need major 
> changes to fit?
> 
> Thanks in advance,
> Manolis
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

