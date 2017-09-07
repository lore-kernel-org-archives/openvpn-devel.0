References: <20170907095530.15972-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a9a4122e-add9-b294-9380-1abd3e9d1989@...1227...>
Date: Thu, 7 Sep 2017 14:08:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170907095530.15972-1-a@...2181...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] tcp-server: ensure AF family is
 propagated to child context
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

Am 07.09.17 um 11:55 schrieb Antonio Quartulli:
> From: Antonio Quartulli <antonio@...515...>
> 
> Commit 23d61c56 introduced the AF_UNSPEC socket family
> to be used when we don't know the actual one until the local
> socket binding is performed.
> 
> In such case AF_UNSPEC is stored in the `ce.af` member of
> the `c->options` object, indicating that the family has to be
> determined at runtime.
> 
> However, the determined value is never propagated back to the
> `options` object, which remains AF_UNSPEC and that is
> later used to initialize the TCP children contexts (UDP
> children contexts are unaffected).
> 
> This unexpected setting can trigger weird behaviours, like
> the one reported in ticket #933.
> In this case the value AF_UNSPEC in combination with the
> changes implemented in 2bed089d are leading to a TCP
> server quitting with M_FATAL upon client connection.
> 
> Note that the misbehaviour described in #933 can only be
> triggered when running a TCP server with mtu-disc set
> in the config (no matter the value).
> 
> Fix this inconsistency by always propagating the AF
> family from the top to the child context when running
> in TCP server mode.
>

ACK. That is a really weird corner case that I must have missed :)

Arne

