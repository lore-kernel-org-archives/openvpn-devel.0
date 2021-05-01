References: <20210422151724.2132573-1-arne@...1227...>
 <20210422151724.2132573-3-arne@...1227...>
 <41065455-7d6d-6b0e-007e-ef6d1391621f@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b5af5fe1-2e29-7ad8-42cf-1a3a159b785d@...1227...>
Date: Sat, 1 May 2021 16:14:46 +0200
MIME-Version: 1.0
In-Reply-To: <41065455-7d6d-6b0e-007e-ef6d1391621f@...2181...>
Content-Language: en-GB
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
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


> 
> 
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
> 
> Does it make sense?
> In my tests this fixes the problem and deferred auth works again.

Yes. It is. I am not sure how I missed that.

Arne

