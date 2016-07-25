References: <CAAWBBYOc5H=0X7b=i_gizvTZUDv2RwxQUEOY85P6c3z-y_U8og@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3e7224ae-474c-1cfd-7bcf-3b9eeb14cb7a@...1227...>
Date: Mon, 25 Jul 2016 10:20:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAAWBBYOc5H=0X7b=i_gizvTZUDv2RwxQUEOY85P6c3z-y_U8og@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Added client-ip option to NAT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Rafael Gava <gava100@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Am 05.07.16 um 15:13 schrieb Rafael Gava:
> Hi Arne, sorry for replying so late. 
>
> Below is the NAT client-ip patch fixing the messed up whitespaces.
> The only difference from the previous patch, besides the whitespaces,
> is that I'm considering both strings 'client-ip' and 'localhost' as
> valid options.
>
> Please, whatever problem let me know.
Wasn't the general consensus on the mailing list that making localhost
an alias for client-ip is confusing? I wonder why you introduced it again.

Arne

