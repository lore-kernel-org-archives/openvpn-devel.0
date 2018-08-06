References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-3-git-send-email-steffan.karger@...1435...>
 <45552257-86e8-b7e9-0168-f53444e36aa2@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <3fc1ebc8-f0b5-de40-7f05-6061521f9d3c@...1435...>
Date: Mon, 6 Aug 2018 09:56:48 +0200
MIME-Version: 1.0
In-Reply-To: <45552257-86e8-b7e9-0168-f53444e36aa2@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 3/7] tls-crypt-v2: generate client
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 03-08-18 17:23, tincanteksup wrote:
> On 25/07/18 17:08, Steffan Karger wrote:
>> @@ -2764,6 +2781,7 @@ options_postprocess_verify_ce(const struct
> options *options, const struct connec
> 
> 
> connec --> connect ? (This is code so I just highlight for your
> consideration, I don't know)

This is just the patch file truncating a line.  The code says "const
struct connection_entry *ce".

>> +/**
>> + * Initialize a tls-crypt-v2 client key.
>> + *
>> + * @param key               Key structure to be initialized with the
> client
>> + *                          key.
>> + * @param wrapped_key_buf   Returns buffer containing the wrapped key
> that will
>> + *                          be sent to the server when connecting.
> Caller must
>> + *                          free this buffer when no longer neede.
> 
> neede --> needed

Yes, will fix in v4!

Thanks,
-Steffan

