References: <20200508212356.18522-1-a@...2181...>
 <2020aab0-8312-2bd9-d2c2-20484d062934@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6a62b6d2-7870-124f-5b5f-be657ffeb34a@...2181...>
Date: Sun, 10 May 2020 15:59:50 +0200
MIME-Version: 1.0
In-Reply-To: <2020aab0-8312-2bd9-d2c2-20484d062934@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] get rid of TAG_FILE_INLINE constant
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
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Hi,

On 10/05/2020 15:53, David Sommerseth wrote:

> This looks promising, but is not complete - and breaking compilation:
> 
> 
> $ git grep INLINE_FILE_TAG
> src/openvpn/tls_crypt.c:        client_filename = INLINE_FILE_TAG;
> 
> $ make -j5
> [...]
> make[3]: Entering directory `/home/davids/devel/OpenVPN/openvpn/src/openvpn'
>   CC       tls_crypt.o
> tls_crypt.c: In function ‘tls_crypt_v2_write_client_key_file’:
> tls_crypt.c:706:27: error: ‘INLINE_FILE_TAG’ undeclared (first use in this
> function)
>          client_filename = INLINE_FILE_TAG;
>                            ^
> 
> I haven't dug into if client_filename really needs to be set to INLINE_FILE_TAG.
> 

whoop - I prepared a patch for this last occurrence (to be applied
before this patch), but did not send it.

Incoming...

-- 
Antonio Quartulli

