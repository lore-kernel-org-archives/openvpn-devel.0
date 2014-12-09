Message-ID: <5486C7A6.8060001@...1227...>
Date: Tue, 09 Dec 2014 10:57:58 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1418118764-17846-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1418118764-17846-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] sockets: Remove the limitation of
 --tcp-nodelay to be server-only
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
To: David Sommerseth <openvpn.list@...1114...>, openvpn-devel@lists.sourceforge.net


Am 09.12.14 10:52, schrieb David Sommerseth:
> From: David Sommerseth <davids@...1347...>
>
> The assert(0) happening if trying to use --tcp-nodelay in a client
> config is really not helpful at all.  When this assert(0) was removed,
> another warning appeared that this could only be used in server
> configs.  That itself is also quite silly, as clients can choose to
> use --socket-flags TCP_NODELAY in the client config instead.  This
> behaviour does not help the user in any way.
>
> This patch removes the server-only restriction and rather provides
> a more helpful warning when using --tcp-nodelay on the client side.
>
> Trac: 489
>
ACK. As already discussed on #openvpn :)

Arne

