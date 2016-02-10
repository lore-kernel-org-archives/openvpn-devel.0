References: <1445277979-21591-1-git-send-email-gert@...1296...>
	<5625FF23.70203@...1400...>
	<20151020212827.GN22054@...1296...>
	<5626C540.2080907@...1114...> <56274788.6060801@...1227...>
	<5629EBF4.2060405@...2080...>
	<20151226221906.GY24952@...1296...>
	<f0248977-40a8-7e63-27b8-6c9134c090d5@...1227...>
	<20151227205803.GC24952@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56BB454C.3050006@...1227...>
Date: Wed, 10 Feb 2016 15:12:28 +0100
MIME-Version: 1.0
In-Reply-To: <20151227205803.GC24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
 sending IPv6 info to clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net



Am 27.12.15 um 21:58 schrieb Gert Doering:
>   push-remove route-ipv6 2001:
I think this is missing " " in the commit message, it is okay later in
the manpage

> +  else if (streq (p[0], "push-remove"))

I would add at least a && p[1] and possible a !p[2]

I think multiple push-remove are better than a single one taking
multiple arguments.

Otherwise are you more likely to end up with push-remove a b instead of
push-remove "a b"

Arne






