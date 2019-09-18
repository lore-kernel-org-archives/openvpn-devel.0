References: <925169bb-1f1c-3f18-b8c8-857cb3ed2b3c@...2080...>
 <20190917121115.13966-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <088f194f-19ce-b77e-88b6-ec897c67d108@...2080...>
Date: Wed, 18 Sep 2019 15:58:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190917121115.13966-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v7 6/7] Sent indication that a session
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...515...>

On 17/09/2019 14:11, Arne Schwabe wrote:
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
> Patch V7: Rebase on master
> ---
>  src/openvpn/auth_token.c |  3 +++
>  src/openvpn/ssl.c        |  6 ++----
>  src/openvpn/ssl_common.h | 10 +++++-----
>  src/openvpn/ssl_verify.c |  8 ++++----
>  src/openvpn/ssl_verify.h | 15 ++++++++++-----
>  5 files changed, 24 insertions(+), 18 deletions(-)
Acked-By: David Sommerseth <davids@...515...>

This is identical to the previous version, just reference points for the
changes are changed - exactly what I'd expect with a rebase.

-- 
kind regards,

David Sommerseth
OpenVPN Inc


