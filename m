From: James MacLean <macleajb@...213...>
In-Reply-To: <twig.1083217597.4062@...41...>
Message-ID: <Pine.LNX.4.58.0404291026460.9026@...212...>
References: <twig.1083217597.4062@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN 2.0-test26 released
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
Date: Fri Apr 30 12:25:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 29 Apr 2004, James Yonan wrote:

> A new release of the 2.0 beta is available.

Hi James,

We have started to look at how we can make use of the single daemon mode
of OpenVPN, but after playing with options and doing some searching we
thought it best to post and get direct answers to 2 things that are
stopping us from using this in place of the 1 process per link for
connecting many sites together. We realize the push was more for roaming 
users, but it apears it might work in our scenario too.

1. Is there any way, or may we add to the wish list, the ability to route
a subnet through Openvpn (inside the internal router). As we understand it
now it will only accept IPs, yet we are trying to use it to connect remote
subnets together as we do now with the single daemon method. They are /16 
subnets.

2. We can not find how to bring up routes when clients connect.  Or be
able to run a client-up script that would be allowed to add routes (to the
remote subnets).

JES
-- 
James B. MacLean        macleajb@...213...
Department of Education 
Nova Scotia, Canada
     

