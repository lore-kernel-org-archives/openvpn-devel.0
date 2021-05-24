MIME-Version: 1.0
References: <r2Oc8HU_6LoYR_UE522CC5CcNVDyYxI_Hm8eiO-Fb-4aPwW5bsVWVIr8nTaZxFIbBT0duI74wOE_CObRLoLNgdkzwHN3ua1qMe9upZIuu98=@protonmail.com>
 <CAKuzo_heOferug+BNyGaKc66_pD2AQO72PSAioGH+aTXux3jsQ@...278...>
 <hygEYgyM5YzWlc1jNqaSj4Ubqzlf4AEvkNGT613wXXBbcjLPkZVen7yb0Uv6dxQPSYBV68VKNXAUc6JMmzIxVWH_u0U9DxaC6x42Zn4cG8A=@protonmail.com>
In-Reply-To: <hygEYgyM5YzWlc1jNqaSj4Ubqzlf4AEvkNGT613wXXBbcjLPkZVen7yb0Uv6dxQPSYBV68VKNXAUc6JMmzIxVWH_u0U9DxaC6x42Zn4cG8A=@protonmail.com>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 24 May 2021 14:50:37 -0400
Message-ID: <CAKuzo_gXUgDYPQj2sGzen+CzdkGrDLKdbEOGSJWC6_n9t8QsOQ@...278...>
Subject: Re: [Openvpn-devel] --tls-verify runs twice for a single cert in
 Peer-fingerprint mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: tincantech <tincantech@...2282...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

> Note: In the logs above, the script is executed *before* Openvpn/Openssl
> verification, so exporting error-status to env for script seems unlikely.

No so. The script is executed from a callback and the error from
openssl is very much in there and should be exported to scripts, imo.
This was not required in the past when we used to call the script only
when openssl verify has succeeded.

Selva

