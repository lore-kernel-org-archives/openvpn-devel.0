From: Arne Schwabe <arne@...1227...>
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <20181010143051.27163-1-arne@...1227...>
Message-ID: <0e3a06c4-da6d-64cd-3579-1f44aff50489@...1227...>
Date: Wed, 10 Oct 2018 16:57:04 +0200
MIME-Version: 1.0
In-Reply-To: <20181010143051.27163-1-arne@...1227...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v5] Revert to original password
 authentication after failed auth-token
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
To: openvpn-devel@lists.sourceforge.net

Am 10.10.18 um 16:30 schrieb Arne Schwabe:
> Auth-tokens can expire. For by reconnecting when the server uses
> auth-gen-toke.
> 
> Behaviour of OpenVPN client is to never fallback to the previous
> authentication method and continue using the auth-token. Depending on
> auth-retry it either quit or tried endlessly with an expired
> token. Since auth-gen-token tokens expire on reconnect, a client will
> not survive a reconnect.
> 
> This patches changes the behaviour on failed auth when using an
> auth-token as a soft error (USR1) and clean the auth-token falling
> back to the original auth method.
> 
> Patch V2: properly formatted commit message, fix openvpn3 detection
> 
> Patch V3: remove all server changes, include only minimal non
> intrusive client changes that only improve error recovery but don't
> change overall behaviour.
> 
> Patch V4: forget add push.c to git index, now also included

Patch V5: is fixing overlong lines and one minor style problem.

Arne

