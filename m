Sender: Vasiliy Kulikov <segooon@...277...>
Date: Fri, 12 Dec 2014 21:49:01 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20141212184901.GA4771@...2009...>
References: <20141208115202.GA4807@...2009...> <20141212165220.GA4575@...2009...>
	<548B32D4.1060607@...1227...>
MIME-Version: 1.0
In-Reply-To: <548B32D4.1060607@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add Mac OS X keychain support
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, Anton Karpov <tokza@...2010...>

Hi Arne,

On Fri, Dec 12, 2014 at 19:24 +0100, Arne Schwabe wrote:
> Am 12.12.14 17:52, schrieb Vasily Kulikov:
> > Any comments?
> >
> None yet. The patch is very large and our time is unfortenately limited.
> And the number of people how do crypto and Mac OS is even smaller. I
> haven't have found time yet to look at the code yet. (We don't want to
> commit unreviewed code).

Thank you!  I don't want anybody to commit unreviewed code too.
Do you think I should just wait until some people read the code or
should I divide the code into smaller parts?  However, I don't see the
way it can be divided as it is a rather monolithic feature, only Tunnelblick
support can be isolated (however, this second part would be very small
and the first part would be still very big).

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

