References: <20190812134513.20758-1-arne@...1227...>
 <20190815121053.18433-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <edccd4b4-4bec-79f6-41ff-17437f919e16@...2181...>
Date: Thu, 15 Aug 2019 14:11:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190815121053.18433-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Fix check if iface name is set
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 15/08/2019 14:10, Arne Schwabe wrote:
> Clang/Android complained
> 
>  warning: address of array 'rgi6->iface' will always evaluate to 'true' [-Wpointer-bool-conversion]
>           if (rgi6->iface)
> 
> iface is a char[16]; So its pointer is always true.
> 
> we do a CLEAR(rgi6) always before setting this struct and strcpy the
> name into iface. So using strlen instead of checking for the pointer
> should be the right fix.
> 
> Patch V2: use if(strlen > 0) instead of if(strlen)
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

