MIME-Version: 1.0
In-Reply-To: <CAP=zTkNE-53SstE=tobE9xKWbpT=ERgstxQNy0EqxrN4GMs0Eg@...278...>
References: <CAP=zTkNE-53SstE=tobE9xKWbpT=ERgstxQNy0EqxrN4GMs0Eg@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 5 May 2016 14:37:13 +0200
Message-ID: <CAA1AbxJRmjTJhzCAekF0yX24ztA1JsYbfjQJ1JnW0Z+OXYrbMg@...278...>
Subject: Re: [Openvpn-devel] SSL handshake and OpenVPN config cipher none
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
To: Shubham Chauhan <shubham13099@...2124...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

On Thu, May 5, 2016 at 12:26 PM, Shubham Chauhan
<shubham13099@...2124...> wrote:
> I had a doubt about the cipher none config in OpenVPN.
> I realized that OpenVPN initiates an SSL handshake, even if I choose not to
> use any encryption-decryption operations through the cipher none config. It
> chooses a particular cipher in the handshake as well.
>
> Is it supposed to happen this way?

Yes.

> If yes then why does this exactly happen?

OpenVPN uses TLS to create the 'control channel', over which keys for
the data channel are negotiated and network configuration is pushed to
clients.

> What is the significance of the SSL/TLS handshake and negotiating a session,
> if I am not using any encryption?

Disabling crypto is possible, but not what OpenVPN was designed for.
Also, disabling encryption (using --cipher) does not disable
authentication (--auth) too. If you want to control the TLS crypto,
use --tls-cipher.  Note however that the TLS control channel is only
used for configuration, so disabling the crypto there won't give you a
faster VPN connection.

-Steffan

