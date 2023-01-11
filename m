Date: Wed, 11 Jan 2023 21:26:09 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y78bYeqqE//h6iVl@...2685...>
References: <20220909195902.2011798-1-arne@...1227...>
 <20230109163810.887999-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230109163810.887999-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5] Introduce dynamic tls-crypt for
 secure soft_reset/session renegotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Jan 09, 2023 at 05:38:10PM +0100, Arne Schwabe wrote:
> Currently we have only one slot for renegotiation of the session/keys.
> If a replayed/faked packet is inserted by a malicous attacker, the
> legimate peer cannot renegotiate anymore.
> 
> This commit introduces dynamic tls-crypt. When both peer support this

"peers"

> feature, both peer create a dynamic tls-crypt key using TLS EKM (export key
> material) and will enforce using that key and tls-crypt for all
> renegotiations. This also add an additional protection layer for
> renegotiations to be taken over by an illegimate client, binding the
> renegotiations tightly to the original session. Especially when 2FA, webauth
> or similar authentication is used, many third party setup ignore the need
> to secure renegotiation with an auth-token.
> 

Acked-By: Frank Lichtenheld <frank@...2641...>

Stared at code, read documentation, stared more at code. Looks like it
does what it should. Ran master+patch t_client tests against a master+patch server.
Log messages look sensible. Also tried running a connection with --reneg-sec 15
just to prove that renegotiations still work.

I can't prove/judge whether it actually uses a different key and whether the crypto
claims from the commit message are actually true.

Regards,
-- 
  Frank Lichtenheld

