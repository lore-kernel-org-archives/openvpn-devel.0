References: <20210317160443.26313-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ac3a0fc1-01f0-004c-5dfb-dd4858673028@...2181...>
Date: Wed, 17 Mar 2021 17:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <20210317160443.26313-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Implement auth-token-user
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

Hi all,

On 17/03/2021 17:04, Arne Schwabe wrote:
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

This feature is not necessarily "good looking", but I understand it may
be useful in some particular (and fairly advanced) setups.

This patch was reviewed with the Arne's guidance.

Acked-by: Antonio Quartulli <antonio@...515...>



-- 
Antonio Quartulli

