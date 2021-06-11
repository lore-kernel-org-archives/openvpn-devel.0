References: <20210520151148.2565578-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e06adf69-995a-4fb9-7407-85aab5eb890c@...2181...>
Date: Fri, 11 Jun 2021 02:23:57 +0200
MIME-Version: 1.0
In-Reply-To: <20210520151148.2565578-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/9] Move auth_token_state from multi
 to key_state
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
> The auth-token check is tied to the username/password that is coming
> via a specific SSL session, so keep the state also in the key_state
> structure.
> 
> This also ensures the auth_token_state is always set to 0 on a new
> session since we clear the key_state object at the start of a new
> SSL session.
> 
> This is a prerequisite patch to fix 2020-15078 in the following two
> commits.
> 
> This also applies the changes to the auth_token_test.c. The change of
> tls_session to a pointer is necessary since before that we had tls_session
> not tied to the multi and had two tls_session used in the test. One
> implicitly in tls_multi and one explicit one. Merge these to one.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Looks good and does what it says. The key-state object is initialized by
key_state_init() which wipes the entire thing before setting fields,
therefore the auth-token-flags are indeed erased as expected during the
key-state life cycle.

No functional change, as expected.

Compile zoo is happy.

Basic connectivity tests with auth-user-pass along with auth-gen-token
have worked fine, including renegotiation.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

