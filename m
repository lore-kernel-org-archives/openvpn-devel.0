Date: Mon, 25 Apr 2022 10:57:10 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <292712180.307848.1650877030325@...2642...>
In-Reply-To: <20220422142953.3805364-10-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-10-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 19/28] Make buf_write_u8/16/32 take the
 type they pretend to take
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

Trivial enough and can be applied independently from the rest of the series.

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> 
>  
> This functions should accept the type of integer they say to write. Calling
> the u32 function with an integer that is actually 32 bit unsigned gives
> compiler warnings.

--
Frank Lichtenheld

