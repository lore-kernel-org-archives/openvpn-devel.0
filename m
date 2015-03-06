MIME-Version: 1.0
In-Reply-To: <20150306192248.GZ21893@...1296...>
References: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
	<20150306192248.GZ21893@...1296...>
From: Nicholas Hall <ngharo@...277...>
Date: Fri, 6 Mar 2015 13:45:16 -0600
Message-ID: <CAK6ywb+kAQ+DrLWoQyAfKfMmXqz1278OYRWiYmw4TZ9cn-F3Uw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix autotools check for res_init
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello!

> We use getaddrinfo() and getnameinfo() extensively, which do not require
> res_init() to be called first...
>
> So, instead of adding more convolutions to configure.ac, I propose to
> throw out res_init() and everything related to it :-) - much easier.

res_init seems to be necessary to pick up changes to /etc/resolv.conf
mid-process (without some low-level caching like nscd). As of master
right now, OpenVPN never recovers when it's started with bogus
nameservers in /etc/resolv.conf.

The steps I describe in bug report #523 is still valid, even though my
description of the implementation of openvpn_getaddrinfo() was wrong.

