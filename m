References: <20210105131758.20311-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e17000a0-eb11-9e9d-f8bd-86f3429b4801@...2181...>
Date: Tue, 12 Jan 2021 17:02:27 +0100
MIME-Version: 1.0
In-Reply-To: <20210105131758.20311-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Zero initialise msghdr prior to calling
 sendmesg
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


On 05/01/2021 14:17, Arne Schwabe wrote:
> This ensure that all unused fields in msg are zero.
> 
> Spotted by Coverity:
> 
> Using uninitialized value "msg". Field "msg.msg_flags" is uninitialized
> when calling "sendmsg".

No signed-off-by ?

> ---
>  src/openvpn/manage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index a4f99c9a..103ccadc 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -2092,7 +2092,7 @@ man_io_error(struct management *man, const char *prefix)
>  static ssize_t
>  man_send_with_fd(int fd, void *ptr, size_t nbytes, int flags, int sendfd)
>  {
> -    struct msghdr msg;
> +    struct msghdr msg = {0};

In the rest of the code we have spaces around the 0, like "{ 0 }"
I suggest using the same style.

>      struct iovec iov[1];
>  
>      union {
> @@ -2124,7 +2124,7 @@ man_send_with_fd(int fd, void *ptr, size_t nbytes, int flags, int sendfd)
>  static ssize_t
>  man_recv_with_fd(int fd, void *ptr, size_t nbytes, int flags, int *recvfd)
>  {
> -    struct msghdr msghdr;
> +    struct msghdr msghdr = {0};

same as above.

>      struct iovec iov[1];
>      ssize_t n;
>  
> 

Other than that it's Feature-ACK.
We should always fully initialize objects that we pass around.

Cheers,

-- 
Antonio Quartulli

