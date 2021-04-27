References: <20210426174436.26210-1-gert@...1296...>
 <20210427110300.6911-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9a2b4fca-1076-3e54-905a-c4ae83d98540@...2181...>
Date: Tue, 27 Apr 2021 16:40:02 +0200
MIME-Version: 1.0
In-Reply-To: <20210427110300.6911-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] rewrite parse_hash_fingerprint()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 27/04/2021 13:03, Gert Doering wrote:
> The existing code was doing far too much work for too little
> gain - copying the string segment for scanf(), checking extra
> for spaces, making the result quite unreadable.
> 
> Verify each segment with (short-circuited) isxdigit() checks,
> then feed directly to scanf(), which will stop parsing on ':'
> or end-of-string.
> 
> Rewrite error message to differentiate "hash too short" (including
> number of bytes read) and "hash too long" (it did not terminate when
> we had enough bytes).
> 
> While at it, add an option printer for the resulting o->verify_hash
> list to show_settings().
> 
> v2:
>    fix typo in commit message
>    appease whitespace dragon
>    add printing of verify_hash_algo and verify_hash_depth
>    print correct hash length for SHA1 certs
>    fix incorrect assignment to options->verify_hash_algo in c3a7065d5
> 

Thanks for the changes :)

> Signed-off-by: Gert Doering <gert@...1296...>

Patch looks good and does what it says. Couldn't break it in any way.

Compile tests passed.

Basic tests on various broken/non-broken hex strings passed too.

Acked-by: Antonio Quartulli <antonio@...515...>


Regards,


-- 
Antonio Quartulli

