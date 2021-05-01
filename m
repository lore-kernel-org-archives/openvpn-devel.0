From: Antonio Quartulli <a@...2181...>
References: <20210422151724.2132573-1-arne@...1227...>
 <20210422151724.2132573-3-arne@...1227...>
 <41065455-7d6d-6b0e-007e-ef6d1391621f@...2181...>
Message-ID: <ca3baa82-ab10-74ea-3782-f1a43b2be983@...2181...>
Date: Sat, 1 May 2021 15:37:47 +0200
MIME-Version: 1.0
In-Reply-To: <41065455-7d6d-6b0e-007e-ef6d1391621f@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/7] Return cached result in
 tls_authentication_status
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

On 01/05/2021 15:33, Antonio Quartulli wrote:
>>      multi->tas_last = now;
> 
> I think keeping this line here is wrong.
> 
> Now that the logic has been changed, the code is setting tas_last to now
> every time this function is called (it wasn't the case before this patch).
> 
> For this reason "cached" will always be true and the ACF will never be
> checked.
> 
> A fix would be to add a condition above this line, like:
> 
> if (!cached)
>     multi->tas_last = now;

I think it may even be better to move these two lines above right after
having invoked key_state_test_auth_control_file() - unless there is some
drawback that I can't see.

Cheers,

-- 
Antonio Quartulli

