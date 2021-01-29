References: <bfa25147-4426-d115-46b3-03170f23e158@...2181...>
 <20210129104708.7484-1-arne@...1227...>
 <e8e4fdb3-90a1-9914-8de3-155dbec172af@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5bb1e9d8-2017-388a-1c9a-579343049ebc@...1227...>
Date: Fri, 29 Jan 2021 15:21:37 +0100
MIME-Version: 1.0
In-Reply-To: <e8e4fdb3-90a1-9914-8de3-155dbec172af@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] Check return values in
 md_ctx_init and hmac_ctx_init
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


> 
> I saw that you missed this case earlier, but I thought that this call
> cannot really fail.
> 
> Assuming it can fail under certain conditions, wouldn't the M_FATAL
> somewhat become a DoS on the server side?

The condition it can fail is basically that the crypto library is unable
or unwilling to create a context for that hash algorithm. If that
happens we later segfault. This basically only happend on the OpenSSL in
FIPS mode, which claim to have MD5 but will then not accept to create
MD5. So a fatal fail here is better than a segfault.

Arne

