References: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c441396b-e30e-c602-d6a0-aaafb82d8e7a@...1856...>
Date: Sun, 5 Mar 2017 15:35:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
Subject: Re: [Openvpn-devel] could be gitlab-ci an alternative to buildbot
 cloud?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 05-03-17 15:25, Илья Шипицин wrote:
> there was some buzz related to improvement of testing system, like
> patchwork.
> we tried gitlab-ci on our internal project, it looks very promising.
> 
> since openvpn is already hosted on gitlab.com <http://gitlab.com>,
> there's a possibility of
> 
> 1) users can add their own gitlab-ci agents to the repo
> 2) it might be even windows agents
> 3) build results are publicly available (not easy to get from buildbot)
> 
> it looks like a big step, and it is hard to predict its result. but, I
> think we can try and have a look at it.
> thoughts?

Does this mean that gitlab (as in, the company) controls the build
slaves?  Or should we host our own gitlab-ci-master to control the slaves?

I currently don't contribute any slaves to the buildbot setup, but I for
one would never want to give gitlab root on my machines.  Quite some
OpenVPN functionality requires root, which makes it more tricky to test.

-Steffan

