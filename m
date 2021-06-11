References: <20210520151148.2565578-1-arne@...1227...>
 <20210520151148.2565578-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9bb2def2-43ae-23f6-f6e0-dfd28ebc1362@...2181...>
Date: Fri, 11 Jun 2021 02:41:12 +0200
MIME-Version: 1.0
In-Reply-To: <20210520151148.2565578-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 2/9] Implement auth-token-user
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 20/05/2021 17:11, Arne Schwabe wrote:
> When not using username and password (i.e. auth-user-pass) it can still make
> to provide the client with an auth-token, e.g. for allowing a session to
> continue after a reconnect without requiring 2FA again.
> 
> However, without --auth-user-pass openvpn does not have a username and will
> ignore any pushed auth-token command.
> 
> This patch adds support for auth-token-user to set the username that should
> be used for auth-token
> 
> The spec of using auth-token-user base64-encoded-user are the ones that
> OpenVPN3 already implements.
> 
> Patch V2: Improve style, fix comments and commit message
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This patch hasn't changed since the last time it was on the mailing list
(and I acked it), so the same goes for this copy.

@Arne I have a new question though: what is expected to happen is the
--auth-token-user is specified in the global config?

Is the same user supposed to be used with every client?
Or is it just ignored?

I am testing this case and I don't see the user being pushed to the client.

Cheers,



-- 
Antonio Quartulli

