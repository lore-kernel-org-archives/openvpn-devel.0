Message-ID: <96375152-3b30-1da5-9b8f-8856cf3d5ec2@...1227...>
Date: Thu, 28 Apr 2022 00:37:57 +0200
MIME-Version: 1.0
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-11-arne@...1227...>
In-Reply-To: <20220422142953.3805364-11-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 20/28] Change reliable_get_buf_sequenced
 to reliable_get_entry_sequenced
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
To: openvpn-devel@lists.sourceforge.net


>    *     buffer.
>    *
> - * @return A pointer to the buffer of the entry with the next
> - *     sequential key ID.  If no such entry is present, this function
> - *     returns NULL.
> + * @return A pointer to the entry with the next sequential key ID.
> + *     If no such entry is present, this function  returns NULL.
>    */



As pointed out in the IRC by Gert, this comment is wrong. It should be 
message or packet id instead of key id.

Arne

