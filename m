Message-ID: <52CD24EA.6090904@...1227...>
Date: Wed, 08 Jan 2014 11:14:02 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1384698620-27946-1-git-send-email-gert@...1296...>
In-Reply-To: <1384698620-27946-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Make code and documentation for
 --remote-random-hostname consistent.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 17.11.13 15:30, schrieb Gert Doering:
> Documentation examples, description and code were disagreeing on what
> this option actually does.  Now they will all agree that it will
> *prepend* a random-byte string to the hostname name before resolving
> to work around DNS caching (needs a "*" wildcard record in the zone).
>
> Fix trac #143
>
>
ACK

