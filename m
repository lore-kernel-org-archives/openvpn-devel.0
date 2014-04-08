Date: Tue, 8 Apr 2014 13:25:47 +0200
From: Davide Brini <dave_br@...1278...>
In-Reply-To: <5343BCAB.3040102@...1790...>
References: <5343BCAB.3040102@...1790...>
MIME-Version: 1.0
Message-ID: <0LikyX-1X9YfO48dR-00d2sy@...1825...>
Subject: Re: [Openvpn-devel] Heartbleed
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

On Tue, 08 Apr 2014 11:08:59 +0200, Tore Anderson <tore@...1790...> wrote:

> I'm guessing that everyone has seen http://heartbleed.com/ by now.
> 
> My question is simple: Could anyone confirm whether or not OpenVPN is
> vulnerable (when linked to a vulnerable version of OpenSSL)?


This is James' reply on the devel list:


Using the tls-auth option should protect against this vulnerability 
(assuming that your tls-auth key is not known to the attacker).

If you're not using tls-auth and are using a vulnerable version of 
OpenSSL, you should definitely upgrade to OpenSSL 1.0.1g.


-- 
D.

