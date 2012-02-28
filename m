Date: Tue, 28 Feb 2012 19:29:04 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1958561304.20120228192904@...449...>
In-Reply-To: <4F4D18C0.1020008@...1114...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<4F4D18C0.1020008@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: 

Hello David,

> The solution we've ended up with is a OpenVPN service helper which runs
> some code parts with admin rights and the OpenVPN binary itself
> (openvpn.exe) will run completely unprivileged.  Those two instances will
> communicate via named pipes, to set up the proper routes and other
> networking parameters.

Why named pipes?

Why don't extend this
http://openvpn.net/index.php/open-source/documentation/miscellaneous/79-management-interface.html
that it works without admin privileges?

> The time of complaining will come to an end with 2.3 :)  Heiko
> demonstrated his prototype at FOSDEM a few weeks ago.  And it really
> looked very impressive.  But there are some changes to the openvpn code
> base which needs to be applied, in addition to be synced with the GUI
> code base.  So we decided to postpone this particular feature to a later
> alpha release - instead of postponing the first alpha release even more.
>  Just to give Heiko a bit better time to complete his code.  But there
> are so many requesting this feature, we really can't ignore it any more.

> And Heiko is free to flog me if I've said and/or promised too much :)

great !!!!

greetings
Carsten


