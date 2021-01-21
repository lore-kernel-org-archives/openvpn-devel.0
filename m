Resent-To: openvpn-devel@lists.sourceforge.net
Resent-Message-ID: <63a43905-70eb-a3f9-3587-c542d69ca143@...2162...>
References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-10-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1881db7f-e881-a893-9e54-71b3533994d8@...2080...>
Date: Thu, 21 Jan 2021 18:29:50 +0100
MIME-Version: 1.0
In-Reply-To: <20200930131317.1299-10-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 08/11] Allow pending auth to be send
 from a auth plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>

On 30/09/2020 15:13, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   doc/man-sections/generic-options.rst |   3 +-
>   include/openvpn-plugin.h.in          |   8 ++
>   src/openvpn/ssl.c                    |   2 +-
>   src/openvpn/ssl_common.h             |   1 +
>   src/openvpn/ssl_verify.c             | 165 ++++++++++++++++++++++++---
>   src/openvpn/ssl_verify.h             |   2 +-
>   6 files changed, 165 insertions(+), 16 deletions(-)
> 

So far just glared at the code, but the change below needs to be fixed 
first.  This patchset has also aged so much it does no longer apply on 
top of latest git master.


[...snip...]
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index e7e62afa..fc3a1116 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c[...snip...]
> @@ -1067,7 +1196,7 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
>       struct gc_arena gc = gc_new();
>       struct argv argv = argv_new();
>       const char *tmp_file = "";
> -    bool ret = false;
> +    bool ret = OPENVPN_PLUGIN_FUNC_ERROR;

This is wrong.  OPENVPN_PLUGIN_FUNC_ERROR is 1, which means "true".  I 
see this is being corrected again in the next patch; but lets make it 
correct from the beginning to avoid making a potential bisect in the 
future more confusing than needed.


The rest of the code looks reasonable.  I've not tested it yet, as there 
are some merge conflicts now.  Since the surrounding code has changed a 
bit since this patch series , I consider it a bit risky to conclude on 
testing this on a older code base without many of the fixes in between 
in place.

Most of the merge conflicts is probably related to commit 99d217b20064 
(removing --disable-def-auth), but there are other AUTH related changes 
as well.  This needs to be carefully tested with all these auth changes 
in place too.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


