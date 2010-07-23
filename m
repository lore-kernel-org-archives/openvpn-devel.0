Message-ID: <20100723140617.19037.qmail@...1287...>
Date: Fri, 23 Jul 2010 16:06:17 +0200
From: Peter Stuge <peter@...1287...>
References: <4C494C31.7020601@...1114...>
MIME-Version: 1.0
In-Reply-To: <4C494C31.7020601@...1114...>
Subject: Re: [Openvpn-devel] [RFC] - (ticket #29) - Fix for
	--push-reset	resetting --topology and --route-gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> 1) Adding a new configure option which "unpush" chosen elements
> 2) Add a new immutable option list for PUSH_REPLY
> 3) Add a flag to the PUSH_REPLY list indicating if it is immutable
..
> Does anyone see another solution which is better?  Or which
> suggestion do you consider preferable?

The problem in this particular case seems to be that push-reset is
removing options that were added to the push list *implicitly* by
other configuration directives.

Would it make sense to simply treat all implicitly added elements as
immutable?

As for how to make elements immutable I prefer option 3, adding a
flag to the existing data structure.


//Peter

