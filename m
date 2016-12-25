Date: Sun, 25 Dec 2016 18:01:25 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161225100125.GF8708@...2182...>
References: <20161219013949.19551-1-a@...2181...>
	<2fc5173c-b27b-3828-f227-e15687831667@...1856...>
	<49e7a0ee-b395-c879-a4d0-63153db9d8bc@...1227...>
MIME-Version: 1.0
In-Reply-To: <49e7a0ee-b395-c879-a4d0-63153db9d8bc@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Dec 25, 2016 at 09:58:31AM +0000, Arne Schwabe wrote:
> Am 25.12.16 um 09:44 schrieb Steffan Karger:
> >> +    bool pkcs12_file_inline; /* contains the base64 encoding of pkcs12 file */
> > This comment is no longer accurate, and should probably just be removed.
> > 
> 
> I don't see the patch changing that, so I would assume it to be still.
> Furthermore, changing that would bring encoding problem in file and
> change config files.

What Steffan meant, I think, is that the "pkcs12_file_inline" field is not the
container of the encoded text anymore. Thus the comment should be moved or
reworded to reflect this change.


Cheers,

-- 
Antonio Quartulli

