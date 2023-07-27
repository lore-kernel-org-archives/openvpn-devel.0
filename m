Message-ID: <93dd3b5c-46ce-a640-4c56-623366179981@...1227...>
Date: Thu, 27 Jul 2023 16:31:01 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <CAEeEfvzkhp_FQ8cnOZcASiVbDN8=+Gw_2sV5SNonL5x7OYb1jA@...278...>
 <892bc3fa-b752-b959-1ea4-19b106c0915c@...1227...>
 <CAEeEfvyw2AKiKV1DW2mPA8C332pK7nroA9=BtpqEND2TPGmFog@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAEeEfvyw2AKiKV1DW2mPA8C332pK7nroA9=BtpqEND2TPGmFog@...278...>
Subject: Re: [Openvpn-devel] [PATCH OpenVPN3] Add 'pull' to ignored options
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
To: Merten Fermont <merten.fermont@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 27.07.23 um 14:21 schrieb Merten Fermont:
> Hi Arne,
> 
> I changed my patch to check the client and client+pull options.
> Giving an error when neither options are declared.
> 
> This however may break current implementations that depend on 'client'
> not being a required option?
> 

Acked-By: Arne Schwabe <arne@...1227...>

Yes. It might. But then again there are people that run into strange 
problems because these configuration are not really working when 
switching to an OpenVPN 2.x client. We rather have consistency between 
clients here.

Arne


