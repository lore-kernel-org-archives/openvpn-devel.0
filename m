References: <0c06f527-c7a0-641e-6b4b-2c484e10d1c5@...2181...>
 <20200721163811.22745-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <58782325-7432-e50b-56bc-940cb02fe5bd@...2181...>
Date: Tue, 21 Jul 2020 21:40:39 +0200
MIME-Version: 1.0
In-Reply-To: <20200721163811.22745-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/9 v3] Indicate that a client is in
 pull mode in IV_PROTO
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

On 21/07/2020 18:38, Arne Schwabe wrote:
> This allows us to skip waiting for the first PUSH_REQUEST message from
> the client to send the response.
> 
> This changes the interpretation of IV_PROTO from a scalar to a bitfield
> Since we only have IV_PROTO=2 defined so far and will support DATA_V2
> this should not make any problem. This avoid adding another IV_xxx variable
> that takes valuable space in the protocol frame.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch V2: Use bitmask for IV_PROTO_DATA_V2 and add more documentation.
> 
> Patch V3: Rewrite IV_PROTO paragraph in man page, incoperate spelling fixes
>           by tincanteksup.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>


Thanks a lot for all the fixes. Looks good to me now.

-- 
Antonio Quartulli

