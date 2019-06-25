Resent-To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <5deb36e0-550c-615a-4dd5-d0a0b9452dfd@...2162...>
References: <20190613134834.5709-1-arne@...1227...>
 <20190613134834.5709-5-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <414b5e76-c18d-5348-0d3c-84b121ca46bd@...2080...>
Date: Tue, 25 Jun 2019 22:17:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190613134834.5709-5-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4 6/7] Sent indication that a session
 is expired to clients
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
To: Arne Schwabe <arne@...1227...>

On 13/06/2019 15:48, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> This allows OpenVPN 3 core to fall back to the original authentication
> method.
> 
> This commit changes man_def_auth_set_client_reason to
> auth_set_client_reason since it now used in more contexts.
> 
> Also remove a FIXME about client_reason not being freed, as it is freed
> in tls_multi_free with auth_set_client_reason(multi, NULL);
> 
> Patch V4: Rebase on master
> ---
>  src/openvpn/auth_token.c |  3 +++
>  src/openvpn/ssl.c        |  6 ++----
>  src/openvpn/ssl_common.h | 10 +++++-----
>  src/openvpn/ssl_verify.c |  8 ++++----
>  src/openvpn/ssl_verify.h | 15 ++++++++++-----
>  5 files changed, 24 insertions(+), 18 deletions(-)
> 

There's a typo in the subject line (Sent -> Send), otherwise this is fine and
works as expected.

Acked-by: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


