MIME-Version: 1.0
In-Reply-To: <49e7a0ee-b395-c879-a4d0-63153db9d8bc@...1227...>
References: <20161219013949.19551-1-a@...2181...>
	<2fc5173c-b27b-3828-f227-e15687831667@...1856...>
	<49e7a0ee-b395-c879-a4d0-63153db9d8bc@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 25 Dec 2016 11:02:00 +0100
Message-ID: <CAA1AbxKU-tP96L3NurwtpSVQ7zUVNzqNgi3sNL+PF97VVDRgkQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <a@...2181...>

Hi,

On 25 December 2016 at 10:58, Arne Schwabe <arne@...1227...> wrote:
> Am 25.12.16 um 09:44 schrieb Steffan Karger:
>>> +    bool pkcs12_file_inline; /* contains the base64 encoding of pkcs12 file */
>> This comment is no longer accurate, and should probably just be removed.
>>
>
> I don't see the patch changing that, so I would assume it to be still.
> Furthermore, changing that would bring encoding problem in file and
> change config files.

The patch changes this from const char *, containing the base64
encoding of the file, to a bool, which merely indicates what
pkcs12_file contains.  That the same as for all of the above, and
sufficiently clear from the name and type I'd say :)

-Steffan

