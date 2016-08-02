MIME-Version: 1.0
In-Reply-To: <1a341630-323e-f2a8-176b-bf5176990f62@...1147...>
References: <1469472766-25131-1-git-send-email-steffan@...1856...>
	<1a341630-323e-f2a8-176b-bf5176990f62@...1147...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 2 Aug 2016 16:42:00 +0200
Message-ID: <CAA1Abx+bPwD5YxHpUzYzaRjMKwUA+_Y4KVAaQO=XbCHZxWvebQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Allow ncp-disable and ncp-ciphers to be
 specified in ccd files
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Fri, Jul 29, 2016 at 5:18 PM, Jan Just Keijser <janjust@...1147...> wrote:
> another remark: making this option CCD-file specific a good idea, but how
> you do ensure that the server only applies it to this particular client?
> o->ncp_enabled seems a global at first glance. Consider this scenario:
>
> 1) client A connects , for which we want to disable NCP; hence a
> client-connect script or CCD file with 'ncp-disable' in it;
> 2) client B connects, no CCD file, it's running v2.4+, so we want NCP.
>
> How does the server handle this?  Or did I miss the "per-client options"
> struct?

You've just answered your own question ;)

The ccd file parsing operates on mi->context.options, which is a
connection-specific options struct (mi = 'multi instance').  See
multi_connection_established().

-Steffan

