MIME-Version: 1.0
In-Reply-To: <20161012130610.GC28918@...1296...>
References: <20160916161354.GM78279@...1296...>
	<1476263591-12401-1-git-send-email-arne@...1227...>
	<CAEsd45Tkkmbp=qbgVZxAt-U3hkLBQemOxDGRjTucLCoJPM+bTg@...278...>
	<026a4dab-8aac-7edb-4f58-4fbacfe56795@...1227...>
	<CAEsd45QhH3=xo-0A3QZe0eqp4gBM7T9WOvJ0Bu4+GFKJbRrtUg@...278...>
	<20161012130610.GC28918@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 12 Oct 2016 09:18:13 -0400
Message-ID: <CAEsd45Qu+Vy1CLbYeCOjL7t8jO_VF-e_i1CoJKYrWg+6oQYs7w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thanks to both Gert and Arne for their answers.

On Wed, Oct 12, 2016 at 9:12 AM, Arne Schwabe <arne@...1227...> wrote:
>> What I should have asked is: with this patch will an OpenVPN client
>> still send out IPv4 packets if there are no IPv6 options specified or
>> pulled from the server?

