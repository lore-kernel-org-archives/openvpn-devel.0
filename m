Message-ID: <c21582dc-4dff-443a-978e-da89b1fd057e@...2181...>
Date: Tue, 10 Dec 2024 10:30:09 +0100
MIME-Version: 1.0
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
 <20241209210956.13536-1-gert@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20241209210956.13536-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v8] Use XOR instead of concatenation for
 calculation of IV from implicit IV
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 09/12/2024 22:09, Gert Doering wrote:
> From: Arne Schwabe <arne@...1227...>
> 
> This change prepares the extended packet id data where also the packet id
> part of the IV will be derived using xor.  Using xor also in the AEAD
> case where this degenerates to a concatenation allows using the same
> IV generation code later.
> 
> Change-Id: I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Acked-by: MaxF <max@...2606...>

My ACK got lost when v8 was created:

Acked-by: Antonio Quartulli <antonio@...2726...>

-- 
Antonio Quartulli


