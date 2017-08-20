References: <CAFHpkQHXhe4UBAePJQXkBYJ+Sahc-3XpVPfPBo5oT6EKbzm3mA@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b524e527-9881-1e25-2ba0-fd7e4117afc4@...1856...>
Date: Sun, 20 Aug 2017 11:10:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHXhe4UBAePJQXkBYJ+Sahc-3XpVPfPBo5oT6EKbzm3mA@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] testing openvpn on gitlab-ci cloud ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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

On 20-08-17 09:43, Илья Шипицин wrote:
> I was playing with gitlab-ci:
> 
> https://gitlab.com/chipitsine/openvpn/pipelines/11012659
> 
> 
> are we interested in something like that ? thoughts?
> 
> some benefits of gitlab-ci:
> 
> 1) ipv6 on loopback (travis-ci runs in GCE without ipv6)
> 2) ability to attach own gitlab-ci runners to repo
> (freebsd/netbsd/.../windows/.../etc)

This does look nice, but I think we should not add another CI setup.  We
now have:

1) The private buildbot setup for the maintainers, which runs a wide
variety of platforms, configs and real-network tests (across various
combinations platforms, to test e.g. endianness).

2) The travis-ci setup for coverity and an early check of github pull
requests (which only is an early staging area for patches to be sent to
the -devel list later).

So I think we have everything that gitlab offers covered.  Let's not add
another setup to maintain.

-Steffan

