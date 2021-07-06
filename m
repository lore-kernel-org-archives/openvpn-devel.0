References: <20210520151148.2565578-6-arne@...1227...>
 <20210705133414.3102815-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <85a225b2-966a-d83b-1117-27433db7d7de@...2181...>
Date: Tue, 6 Jul 2021 11:23:50 +0200
MIME-Version: 1.0
In-Reply-To: <20210705133414.3102815-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 6/9] Introduce S_GENERATED_KEYS state
 and generate keys only when authenticated
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

On 05/07/2021 15:34, Arne Schwabe wrote:
> Since generating data channel keys does not happen when we have reach the
> S_ACTIVE/S_GOT_KEY state anymore like it used to be before NCP, the
> state that data channel keys deserves its own state in the TLS session
> state machine.
> 
> The changes done by this commit are rather intrusive since they
> move the key generation to a completely different place and also
> rely on the state machine to decide if keys should be
> generated rather than on the complicated conditions that were
> implemented in the key_method_2_write/read methods.
> 
> A (intended) side effect of this change is that sessions that
> are still in deferred state (ks->authenticated == KS_DEFERRED)
> will not have data channel keys generated. This avoids corner
> cases where a not fully authenticated sessions might leak data.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch v2: rebased
> 
> Patch v3: fix crash in non TLS mode
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Thanks for fixing the crash. I added the basic --secret test to my suite
and I could indeed see the crash when using v2 of this patch.

I can confirm that v3 is indeed fixing the crash.
Classic client/server and p2p with TLS still works as expected.

Deferred auth works too.


Regards,



-- 
Antonio Quartulli

