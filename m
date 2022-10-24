Message-ID: <102833f9-35a9-b512-8e3b-d0eeecec138c@...1227...>
Date: Mon, 24 Oct 2022 14:10:11 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20221023195105.31714-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221023195105.31714-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Ensure --auth-nocache is handled during
 renegotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 23.10.22 um 21:51 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Currently, clearing auth_user_pass struct is delayed until
> push-reply processing to support auth-token. This results in
> username/password not purged after renegotiations that may
> not accompany any pushed tokens -- say, when auth-token is not
> in use.
> 
> Fix by always clearing auth_user_pass soon after it is used,
> instead of delaying the purge as in pre-token days. But, when
> "pull" is true, retain the username in auth_token in anticipation
> of a token that may or may not arrive later.
> 
> Remove ssl_clean_user_pass() as there is no delayed purge any
> longer -- auth-nocache handling is now done immediately after
> writing username/password to the send-buffer.

Acked-By: Arne Schwabe <arne@...1227...

I think the delaying and complicated logic, which thiss patch removes, 
is the last part of the attempt to try to use the same auth_user_pass 
struct for both auth token and user/password.

Arne


