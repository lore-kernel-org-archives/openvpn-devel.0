Date: Thu, 13 Apr 2017 04:23:56 +1000
From: Steven McDonald <steven@...2262...>
Message-ID: <20170413042356.15732018@...2263...>
In-Reply-To: <20170412062437.GZ93896@...1296...>
References: <20170411173133.18060-1-davids@...515...>
	<20170412062437.GZ93896@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On Wed, 12 Apr 2017 08:24:37 +0200
Gert Doering <gert@...1296...> wrote:

> While this *looks* harmless, it has non-obvious side effects - from
> what I observe, it breaks compilation on all platforms that do not
> have pkg_config for OpenSSL, which was not a requirement earlier (and
> there even was a comment to that extent, "to prevent erroring out").
> 
> In other words: all BSDs are broken now, no matter which openssl
> version they have.

This is further complicated by the fact that, beyond OpenSSL 1.0.0, the
version number of libssl and libcrypto can no longer be relied upon as
an indicator of available features due to the LibreSSL and BoringSSL
forks.

For example, OpenBSD does have pkg-config for libssl, but hasn't
updated it since LibreSSL was forked:

  $ pkg-config --modversion libssl
  1.0.0

This causes the latest master branch of OpenVPN to fail to build. It
builds and runs fine if I change configure.ac to accept libssl (and
libcrypto) 1.0.0.

In the latest LibreSSL portable release on Linux, this would report
2.5.3, but it won't have all the same code as OpenSSL 1.1.0, making
version tests useless in the other direction too. I haven't looked at
what BoringSSL does.

