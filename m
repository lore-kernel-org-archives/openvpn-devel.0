Message-ID: <5b9f85fd-dcd1-463a-bb0f-9cc3a9081116@...2181...>
Date: Mon, 8 Jul 2024 23:14:58 +0200
MIME-Version: 1.0
References: <20240708210912.566-1-chipitsine@...277...>
 <20240708210912.566-2-chipitsine@...277...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20240708210912.566-2-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] src/openvpn/init.c: handle strdup
 failures
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
To: Ilia Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/07/2024 23:08, Ilia Shipitsin wrote:
> Signed-off-by: Ilia Shipitsin <chipitsine@...277...>
> ---
>   src/openvpn/init.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index a49e5639..59205ba6 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -4967,6 +4967,10 @@ write_pid_file(const char *filename, const char *chroot_dir)
>           if (!chroot_dir)
>           {
>               saved_pid_file_name = strdup(filename);
> +            if (!saved_pid_file_name)
> +            {
> +                msg( M_FATAL, "Failed allocate memory saved_pid_file_name");

patchset looks great, but (!!) there should be no space after the 
opening parenthesis..

Cheers,

> +            }
>           }
>       }
>   }

-- 
Antonio Quartulli

