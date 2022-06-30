Message-ID: <c1a7994a-f4af-f431-9436-d3bf6a4be988@...1227...>
Date: Fri, 1 Jul 2022 00:32:22 +0200
MIME-Version: 1.0
References: <20220630190549.16675-1-selva.nair@...277...>
 <20220630190549.16675-2-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220630190549.16675-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Reactivate record_peer_info in
 manage.c
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


Am 30.06.2022 um 21:05 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
>
> --management-client has an obscure and undocumented feature
> to take a file argument where the peer's address and port are
> recorded. This has become dead code over time.
>
> - reactivate the dead code
> - make it work with v6 addresses as well
> - do not exit on error in writing the record

This is feature actually useful? If it is dead for a long time and 
nobody noticed, maybe we can just remove it?


Arne


