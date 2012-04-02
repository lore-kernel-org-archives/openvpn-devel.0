MIME-Version: 1.0
In-Reply-To: <4F79500E.6060005@...1435...>
References: <CAOazyz1OjVKEq5+0BcAgS9PVPcs77oJemG+kD3S7ZZUv+TiAEg@...278...>
	<1333287988-25921-1-git-send-email-alon.barlev@...277...>
	<4F79500E.6060005@...1435...>
Date: Mon, 2 Apr 2012 12:25:24 +0300
Message-ID: <CAOazyz1ytO+Tx5nTKeX54=QbDE6G9kOVRo8fC4tSDy3_JeXVkA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: gc usage
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, Apr 2, 2012 at 10:06 AM, Adriaan de Jong <dejong@...1435...> wrote:
> Thanks, looks good. Does platform_open return -1 on failure on all
> platforms? If so, ack, otherwise change that to < 0.

As far as I know, yes.

"""open() and creat() return the new file descriptor, or -1 if  an
error  occurred."""

