Message-ID: <7008490b-1e53-ff72-6455-5292b8570881@...1227...>
Date: Thu, 20 Oct 2022 12:12:30 +0200
MIME-Version: 1.0
References: <20221019224642.11178-1-selva.nair@...277...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221019224642.11178-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH for 2.5/2.6] Purge auth-token as well
 while purging passwords
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

Am 20.10.22 um 00:46 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Starting from commit e61b401a auth-token is saved in a separate struct
> from auth-user-pass and is not cleared when ssl_purge_auth() is called.
> This makes "forget-passwords" sent to the management
> interface or "--management-forget-disconnect" option not to work
> as expected.
> 
> Purging caused by --auth-nocache is not affected
> (auth-token is retained in that case as it should be).
> 
> Use case:
> For Pre-Logon access and persistent connections on Windows, use of
> "forget-passwords" before disconnect is probably the only way to
> ensure that no credentials are left behind. Note that openvpn.exe
> continues to run after disconnect in these cases.
> 
> Also, the original intent of "forget-passwords" appears to be to
> clear all "passwords" that can be used to reconnect.

I had to first figure out what forget-password actually but yes this 
commit is correct for that obscure feature.

Acked-By: Arne Schwabe <arne@...1227...>


