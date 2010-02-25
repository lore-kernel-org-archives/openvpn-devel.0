From: Marcel =?utf-8?q?Pennewi=C3=9F?= <mailinglists@...1145...>
Date: Thu, 25 Feb 2010 07:59:27 +0100
References: <201002241424.39312.mailinglists@...1145...>
	<4B855916.9080702@...1114...>
In-Reply-To: <4B855916.9080702@...1114...>
MIME-Version: 1.0
Message-Id: <201002250759.27945.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] Gentoo Git-Live-Ebuild
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On Wednesday 24 February 2010 17:51:34 David Sommerseth wrote:
> I looked through the ebuild, and I see you apply two patches.  Are they
> Gentoo specific, or is it something we should consider pulling into the
> the testing tree?

The peercred-patch was included to build openvpn with glibc-2.8 (for further 
information please have a look at 
http://bugs.gentoo.org/show_bug.cgi?id=245181). The pkcs11-patch was included 
to ensure some backward compatibility for the easy-RSA-stuff.

i'm not a developer *g* and i don't know if we should consider these patches 
for the testing tree ;) 

> Please have a look here for some extra details, especially pay attention
> to the "Configure and compile" section.
> 
> <http://www.secure-computing.net/wiki/index.php/OpenVPN/Documentation_for_t
> esters>

I've added "--disable-depr-random-resolv" to configure ;) Ebuild fixed and 
tested.

Thats a private repository and not yet in official Gentoo-portage. Maybe I'll 
find some time in march to talk to Cedrik, the official maintainer of openvpn-
packages for Gentoo.

> I will even enable this one
> on one of my Gentoo servers where OpenVPN is already running! :)

Fine ;)

Marcel

