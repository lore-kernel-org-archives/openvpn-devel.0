Message-ID: <060ec1ea-9081-4935-a7d6-8c5a1bdd181e@...1227...>
Date: Mon, 26 May 2025 09:31:08 +0200
MIME-Version: 1.0
References: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
 <20250507074438.1326755-1-walter.openvpn@...2889...>
 <eedcf175305a088df0eb7ec146dbe441.squirrel@...2890...>
 <f60dbf91-c2f8-495b-ba14-967e70629d1b@...1227...>
 <ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...>
 <8ba925a1-85c9-4274-a512-32dcec35b147@...1227...>
 <2bb3487e-6762-40ea-b6ad-2622a879ca21@...2889...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <2bb3487e-6762-40ea-b6ad-2622a879ca21@...2889...>
Subject: Re: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP
 right after connection setup
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
To: Walter Doekes <walter.openvpn@...2889...>, openvpn-devel@lists.sourceforge.net

Am 25.05.25 um 22:27 schrieb Walter Doekes:
> Good. Your understanding of the situation is the same.
> 
> I did not yet make a reproducer config -- mostly because I don't think 
> we're doing anything non-standard. But I did double check that latest 
> 2.6 is affected, tested both client and server.

It is non-standard enough that you are the only ones affected and that 
we have trouble reproducing it.

It would be good to get a pcap of the servers view of the client 
connection. You can send that in private if you want. I might have some 
idea what is happening if I can have a look at that. But currently it is 
just too much guesswork without knowing anything concrete that I can go on.

Arne

