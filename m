References: <20210520151148.2565578-4-arne@...1227...>
 <20210604143938.779193-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6e94d1dd-e5a7-7d22-4a9b-01d1cb49a2bb@...2181...>
Date: Mon, 14 Jun 2021 02:29:12 +0200
MIME-Version: 1.0
In-Reply-To: <20210604143938.779193-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4 4/9] Make waiting on auth an explicit
 state in the context state machine
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 04/06/2021 16:39, Arne Schwabe wrote:
> Previously we relied on checking tls_authentication_status to check
> wether to determine if the context auth state is actually valid or not.
> This patch eliminates that check by introducing waiting on the
> authentication as extra state in the context auth, state machine.
> 
> Patch v3: Fix ccd config from management being ignored
> Patch v4: Fix race condition, we need to accept the config from
>           management if we are in CAS_WAITING_AUTH or earlier states 
> 	  and not just in CAS_WAITING_AUTH state
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This patch gets an ACK from me because all my tests have passed and I
find the code reasonable.

My compile zoo was happy too.

My tests included client/server, with auth, with deferred auth, p2p.

I have not tested this patch using the mgmt interface.


Acked-by: Antonio Quartulli <antonio@...515...>

From now on, when Acking a patch I will imply that:
* my GitLab CI is all green with this patch applied;
* the patch compiled against mbedtls (various versions), openssl
(various versions), libressl (various versions), wolfssl (master branch).

This way I don't have to talk about my compile zoo every time :-)

-- 
Antonio Quartulli

