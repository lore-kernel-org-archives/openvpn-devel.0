Resent-To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <f9c8cda6-39e3-ff1e-aa77-cb7c48f2e48f@...2080...>
Date: Wed, 20 Sep 2017 19:25:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170920172546.GV70062@...1296...>
References: <CAO5O-ELs7tpAcdDWXZipeFMkVAmRbVtK=u4+tXU-km_Tq4oHnQ@...278...>
 <80690690-67ac-3320-1891-9fecedc6a1fa@...1435...>
In-Reply-To: <80690690-67ac-3320-1891-9fecedc6a1fa@...1435...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Remote memory corruption
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Steffan Karger <steffan.karger@...1435...>
Cc: Guido Vranken <guidovranken@...277...>, security@...515...

Hi,

On Tue, Aug 15, 2017 at 10:10:32AM +0200, Steffan Karger wrote:
[..]
> To all: following <54FC26BB.2000202@...1856...> and commit 1ce06386, I
> think it really is time to remove key method 1 from the master branch.
> 
> Attached a proposed patch to fix this issue in release/2.4 and master.
> 
> -Steffan

> From f7390bf97af7f1977547586529be1d51adde4c67 Mon Sep 17 00:00:00 2001
> From: Steffan Karger <steffan.karger@...1435...>
> Date: Tue, 15 Aug 2017 10:04:33 +0200
> Subject: [PATCH] CVE-2017-xxx: fix bounds check in read_key()
> 
> The bounds check in read_key() was performed after using the value, instead
> of before.  If 'key-method 1' is used, this allowed an attacker to send a
> malformed packet to trigger a stack buffer overflow.
> 
> Fix this by moving the input validation to before the writes.
> 
> Note that 'key-method 1' has been replaced by 'key method 2' as the default
> in OpenVPN 2.0 (released on 2005-04-17), and explicitly deprecated in 2.4
> and marked for removal in 2.5.  This should limit the amount of users
> impacted by this issue.
> 
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/crypto.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index cc3c7b6..0ebbcd0 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1653,6 +1653,11 @@ read_key(struct key *key, const struct key_type *kt, struct buffer *buf)
>          goto read_err;
>      }
>  
> +    if (cipher_length != kt->cipher_length || hmac_length != kt->hmac_length)
> +    {
> +        goto key_len_err;
> +    }
> +
>      if (!buf_read(buf, key->cipher, cipher_length))
>      {
>          goto read_err;
> @@ -1662,11 +1667,6 @@ read_key(struct key *key, const struct key_type *kt, struct buffer *buf)
>          goto read_err;
>      }
>  
> -    if (cipher_length != kt->cipher_length || hmac_length != kt->hmac_length)
> -    {
> -        goto key_len_err;
> -    }
> -
>      return 1;
>  
>  read_err:

ACK.  Fixes the problem at hand and is generally good housekeeping
to check your things first :-)

Subject: and commit message needs "real" CVE message.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

