References: <20200703095506.28559-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d892a2e7-55b9-3bc0-bf26-33c31004cc48@...2181...>
Date: Fri, 3 Jul 2020 18:56:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200703095506.28559-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Remove did_open_context,
 defined and connection_established_flag
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

Compile tested and checked logically by going through the various places
where these members were used (except for defined which is not used
anywhere :-)).

It all looks good and makes sense!


Glad to see that we are simplifying these jungle of state variables..

On 03/07/2020 11:55, Arne Schwabe wrote:
> multi_instance->defined is not used anywhere.
> 
> did_open_context is always set to true when a context is created in
> multi_create_instance, so checking it for true is always true.
> 
> context_auth is also always set to CAS_PENDING in multi_create_instance.
> 
> connection_established_flag is only set to true if context_auth
> is changed from CAS_PENDING to one another state, so we can also check
> for cas_context != CAS_PENDING.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

