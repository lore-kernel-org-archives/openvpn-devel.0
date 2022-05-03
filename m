Date: Tue, 3 May 2022 15:13:57 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1857158560.57717.1651583637365@...2642...>
In-Reply-To: <20220503112900.933975-1-arne@...1227...>
References: <20220422142953.3805364-15-arne@...1227...>
 <20220503112900.933975-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Extract read_incoming_tls_plaintext
 into its own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

Trivial code move. Compiles now.

> Arne Schwabe <arne@...1227...> hat am 03.05.2022 13:29 geschrieben:
> 
>  
> This makes the tls_process_state function a bit easier to read allows

I still think there is an "and" missing after "read"

> extending the read_incoming_tls_plaintext function later without
> making tls_process_state even longer.
> 
> Patch v2: fix compile error.

Regards,
--
Frank Lichtenheld

