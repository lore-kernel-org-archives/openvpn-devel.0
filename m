Message-ID: <812ea408-893f-799e-d560-c193aaa2f789@...1227...>
Date: Thu, 20 Jan 2022 12:11:29 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-13-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-13-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 12/18] Increase ERR_BUF_SIZE when
 management interface support is enabled
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

Am 14.12.21 um 17:59 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Sending largish messages to the management interface errors due to
> the limited size used for the "error" buffer in x_msg_va(). Although
> all intermediate steps allocate required space for the data to
> send, it gets truncated at the last step.
> 
> This really requires a smarter fix. As a quick relief, we just increase
> the buffer size to 10240 when management support is compiled in. Should
> be enough for PK_SIGN with undigested message.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>



Acked-By: Arne Schwabe <arne@...1227...>


