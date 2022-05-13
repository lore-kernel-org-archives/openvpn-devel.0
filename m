Message-ID: <1e5fe75f-72b9-6bdc-d061-c18223ae92cf@...1227...>
Date: Fri, 13 May 2022 09:14:29 +0200
MIME-Version: 1.0
References: <20220512231105.1076835-1-heiko@...2662...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220512231105.1076835-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH] signal --dns support in peer info
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net


Am 13.05.2022 um 01:11 schrieb Heiko Hund:
> Have clients set a bit in IV_PROTO, so that servers can make an informed
> decision on whether to push --dns to the client. While unknown options
> are ignored by clients when pushed, they generate a warning in the log.
> That can be circumvented by server backends by checking if bit 7 is set.
Acked-By: Arne Schwabe <arne@...1227...>

