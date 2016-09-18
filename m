MIME-Version: 1.0
In-Reply-To: <b7d9be2a-b8e1-e565-198f-a5177e11d0c2@...1435...>
References: <b7d9be2a-b8e1-e565-198f-a5177e11d0c2@...1435...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 18 Sep 2016 14:25:22 +0200
Message-ID: <CAA1AbxK+mE0mz01UwrJ=o_6HBkBBe+FUXNnmqsfMe7vQLzCTsQ@...278...>
Subject: Re: [Openvpn-devel] Feature proposal: tls-crypt
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 27 July 2016 at 16:42, Steffan Karger <steffan.karger@...1435...> wrote:
> Our customers, as well as community users, have asked for encryption of
> control channel packets to hide their certificate (containing perhaps
> the users' name or organisation), or to provide some basic form of
> post-quantum security (see e.g. trac #633).
>
> We've been thinking about this for a while, and would like to implement
> such a feature.  I've attached a proposal for an extension of tls-auth
> to achieve this in OpenVPN.  Comments and/or questions are very welcome.
>  I hope to be able to start implementing this soon.

I just pushed an experimental branch with --tls-crypt support:
https://github.com/syzzer/openvpn/tree/tls-crypt-preview

Any comments and test results or very much welcome.

This code has not yet been reviewed, or tested by anyone else but me,
so do not use in production yet.

-Steffan

