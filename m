Message-ID: <52173B95.6030401@...1227...>
Date: Fri, 23 Aug 2013 12:38:13 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAMRyNXJVwnk5D8ZK_tN6NQ8BX1+zbn9jWfEWTUDa90g-RNVVDw@...278...>
In-Reply-To: <CAMRyNXJVwnk5D8ZK_tN6NQ8BX1+zbn9jWfEWTUDa90g-RNVVDw@...278...>
Subject: Re: [Openvpn-devel] Implementing a Mobile OpenVPN - questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Abdullah Alshalan <aalshala@...1837...>
Cc: openvpn-devel-request@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Am 23.08.13 02:48, schrieb Abdullah Alshalan:
> Hi all,
> I'm not sure if I'm sending this email to the right development group
> so I apologize if it's not.
>
> I'm trying to reach the open vpn development team or anyone who has
> experience with OpenVPN development.
> I started working on a project to implement an open-source, true
> Mobile SSL VPN and I'm finsihed with a detailed framework design. I
> know OpenVPN has released OpenVPN connect for smart phones but what I
> want to add is mobility features. Meaning the VPN session survives any
> network interruptions due tp switching from one network to another,
> thus getting new IP addresses or during lack of network coverage for
> some time.
>
> My question is how big of a project is this going to be? I mean is it
> something one person can handle or needs a team of experience network
> programmers? 
> Are there any books or any sort of  documentation that helps
> understand and modify the OpenVPN source code?
>
I am not quite what you aiming at. OpenVPN does support changing IP
addresses when both sides use --float.

Arne

